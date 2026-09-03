-- Init.lua - Central initialization manager
-- Loads all modules, initializes systems, and starts the script

local Init = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Module cache
local modules = {}
local isRunning = false

function Init:loadModules()
    -- Core
    modules.Config = require(script.Parent.Config)
    modules.UI = require(script.Parent.Library.UI)
    
    -- Utils (load these first for dependencies)
    modules.Math = require(script.Parent.Utils.Math)
    modules.Table = require(script.Parent.Utils.Table)
    modules.Signal = require(script.Parent.Utils.Signal)
    modules.KeyHandling = require(script.Parent.Utils.KeyHandling)
    
    -- Timings
    modules.TimingManager = require(script.Parent.Timings.TimingManager)
    modules.Action = require(script.Parent.Timings.Action)
    modules.WeaponTimings = require(script.Parent.Timings.WeaponTimings)
    modules.MantraTimings = require(script.Parent.Timings.MantraTimings)
    modules.MobTimings = require(script.Parent.Timings.MobTimings)
    modules.EffectTimings = require(script.Parent.Timings.EffectTimings)
    modules.PartTimings = require(script.Parent.Timings.PartTimings)
    modules.SoundTimings = require(script.Parent.Timings.SoundTimings)
    
    -- Features (in dependency order)
    modules.InputClient = require(script.Parent.Features.InputClient)
    modules.Hooking = require(script.Parent.Features.Hooking)
    modules.Combat = require(script.Parent.Features.Combat)
    modules.CombatIntegration = require(script.Parent.Features.CombatIntegration)
    modules.ESP = require(script.Parent.Features.ESP)
    modules.Movement = require(script.Parent.Features.Movement)
    modules.Automation = require(script.Parent.Features.Automation)
    modules.Removals = require(script.Parent.Features.Removals)
    modules.AntiCheat = require(script.Parent.Features.AntiCheat)
    modules.AnimationLogger = require(script.Parent.Features.AnimationLogger)
    
    print("✓ All modules loaded")
    print("  - Utils: Math, Table, Signal, KeyHandling")
    print("  - Timings: Action, TimingManager, Weapon, Mantra, Mob, Effect, Part, Sound")
    print("  - Features: InputClient, Hooking, Combat, ESP, Movement, Automation, Removals, AntiCheat, AnimationLogger")
end

function Init:initAll()
    -- Load config
    modules.Config:load()
    local config = modules.Config:get()
    
    -- Load all timings
    modules.TimingManager.loadAll()
    
    -- Initialize InputClient
    modules.InputClient.cacheRemotes()
    
    -- Initialize Hooking
    modules.Hooking:init()
    
    -- Initialize UI with custom theme
    modules.UI:init()
    
    -- Initialize features with config
    modules.Combat:init({ config = config })
    modules.CombatIntegration:init()
    modules.ESP:init({ config = config })
    modules.Movement:init({ config = config })
    modules.Automation:init({ config = config })
    modules.Removals:init({ config = config })
    modules.AntiCheat:init({ config = config })
    modules.AnimationLogger:init({ config = config })
    
    print("✓ All systems initialized")
    print("✓ Animation Logger active - learning new animations (Press F7)")
end

function Init:start()
    local config = modules.Config:get()
    
    -- Main update loop
    RunService.Heartbeat:Connect(function(dt)
        modules.CombatIntegration:update()
        modules.Combat:update(dt)
        modules.ESP:update()
        modules.Movement:update(dt)
        modules.Automation:update(dt)
        modules.Removals:update(dt)
        modules.AntiCheat:update(dt)
        modules.AnimationLogger:update(dt)
    end)
    
    -- Keybind handler
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        local key = input.KeyCode.Name
        
        if key == "Delete" then
            modules.UI:toggle()
            return
        end
        
        local bindings = {
            F1 = "speed",
            F2 = "fly",
            F4 = "noclip",
            F5 = "void_mobs",
            F6 = "ap_breaker",
            F7 = "animation_logger",
        }
        
        for bindKey, feature in pairs(bindings) do
            if key == bindKey then
                if feature == "animation_logger" then
                    modules.AnimationLogger:toggle()
                else
                    local newState = not config[feature]
                    config[feature] = newState
                    print("Toggled " .. feature .. ": " .. tostring(newState))
                end
                return
            end
        end
    end)
    
    print("✓ All systems running")
    print("  Press F7 to toggle Animation Logger")
end

function Init:detach()
    isRunning = false
    modules.Hooking:detach()
    modules.Combat:detach()
    modules.CombatIntegration:detach()
    modules.ESP:detach()
    modules.Movement:detach()
    modules.Automation:detach()
    modules.Removals:detach()
    modules.AntiCheat:detach()
    modules.AnimationLogger:detach()
    modules.UI:destroy()
    print("✓ All systems detached")
end

function Init:run()
    self:loadModules()
    self:initAll()
    self:start()
    
    getgenv().Obliterated = {
        detach = function() self:detach() end,
        toggle = function() modules.UI:toggle() end,
        config = modules.Config,
        status = function()
            print("Obliterated Status:")
            print("  Running: true")
            print("  Menu: " .. tostring(modules.UI.isOpen or false))
            print("  Animation Logger: " .. tostring(modules.AnimationLogger.isLogging or false))
            print("  Learned Animations: " .. modules.AnimationLogger:count())
        end,
        debug = {
            timings = modules.TimingManager.getAll,
            remotes = modules.CombatIntegration.getRemotes,
            learned = modules.AnimationLogger.getLearned,
        }
    }
    
    print("")
    print("╔═══════════════════════════════════════════════════════════════════╗")
    print("║                    OBLITERATED LOADED!                           ║")
    print("╠═══════════════════════════════════════════════════════════════════╣")
    print("║  Press Delete to open the menu                                  ║")
    print("║  Press F1 for speed, F2 for fly                                ║")
    print("║  Press F4 for noclip, F5 for void mobs                        ║")
    print("║  Press F6 for AP breaker, F7 for Animation Logger              ║")
    print("║                                                               ║")
    print("║  Type 'obliterated:detach()' to unload                        ║")
    print("║  Type 'obliterated:toggle()' to toggle menu                   ║")
    print("║  Type 'obliterated:status()' for status                       ║")
    print("║  Type 'obliterated.debug.learned()' for learned animations    ║")
    print("╚═══════════════════════════════════════════════════════════════════╝")
    
    return getgenv().Obliterated
end

return Init
