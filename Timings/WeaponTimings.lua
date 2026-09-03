-- Timings/WeaponTimings.lua
local WeaponTimings = {}

local function createWeaponTiming(name, tag, hitbox, parryTime, imxd, extra)
    return {
        _id = name,
        name = name,
        tag = tag or "M1",
        hitbox = hitbox or Vector3.new(28, 28, 28),
        imdd = 0,
        imxd = imxd or 30,
        duih = false,
        fhb = true,
        hso = extra and extra.hso or -5,
        nbfb = extra and extra.nbfb or false,
        nvfb = false,
        ndfb = false,
        bfht = extra and extra.bfht or 0.3,
        pfh = extra and extra.pfh or true,
        phd = extra and extra.phd or false,
        phds = extra and extra.phds or 0,
        pfht = extra and extra.pfht or 0.25,
        dp = extra and extra.dp or false,
        ffh = extra and extra.ffh or false,
        actions = {
            {
                _type = "Parry",
                _when = parryTime or 250,
                name = name .. " Parry",
                hitbox = hitbox or Vector3.new(28, 28, 28),
                ihbc = false,
            }
        }
    }
end

WeaponTimings["Sword_M1"] = createWeaponTiming("Sword_M1", "M1", Vector3.new(28, 28, 28), 160, 30, { pfh = true, phd = true, phds = 0.6, pfht = 0.25 })
WeaponTimings["Sword_Critical"] = createWeaponTiming("Sword_Critical", "Critical", Vector3.new(20, 20, 30), 650, 25, { pfh = true, phd = true, phds = 1.0, pfht = 0.3, nbfb = true })
WeaponTimings["Greatsword_M1"] = createWeaponTiming("Greatsword_M1", "M1", Vector3.new(32, 32, 32), 300, 35, { pfh = true, phd = false, pfht = 0.5, ffh = true })
WeaponTimings["Greatsword_Critical"] = createWeaponTiming("Greatsword_Critical", "Critical", Vector3.new(25, 25, 35), 700, 30, { pfh = true, phd = true, phds = 1.0, pfht = 0.3, nbfb = true })
WeaponTimings["Dagger_M1"] = createWeaponTiming("Dagger_M1", "M1", Vector3.new(20, 20, 20), 150, 20, { pfh = false, phd = true, phds = 0.6, pfht = 0.25, dp = true, bfht = 0.6 })
WeaponTimings["Dagger_Critical"] = createWeaponTiming("Dagger_Critical", "Critical", Vector3.new(14, 15, 15), 400, 20, { pfh = true, phd = false, nbfb = true })
WeaponTimings["Spear_M1"] = createWeaponTiming("Spear_M1", "M1", Vector3.new(30, 30, 30), 250, 40, { pfh = true, phd = false, pfht = 0.5, ffh = true })
WeaponTimings["Spear_Critical"] = createWeaponTiming("Spear_Critical", "Critical", Vector3.new(20, 20, 30), 400, 35, { pfh = true, phd = true, phds = 1.0, pfht = 0.3, nbfb = true })
WeaponTimings["Greataxe_M1"] = createWeaponTiming("Greataxe_M1", "M1", Vector3.new(35, 35, 35), 350, 35, { pfh = true, phd = false, pfht = 0.5, ffh = true })
WeaponTimings["Greataxe_Critical"] = createWeaponTiming("Greataxe_Critical", "Critical", Vector3.new(20, 20, 30), 750, 30, { pfh = true, phd = true, phds = 1.0, pfht = 0.3, nbfb = true })
WeaponTimings["Greathammer_M1"] = createWeaponTiming("Greathammer_M1", "M1", Vector3.new(30, 30, 30), 300, 35, { pfh = true, phd = false, pfht = 0.5, ffh = true })
WeaponTimings["Greathammer_Critical"] = createWeaponTiming("Greathammer_Critical", "Critical", Vector3.new(20, 20, 30), 800, 30, { pfh = true, phd = true, phds = 1.0, pfht = 0.3, nbfb = true })
WeaponTimings["Rapier_M1"] = createWeaponTiming("Rapier_M1", "M1", Vector3.new(22, 22, 22), 220, 25, { pfh = true, phd = true, phds = 0.6, pfht = 0.25 })
WeaponTimings["Twinblade_M1"] = {
    _id = "Twinblade_M1",
    name = "Twinblade M1",
    tag = "M1",
    hitbox = Vector3.new(25, 25, 25),
    imdd = 0,
    imxd = 30,
    duih = false,
    fhb = true,
    hso = -5,
    nbfb = false,
    nvfb = false,
    ndfb = false,
    bfht = 0.3,
    pfh = true,
    phd = true,
    phds = 0.6,
    pfht = 0.25,
    dp = false,
    ffh = false,
    actions = {
        { _type = "Parry", _when = 300, name = "Twinblade M1 Parry 1", hitbox = Vector3.new(25, 25, 25), ihbc = false },
        { _type = "Parry", _when = 600, name = "Twinblade M1 Parry 2", hitbox = Vector3.new(25, 25, 25), ihbc = false }
    }
}
WeaponTimings["Club_M1"] = createWeaponTiming("Club_M1", "M1", Vector3.new(28, 28, 28), 280, 30, { pfh = true, phd = false, pfht = 0.5, ffh = true })

return WeaponTimings
