-- Features/Combat.lua
local Combat = {}
Combat.__index = Combat

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local isRunning = false
local config = nil
local remotes = {}
local trackedAnimations = {}

-- Load timings
local WeaponTimings = require(script.Parent.Parent.Timings.WeaponTimings)
local MantraTimings = require(script.Parent.Parent.Timings.MantraTimings)
local MobTimings = require(script.Parent.Parent.Timings.MobTimings)
local EffectTimings = require(script.Parent.Parent.Timings.EffectTimings)
local PartTimings = require(script.Parent.Parent.Timings.PartTimings)
local SoundTimings = require(script.Parent.Parent.Timings.SoundTimings)

local allTimings = {}
for k, v in pairs(WeaponTimings) do allTimings[k] = v end
for k, v in pairs(MantraTimings) do allTimings[k] = v end
for k, v in pairs(MobTimings) do allTimings[k] = v end
for k, v in pairs(EffectTimings) do allTimings[k] = v end
for k, v in pairs(PartTimings) do allTimings[k] = v end
for k, v in pairs(SoundTimings) do allTimings[k] = v end

function Combat:init(parentModule)
    config = parentModule and parentModule.config or {}
    isRunning = true
    
    local KeyHandling = require(script.Parent.Parent.Utils.KeyHandling)
    KeyHandling.searchForKeyHandlerData()
    
    remotes.block = KeyHandling.getRemote("Block")
    remotes.unblock = KeyHandling.getRemote("Unblock")
    remotes.dodge = KeyHandling.getRemote("Dodge")
    remotes.stopDodge = KeyHandling.getRemote("StopDodge")
    remotes.leftClick = KeyHandling.getRemote("LeftClick")
    remotes.criticalClick = KeyHandling.getRemote("CriticalClick")
    remotes.feintClick = KeyHandling.getRemote("FeintClick")
    remotes.activateMantra = KeyHandling.getRemote("ActivateMantra")
    
    print("✓ Combat initialized with " .. Table.size(allTimings) .. " timings")
end

function Combat:getTiming(id)
    return allTimings[id]
end

function Combat:executeParry()
    if remotes.block then
        remotes.block:FireServer()
        task.spawn(function()
            task.wait(0.06)
            if remotes.unblock then remotes.unblock:FireServer() end
        end)
    end
end

function Combat:executeDodge()
    if remotes.dodge then
        remotes.dodge:FireServer("roll", nil, nil, false)
        task.spawn(function()
            task.wait(0.15)
            if remotes.stopDodge then remotes.stopDodge:FireServer() end
        end)
    end
end

function Combat:trackAnimation(track, entity)
    local id = tostring(track.Animation.AnimationId)
    local timing = self:getTiming(id)
    if not timing or trackedAnimations[id] then return end
    
    trackedAnimations[id] = true
    
    for _, action in ipairs(timing.actions or {}) do
        task.spawn(function()
            task.wait(action._when / 1000)
            if not track.IsPlaying then
                trackedAnimations[id] = nil
                return
            end
            
            local char = Players.LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local targetRoot = entity:FindFirstChild("HumanoidRootPart")
            if not targetRoot then return end
            
            local dist = (root.Position - targetRoot.Position).Magnitude
            if dist > (timing.imxd or 50) then return end
            
            if action._type == "Parry" then
                self:executeParry()
            elseif action._type == "Dodge" or action._type == "Forced Full Dodge" then
                self:executeDodge()
            elseif action._type == "Start Block" and remotes.block then
                remotes.block:FireServer()
            elseif action._type == "End Block" and remotes.unblock then
                remotes.unblock:FireServer()
            end
        end)
    end
    
    task.spawn(function()
        while track.IsPlaying do task.wait() end
        trackedAnimations[id] = nil
    end)
end

function Combat:scanForAnimations()
    local live = workspace:FindFirstChild("Live")
    if not live then return end
    
    local character = Players.LocalPlayer.Character
    if not character then return end
    
    for _, entity in ipairs(live:GetChildren()) do
        if entity == character then continue end
        
        local humanoid = entity:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then continue end
        
        local animator = humanoid:FindFirstChild("Animator")
        if not animator then continue end
        
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local id = tostring(track.Animation.AnimationId)
            if not trackedAnimations[id] then
                self:trackAnimation(track, entity)
            end
        end
    end
end

function Combat:update(dt)
    if not isRunning then return end
    self:scanForAnimations()
end

function Combat:detach()
    isRunning = false
    trackedAnimations = {}
end

return Combat
