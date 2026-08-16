local GOSSIP_EVENT_ON_HELLO = 1
local GOSSIP_EVENT_ON_SELECT = 2
local CREATURE_EVENT_ON_MOVE_IN_LOS = 27

local GIDEON_ENTRY = 200000
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

local LORE_NPC_TEXT_ID = 200001

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
    player:GossipMenuAddItem(0, "Nothing, thank you", 0, ACTION_CLOSE)
    player:GossipSendMenu(1, object, 1)
end

local function OnGideonSelect(event, player, object, sender, intid, code, menu_id)
    if intid == ACTION_LORE then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "...", 0, ACTION_BACK)
        player:GossipSendMenu(LORE_NPC_TEXT_ID, object, 2)
    elseif intid == ACTION_BACK then
        OnGideonHello(event, player, object)
    elseif intid == ACTION_TRAIN then
        player:SendTrainerList(object)
    else
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(GIDEON_ENTRY, GOSSIP_EVENT_ON_HELLO, OnGideonHello)
RegisterCreatureGossipEvent(GIDEON_ENTRY, GOSSIP_EVENT_ON_SELECT, OnGideonSelect)
RegisterCreatureEvent(GIDEON_ENTRY, CREATURE_EVENT_ON_MOVE_IN_LOS, OnGideonMoveInLOS)
