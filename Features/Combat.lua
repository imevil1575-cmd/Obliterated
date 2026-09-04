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

local allTimings = {}

function Combat:init(parentModule)
    config = (parentModule and parentModule.config) or {}
    isRunning = true
    
    self:cacheRemotes()
    
    if getgenv().ObliteratedTimings then
        allTimings = getgenv().ObliteratedTimings
    else
        allTimings = {}
    end
    
    print("Combat initialized")
end

function Combat:cacheRemotes()
    local keybinds = ReplicatedStorage:FindFirstChild("KeyBinds")
    if not keybinds then
        warn("KeyBinds folder not found")
        return
    end
    
    remotes = {}
    
    for _, child in ipairs(keybinds:GetChildren()) do
        if child:IsA("RemoteEvent") then
            local name = child.Name
            if name:match("Block") then remotes.block = child
            elseif name:match("Unblock") then remotes.unblock = child
            elseif name:match("Dodge") or name:match("Roll") then remotes.dodge = child
            elseif name:match("StopDodge") or name:match("StopRoll") then remotes.stopDodge = child
            elseif name:match("LeftClick") or name:match("M1") then remotes.leftClick = child
            elseif name:match("CriticalClick") or name:match("Crit") then remotes.criticalClick = child
            elseif name:match("Feint") then remotes.feintClick = child
            elseif name:match("ActivateMantra") then remotes.activateMantra = child
            end
        end
    end
    
    print("Cached remotes: Block=" .. tostring(remotes.block ~= nil) .. " Dodge=" .. tostring(remotes.dodge ~= nil))
end

function Combat:getTiming(id)
    return allTimings[id]
end

function Combat:executeParry()
    if remotes.block then
        pcall(function() remotes.block:FireServer() end)
        task.spawn(function()
            task.wait(0.06)
            if remotes.unblock then
                pcall(function() remotes.unblock:FireServer() end)
            end
        end)
    end
end

function Combat:executeDodge()
    if remotes.dodge then
        pcall(function() remotes.dodge:FireServer("roll", nil, nil, false) end)
        task.spawn(function()
            task.wait(0.15)
            if remotes.stopDodge then
                pcall(function() remotes.stopDodge:FireServer() end)
            end
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
            task.wait((action._when or 500) / 1000)
            
            if not track or not track.IsPlaying then
                trackedAnimations[id] = nil
                return
            end
            
            local char = Players.LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local targetRoot = entity and entity:FindFirstChild("HumanoidRootPart")
            if not targetRoot then return end
            
            local dist = (root.Position - targetRoot.Position).Magnitude
            if dist > (timing.imxd or 50) then return end
            
            if action._type == "Parry" then
                self:executeParry()
            elseif action._type == "Dodge" or action._type == "Forced Full Dodge" then
                self:executeDodge()
            elseif action._type == "Start Block" and remotes.block then
                pcall(function() remotes.block:FireServer() end)
            elseif action._type == "End Block" and remotes.unblock then
                pcall(function() remotes.unblock:FireServer() end)
            end
        end)
    end
    
    task.spawn(function()
        while track and track.IsPlaying do task.wait() end
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
