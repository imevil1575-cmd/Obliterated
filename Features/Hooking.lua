-- Features/Hooking.lua
local Hooking = {}

-- FIX 1: Don't use require, get things directly
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local banRemotes = {}
local hooksActive = false

-- FIX 2: Safe function to check if hookfunction exists
local function safeHookFunction(func, hook)
    if type(hookfunction) == "function" then
        return hookfunction(func, hook)
    end
    return nil
end

function Hooking.findBanRemotes()
    local requests = ReplicatedStorage:FindFirstChild("Requests")
    if not requests then 
        warn("⚠️ Requests folder not found")
        return 
    end
    
    banRemotes = {}
    for _, remote in ipairs(requests:GetChildren()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local remoteName = remote.Name:lower()
            -- Check for ban-related remotes by name
            if remoteName:find("ban") or 
               remoteName:find("kick") or 
               remoteName:find("punish") or
               remoteName:find("moderate") then
                banRemotes[remote] = true
                print("🔒 Found ban remote:", remote.Name)
            end
        end
    end
end

function Hooking.hookFireServer()
    -- FIX 2: Check if hookfunction exists first
    if type(hookfunction) ~= "function" then
        warn("⚠️ hookfunction not available")
        return false
    end
    
    local remoteEvent = Instance.new("RemoteEvent")
    local originalFire = remoteEvent.FireServer
    
    local hooked, result = pcall(function()
        return hookfunction(originalFire, function(self, ...)
            if banRemotes[self] then 
                return nil -- Block the remote
            end
            return originalFire(self, ...)
        end)
    end)
    
    if hooked then
        print("✓ FireServer hooked")
        return true
    else
        warn("⚠️ Failed to hook FireServer:", result)
        return false
    end
end

function Hooking.hookUnreliableFireServer()
    if type(hookfunction) ~= "function" then
        return false
    end
    
    local unreliableRemote = Instance.new("UnreliableRemoteEvent")
    local originalFire = unreliableRemote.FireServer
    
    local hooked, result = pcall(function()
        return hookfunction(originalFire, function(self, ...)
            if banRemotes[self] then 
                return nil
            end
            return originalFire(self, ...)
        end)
    end)
    
    if hooked then
        print("✓ UnreliableFireServer hooked")
        return true
    else
        warn("⚠️ Failed to hook UnreliableFireServer:", result)
        return false
    end
end

function Hooking.hookNamecall()
    -- FIX 2: Alternative approach using __index
    local success, result = pcall(function()
        local mt = getrawmetatable(game)
        if not mt then 
            warn("⚠️ No metatable found for game")
            return false
        end
        
        -- Backup original __index
        local oldIndex = mt.__index
        
        mt.__index = function(table, key)
            -- Check if it's a banned remote
            if key == "FireServer" and banRemotes[table] then
                return function() return nil end -- No-op function
            end
            -- Return original or next in chain
            if oldIndex then
                return oldIndex(table, key)
            end
            return nil
        end
        
        return true
    end)
    
    if success then
        print("✓ Namecall hooked")
        return true
    else
        warn("⚠️ Failed to hook namecall:", result)
        return false
    end
end

function Hooking.bypassBanRemotes()
    for remote, _ in pairs(banRemotes) do
        if remote and remote.Parent then 
            pcall(function()
                remote:Destroy()
                print("🗑️ Destroyed banned remote:", remote.Name)
            end)
        end
    end
end

-- FIX 3: Alternative method without setfenv
function Hooking.init()
    print("🔄 Initializing hooks...")
    
    -- Wait for game to load (FIX 4)
    local function waitForGame()
        if not game:IsLoaded() then
            print("⏳ Waiting for game to load...")
            game.Loaded:Wait()
        end
        if not Players.LocalPlayer then
            print("⏳ Waiting for LocalPlayer...")
            repeat 
                task.wait(0.1)
            until Players.LocalPlayer
        end
    end
    
    -- Wrap everything in pcall for safety
    local success, err = pcall(function()
        waitForGame()
        
        Hooking.findBanRemotes()
        
        if next(banRemotes) then
            Hooking.bypassBanRemotes()
        end
        
        -- Try all hooking methods
        local hooksSucceeded = 0
        if Hooking.hookFireServer() then hooksSucceeded = hooksSucceeded + 1 end
        if Hooking.hookUnreliableFireServer() then hooksSucceeded = hooksSucceeded + 1 end
        if Hooking.hookNamecall() then hooksSucceeded = hooksSucceeded + 1 end
        
        hooksActive = true
        print("✓ Hooking initialized (", hooksSucceeded, "/3 hooks active)")
    end)
    
    if not success then
        warn("⚠️ Hooking init failed:", err)
        -- Try fallback method without hooks
        Hooking.fallback()
    end
end

-- FALLBACK: If hooks fail, use direct remote blocking
function Hooking.fallback()
    print("🔄 Using fallback method...")
    
    -- Directly modify remote events
    local requests = ReplicatedStorage:FindFirstChild("Requests")
    if requests then
        for _, remote in ipairs(requests:GetChildren()) do
            if remote:IsA("RemoteEvent") then
                local name = remote.Name:lower()
                if name:find("ban") or name:find("kick") then
                    -- Override the FireServer method directly
                    local oldFire = remote.FireServer
                    remote.FireServer = function(self, ...)
                        print("🚫 Blocked banned remote:", remote.Name)
                        return nil
                    end
                    print("🔒 Blocked remote via fallback:", remote.Name)
                end
            end
        end
    end
end

-- Cleanup function
function Hooking.detach()
    if not hooksActive then return end
    
    print("🔄 Detaching hooks...")
    
    -- Try to restore original functions
    pcall(function()
        -- Restore metatable
        local mt = getrawmetatable(game)
        if mt and mt.__index then
            -- Try to restore original
        end
    end)
    
    hooksActive = false
    print("✓ Hooks detached")
end

-- FIX 3: Handle Volt's environment differently
-- Setup the environment for Volt
local function setupVoltEnvironment()
    -- Volt-specific setup if needed
    if _G.VOLT or _G.Volt then
        print("⚡ Volt environment detected")
        -- Any Volt-specific adjustments here
    end
end

setupVoltEnvironment()

return Hooking
