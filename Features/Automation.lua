-- Features/Automation.lua
local Automation = {}
Automation.__index = Automation

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local isRunning = false
local config = nil

function Automation:init(parentModule)
    config = parentModule and parentModule.config or {}
    isRunning = true
    print("✓ Automation initialized")
end

function Automation:autoLoot()
    if not config.auto_loot then return end
    
    local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end
    
    local choicePrompt = playerGui:FindFirstChild("ChoicePrompt")
    if not choicePrompt then return end
    
    local choiceFrame = choicePrompt:FindFirstChild("ChoiceFrame")
    if not choiceFrame then return end
    
    local options = choiceFrame:FindFirstChild("Options")
    if not options then return end
    
    local lootRarities = config.loot_all_rarities or { Mythic = true, Legendary = true, Enchant = true }
    local alwaysLoot = config.always_loot or {}
    local itemName = config.item_loot_input or ""
    
    for _, option in ipairs(options:GetChildren()) do
        if option:IsA("TextButton") then
            local text = option.Text or ""
            local shouldLoot = false
            
            for rarity, enabled in pairs(lootRarities) do
                if enabled and text:find(rarity) then shouldLoot = true break end
            end
            for _, item in ipairs(alwaysLoot) do
                if text:find(item) then shouldLoot = true break end
            end
            if itemName ~= "" and text:find(itemName) then shouldLoot = true end
            
            if shouldLoot then
                option:FireServer()
                task.wait(0.05)
            end
        end
    end
end

function Automation:antiAFK()
    if not config.anti_afk then return end
    local virtualUser = game:GetService("VirtualUser")
    if virtual
