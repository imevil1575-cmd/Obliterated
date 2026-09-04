-- Features/Automation.lua
local Automation = {}
Automation.__index = Automation

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local isRunning = false
local config = nil
local lastLootTime = 0

function Automation:init(parentModule)
    config = (parentModule and parentModule.config) or {}
    isRunning = true
    print("Automation initialized")
end

function Automation:autoLoot()
    if not config.auto_loot then return end
    
    -- Don't spam loot
    if tick() - lastLootTime < 0.5 then return end
    lastLootTime = tick()
    
    local character = Players.LocalPlayer.Character
    if not character then return end
    
    local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
    if not playerGui then return end
    
    -- Look for loot prompts
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
                if enabled and text:find(rarity) then 
                    shouldLoot = true 
                    break 
                end
            end
            
            if not shouldLoot then
                for _, item in ipairs(alwaysLoot) do
                    if text:find(item) then 
                        shouldLoot = true 
                        break 
                    end
                end
            end
            
            if not shouldLoot and itemName ~= "" and text:find(itemName) then 
                shouldLoot = true 
            end
            
            if shouldLoot then
                pcall(function()
                    -- Fire the button click
                    local args = {}
                    for _, arg in ipairs(option:GetAttributes()) do
                        table.insert(args, arg)
                    end
                    
                    -- Try to activate the button
                    if option.Parent and option.Parent.Parent then
                        -- Look for the remote that handles loot
                        local requests = ReplicatedStorage:FindFirstChild("Requests")
                        if requests then
                            local lootRemote = requests:FindFirstChild("Loot") or requests:FindFirstChild("Choice")
                            if lootRemote then
                                lootRemote:FireServer(text)
                            end
                        end
                    end
                end)
                task.wait(0.05)
            end
        end
    end
end

function Automation:antiAFK()
    if not config.anti_afk then return end
    
    local virtualUser = game:GetService("VirtualUser")
    if not virtualUser then return end
    
    -- Move mouse slightly every 30 seconds
    task.spawn(function()
        while isRunning and config.anti_afk do
            task.wait(30)
            pcall(function()
                virtualUser:CaptureController()
                virtualUser:ClickButton2(Vector2.new())
            end)
        end
    end)
end

function Automation:autoFish()
    if not config.auto_fish then return end
    
    -- Auto fish logic would go here
    -- This depends on the game's fishing system
end

function Automation:update(dt)
    if not isRunning then return end
    
    self:autoLoot()
end

function Automation:detach()
    isRunning = false
end

return Automation
