-- Timings/TimingManager.lua - Load and manage all timings
local TimingManager = {}

local timings = {}

function TimingManager.loadAll()
    -- Clear existing
    timings = {}
    
    -- Load weapon timings
    for id, timing in pairs(WeaponTimings) do
        timings[id] = timing
    end
    
    -- Load mantra timings
    for id, timing in pairs(MantraTimings) do
        timings[id] = timing
    end
    
    -- Load mob timings
    for id, timing in pairs(MobTimings) do
        timings[id] = timing
    end
    
    -- Load effect timings
    for id, timing in pairs(EffectTimings) do
        timings[id] = timing
    end
    
    -- Load part timings
    for id, timing in pairs(PartTimings) do
        timings[id] = timing
    end
    
    -- Load sound timings
    for id, timing in pairs(SoundTimings) do
        timings[id] = timing
    end
    
    print("✓ Loaded " .. Table.size(timings) .. " timings")
end

function TimingManager.get(id)
    return timings[id]
end

function TimingManager.add(id, timing)
    timings[id] = timing
end

function TimingManager.getByTag(tag)
    local results = {}
    for id, timing in pairs(timings) do
        if timing.tag == tag then
            results[id] = timing
        end
    end
    return results
end

function TimingManager.getByType(type)
    local results = {}
    for id, timing in pairs(timings) do
        if timing._type == type then
            results[id] = timing
        end
    end
    return results
end

function TimingManager.learn(animationId, parryWindow, hitbox)
    local timing = {
        _id = animationId,
        name = "Learned: " .. animationId,
        tag = "Learned",
        hitbox = hitbox or Vector3.new(10, 10, 10),
        imdd = 0,
        imxd = 30,
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
                _when = parryWindow[1] * 1000,
                name = "Learned Parry",
                hitbox = hitbox or Vector3.new(10, 10, 10),
                ihbc = false,
            }
        }
    }
    timings[animationId] = timing
    return timing
end

function TimingManager.getAll()
    return timings
end

return TimingManager
