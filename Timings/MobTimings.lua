-- Timings/MobTimings.lua - Mob and boss attack timings
local MobTimings = {}

-- Helper to create a mob timing
local function createMobTiming(name, hitbox, parryTime, imxd, actionType)
    return {
        _id = name,
        name = name,
        tag = "Mantra",
        hitbox = hitbox,
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
                hitbox = hitbox,
                ihbc = false,
            }
        }
    }
end

-- Helper for multi-action timings
local function createMultiAction(name, hitbox, actions)
    return {
        _id = name,
        name = name,
        tag = "Mantra",
        hitbox = hitbox,
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
        actions = actions or {},
    }
end

-- ===== TITUS =====
MobTimings["TitusDrive"] = createMobTiming("TitusDrive", {30, 20, 50}, 700, 40, "Dodge")
MobTimings["TitusKick"] = createMobTiming("TitusKick", {20, 20, 50}, 400, 30, "Dodge")
MobTimings["TitusSkycrash"] = createMobTiming("TitusSkycrash", {30, 50, 53}, 175, 50, "Dodge")
MobTimings["TitusVault"] = createMobTiming("TitusVault", {70, 100, 75}, 1300, 60, "Dodge")
MobTimings["TitusKickWindup"] = createMobTiming("TitusKickWindup", {20, 20, 50}, 400, 30, "Dodge")
MobTimings["TitusSkycrashGo"] = createMobTiming("TitusSkycrashGo", {30, 50, 53}, 175, 50, "Dodge")

-- ===== PRIMADON =====
MobTimings["PrimadonStomp"] = createMobTiming("PrimadonStomp", {80, 250, 80}, 750, 100)
MobTimings["PrimadonTripleStomp"] = createMultiAction("PrimadonTripleStomp", {80, 250, 80}, {
    { _type = "Parry", _when = 800, name = "Triple Stomp 1", hitbox = {80, 250, 80}, ihbc = false },
    { _type = "Parry", _when = 1400, name = "Triple Stomp 2", hitbox = {80, 250, 80}, ihbc = false },
    { _type = "Parry", _when = 2050, name = "Triple Stomp 3", hitbox = {80, 250, 80}, ihbc = false },
})
MobTimings["PrimadonPunch"] = createMobTiming("PrimadonPunch", {80, 250, 80}, 1050, 80)
MobTimings["PrimadonGrab"] = createMobTiming("PrimadonGrab", {80, 250, 80}, 900, 80, "Forced Full Dodge")
MobTimings["PrimadonKick"] = createMobTiming("PrimadonKick", {80, 250, 80}, 900, 80, "Dodge")
MobTimings["PrimadonMidPunch"] = createMobTiming("PrimadonMidPunch", {80, 250, 80}, 600, 80)
MobTimings["PrimadonUltimateStomp"] = createMobTiming("PrimadonUltimateStomp", {100, 250, 100}, 2130, 100)
MobTimings["ElderPrimaSlam"] = createMobTiming("ElderPrimaSlam", {80, 250, 140}, 1200, 100, "Dodge")
MobTimings["ElderPrimaStompFeint"] = createMobTiming("ElderPrimaStompFeint", {80, 250, 140}, 750, 100)
MobTimings["ElderPrimaSixStomp"] = createMultiAction("ElderPrimaSixStomp", {100, 250, 100}, {
    { _type = "Parry", _when = 550, name = "Six Stomp 1", hitbox = {100, 250, 100}, ihbc = false },
    { _type = "Parry", _when = 1000, name = "Six Stomp 2", hitbox = {100, 250, 100}, ihbc = false },
    { _type = "Parry", _when = 1450, name = "Six Stomp 3", hitbox = {100, 250, 100}, ihbc = false },
    { _type = "Parry", _when = 1800, name = "Six Stomp 4", hitbox = {100, 250, 100}, ihbc = false },
    { _type = "Parry", _when = 2250, name = "Six Stomp 5", hitbox = {100, 250, 100}, ihbc = false },
    { _type = "Parry", _when = 2700, name = "Six Stomp 6", hitbox = {100, 250, 100}, ihbc = false },
})

-- ===== DUKE =====
MobTimings["DukeGrasp"] = createMobTiming("DukeGrasp", {160, 120, 160}, 1100, 150)
MobTimings["DukeStomp"] = createMobTiming("DukeStomp", {40, 40, 100}, 650, 80, "Dodge")
MobTimings["DukeStrongLeft"] = createMobTiming("DukeStrongLeft", {23, 15, 25}, 500, 40)

-- ===== CHASER =====
MobTimings["ChaserSlam"] = createMobTiming("ChaserSlam", {70, 70, 70}, 920, 80)
MobTimings["HitTendril"] = createMultiAction("HitTendril", {40, 40, 40}, {
    { _type = "Forced Full Dodge", _when = 585, name = "Hit Tendril Dodge", hitbox = {40, 40, 40}, ihbc = true },
    { _type = "Parry", _when = 600, name = "Hit Tendril Parry", hitbox = {40, 40, 40}, ihbc = true },
})

-- ===== ETHIRON =====
MobTimings["EthironBeam"] = createMobTiming("EthironBeam", {50, 50, 200}, 150, 200, "Forced Full Dodge")
MobTimings["EthironBlind"] = createMobTiming("EthironBlind", {800, 800, 800}, 1400, 500)

-- ===== RAT KING =====
MobTimings["RatKingSlashDash"] = createMultiAction("RatKingSlashDash", {40, 40, 40}, {
    { _type = "Parry", _when = 580, name = "Slash 1", hitbox = {40, 40, 40}, ihbc = false },
    { _type = "Parry", _when = 1390, name = "Slash 2", hitbox = {40, 40, 40}, ihbc = false },
    { _type = "Parry", _when = 2300, name = "Slash 3", hitbox = {50, 50, 50}, ihbc = false },
})
MobTimings["RatKingTurnDash"] = createMobTiming("RatKingTurnDash", {35, 40, 35}, 350, 60)
MobTimings["RatKingChorusCrit"] = createMobTiming("RatKingChorusCrit", {30, 30, 40}, 350, 60)

-- ===== LORD REGENT =====
MobTimings["RegentGrab"] = createMobTiming("RegentGrab", {500, 500, 500}, 600, 200, "Dodge")
MobTimings["RegentGrapple"] = createMobTiming("RegentGrapple", {40, 40, 400}, 500, 150, "Dodge")

-- ===== KING GOLEM =====
MobTimings["GolemBeam"] = createMobTiming("GolemBeam", {40, 200, 200}, 2300, 200, "Dodge")
MobTimings["GolemGreathammer"] = createMobTiming("GolemGreathammer", {35, 35, 35}, 300, 40, "Dodge")

-- ===== SQUIBBO =====
MobTimings["SquibboAxeKick"] = createMobTiming("SquibboAxeKick", {20, 33, 33}, 350, 40)
MobTimings["SquidwardEruption"] = createMobTiming("SquidwardEruption", {40, 40, 50}, 400, 50, "Dodge")

return MobTimings
