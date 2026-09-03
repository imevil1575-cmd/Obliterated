-- Utils/Signal.lua
local Signal = {}
Signal.__index = Signal

function Signal.new()
    local self = setmetatable({}, Signal)
    self._connections = {}
    return self
end

function Signal:connect(callback)
    local conn = { callback = callback, connected = true }
    table.insert(self._connections, conn)
    return conn
end

function Signal:fire(...)
    local toRemove = {}
    for i, conn in ipairs(self._connections) do
        if conn.connected then
            pcall(conn.callback, ...)
        else
            toRemove[#toRemove + 1] = i
        end
    end
    for i = #toRemove, 1, -1 do
        table.remove(self._connections, toRemove[i])
    end
end

return Signal
