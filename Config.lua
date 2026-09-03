-- Config.lua - Complete configuration from chime monster.json
-- All settings organized by category

local Config = {}

-- Default configuration (matches your JSON)
local defaults = {
    -- === KEYBINDS ===
    MenuKeybind = "Delete",
    speedKeybind = "F1",
    flyKeybind = "F2",
    noclipKeybind = "F4",
    void_mobsKeybind = "F5",
    ap_breakerKeybind = "F6",
    animation_loggerKeybind = "F7",
    
    -- === COMBAT TOGGLES ===
    ap_enable_auto_defense = true,
    ap_parry_only_pve = true,
    ap_parry_only_pvp = false,
    ap_use_iframes = true,
    ap_roll_if_behind = true,
    ap_roll_on_parry_cooldown = true,
    ap_blatant_roll_pvp = true,
    ap_blatant_roll_pve = true,
    ap_block_parry_state_pve = true,
    ap_block_parry_state_pvp = false,
    ap_block_dodge_state_pve = true,
    ap_block_dodge_state_pvp = false,
    ap_block_vent_state_pve = true,
    ap_block_vent_state_pvp = false,
    ap_deflect_block_fallback = true,
    ap_vent_fallback = false,
    ap_auto_ragdoll_recover = true,
    ap_limit_to_ap_animations = true,
    ap_enable_visualizations = false,
    ap_enable_notifications = false,
    ap_allow_failure = false,
    ap_use_prediction = false,
    ap_use_punishment = false,
    ap_roll_cancel_pve = true,
    ap_roll_cancel_pvp = true,
    ap_animation_speed_changer = false,
    ap_switch_between_speeds = false,
    ap_ignore_players = false,
    ap_ignore_mobs = true,
    ap_ignore_allies = false,
    ap_check_targeting_value = false,
    
    -- === COMBAT SLIDERS ===
    ap_failure_rate = 0,
    ap_dash_instead_of_parry_rate = 0,
    ap_ignore_animation_end_rate = 0,
    ap_distance_limit = 500,
    ap_fov_limit = 180,
    ap_max_targets = 5,
    ap_roll_cancel_delay_pve = 0.01,
    ap_roll_cancel_delay_pvp = 0.02,
    
    -- === MOVEMENT TOGGLES ===
    speed = false,
    fly = false,
    noclip = false,
    infinite_jump = false,
    auto_sprint = false,
    no_fall = true,
    no_roll_fatigue = true,
    no_speed_debuff = true,
    agility_spoofer = true,
    max_momentum_spoof = true,
    
    -- === MOVEMENT SLIDERS ===
    fly_speed = 195.5,
    walk_speed = 194.4,
    agility_spoof_amount = 45,
    jump_power = 50,
    min_speed_mult = 7.4,
    max_speed_mult = 7.4,
    auto_sprint_delay = 0.3,
    max_tick_rate = 6.1,
    min_tick_rate = 6.1,
    free_cam_speed = 4,
    
    -- === ESP TOGGLES ===
    player_esp = true,
    mob_esp = true,
    esp_nametags = true,
    esp_healthbar = true,
    streamer_mode = true,
    full_bright = true,
    esp_boxes = false,
    esp_fadeout = false,
    chest_esp = false,
    bag_esp = false,
    npc_esp = false,
    shop_esp = false,
    obelisk_esp = false,
    owl_esp = false,
    artifact_esp = false,
    crate_esp = false,
    ingredient_esp = false,
    area_esp = false,
    job_esp = false,
    banner_esp = false,
    whirlpool_esp = false,
    cache_esp = false,
    dropped_item_esp = false,
    
    -- === ESP COLORS ===
    player_esp_color = Color3.fromHex("e2e9aa"),
    mob_esp_color = Color3.fromHex("e78284"),
    chest_esp_color = Color3.fromHex("e5c890"),
    bag_esp_color = Color3.fromHex("f9e2af"),
    npc_esp_color = Color3.fromHex("00e0ff"),
    shop_esp_color = Color3.fromHex("d8dde9"),
    obelisk_esp_color = Color3.fromHex("ffffff"),
    owl_esp_color = Color3.fromHex("6a19ce"),
    artifact_esp_color = Color3.fromHex("ca9ee6"),
    crate_esp_color = Color3.fromHex("ed8796"),
    ingredient_esp_color = Color3.fromHex("89b4fa"),
    area_esp_color = Color3.fromHex("c6d0f5"),
    job_esp_color = Color3.fromHex("f2d5cf"),
    banner_esp_color = Color3.fromHex("9cf3b9"),
    whirlpool_esp_color = Color3.fromHex("8caaee"),
    cache_esp_color = Color3.fromHex("b7bdf8"),
    dropped_item_esp_color = Color3.fromHex("afffd7"),
    
    -- === ESP SLIDERS ===
    esp_update_rate = 9,
    text_size = 15,
    Font = "BuilderSansMedium",
    player_esp_max_distance = 50000,
    mob_esp_max_distance = 50000,
    chest_esp_max_distance = 50000,
    max_player_distance = 50000,
    esp_fadeout_distance = 100,
    fov_radius = 2000,
    fov_transparency = 0.95,
    
    -- === REMOVALS TOGGLES ===
    no_fog = true,
    no_blind = true,
    no_blur = true,
    no_wind = true,
    no_fire = true,
    no_stun = true,
    no_kill_bricks = true,
    no_status_effects = false,
    no_echo_screen = true,
    no_sanity_vfx = true,
    no_one_bit = true,
    no_enforcer_pull = true,
    no_hive_gate = true,
    no_castle_light_gate = true,
    no_yun_shul_gate = true,
    no_sea = false,
    no_shadows = false,
    no_rosen_fire = true,
    no_respawn_time = true,
    no_mob_encounters = true,
    
    -- === AUTOMATION TOGGLES ===
    auto_loot = true,
    auto_charisma = true,
    auto_math_book = true,
    auto_fish = false,
    auto_wisp = false,
    auto_ardour = false,
    auto_flow_state = false,
    auto_golden_tongue = false,
    anti_afk = true,
    
    -- === AUTOMATION SETTINGS ===
    auto_wisp_delay = 0,
    auto_golden_tongue_mode = "Blatant",
    loot_all_rarities = { Mythic = true, Legendary = true, Enchant = true },
    always_loot = { "Kyrsan Medallions", "Relics" },
    item_loot_input = "Umbral Obsidian",
    
    -- === ANTI-CHEAT ===
    mod_detector = true,
    aa_bypass = true,
    aa_bypass_mode = "Water",
    harrow_remover = true,
    experimental_bug_fixes = false,
    
    -- === UI ===
    Watermark = true,
    KeybindShower = true,
    proximity_list = true,
    show_chat = false,
    optimize_game = true,
    aggressive_optimize_game = true,
    NotificationVolume = 1.5,
}

local state = {}
for k, v in pairs(defaults) do state[k] = v end

function Config:load()
    state = {}
    for k, v in pairs(defaults) do state[k] = v end
end

function Config:get() return state end
function Config:set(key, value) state[key] = value end
function Config:toggle(key) state[key] = not state[key]; return state[key] end
function Config:reset() self:load() end

return Config
