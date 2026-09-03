-- Timings/Action.lua
local Action = {}
Action.__index = Action

function Action.new()
    local self = setmetatable({}, Action)
    self._type = "N/A"
    self._when = 0
    self.name = ""
    self.hitbox = Vector3.zero
    self.ihbc = false
    return self
end

function Action:when()
    return self._when / 1000
end

Action.TYPES = {
    PARRY = "Parry",
    DODGE = "Dodge",
    START_BLOCK = "Start Block",
    END_BLOCK = "End Block",
    JUMP = "Jump",
    TELEPORT_UP = "Teleport Up",
    FORCED_FULL_DODGE = "Forced Full Dodge",
    START_SLIDE = "Start Slide",
    END_SLIDE = "End Slide",
    START_CROUCH = "Start Crouch",
    END_CROUCH = "End Crouch",
}

return Action
