-- Timings/MobTimings.lua - Mob and boss attack timings
local MobTimings = {}

-- Helper to create a mob timing
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

-- ===== TITUS =====
MobTimings["TitusDrive"] = createMobTiming("TitusDrive", Vector3.new(30, 20, 50), 700, 40, "Dodge")
MobTimings["TitusKick"] = createMobTiming("TitusKick", Vector3.new(20, 20, 50), 400, 30, "Dodge")
MobTimings["TitusSkycrash"] = createMobTiming("TitusSkycrash", Vector3.new(30, 50, 53), 175, 50, "Dodge")
MobTimings["TitusVault"] = createMobTiming("TitusVault", Vector3.new(70, 100, 75), 1300, 60, "Dodge")
MobTimings["TitusKickWindup"] = createMobTiming("TitusKickWindup", Vector3.new(20, 20, 50), 400, 30, "Dodge")
MobTimings["TitusSkycrashGo"] = createMobTiming("TitusSkycrashGo", Vector3.new(30, 50, 53), 175, 50, "Dodge")

-- ===== PRIMADON =====
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
        {
            _type = "Parry",
            _when = 800,
            name = "Triple Stomp 1",
            hitbox = Vector3.new(80, 250, 80),
            ihbc = false,
        },
        {
            _type = "Parry",
            _when = 1400,
            name = "Triple Stomp 2",
            hitbox = Vector3.new(80, 250, 80),
            ihbc = false,
        },
        {
            _type = "Parry",
            _when = 2050,
            name = "Triple Stomp 3",
            hitbox = Vector3.new(80, 250, 80),
            ihbc = false,
        }
    }
}
MobTimings["PrimadonPunch"] = createMobTiming("PrimadonPunch", Vector3.new(80, 250, 80), 1050, 80)
MobTimings["PrimadonGrab"] = createMobTiming("PrimadonGrab", Vector3.new(80, 250, 80), 900, 80, "Forced Full Dodge")
MobTimings["PrimadonKick"] = createMobTiming("PrimadonKick", Vector3.new(80, 250, 80), 900, 80, "Dodge")
MobTimings["PrimadonMidPunch"] = createMobTiming("PrimadonMidPunch", Vector3.new(80, 250, 80), 600, 80)
MobTimings["PrimadonUltimateStomp"] = createMobTiming("PrimadonUltimateStomp", Vector3.new(100, 250, 100), 2130, 100)
MobTimings["ElderPrimaSlam"] = createMobTiming("ElderPrimaSlam", Vector3.new(80, 250, 140), 1200, 100, "Dodge")
MobTimings["ElderPrimaStompFeint"] = createMobTiming("ElderPrimaStompFeint", Vector3.new(80, 250, 140), 750, 100)
MobTimings["ElderPrimaSixStomp"] = {
    _id = "ElderPrimaSixStomp",
    name = "Elder Prima Six Stomp",
    tag = "Mantra",
    hitbox = Vector3.new(100, 250, 100),
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
        { _type = "Parry", _when = 550, name = "Six Stomp 1", hitbox = Vector3.new(100, 250, 100), ihbc = false },
        { _type = "Parry", _when = 1000, name = "Six Stomp 2", hitbox = Vector3.new(100, 250, 100), ihbc = false },
        { _type = "Parry", _when = 1450, name = "Six Stomp 3", hitbox = Vector3.new(100, 250, 100), ihbc = false },
        { _type = "Parry", _when = 1800, name = "Six Stomp 4", hitbox = Vector3.new(100, 250, 100), ihbc = false },
        { _type = "Parry", _when = 2250, name = "Six Stomp 5", hitbox = Vector3.new(100, 250, 100), ihbc = false },
        { _type = "Parry", _when = 2700, name = "Six Stomp 6", hitbox = Vector3.new(100, 250, 100), ihbc = false }
    }
}

-- ===== DUKE =====
MobTimings["DukeGrasp"] = createMobTiming("DukeGrasp", Vector3.new(160, 120, 160), 1100, 150)
MobTimings["DukeStomp"] = createMobTiming("DukeStomp", Vector3.new(40, 40, 100), 650, 80, "Dodge")
MobTimings["DukeStrongLeft"] = createMobTiming("DukeStrongLeft", Vector3.new(23, 15, 25), 500, 40)

-- ===== CHASER =====
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
        {
            _type = "Forced Full Dodge",
            _when = 585,
            name = "Hit Tendril Dodge",
            hitbox = Vector3.new(40, 40, 40),
            ihbc = true,
        },
        {
            _type = "Parry",
            _when = 600,
            name = "Hit Tendril Parry",
            hitbox = Vector3.new(40, 40, 40),
            ihbc = true,
        }
    }
}

-- ===== ETHIRON =====
MobTimings["EthironBeam"] = createMobTiming("EthironBeam", Vector3.new(50, 50, 200), 150, 200, "Forced Full Dodge")
MobTimings["EthironBlind"] = createMobTiming("EthironBlind", Vector3.new(800, 800, 800), 1400, 500)

-- ===== RAT KING =====
MobTimings["RatKingSlashDash"] = {
    _id = "RatKingSlashDash",
    name = "Rat King Slash Dash",
    tag = "Mantra",
    hitbox = Vector3.new(40, 40, 40),
    imdd = 0,
    imxd = 80,
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
        { _type = "Parry", _when = 580, name = "Slash 1", hitbox = Vector3.new(40, 40, 40), ihbc = false },
        { _type = "Parry", _when = 1390, name = "Slash 2", hitbox = Vector3.new(40, 40, 40), ihbc = false },
        { _type = "Parry", _when = 2300, name = "Slash 3", hitbox = Vector3.new(50, 50, 50), ihbc = false }
    }
}
MobTimings["RatKingTurnDash"] = createMobTiming("RatKingTurnDash", Vector3.new(35, 40, 35), 350, 60)
MobTimings["RatKingChorusCrit"] = {
    _id = "RatKingChorusCrit",
    name = "Rat King Chorus Crit",
    tag = "Mantra",
    hitbox = Vector3.new(30, 30, 40),
    imdd = 0,
    imxd = 60,
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
        { _type = "Parry", _when = 350, name = "Chorus Crit", hitbox = Vector3.new(30, 30, 40), ihbc = false }
    }
}

-- ===== LORD REGENT =====
MobTimings["RegentGrab"] = createMobTiming("RegentGrab", Vector3.new(500, 500, 500), 600, 200, "Dodge")
MobTimings["RegentGrapple"] = createMobTiming("RegentGrapple", Vector3.new(40, 40, 400), 500, 150, "Dodge")

-- ===== KING GOLEM =====
MobTimings["GolemBeam"] = createMobTiming("GolemBeam", Vector3.new(40, 200, 200), 2300, 200, "Dodge")
MobTimings["GolemGreathammer"] = createMobTiming("GolemGreathammer", Vector3.new(35, 35, 35), 300, 40, "Dodge")

-- ===== SQUIBBO =====
MobTimings["SquibboAxeKick"] = createMobTiming("SquibboAxeKick", Vector3.new(20, 33, 33), 350, 40)
MobTimings["SquidwardEruption"] = createMobTiming("SquidwardEruption", Vector3.new(40, 40, 50), 400, 50, "Dodge")

return MobTimings
