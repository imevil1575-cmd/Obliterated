-- Timings/EffectTimings.lua
local EffectTimings = {}

EffectTimings["DisplayThorns"] = {
    _id = "DisplayThorns",
    name = "Display Thorns",
    tag = "Undefined",
    hitbox = Vector3.new(30, 30, 30),
    imdd = 0,
    imxd = 40,
    duih = false,
    fhb = true,
    hso = 0,
    nbfb = true,
    nvfb = false,
    ndfb = false,
    bfht = 0.3,
    pfh = false,
    phd = false,
    phds = 0,
    pfht = 0.15,
    dp = false,
    actions = {
        { _type = "Parry", _when = 0, name = "Display Thorns Parry", hitbox = Vector3.new(30, 30, 30), ihbc = true }
    }
}

EffectTimings["DisplayThornsRed"] = {
    _id = "DisplayThornsRed",
    name = "Display Thorns Red",
    tag = "Undefined",
    hitbox = Vector3.new(30, 30, 30),
    imdd = 0,
    imxd = 40,
    duih = false,
    fhb = true,
    hso = 0,
    nbfb = true,
    nvfb = false,
    ndfb = false,
    bfht = 0.3,
    pfh = false,
    phd = false,
    phds = 0,
    pfht = 0.15,
    dp = false,
    actions = {
        { _type = "Parry", _when = 0, name = "Display Thorns Red Parry", hitbox = Vector3.new(30, 30, 30), ihbc = true }
    }
}

EffectTimings["OwlDisperse"] = {
    _id = "OwlDisperse",
    name = "Owl Disperse",
    tag = "Undefined",
    hitbox = Vector3.new(20, 20, 20),
    imdd = 0,
    imxd = 50,
    duih = false,
    fhb = false,
    hso = 0,
    nbfb = true,
    nvfb = false,
    ndfb = true,
    bfht = 0.3,
    pfh = false,
    phd = false,
    phds = 0,
    pfht = 0.15,
    dp = false,
    rpue = true,
    _rsd = 0,
    _rpd = 250,
    actions = {}
}

return EffectTimings
