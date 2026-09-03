-- Utils/Table.lua
local Table = {}

function Table.contains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then return true end
    end
    return false
end

function Table.find(tbl, predicate)
    for i, v in ipairs(tbl) do
        if predicate(v, i) then return i, v end
    end
    return nil
end

function Table.clone(tbl)
    local new = {}
    for k, v in pairs(tbl) do
        new[k] = v
    end
    return new
end

function Table.merge(tbl1, tbl2)
    local new = Table.clone(tbl1)
    for k, v in pairs(tbl2) do
        new[k] = v
    end
    return new
end

function Table.size(tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    return count
end

return Table
