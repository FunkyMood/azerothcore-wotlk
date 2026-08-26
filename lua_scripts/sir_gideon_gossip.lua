local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2
local CREATURE_EVENT_ON_MOVE_IN_LOS = 27

-- Two creature_template entries for the same NPC exist: 200000 (the one this
-- script was originally written for) and 200001 (a parallel duplicate that
-- already stood in every capital and starting zone with no custom gossip of
-- its own - see starting_town_conversation.lua). Both carry the same 186
-- quest-starter rows, so registering everything on both is safe.
local GIDEON_ENTRIES = { 200000, 200001 }
local GREETING_DISTANCE = 20
local UNIVERSAL_LANGUAGE = 0
local FIRST_GREETING =
    "Hey, Tarnished... ahem, no, not that script. Where did I put it? Oh, never mind. Come here, adventurer."

-- Avoid repeated character-database queries while the server is running.
local greetingChecked = {}

local ACTION_LORE = 1
local ACTION_TRAIN = 2
local ACTION_CLOSE = 3
local ACTION_BACK = 4
local ACTION_CHALLENGES = 5

local LORE_NPC_TEXT_ID = 200001

-- Mirrors mod-challenge-modes' ChallengeModeSettings enum and its
-- "mod-challenge-modes" PlayerSetting source string exactly - the module's
-- own PlayerScript hooks (XP, equip checks, death handling...) read the same
-- setting regardless of who flips it, so toggling it here from Gideon's
-- gossip is equivalent to the module's own gossip used to be.
local CHALLENGE_SETTING_SOURCE = "mod-challenge-modes"
local SETTING_HARDCORE = 0
local SETTING_SEMI_HARDCORE = 1
local SETTING_SELF_CRAFTED = 2
local SETTING_ITEM_QUALITY_LEVEL = 3
local SETTING_QUEST_XP_ONLY = 6
local SETTING_IRON_MAN = 7

-- SlowXpGain/VerySlowXpGain are disabled server-side (mod-individual-xp
-- already covers that ground), so they're intentionally left out here.
local CHALLENGE_TOGGLES = {
    { setting = SETTING_HARDCORE, enableText = "Enable Hardcore mode", disableText = "Disable Hardcore mode", blockedBy = { SETTING_HARDCORE, SETTING_SEMI_HARDCORE } },
    { setting = SETTING_SEMI_HARDCORE, enableText = "Enable Semi-Hardcore mode", disableText = "Disable Semi-Hardcore mode", blockedBy = { SETTING_HARDCORE, SETTING_SEMI_HARDCORE } },
    { setting = SETTING_SELF_CRAFTED, enableText = "Enable Self-Crafted mode", disableText = "Disable Self-Crafted mode", blockedBy = { SETTING_SELF_CRAFTED, SETTING_IRON_MAN } },
    { setting = SETTING_ITEM_QUALITY_LEVEL, enableText = "Enable Item Quality Level mode", disableText = "Disable Item Quality Level mode", blockedBy = {} },
    { setting = SETTING_QUEST_XP_ONLY, enableText = "Enable Quest XP Only mode", disableText = "Disable Quest XP Only mode", blockedBy = {} },
    { setting = SETTING_IRON_MAN, enableText = "Enable Iron Man mode", disableText = "Disable Iron Man mode", blockedBy = { SETTING_SELF_CRAFTED, SETTING_IRON_MAN } },
}

local function FindToggleBySetting(setting)
    for _, toggle in ipairs(CHALLENGE_TOGGLES) do
        if toggle.setting == setting then
            return toggle
        end
    end
    return nil
end

-- GossipSendMenu's menu_id argument is silently ignored for creature-sourced
-- menus (Eluna only calls SetMenuId when the gossip source is a Player - see
-- PlayerMethods.h GossipSendMenu), so OnGideonSelect can't use it to tell the
-- challenges submenu apart from the top-level one. Encoding enable/disable
-- into the intid range itself instead - offsets picked well clear of
-- ACTION_LORE..ACTION_CHALLENGES (1-5) - sidesteps that entirely.
local INTID_ENABLE_OFFSET = 100
local INTID_DISABLE_OFFSET = 200
local CHALLENGES_NPC_TEXT_ID = 1

local function OnGideonMoveInLOS(event, creature, unit)
    if not unit or not unit:IsPlayer() or unit:IsBot() then
        return
    end

    if creature:GetDistance(unit) > GREETING_DISTANCE then
        return
    end

    local guid = unit:GetGUIDLow()
    if greetingChecked[guid] then
        return
    end

    greetingChecked[guid] = true

    local seen = CharDBQuery("SELECT 1 FROM custom_gideon_first_greeting WHERE guid = ? LIMIT 1", guid)
    if seen then
        return
    end

    CharDBExecute("INSERT IGNORE INTO custom_gideon_first_greeting (guid) VALUES (?)", guid)
    creature:SendUnitSay(FIRST_GREETING, UNIVERSAL_LANGUAGE)
end

local function OnGideonHello(event, player, object)
    player:GossipClearMenu()
    -- Eluna replaces the core-built gossip menu for this entry. Restore the
    -- native available/completable quests before adding Gideon's own topics.
    player:GossipAddQuests(object)
    player:GossipMenuAddItem(0, "Tell me about this place", 0, ACTION_LORE)
    player:GossipMenuAddItem(0, "Teach me your arts", 0, ACTION_TRAIN)
    player:GossipMenuAddItem(0, "I want to take up a challenge", 0, ACTION_CHALLENGES)
    player:GossipMenuAddItem(0, "Nothing, thank you", 0, ACTION_CLOSE)
    player:GossipSendMenu(1, object, 1)
end

local function ShowChallengesMenu(player, object)
    player:GossipClearMenu()

    for _, toggle in ipairs(CHALLENGE_TOGGLES) do
        local active = player:GetPlayerSettingValue(CHALLENGE_SETTING_SOURCE, toggle.setting) == 1

        if active then
            player:GossipMenuAddItem(0, toggle.disableText, 0, INTID_DISABLE_OFFSET + toggle.setting)
        else
            local blocked = false
            for _, blockingSetting in ipairs(toggle.blockedBy) do
                if player:GetPlayerSettingValue(CHALLENGE_SETTING_SOURCE, blockingSetting) == 1 then
                    blocked = true
                    break
                end
            end
            if not blocked then
                player:GossipMenuAddItem(0, toggle.enableText, 0, INTID_ENABLE_OFFSET + toggle.setting)
            end
        end
    end

    player:GossipMenuAddItem(0, "...", 0, ACTION_BACK)
    player:GossipSendMenu(CHALLENGES_NPC_TEXT_ID, object, 3)
end

local function OnGideonSelect(event, player, object, sender, intid, code, menu_id)
    if intid >= INTID_ENABLE_OFFSET then
        local enabling = intid < INTID_DISABLE_OFFSET
        local setting = enabling and (intid - INTID_ENABLE_OFFSET) or (intid - INTID_DISABLE_OFFSET)

        player:UpdatePlayerSetting(CHALLENGE_SETTING_SOURCE, setting, enabling and 1 or 0)
        player:SendBroadcastMessage(enabling and "Challenge mode enabled." or "Challenge mode disabled.")
        player:GossipComplete()
        return
    end

    if intid == ACTION_LORE then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "...", 0, ACTION_BACK)
        player:GossipSendMenu(LORE_NPC_TEXT_ID, object, 2)
    elseif intid == ACTION_BACK then
        OnGideonHello(event, player, object)
    elseif intid == ACTION_TRAIN then
        player:SendTrainerList(object)
    elseif intid == ACTION_CHALLENGES then
        ShowChallengesMenu(player, object)
    else
        player:GossipComplete()
    end
end

for _, entry in ipairs(GIDEON_ENTRIES) do
    RegisterCreatureGossipEvent(entry, GOSSIP_EVENT_ON_HELLO, OnGideonHello)
    RegisterCreatureGossipEvent(entry, GOSSIP_EVENT_ON_SELECT, OnGideonSelect)
    RegisterCreatureEvent(entry, CREATURE_EVENT_ON_MOVE_IN_LOS, OnGideonMoveInLOS)
end
