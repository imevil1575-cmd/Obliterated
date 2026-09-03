-- Features/CombatIntegration.lua
local CombatIntegration = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local isRunning = false
local config = nil
local remotes = {}
local trackedAnimations = {}
local trackedEffects = {}
local trackedParts = {}
local trackedSounds = {}

function CombatIntegration:init()
    local Config = require(script.Parent.Parent.Config)
    config = Config:get()
    
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
    remotes.fallDamage = KeyHandling.getRemote("FallDamage")
    remotes.serverSlide = KeyHandling.getRemote("ServerSlide")
    remotes.serverSlideStop = KeyHandling.getRemote("ServerSlideStop")
    
    isRunning = true
    print("✓ CombatIntegration initialized")
end

function CombatIntegration:executeParry()
    if remotes.block then
        remotes.block:FireServer()
        task.spawn(function()
            task.wait(0.06)
            if remotes.unblock then remotes.unblock:FireServer() end
        end)
    end
end

function CombatIntegration:executeDodge()
    if remotes.dodge then
        remotes.dodge:FireServer("roll", nil, nil, false)
        task.spawn(function()
            task.wait(0.15)
            if remotes.stopDodge then remotes.stopDodge:FireServer() end
        end)
    end
end

function CombatIntegration:update()
    if not isRunning then return end
    -- Animation, effect, part, and sound scanning would go here
end

function CombatIntegration:detach()
    isRunning = false
end

return CombatIntegration
