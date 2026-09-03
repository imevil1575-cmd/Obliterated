-- Timings/MantraTimings.lua - All mantra parry timings
local MantraTimings = {}

-- Helper to create a mantra timing
local function createMantraTiming(name, hitbox, parryTime, imxd, extra)
    return {
        _id = name,
        name = name,
        tag = "Mantra",
        hitbox = hitbox or Vector3.new(25, 25, 40),
        imdd = 0,
        imxd = imxd or 50,
        duih = false,
        fhb = true,
        hso = extra and extra.hso or 0,
        nbfb = true,
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
                _type = extra and extra.actionType or "Parry",
                _when = parryTime or 450,
                name = name .. " Parry",
                hitbox = hitbox or Vector3.new(25, 25, 40),
                ihbc = false,
            }
        }
    }
end

-- ===== FIRE PALM =====
MantraTimings["FirePalm"] = createMantraTiming("FirePalm", Vector3.new(25, 25, 40), 450, 50)

-- ===== ICE ERUPTION =====
MantraTimings["IceEruption"] = createMantraTiming("IceEruption", Vector3.new(22, 20, 30), 525, 60, { actionType = "Dodge" })

-- ===== METAL ERUPTION =====
MantraTimings["MetalEruption"] = createMantraTiming("MetalEruption", Vector3.new(23, 20, 30), 200, 50)

-- ===== FIRE ERUPTION =====
MantraTimings["FireEruption"] = {
    _id = "FireEruption",
    name = "Fire Eruption",
    tag = "Mantra",
    hitbox = Vector3.new(30, 25, 35),
    imdd = 0,
    imxd = 50,
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
    ffh = false,
    actions = {
        {
            _type = "Parry",
            _when = 150,
            name = "Fire Eruption Parry 1",
            hitbox = Vector3.new(30, 25, 35),
            ihbc = false,
        },
        {
            _type = "Parry",
            _when = 900,
            name = "Fire Eruption Parry 2",
            hitbox = Vector3.new(30, 25, 35),
            ihbc = false,
        }
    }
}

-- ===== ICE BEAM =====
MantraTimings["IceBeam"] = createMantraTiming("IceBeam", Vector3.new(15, 15, 85), 570, 100)

-- ===== LIGHTNING BEAM =====
MantraTimings["LightningBeam"] = createMantraTiming("LightningBeam", Vector3.new(15, 15, 90), 0, 100)

-- ===== CHAIN PULL =====
MantraTimings["ChainPull"] = createMantraTiming("ChainPull", Vector3.new(15, 15, 40), 350, 80)

-- ===== WIND CARVE =====
MantraTimings["WindCarve"] = {
    _id = "WindCarve",
    name = "Wind Carve",
    tag = "Mantra",
    hitbox = Vector3.new(20, 20, 20),
    imdd = 0,
    imxd = 50,
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
    ffh = true,
    actions = {
        {
            _type = "Start Block",
            _when = 400,
            name = "Wind Carve Start",
            hitbox = Vector3.new(20, 20, 20),
            ihbc = false,
        },
        {
            _type = "End Block",
            _when = 800,
            name = "Wind Carve End",
            hitbox = Vector3.new(20, 20, 20),
            ihbc = true,
        }
    }
}

-- ===== ICE CARVE =====
MantraTimings["IceCarve"] = {
    _id = "IceCarve",
    name = "Ice Carve",
    tag = "Mantra",
    hitbox = Vector3.new(32, 32, 32),
    imdd = 0,
    imxd = 50,
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
    ffh = true,
    actions = {
        {
            _type = "Start Block",
            _when = 200,
            name = "Ice Carve Start",
            hitbox = Vector3.new(32, 32, 32),
            ihbc = false,
        },
        {
            _type = "End Block",
            _when = 0,
            name = "Ice Carve End",
            hitbox = Vector3.new(32, 32, 32),
            ihbc = true,
        }
    }
}

-- ===== REVENGE =====
MantraTimings["Revenge"] = createMantraTiming("Revenge", Vector3.new(20, 20, 30), 400, 40, { ffh = true })

-- ===== RISING FLAME =====
MantraTimings["RisingFlame"] = createMantraTiming("RisingFlame", Vector3.new(25, 25, 25), 400, 40)

-- ===== SHADOW GUN =====
MantraTimings["ShadowGun"] = createMantraTiming("ShadowGun", Vector3.new(10, 10, 25), 650, 80)

-- ===== SHADOW ROAR =====
MantraTimings["ShadowRoar"] = {
    _id = "ShadowRoar",
    name = "Shadow Roar",
    tag = "Mantra",
    hitbox = Vector3.new(20, 20, 40),
    imdd = 0,
    imxd = 50,
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
    rpue = true,
    _rsd = 0,
    _rpd = 300,
    actions = {
        {
            _type = "Parry",
            _when = 500,
            name = "Shadow Roar Parry",
            hitbox = Vector3.new(20, 20, 40),
            ihbc = false,
        }
    }
}

-- ===== SHADOW ERUPTION =====
MantraTimings["ShadowEruption"] = createMantraTiming("ShadowEruption", Vector3.new(35, 35, 35), 0, 60)

-- ===== SHADOW CHAINS =====
MantraTimings["ShadowChains"] = createMantraTiming("ShadowChains", Vector3.new(55, 55, 55), 200, 80)

-- ===== IRON SLAM =====
MantraTimings["IronSlam"] = createMantraTiming("IronSlam", Vector3.new(24, 24, 24), 530, 40)

-- ===== IRON QUILLS =====
MantraTimings["IronQuills"] = createMantraTiming("IronQuills", Vector3.new(20, 20, 20), 350, 30)

-- ===== RISING THUNDER =====
MantraTimings["RisingThunder"] = {
    _id = "RisingThunder",
    name = "Rising Thunder",
    tag = "Mantra",
    hitbox = Vector3.new(20, 20, 20),
    imdd = 0,
    imxd = 50,
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
    ffh = false,
    mat = 1300,
    iae = true,
    ieae = true,
    actions = {
        {
            _type = "Start Block",
            _when = 200,
            name = "Rising Thunder Start",
            hitbox = Vector3.new(20, 20, 20),
            ihbc = false,
        },
        {
            _type = "End Block",
            _when = 1250,
            name = "Rising Thunder End",
            hitbox = Vector3.new(20, 20, 20),
            ihbc = true,
        }
    }
}

return MantraTimings
