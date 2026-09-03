-- Features/ESP.lua
local ESP = {}
ESP.__index = ESP

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local isRunning = false
local config = nil
local espObjects = {}
local updateCounter = 0

local ESPObject = {}
ESPObject.__index = ESPObject

function ESPObject.new(instance, label, color, maxDist)
    local self = setmetatable({}, ESPObject)
    self.instance = instance
    self.label = label
    self.color = color or Color3.new(1, 1, 1)
    self.maxDist = maxDist or 50000
    self.billboard = nil
    self.enabled = true
    
    local billboard = Instance.new("BillboardGui")
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 30)
    billboard.Adornee = instance
    billboard.Parent = workspace
    billboard.Enabled = false
    
    local text = Instance.new("TextLabel")
    text.BackgroundTransparency = 1
    text.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json")
    text.Text = label
    text.TextColor3 = color
    text.TextSize = 14
    text.TextStrokeTransparency = 0.5
    text.Size = UDim2.new(1, 0, 1, 0)
    text.Parent = billboard
    
    self.billboard = billboard
    self.textLabel = text
    return self
end

function ESPObject:update()
    if not self.enabled then self.billboard.Enabled = false return end
    
    local char = Players.LocalPlayer.Character
    if not char then self.billboard.Enabled = false return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then self.billboard.Enabled = false return end
    
    local inst = self.instance
    if not inst or not inst.Parent then self.billboard.Enabled = false return end
    
    local pos = inst.Position or inst:GetPivot().Position
    if not pos then self.billboard.Enabled = false return end
    
    local dist = (root.Position - pos).Magnitude
    if dist > self.maxDist then self.billboard.Enabled = false return end
    
    self.billboard.Enabled = true
    self.textLabel.Text = self.label .. " [" .. math.floor(dist) .. "m]"
end

function ESPObject:destroy()
    if self.billboard then self.billboard:Destroy() end
end

function ESP:init(parentModule)
    config = parentModule and parentModule.config or {}
    isRunning = true
    print("✓ ESP initialized")
end

function ESP:createESP(instance, label, color, maxDist)
    local esp = ESPObject.new(instance, label, color, maxDist)
    table.insert(espObjects, esp)
    return esp
end

function ESP:update()
    if not isRunning then return end
    
    updateCounter = updateCounter + 1
    if updateCounter < (config.esp_update_rate or 9) then return end
    updateCounter = 0
    
    -- Update player ESP
    if config.player_esp then
        for _, player in ipairs(Players:GetPlayers()) do
            if player == Players.LocalPlayer then continue end
            local found = false
            for _, esp in ipairs(espObjects) do
                if esp.instance == player then found = true break end
            end
            if not found then
                self:createESP(player, player.Name, config.player_esp_color or Color3.new(1,1,1), config.player_esp_max_distance or 50000)
            end
        end
    end
    
    -- Update all ESP objects
    local toRemove = {}
    for i, esp in ipairs(espObjects) do
        if not esp.instance or not esp.instance.Parent then
            esp:destroy()
            toRemove[#toRemove + 1] = i
        else
            esp:update()
        end
    end
    for i = #toRemove, 1, -1 do table.remove(espObjects, toRemove[i]) end
end

function ESP:detach()
    isRunning = false
    for _, esp in ipairs(espObjects) do esp:destroy() end
    espObjects = {}
end

return ESP
