-- Features/Hooking.lua
local Hooking = {}

-- SAFE SERVICE GETTER
local function getService(serviceName)
    local success, service = pcall(function()
        return game:GetService(serviceName)
    end)
    if success and service then
        return service
    end
    warn("⚠️ Failed to get service: " .. serviceName)
    return nil
end

-- Get services safely
local Players = getService("Players")
local ReplicatedStorage = getService("ReplicatedStorage")

-- State variables
local banRemotes = {}
local hooksActive = false
local hookResults = {
    fireServer = false,
    unreliableFireServer = false,
    namecall = false
}

-- SAFE GAME LOAD WAITER
local function waitForGame()
    -- Check if game is loaded
    local success, isLoaded = pcall(function()
        return game:IsLoaded()
    end)
    
    if success and not isLoaded then
        print("⏳ Waiting for game to load...")
        local loaded = pcall(function()
            game.Loaded:Wait()
        end)
        if not loaded then
            warn("⚠️ Game load wait timed out")
        end
    end
    
    -- Wait for LocalPlayer
    if Players then
        local player = Players.LocalPlayer
        local attempts = 0
        while not player and attempts < 50 do
            task.wait(0.1)
            player = Players.LocalPlayer
            attempts = attempts + 1
        end
        if not player then
            warn("⚠️ LocalPlayer not found after 5 seconds")
        else
            print("✅ LocalPlayer found")
        end
    end
end

-- FIND BAN REMOTES
function Hooking.findBanRemotes()
    if not ReplicatedStorage then
        warn("⚠️ ReplicatedStorage not available")
        return
    end
    
    local requests = ReplicatedStorage:FindFirstChild("Requests")
    if not requests then 
        warn("⚠️ Requests folder not found")
        return 
    end
    
    banRemotes = {}
    local count = 0
    for _, remote in ipairs(requests:GetChildren()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local remoteName = remote.Name:lower()
            if remoteName:find("ban") or 
               remoteName:find("kick") or 
               remoteName:find("punish") or
               remoteName:find("moderate") or
               remoteName:find("admin") then
                banRemotes[remote] = true
                count = count + 1
                print("🔒 Found ban remote:", remote.Name)
            end
        end
    end
    
    if count > 0 then
        print("✅ Found", count, "ban remotes")
    else
        print("ℹ️ No ban remotes found")
    end
end

-- HOOK FIRESERVER
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

-- HOOK UNRELIABLE FIRESERVER
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

-- HOOK NAMECALL (will fail in Volt, that's okay)
function Hooking.hookNamecall()
    local success, result = pcall(function()
        local mt = getrawmetatable(game)
        if not mt then 
            warn("⚠️ No metatable found for game")
            return false
        end
        
        local oldNamecall = mt.__namecall
        if not oldNamecall then
            warn("⚠️ __namecall not found")
            return false
        end
        
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
        if result and result:find("readonly") then
            print("ℹ️ Namecall hook skipped (readonly table - expected)")
        else
            warn("⚠️ Failed to hook namecall:", result)
        end
        return false
    end
end

-- BYPASS BAN REMOTES (Destroy them)
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

-- FALLBACK: Direct remote blocking
function Hooking.blockRemotesDirect()
    if not ReplicatedStorage then
        warn("⚠️ ReplicatedStorage not available for direct blocking")
        return
    end
    
    print("🔄 Applying direct remote blocking...")
    local requests = ReplicatedStorage:FindFirstChild("Requests")
    if not requests then 
        warn("⚠️ Requests folder not found for direct blocking")
        return 
    end
    
    local count = 0
    for _, remote in ipairs(requests:GetChildren()) do
        if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("ban") or name:find("kick") or name:find("punish") then
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
    else
        print("ℹ️ No remotes to block directly")
    end
end

-- MAIN INIT FUNCTION
function Hooking.init()
    print("🔄 Initializing hooks...")
    print("🔧 Environment: Volt")
    
    -- Check if critical services exist
    if not ReplicatedStorage then
        warn("⚠️ ReplicatedStorage not available, retrying...")
        task.wait(1)
        ReplicatedStorage = getService("ReplicatedStorage")
        if not ReplicatedStorage then
            error("❌ Critical: ReplicatedStorage not available")
            return
        end
    end
    
    if not Players then
        Players = getService("Players")
        if not Players then
            error("❌ Critical: Players service not available")
            return
        end
    end
    
    -- Wait for game to load
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
    print("✅ All systems ready!")
end

-- GET STATUS
function Hooking.getStatus()
    return {
        active = hooksActive,
        hooks = hookResults,
        bannedRemotes = #banRemotes,
        servicesAvailable = {
            players = Players ~= nil,
            replicatedStorage = ReplicatedStorage ~= nil
        }
    }
end

-- DETACH HOOKS
function Hooking.detach()
    if not hooksActive then 
        print("ℹ️ No hooks to detach")
        return 
    end
    
    print("🔄 Detaching hooks...")
    
    pcall(function()
        local remoteEvent = Instance.new("RemoteEvent")
        if hookResults.fireServer then
            hookfunction(remoteEvent.FireServer, remoteEvent.FireServer)
        end
    end)
    
    hooksActive = false
    print("✅ Hooks detached")
end

-- AUTO-INIT WITH ERROR HANDLING
local function autoInit()
    local success, err = pcall(function()
        Hooking.init()
    end)
    
    if not success then
        warn("❌ Auto-init failed:", err)
        -- Try fallback direct blocking
        pcall(function()
            print("🔄 Trying fallback...")
            Hooking.blockRemotesDirect()
        end)
    end
end

-- Run auto-init
autoInit()

return Hooking
