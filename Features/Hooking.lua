-- Features/Hooking.lua
local Hooking = {}

-- Direct service access (Loader handles waiting)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- State variables
local banRemotes = {}
local hooksActive = false

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

-- DIRECT REMOTE BLOCKING (Works in Volt)
function Hooking.blockRemotesDirect()
    print("🔄 Applying direct remote blocking...")
    local requests = ReplicatedStorage:FindFirstChild("Requests")
    if not requests then 
        warn("⚠️ Requests folder not found")
        return 
    end
    
    local count = 0
    for _, remote in ipairs(requests:GetChildren()) do
        if remote:IsA("RemoteEvent") then
            local name = remote.Name:lower()
            if name:find("ban") or name:find("kick") or name:find("punish") then
                -- Override FireServer directly (works in Volt)
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
        print("ℹ️ No remotes to block")
    end
end

-- MAIN INIT FUNCTION
function Hooking.init()
    print("🔄 Initializing hooks...")
    print("🔧 Environment: Volt")
    
    -- Find ban remotes
    Hooking.findBanRemotes()
    
    -- Destroy them if found
    if next(banRemotes) then
        Hooking.bypassBanRemotes()
    end
    
    -- Always apply direct blocking (works in Volt)
    Hooking.blockRemotesDirect()
    
    hooksActive = true
    print("✅ Hooking ready!")
end

-- GET STATUS
function Hooking.getStatus()
    return {
        active = hooksActive,
        bannedRemotes = #banRemotes,
        servicesAvailable = {
            players = Players ~= nil,
            replicatedStorage = ReplicatedStorage ~= nil
        }
    }
end

-- DETACH (Cleanup)
function Hooking.detach()
    if not hooksActive then 
        print("ℹ️ No hooks to detach")
        return 
    end
    
    print("🔄 Detaching hooks...")
    -- In Volt, we can't easily restore overridden functions
    -- But we can reset state
    banRemotes = {}
    hooksActive = false
    print("✅ Hooks detached")
end

return Hooking
