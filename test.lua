-- test.lua - Quick test to verify all modules load correctly
print("=" .. string.rep("=", 50))
print("  Obliterated - Quick Test")
print("=" .. string.rep("=", 50))

local function checkModule(name, path)
    local success, result = pcall(function()
        return require(path)
    end)
    if success then
        print("  ✅ " .. name .. " - Loaded")
        return result
    else
        print("  ❌ " .. name .. " - Failed: " .. tostring(result))
        return nil
    end
end

print("\n📦 Loading Modules...")

local modules = {
    Config = checkModule("Config", "script.Config"),
    UI = checkModule("UI", "script.Library.UI"),
    Math = checkModule("Math", "script.Utils.Math"),
    Table = checkModule("Table", "script.Utils.Table"),
    Signal = checkModule("Signal", "script.Utils.Signal"),
    KeyHandling = checkModule("KeyHandling", "script.Utils.KeyHandling"),
    Action = checkModule("Action", "script.Timings.Action"),
    TimingManager = checkModule("TimingManager", "script.Timings.TimingManager"),
    WeaponTimings = checkModule("WeaponTimings", "script.Timings.WeaponTimings"),
    MantraTimings = checkModule("MantraTimings", "script.Timings.MantraTimings"),
    MobTimings = checkModule("MobTimings", "script.Timings.MobTimings"),
    EffectTimings = checkModule("EffectTimings", "script.Timings.EffectTimings"),
    PartTimings = checkModule("PartTimings", "script.Timings.PartTimings"),
    SoundTimings = checkModule("SoundTimings", "script.Timings.SoundTimings"),
    InputClient = checkModule("InputClient", "script.Features.InputClient"),
    Hooking = checkModule("Hooking", "script.Features.Hooking"),
    Combat = checkModule("Combat", "script.Features.Combat"),
    CombatIntegration = checkModule("CombatIntegration", "script.Features.CombatIntegration"),
    ESP = checkModule("ESP", "script.Features.ESP"),
    Movement = checkModule("Movement", "script.Features.Movement"),
    Automation = checkModule("Automation", "script.Features.Automation"),
    Removals = checkModule("Removals", "script.Features.Removals"),
    AntiCheat = checkModule("AntiCheat", "script.Features.AntiCheat"),
    AnimationLogger = checkModule("AnimationLogger", "script.Features.AnimationLogger"),
}

local loaded = 0
local failed = 0
for name, module in pairs(modules) do
    if module then loaded = loaded + 1 else failed = failed + 1 end
end

print("\n📊 Summary:")
print("  Loaded: " .. loaded .. "/" .. (loaded + failed) .. " modules")
print("  Failed: " .. failed .. " modules")

if failed == 0 then
    print("\n✅ All modules loaded successfully!")
    print("\n🚀 To start the script, run:")
    print("   local Init = require(script.Init)")
    print("   Init:run()")
else
    print("\n⚠️ Some modules failed to load. Check the file structure.")
end

-- Test KeyHandling
if modules.KeyHandling then
    print("\n🔍 Testing KeyHandling...")
    local found = modules.KeyHandling.searchForKeyHandlerData()
    if found then
        print("  ✅ KeyHandler data found!")
    else
        print("  ⚠️ KeyHandler data not found (may need to be in-game)")
    end
end

-- Test TimingManager
if modules.TimingManager then
    print("\n📊 TimingManager:")
    local count = 0
    for _ in pairs(modules.TimingManager.getAll() or {}) do count = count + 1 end
    print("  " .. count .. " timings loaded")
end

print("\n" .. "=" .. string.rep("=", 50))
