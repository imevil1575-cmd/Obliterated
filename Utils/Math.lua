-- Utils/Math.lua
local Math = {}

function Math.clamp(val, min, max)
    return math.max(min, math.min(max, val))
end

function Math.lerp(a, b, t)
    return a + (b - a) * t
end

function Math.randomColor()
    return Color3.fromRGB(
        math.random(0, 255),
        math.random(0, 255),
        math.random(0, 255)
    )
end

return Math
