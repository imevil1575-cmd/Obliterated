-- Timings/PartTimings.lua
local PartTimings = {}

PartTimings["FireForgeProjectile"] = {
    _id = "FireForgeProjectile",
    name = "Fire Forge",
    tag = "Undefined",
    pname = "FireDagger",
    hitbox = Vector3.new(5, 25, 5),
    imdd = 0,
    imxd = 50,
    duih = true,
    uhc = true,
    fhb = false,
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
        { _type = "Parry", _when = 0, name = "Fire Forge Parry", hitbox = Vector3.new(5, 25, 5), ihbc = false }
    }
}

PartTimings["GrandJavelinProjectile"] = {
    _id = "GrandJavelinProjectile",
    name = "Grand Javelin",
    tag = "Undefined",
    pname = "SpearPart",
    hitbox = Vector3.new(20, 20, 70),
    imdd = 0,
    imxd = 80,
    duih = true,
    uhc = true,
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
        { _type = "Parry", _when = 0, name = "Grand Javelin Parry", hitbox = Vector3.new(20, 20, 70), ihbc = false }
    }
}

PartTimings["LightningStreamProjectile"] = {
    _id = "LightningStreamProjectile",
    name = "Lightning Stream",
    tag = "Undefined",
    pname = "STREAMPART",
    hitbox = Vector3.new(55, 55, 55),
    imdd = 0,
    imxd = 80,
    duih = true,
    uhc = true,
    fhb = false,
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
        { _type = "Parry", _when = 0, name = "Lightning Stream Parry", hitbox = Vector3.new(55, 55, 55), ihbc = false }
    }
}

return PartTimings
