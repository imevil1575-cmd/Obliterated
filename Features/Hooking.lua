-- Features/Hooking.lua
local Hooking = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KeyHandling = require(script.Parent.Parent.Utils.KeyHandling)

local oldFireServer = nil
local oldUnreliableFireServer = nil
local oldNameCall = nil
local banRemotes = {}

function Hooking.findBanRemotes()
    local requests = ReplicatedStorage:FindFirstChild("Requests")
    if not requests then return end
    banRemotes = {}
    for _, remote in ipairs(requests:GetChildren()) do
        if #getconnections(remote.Changed) > 0 then
            banRemotes[remote] = true
        end
    end
end

function Hooking.hookFireServer()
    oldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
        if banRemotes[self] then return end
        return oldFireServer(self, ...)
    end)
end

function Hooking.hookUnreliableFireServer()
    oldUnreliableFireServer = hookfunction(Instance.new("UnreliableRemoteEvent").FireServer, function(self, ...)
        if banRemotes[self] then return end
        return oldUnreliableFireServer(self, ...)
    end)
end

function Hooking.hookNamecall()
    oldNameCall = hookfunction(getrawmetatable(game).__namecall, function(...)
        local self = {...}[1]
        if banRemotes[self] then return end
        return oldNameCall(...)
    end)
end

function Hooking.bypassBanRemotes()
    for remote, _ in pairs(banRemotes) do
        if remote and remote.Parent then remote:Destroy() end
    end
end

function Hooking.init()
    Hooking.findBanRemotes()
    Hooking.bypassBanRemotes()
    Hooking.hookFireServer()
    Hooking.hookUnreliableFireServer()
    Hooking.hookNamecall()
    print("✓ Hooking initialized")
end

function Hooking.detach()
    if oldFireServer then hookfunction(Instance.new("RemoteEvent").FireServer, oldFireServer) end
    if oldUnreliableFireServer then hookfunction(Instance.new("UnreliableRemoteEvent").FireServer, oldUnreliableFireServer) end
    if oldNameCall then hookfunction(getrawmetatable(game).__namecall, oldNameCall) end
end

return Hooking
