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
local SETTING_ARTISAN = 10

-- SlowXpGain/VerySlowXpGain are disabled server-side (mod-individual-xp
-- already covers that ground), so they're intentionally left out here.
--
-- `description` is shown as the gossip confirmation prompt, so the player
-- reads what a challenge actually costs at the moment of committing to it
-- rather than finding out afterwards.
--
-- `blockedBy` lists the settings that hide this option while they're active,
-- and always includes the challenge itself (harmless: that branch only runs
-- when it isn't active). The exclusions are not cosmetic:
--   Hardcore / Semi-Hardcore  - contradictory death rules.
--   Self-Crafted / Iron Man   - Iron Man already bans everything but grey and
--                               white gear, and forbids trade skills, so you
--                               could never craft what Self-Crafted demands.
--   Artisan / Iron Man        - Iron Man unlearns every trade skill, while
--                               Artisan makes professions the only source of
--                               experience. Together they leave a character
--                               unable to gain a single point of XP, ever.
local CHALLENGE_TOGGLES = {
    {
        setting = SETTING_HARDCORE,
        enableText = "Enable Hardcore mode",
        disableText = "Disable Hardcore mode",
        description = "If you die, this character is finished for good - no resurrection, no spirit to recover. Cannot be combined with Semi-Hardcore.",
        blockedBy = { SETTING_HARDCORE, SETTING_SEMI_HARDCORE },
    },
    {
        setting = SETTING_SEMI_HARDCORE,
        enableText = "Enable Semi-Hardcore mode",
        disableText = "Disable Semi-Hardcore mode",
        description = "Every death strips you of all worn equipment and every coin you are carrying. You live on. Cannot be combined with Hardcore.",
        blockedBy = { SETTING_HARDCORE, SETTING_SEMI_HARDCORE },
    },
    {
        setting = SETTING_SELF_CRAFTED,
        enableText = "Enable Self-Crafted mode",
        disableText = "Disable Self-Crafted mode",
        description = "You may only wear equipment you crafted with your own hands - nothing bought, looted or handed to you. Cannot be combined with Iron Man.",
        blockedBy = { SETTING_SELF_CRAFTED, SETTING_IRON_MAN },
    },
    {
        setting = SETTING_ITEM_QUALITY_LEVEL,
        enableText = "Enable Item Quality Level mode",
        disableText = "Disable Item Quality Level mode",
        description = "You may only wear Poor and Common quality gear - greys and whites. No greens, blues or epics, whatever you find.",
        blockedBy = {},
    },
    {
        setting = SETTING_QUEST_XP_ONLY,
        enableText = "Enable Quest XP Only mode",
        disableText = "Disable Quest XP Only mode",
        description = "Experience comes only from completing quests. Slaying creatures will no longer advance you.",
        blockedBy = {},
    },
    {
        setting = SETTING_IRON_MAN,
        enableText = "Enable Iron Man mode",
        disableText = "Disable Iron Man mode",
        description = "No groups, no enchants, no potions, elixirs or buff food, grey and white gear only, no talent points and no trade skills. The hardest road there is. Cannot be combined with Self-Crafted or Artisan.",
        blockedBy = { SETTING_SELF_CRAFTED, SETTING_IRON_MAN, SETTING_ARTISAN },
    },
    {
        setting = SETTING_ARTISAN,
        enableText = "Enable Artisan mode",
        disableText = "Disable Artisan mode",
        description = "Experience comes only from your professions, gathering and crafting alike. Kills, quests and exploration will give you nothing. Cannot be combined with Iron Man, which would forbid you the trade skills you depend on.",
        blockedBy = { SETTING_ARTISAN, SETTING_IRON_MAN },
    },
}

-- GossipSendMenu's menu_id argument is silently ignored for creature-sourced
-- menus (Eluna only calls SetMenuId when the gossip source is a Player - see
-- PlayerMethods.h GossipSendMenu), so OnGideonSelect can't use it to tell the
-- challenges submenu apart from the top-level one. Encoding enable/disable
-- into the intid range itself instead - offsets picked well clear of
-- ACTION_LORE..ACTION_CHALLENGES (1-5) - sidesteps that entirely.
local INTID_ENABLE_OFFSET = 100
local INTID_DISABLE_OFFSET = 200
local CHALLENGES_NPC_TEXT_ID = 1

-- Artisan draws experience only from professions, but a primary profession
-- can't be learned before level 5 - so a fresh character taking the challenge
-- would be deadlocked: no trade to earn from, and no way to earn the level
-- that would let them learn one. Gideon covers the first step.
local ARTISAN_STARTING_LEVEL = 5
local ARTISAN_STARTING_MONEY = 30 * 100 -- 30 silver, in copper

local function GrantArtisanStartingKit(player)
    -- Guarded on level rather than a "already paid" flag on purpose: the check
    -- becomes false the moment the kit is handed over, so toggling the
    -- challenge off and on again can't be farmed for silver. A character who
    -- is already level 5 or beyond needs nothing and gets nothing.
    if player:GetLevel() >= ARTISAN_STARTING_LEVEL then
        return
    end

    player:SetLevel(ARTISAN_STARTING_LEVEL)
    player:ModifyMoney(ARTISAN_STARTING_MONEY)
    player:SendBroadcastMessage(
        "Gideon sets you on your way: level 5, and 30 silver to pay for your first trades.")
end

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
                -- The 6th argument is the confirmation prompt: the description
                -- lands in a popup the player has to accept, so nobody takes a
                -- challenge without having read what it does.
                player:GossipMenuAddItem(0, toggle.enableText, 0, INTID_ENABLE_OFFSET + toggle.setting,
                    false, toggle.description)
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

        if enabling and setting == SETTING_ARTISAN then
            GrantArtisanStartingKit(player)
        end

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
