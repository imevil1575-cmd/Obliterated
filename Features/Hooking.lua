-- Features/Hooking.lua
local Hooking = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local banRemotes = {}
local hooksActive = false
local hookResults = {
    fireServer = false,
    unreliableFireServer = false,
    namecall = false
}

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
            if remoteName:find("ban") or 
               remoteName:find("kick") or 
               remoteName:find("punish") or
               remoteName:find("moderate") or
               remoteName:find("admin") then
                banRemotes[remote] = true
                print("🔒 Found ban remote:", remote.Name)
            end
        end
    end
end

function Hooking.hookFireServer()
    if type(hookfunction) ~= "function" then
        warn("⚠️ hookfunction not available")
        return false
    end
    
    local remoteEvent = Instance.new("RemoteEvent")
    local originalFire = remoteEvent.FireServer
    
    local hooked, result = pcall(function()
        return hookfunction(originalFire, function(self, ...)
            if banRemotes[self] then 
                return nil
            end
            return originalFire(self, ...)
        end)
    end)
    
    if hooked then
        print("✅ FireServer hooked")
        hookResults.fireServer = true
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
        print("✅ UnreliableFireServer hooked")
        hookResults.unreliableFireServer = true
        return true
    else
        warn("⚠️ Failed to hook UnreliableFireServer:", result)
        return false
    end
end

function Hooking.hookNamecall()
    -- This will likely fail in Volt (readonly table)
    -- But that's okay, it's not critical
    local success, result = pcall(function()
        local mt = getrawmetatable(game)
        if not mt then 
            warn("⚠️ No metatable found for game")
            return false
        end
        
        -- Try to get the real __namecall
        local oldNamecall = mt.__namecall
        if not oldNamecall then
            warn("⚠️ __namecall not found")
            return false
        end
        
        -- Attempt to modify (will likely fail in Volt)
        mt.__namecall = function(...)
            local self = {...}[1]
            if banRemotes[self] then
                return nil
            end
            return oldNamecall(...)
        end
        
        return true
    end)
    
    if success then
        print("✅ Namecall hooked")
        hookResults.namecall = true
        return true
    else
        -- Expected error in Volt: "attempt to modify a readonly table"
        -- This is fine, we have fallbacks
        if result:find("readonly") then
            print("ℹ️ Namecall hook skipped (readonly table - expected in Volt)")
        else
            warn("⚠️ Failed to hook namecall:", result)
        end
        return false
    end
end

function Hooking.bypassBanRemotes()
    local count = 0
    for remote, _ in pairs(banRemotes) do
        if remote and remote.Parent then 
            pcall(function()
                remote:Destroy()
                count = count + 1
                print("🗑️ Destroyed banned remote:", remote.Name)
            end)
        end
    end
    if count > 0 then
        print("✅ Destroyed", count, "banned remotes")
    end
end

-- Fallback: Direct remote blocking without hooks
function Hooking.blockRemotesDirect()
    print("🔄 Applying direct remote blocking...")
    local requests = ReplicatedStorage:FindFirstChild("Requests")
    if not requests then return end
    
    local count = 0
    for _, remote in ipairs(requests:GetChildren()) do
        if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("ban") or name:find("kick") or name:find("punish") then
                -- Store original function
                local originalFire = remote.FireServer
                
                -- Override with our block
                remote.FireServer = function(self, ...)
                    print("🚫 Blocked banned remote:", remote.Name)
                    return nil
                end
                count = count + 1
                print("🔒 Directly blocked:", remote.Name)
            end
        end
    end
    
    if count > 0 then
        print("✅ Directly blocked", count, "remotes")
    end
end

function Hooking.init()
    print("🔄 Initializing hooks...")
    print("🔧 Environment: Volt")
    
    -- Wait for game to load
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
        print("✅ Game loaded")
    end
    
    local success, err = pcall(function()
        waitForGame()
        
        -- Find all ban remotes
        Hooking.findBanRemotes()
        
        -- Destroy banned remotes if found
        if next(banRemotes) then
            Hooking.bypassBanRemotes()
        end
        
        -- Try hooking methods
        print("🔧 Attempting hooks...")
        Hooking.hookFireServer()
        Hooking.hookUnreliableFireServer()
        Hooking.hookNamecall() -- Will fail in Volt, but that's okay
        
        -- Count successful hooks
        local successCount = 0
        for _, v in pairs(hookResults) do
            if v then successCount = successCount + 1 end
        end
        
        print("✅ Hooking initialized (", successCount, "/3 hooks active)")
        
        -- Even if hooks fail, try direct blocking
        if successCount == 0 then
            print("🔄 No hooks active, using direct blocking...")
            Hooking.blockRemotesDirect()
        end
        
        hooksActive = true
    end)
    
    if not success then
        warn("⚠️ Hooking init failed:", err)
        -- Ultimate fallback: try direct blocking
        pcall(function()
            Hooking.blockRemotesDirect()
        end)
    end
end

function Hooking.getStatus()
    return {
        active = hooksActive,
        hooks = hookResults,
        bannedRemotes = #banRemotes
    }
end

function Hooking.detach()
    if not hooksActive then 
        print("ℹ️ No hooks to detach")
        return 
    end
    
    print("🔄 Detaching hooks...")
    
    -- Restore FireServer hooks if possible
    pcall(function()
        local remoteEvent = Instance.new("RemoteEvent")
        if hookResults.fireServer then
            -- Restore original
            hookfunction(remoteEvent.FireServer, remoteEvent.FireServer)
        end
    end)
    
    hooksActive = false
    print("✅ Hooks detached")
end

return Hooking
