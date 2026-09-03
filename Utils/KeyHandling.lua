-- Utils/KeyHandling.lua
local KeyHandling = {}

local remoteTable = nil
local randomTable = nil
local hashCache = {}

local function nts(num, iter)
    local str = ""
    for _ = 1, iter do
        local v78 = num % 256
        str = string.char(v78) .. str
        num = (num - v78) / 256
    end
    return str
end

local function stn(str, len)
    local num = 0
    for i = len, len + 3 do
        num = num * 256 + string.byte(str, i)
    end
    return num
end

local function preprocess(msg, len)
    return msg .. string.char(128) .. string.rep(string.char(0), 64 - (len + 9) % 64) .. nts(8 * len, 8)
end

local function digest(msg, i, H)
    local chunks = {}
    for j = 1, 16 do
        chunks[j] = stn(msg, i + (j - 1) * 4)
    end
    for j = 17, 64 do
        local v103 = chunks[j - 15]
        local v104 = bit32.bxor(bit32.rrotate(v103, 7), bit32.rrotate(v103, 18), bit32.rshift(v103, 3))
        v103 = chunks[j - 2]
        chunks[j] = chunks[j - 16] + v104 + chunks[j - 7] + bit32.bxor(bit32.rrotate(v103, 17), bit32.rrotate(v103, 19), bit32.rshift(v103, 10))
    end
    local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]
    for iter = 1, 64 do
        local v114 = bit32.bxor(bit32.rrotate(a, 2), bit32.rrotate(a, 13), bit32.rrotate(a, 22)) + bit32.bxor(bit32.band(a, b), bit32.band(a, c), bit32.band(b, c))
        local v115 = bit32.bxor(bit32.rrotate(e, 6), bit32.rrotate(e, 11), bit32.rrotate(e, 25))
        local v116 = bit32.bxor(bit32.band(e, f), bit32.band(bit32.bnot(e), g))
        local v117 = h + v115 + v116 + randomTable[iter] + chunks[iter]
        h, g, f, e, d, c, b, a = g, f, e, d + v117, c, b, a, v117 + v114
    end
    H[1] = bit32.band(H[1] + a)
    H[2] = bit32.band(H[2] + b)
    H[3] = bit32.band(H[3] + c)
    H[4] = bit32.band(H[4] + d)
    H[5] = bit32.band(H[5] + e)
    H[6] = bit32.band(H[6] + f)
    H[7] = bit32.band(H[7] + g)
    H[8] = bit32.band(H[8] + h)
end

local function hash(remoteName)
    if hashCache[remoteName] then return hashCache[remoteName] end
    local processed = preprocess(remoteName, #remoteName)
    local ht = {1779033703, 3144134277, 1013904242, 2773480762, 1359893119, 2600822924, 528734635, 1541459225}
    for iter = 1, #remoteName, 64 do
        digest(processed, iter, ht)
    end
    local result = nts(ht[1], 4) .. nts(ht[2], 4) .. nts(ht[3], 4) .. nts(ht[4], 4) ..
                   nts(ht[5], 4) .. nts(ht[6], 4) .. nts(ht[7], 4) .. nts(ht[8], 4)
    hashCache[remoteName] = result
    return result
end

function KeyHandling.findRemoteTables(upvalues)
    for _, upvalue in next, upvalues do
        if typeof(upvalue) == "table" and not getrawmetatable(upvalue) and #upvalue == 0 and not upvalue[10] then
            return upvalue
        end
    end
    return nil
end

function KeyHandling.searchForKeyHandlerData()
    for _, value in next, getgc(true) do
        if typeof(value) == "table" and not getrawmetatable(value) then
            local firstIndex, firstValue = next(value)
            if typeof(firstIndex) == "number" and typeof(firstValue) == "number" and 
               firstValue > 100000 and firstValue < 100000000 and #value == 68 then
                randomTable = value
            end
        end
        if typeof(value) == "function" and not iscclosure(value) and not isexecutorclosure(value) then
            local info = debug.getinfo(value)
            if info and info.short_src and info.short_src:match("KeyHandler") then
                local upvalues = debug.getupvalues(value)
                local found = KeyHandling.findRemoteTables(upvalues)
                if found then remoteTable = found end
            end
        end
        if remoteTable and randomTable then return true end
    end
    return false
end

function KeyHandling.getRemote(remoteName)
    if not remoteTable or not randomTable then
        if not KeyHandling.searchForKeyHandlerData() then return nil end
    end
    return remoteTable[hash(remoteName)]
end

return KeyHandling
