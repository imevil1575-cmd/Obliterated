-- Features/AnimationLogger.lua - Learns new animations
local AnimationLogger = {}
AnimationLogger.__index = AnimationLogger

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local isRunning = false
local isLogging = true
local learnedAnimations = {}
local trackedUnknowns = {}

function AnimationLogger:init(parentModule)
    isRunning = true
    isLogging = true
    print("✓ Animation Logger initialized")
end

function AnimationLogger:toggle()
    isLogging = not isLogging
    print("Animation Logger: " .. (isLogging and "ON" or "OFF"))
end

function AnimationLogger:update(dt)
    if not isRunning or not isLogging then return end
    
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
            if not learnedAnimations[id] and not trackedUnknowns[id] then
                self:learnAnimation(id, track, entity)
            end
        end
    end
end

function AnimationLogger:learnAnimation(id, track, entity)
    trackedUnknowns[id] = true
    
    print("[Logger] Learning: " .. id)
    
    local startTime = os.clock()
    local hitTimes = {}
    local connection
    
    connection = RunService.Heartbeat:Connect(function()
        if not track.IsPlaying then
            connection:Disconnect()
            self:finalizeLearning(id, hitTimes)
            trackedUnknowns[id] = nil
            return
        end
        
        local timePos = track.TimePosition
        if timePos > 0.1 and timePos < 0.8 and track.Speed > 0.5 then
            hitTimes[#hitTimes + 1] = os.clock() - startTime
        end
    end)
    
    task.delay(8, function()
        if connection and connection.Connected then
            connection:Disconnect()
            self:finalizeLearning(id, hitTimes)
            trackedUnknowns[id] = nil
        end
    end)
end

function AnimationLogger:finalizeLearning(id, hitTimes)
    if learnedAnimations[id] then return end
    
    local parryTime = 250 -- default 250ms
    if #hitTimes > 0 then
        local sum = 0
        for _, t in ipairs(hitTimes) do sum = sum + t end
        parryTime = math.clamp((sum / #hitTimes) * 1000, 50, 2000)
    end
    
    learnedAnimations[id] = {
        _id = id,
        name = "Learned: " .. string.sub(id, -10),
        tag = "Learned",
        hitbox = Vector3.new(15, 15, 15),
        imdd = 0,
        imxd = 40,
        duih = false,
        fhb = true,
        nbfb = true,
        actions = {
            { _type = "Parry", _when = parryTime, name = "Learned Parry", hitbox = Vector3.new(15, 15, 15), ihbc = false }
        }
    }
    
    -- Add to TimingManager
    local TimingManager = require(script.Parent.Parent.Timings.TimingManager)
    TimingManager.add(id, learnedAnimations[id])
    
    print("[Logger] ✅ Learned: " .. id .. " (Parry: " .. string.format("%.0f", parryTime) .. "ms)")
end

function AnimationLogger:getLearned()
    return learnedAnimations
end

function AnimationLogger:count()
    local count = 0
    for _ in pairs(learnedAnimations) do count = count + 1 end
    return count
end

function AnimationLogger:detach()
    isRunning = false
end

return AnimationLogger
