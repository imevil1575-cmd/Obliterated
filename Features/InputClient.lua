-- Features/InputClient.lua
local InputClient = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remotes = {}

function InputClient.cacheRemotes()
    local keybinds = ReplicatedStorage:FindFirstChild("KeyBinds")
    if not keybinds then
        warn("KeyBinds not found")
        return
    end
    
    remotes = {}
    
    -- Find remotes by name pattern
    for _, child in ipairs(keybinds:GetChildren()) do
        local name = child.Name
        if child:IsA("RemoteEvent") then
            if name:match("LeftClick") or name:match("M1") then remotes.leftClick = child
            elseif name:match("CriticalClick") or name:match("Crit") then remotes.criticalClick = child
            elseif name:match("Feint") then remotes.feintClick = child
            elseif name:match("Offhand") then remotes.offhandAttack = child
            elseif name:match("Block") then remotes.block = child
            elseif name:match("Unblock") then remotes.unblock = child
            elseif name:match("Dodge") or name:match("Roll") then remotes.dodge = child
            elseif name:match("StopDodge") or name:match("StopRoll") then remotes.stopDodge = child
            elseif name:match("Sprint") then remotes.sprint = child
            elseif name:match("Crouch") then remotes.crouch = child
            elseif name:match("Jump") then remotes.jump = child
            elseif name:match("ActivateMantra") then remotes.activateMantra = child
            end
        end
    end
end

function InputClient.init(parent)
    InputClient.cacheRemotes()
end

function InputClient.leftClick(cframe)
    if remotes.leftClick then 
        pcall(function() remotes.leftClick:FireServer(cframe) end)
    end
end

function InputClient.criticalClick(cframe)
    if remotes.criticalClick then 
        pcall(function() remotes.criticalClick:FireServer(cframe) end)
    end
end

function InputClient.feint()
    if remotes.feintClick then 
        pcall(function() remotes.feintClick:FireServer() end)
    end
end

function InputClient.block()
    if remotes.block then 
        pcall(function() remotes.block:FireServer() end)
    end
end

function InputClient.unblock()
    if remotes.unblock then 
        pcall(function() remotes.unblock:FireServer() end)
    end
end

function InputClient.dodge(rollType, cancel)
    if remotes.dodge then 
        pcall(function() remotes.dodge:FireServer(rollType or "roll", nil, nil, cancel or false) end)
    end
end

function InputClient.stopDodge()
    if remotes.stopDodge then 
        pcall(function() remotes.stopDodge:FireServer() end)
    end
end

function InputClient.sprint(state)
    if remotes.sprint then 
        pcall(function() remotes.sprint:FireServer(state) end)
    end
end

function InputClient.crouch(state)
    if remotes.crouch then 
        pcall(function() remotes.crouch:FireServer(state) end)
    end
end

function InputClient.jump()
    if remotes.jump then 
        pcall(function() remotes.jump:FireServer() end)
    end
end

function InputClient.activateMantra(tool)
    if remotes.activateMantra then 
        pcall(function() remotes.activateMantra:FireServer(tool) end)
    end
end

return InputClient
