-- Features/Movement.lua
local Movement = {}
Movement.__index = Movement

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local isRunning = false
local config = nil
local originalCollisions = {}

function Movement:init(parentModule)
    config = parentModule and parentModule.config or {}
    isRunning = true
    print("✓ Movement initialized")
end

function Movement:updateMovement(dt)
    local cfg = config or {}
    local character = Players.LocalPlayer.Character
    if not character then return end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- Speedhack
    if cfg.speed then
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0.001 then
            root.AssemblyLinearVelocity = moveDirection.Unit * cfg.walk_speed
        end
    end
    
    -- Fly
    if cfg.fly then
        local camera = workspace.CurrentCamera
        if camera then
            local moveVector = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + Vector3.new(0, 0, -1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector + Vector3.new(0, 0, 1) end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector + Vector3.new(-1, 0, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + Vector3.new(1, 0, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveVector = moveVector + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveVector = moveVector + Vector3.new(0, -1, 0) end
            
            if moveVector.Magnitude > 0 then
                moveVector = moveVector.Unit * cfg.fly_speed
                root.AssemblyLinearVelocity = camera.CFrame:VectorToWorldSpace(moveVector)
            end
        end
    end
    
    -- Noclip
    if cfg.noclip then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                if originalCollisions[part] == nil then
                    originalCollisions[part] = part.CanCollide
                end
                part.CanCollide = false
            end
        end
    else
        for part, canCollide in pairs(originalCollisions) do
            if part and part.Parent then part.CanCollide = canCollide end
        end
        originalCollisions = {}
    end
end

function Movement:update(dt)
    if not isRunning then return end
    self:updateMovement(dt)
end

function Movement:detach()
    isRunning = false
    for part, canCollide in pairs(originalCollisions) do
        if part and part.Parent then part.CanCollide = canCollide end
    end
    originalCollisions = {}
end

return Movement
