-- Features/InputClient.lua
local InputClient = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KeyHandling = require(script.Parent.Parent.Utils.KeyHandling)

local remotes = {}

function InputClient.cacheRemotes()
    remotes = {
        leftClick = KeyHandling.getRemote("LeftClick"),
        criticalClick = KeyHandling.getRemote("CriticalClick"),
        feintClick = KeyHandling.getRemote("FeintClick"),
        offhandAttack = KeyHandling.getRemote("OffhandAttack"),
        block = KeyHandling.getRemote("Block"),
        unblock = KeyHandling.getRemote("Unblock"),
        dodge = KeyHandling.getRemote("Dodge"),
        stopDodge = KeyHandling.getRemote("StopDodge"),
        sprint = KeyHandling.getRemote("Sprint"),
        crouch = KeyHandling.getRemote("Crouch"),
        jump = KeyHandling.getRemote("Jump"),
        activateMantra = KeyHandling.getRemote("ActivateMantra"),
    }
end

function InputClient.leftClick(cframe)
    if remotes.leftClick then remotes.leftClick:FireServer(cframe) end
end

function InputClient.criticalClick(cframe)
    if remotes.criticalClick then remotes.criticalClick:FireServer(cframe) end
end

function InputClient.feint()
    if remotes.feintClick then remotes.feintClick:FireServer() end
end

function InputClient.block()
    if remotes.block then remotes.block:FireServer() end
end

function InputClient.unblock()
    if remotes.unblock then remotes.unblock:FireServer() end
end

function InputClient.dodge(rollType, cancel)
    if remotes.dodge then remotes.dodge:FireServer(rollType or "roll", nil, nil, cancel or false) end
end

function InputClient.stopDodge()
    if remotes.stopDodge then remotes.stopDodge:FireServer() end
end

function InputClient.sprint(state)
    if remotes.sprint then remotes.sprint:FireServer(state) end
end

function InputClient.crouch(state)
    if remotes.crouch then remotes.crouch:FireServer(state) end
end

function InputClient.jump()
    if remotes.jump then remotes.jump:FireServer() end
end

function InputClient.activateMantra(tool)
    if remotes.activateMantra then remotes.activateMantra:FireServer(tool) end
end

return InputClient
