-- loader.lua - Load Obliterated for Volt
-- This bypasses require() path issues

print("Loading Obliterated...")

-- GitHub raw URL
local baseUrl = "https://raw.githubusercontent.com/imevil1575-cmd/Obliterated/main/"

-- Function to load a file
local function loadFile(path)
    local url = baseUrl .. path
    local success, result = pcall(function()
        return game:HttpGet(url)
    end
    if not success then
        print("Failed to load: " .. path)
        return nil
    end
    return result
end

-- Load all files manually
print("Loading Config...")
Config = loadfile("Config.lua") or loadstring(loadFile("Config.lua"))()
if Config then Config:load() end

print("Loading Utils...")
Utils = {}
Utils.Math = loadstring(loadFile("Utils/Math.lua"))()
Utils.Table = loadstring(loadFile("Utils/Table.lua"))()
Utils.Signal = loadstring(loadFile("Utils/Signal.lua"))()
Utils.KeyHandling = loadstring(loadFile("Utils/KeyHandling.lua"))()

print("Loading Timings...")
Timings = {}
Timings.Action = loadstring(loadFile("Timings/Action.lua"))()
Timings.WeaponTimings = loadstring(loadFile("Timings/WeaponTimings.lua"))()
Timings.MantraTimings = loadstring(loadFile("Timings/MantraTimings.lua"))()
Timings.MobTimings = loadstring(loadFile("Timings/MobTimings.lua"))()
Timings.EffectTimings = loadstring(loadFile("Timings/EffectTimings.lua"))()
Timings.PartTimings = loadstring(loadFile("Timings/PartTimings.lua"))()
Timings.SoundTimings = loadstring(loadFile("Timings/SoundTimings.lua"))()
Timings.TimingManager = loadstring(loadFile("Timings/TimingManager.lua"))()

print("Loading Features...")
Features = {}
Features.InputClient = loadstring(loadFile("Features/InputClient.lua"))()
Features.Hooking = loadstring(loadFile("Features/Hooking.lua"))()
Features.Combat = loadstring(loadFile("Features/Combat.lua"))()
Features.CombatIntegration = loadstring(loadFile("Features/CombatIntegration.lua"))()
Features.ESP = loadstring(loadFile("Features/ESP.lua"))()
Features.Movement = loadstring(loadFile("Features/Movement.lua"))()
Features.Automation = loadstring(loadFile("Features/Automation.lua"))()
Features.Removals = loadstring(loadFile("Features/Removals.lua"))()
Features.AntiCheat = loadstring(loadFile("Features/AntiCheat.lua"))()
Features.AnimationLogger = loadstring(loadFile("Features/AnimationLogger.lua"))()

print("Loading UI...")
UI = loadstring(loadFile("Library/UI.lua"))()

print("Loading Init...")
Init = loadstring(loadFile("Init.lua"))()

print("Loading Main...")
Main = loadstring(loadFile("Main.lua"))()

-- Run the script
if Init and Init.run then
    print("✅ All files loaded! Starting...")
    Init:run()
else
    print("❌ Init.lua not loaded properly")
end
