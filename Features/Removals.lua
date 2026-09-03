-- Features/Removals.lua
local Removals = {}
Removals.__index = Removals

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local isRunning = false
local config = nil
local originalFogStart = 0
local originalFogEnd = 0

function Removals:init(parentModule)
    config = parentModule and parentModule.config or {}
    isRunning = true
    originalFogStart = Lighting.FogStart
    originalFogEnd = Lighting.FogEnd
    print("✓ Removals initialized")
end

function Removals:removeFog()
    if not config.no_fog then
        Lighting.FogStart = originalFogStart
        Lighting.FogEnd = originalFogEnd
        return
    end
    Lighting.FogStart = 9e9
    Lighting.FogEnd = 9e9
    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmosphere then atmosphere.Density = 0 end
end

function Removals:removeBlind()
    if not config.no_blind then return end
    local character = Players.LocalPlayer.Character
    if not character then return end
    for _, child in ipairs(character:GetDescendants()) do
        if child:IsA("Attachment") and child.Name:match("Blind") then
            child:Destroy()
        end
    end
end

function Removals:removeBlur()
    if not config.no_blur then return end
    local blur = Lighting:FindFirstChild("GenericBlur")
    if blur then blur.Size = 0 end
    local underwaterBlur = Lighting:FindFirstChild("UnderwaterBlur")
    if underwaterBlur then underwaterBlur.Size = 0 end
end

function Removals:removeKillBricks()
    if not config.no_kill_bricks then return end
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and (part.Name == "KillBrick" or part.Name == "KillPlane") then
            part.CanCollide = false
            part.Transparency = 1
        end
    end
end

function Removals:update(dt)
    if not isRunning then return end
    self:removeFog()
    self:removeBlind()
    self:removeBlur()
    self:removeKillBricks()
end

function Removals:detach()
    isRunning = false
    Lighting.FogStart = originalFogStart
    Lighting.FogEnd = originalFogEnd
end

return Removals
