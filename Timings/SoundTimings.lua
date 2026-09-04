-- Timings/SoundTimings.lua - Timings for sounds (audio cues for attacks)
local SoundTimings = {}

-- ===== GENERIC TELEGRAPH SOUND =====
SoundTimings["GenericTelegraphSound"] = {
    _id = "rbxassetid://GenericTelegraphSound",
    name = "Generic Telegraph",
    tag = "Undefined",
    hitbox = {25, 25, 25},
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
    alp = true,
    actions = {
        {
            _type = "Parry",
            _when = 0,
            name = "Generic Telegraph Parry",
            hitbox = {25, 25, 25},
            ihbc = false,
        }
    }
}

-- ===== TITUS TELEGRAPH =====
SoundTimings["TitusTelegraph"] = {
    _id = "rbxassetid://TitusTelegraph",
    name = "Titus Telegraph",
    tag = "Undefined",
    hitbox = {30, 30, 30},
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
        {
            _type = "Parry",
            _when = 0,
            name = "Titus Telegraph Parry",
            hitbox = {30, 30, 30},
            ihbc = false,
        }
    }
}

return SoundTimings
