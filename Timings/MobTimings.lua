-- Timings/MobTimings.lua
local MobTimings = {}

local function createMobTiming(name, hitbox, parryTime, imxd, actionType)
    return {
        _id = name,
        name = name,
        tag = "Mantra",
        hitbox = hitbox or Vector3.new(50, 50, 50),
        imdd = 0,
        imxd = imxd or 100,
        duih = false,
        fhb = true,
        hso = 0,
        nbfb = false,
        nvfb = false,
        ndfb = false,
        bfht = 0.3,
        pfh = false,
        phd = false,
        phds = 0,
        pfht = 0.15,
        dp = false,
        ffh = false,
        actions = {
            {
                _type = actionType or "Parry",
                _when = parryTime or 750,
                name = name .. " Action",
                hitbox = hitbox or Vector3.new(50, 50, 50),
                ihbc = false,
            }
        }
    }
}

-- TITUS
MobTimings["TitusDrive"] = createMobTiming("TitusDrive", Vector3.new(30, 20, 50), 700, 40, "Dodge")
MobTimings["TitusKick"] = createMobTiming("TitusKick", Vector3.new(20, 20, 50), 400, 30, "Dodge")
MobTimings["TitusSkycrash"] = createMobTiming("TitusSkycrash", Vector3.new(30, 50, 53), 175, 50, "Dodge")
MobTimings["TitusVault"] = createMobTiming("TitusVault", Vector3.new(70, 100, 75), 1300, 60, "Dodge")

-- PRIMADON
MobTimings["PrimadonStomp"] = createMobTiming("PrimadonStomp", Vector3.new(80, 250, 80), 750, 100)
MobTimings["PrimadonTripleStomp"] = {
    _id = "PrimadonTripleStomp",
    name = "Primadon Triple Stomp",
    tag = "Mantra",
    hitbox = Vector3.new(80, 250, 80),
    imdd = 0,
    imxd = 100,
    duih = false,
    fhb = true,
    hso = 0,
    nbfb = false,
    nvfb = false,
    ndfb = false,
    bfht = 0.3,
    pfh = false,
    phd = false,
    phds = 0,
    pfht = 0.15,
    dp = false,
    ffh = false,
    actions = {
        { _type = "Parry", _when = 800, name = "Triple Stomp 1", hitbox = Vector3.new(80, 250, 80), ihbc = false },
        { _type = "Parry", _when = 1400, name = "Triple Stomp 2", hitbox = Vector3.new(80, 250, 80), ihbc = false },
        { _type = "Parry", _when = 2050, name = "Triple Stomp 3", hitbox = Vector3.new(80, 250, 80), ihbc = false }
    }
}
MobTimings["PrimadonPunch"] = createMobTiming("PrimadonPunch", Vector3.new(80, 250, 80), 1050, 80)
MobTimings["PrimadonGrab"] = createMobTiming("PrimadonGrab", Vector3.new(80, 250, 80), 900, 80, "Forced Full Dodge")
MobTimings["PrimadonKick"] = createMobTiming("PrimadonKick", Vector3.new(80, 250, 80), 900, 80, "Dodge")
MobTimings["PrimadonMidPunch"] = createMobTiming("PrimadonMidPunch", Vector3.new(80, 250, 80), 600, 80)

-- DUKE
MobTimings["DukeGrasp"] = createMobTiming("DukeGrasp", Vector3.new(160, 120, 160), 1100, 150)
MobTimings["DukeStomp"] = createMobTiming("DukeStomp", Vector3.new(40, 40, 100), 650, 80, "Dodge")

-- CHASER
MobTimings["ChaserSlam"] = createMobTiming("ChaserSlam", Vector3.new(70, 70, 70), 920, 80)
MobTimings["HitTendril"] = {
    _id = "HitTendril",
    name = "Hit Tendril",
    tag = "Mantra",
    hitbox = Vector3.new(40, 40, 40),
    imdd = 0,
    imxd = 50,
    duih = false,
    fhb = true,
    hso = 0,
    nbfb = false,
    nvfb = false,
    ndfb = false,
    bfht = 0.3,
    pfh = false,
    phd = false,
    phds = 0,
    pfht = 0.15,
    dp = false,
    ffh = false,
    actions = {
        { _type = "Forced Full Dodge", _when = 585, name = "Hit Tendril Dodge", hitbox = Vector3.new(40, 40, 40), ihbc = true },
        { _type = "Parry", _when = 600, name = "Hit Tendril Parry", hitbox = Vector3.new(40, 40, 40), ihbc = true }
    }
}

-- ETHIRON
MobTimings["EthironBeam"] = createMobTiming("EthironBeam", Vector3.new(50, 50, 200), 150, 200, "Forced Full Dodge")
MobTimings["EthironBlind"] = createMobTiming("EthironBlind", Vector3.new(800, 800, 800), 1400, 500)

return MobTimings
