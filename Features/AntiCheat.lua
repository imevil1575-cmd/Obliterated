-- Features/AntiCheat.lua
local AntiCheat = {}
AntiCheat.__index = AntiCheat

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local isRunning = false
local config = nil
local detectedMods = {}

function AntiCheat:init(parentModule)
    config = parentModule and parentModule.config or {}
    isRunning = true
    print("✓ AntiCheat initialized")
end

function AntiCheat:aaBypass()
    local cfg = config or {}
    if not cfg.aa_bypass then return end
    
    local character = Players.LocalPlayer.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Water-based AA bypass
    local waterParts = workspace:FindFirstChild("WaterParts")
    if waterParts then
        for _, water in ipairs(waterParts:GetChildren()) do
            if water:IsA("BasePart") and root.Position.Y < water.Position.Y then
                root.AssemblyLinearVelocity = Vector3.new(0, -50, 0)
            end
        end
    end
end

function AntiCheat:detectMods()
    local cfg = config or {}
    if not cfg.mod_detector then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == Players.LocalPlayer then continue end
        if not detectedMods[player] and self:isPlayerMod(player) then
            detectedMods[player] = true
            print("[AntiCheat] Mod detected: " .. player.Name)
        end
    end
end

function AntiCheat:isPlayerMod(player)
    local success, result = pcall(function()
        local response = HttpService:GetAsync("https://groups.roblox.com/v2/users/" .. player.UserId .. "/groups/roles")
        local data = HttpService:JSONDecode(response)
        for _, group in ipairs(data.data or {}) do
            if group.group.id == 5212858 and group.role.rank > 0 then
                return true
            end
        end
        return false
    end)
    return success and result or false
end

function AntiCheat:removeHarrow()
    local effectReplicator = ReplicatedStorage:FindFirstChild("EffectReplicator")
    if not effectReplicator then return end
    
    local success, module = pcall(require, effectReplicator)
    if not success or not module then return end
    
    for _, effect in ipairs(module.Effects or {}) do
        if effect.Class == "Harrow" or effect.Class == "Harrowed" then
            effect:Remove()
        end
    end
end

function AntiCheat:update(dt)
    if not isRunning then return end
    self:aaBypass()
    self:detectMods()
    self:removeHarrow()
end

function AntiCheat:detach()
    isRunning = false
end

return AntiCheat
