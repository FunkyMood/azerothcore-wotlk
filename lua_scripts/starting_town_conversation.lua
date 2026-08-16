-- Silent ambient gestures for the eight starting-town Gideons only. Merchant
-- Kale's model does not visibly support these animations, so he remains still.
-- Capital Gideons share the entry; database GUIDs are the deliberate boundary.
local CREATURE_EVENT_ON_SPAWN = 5
local GIDEON_ENTRY = 200001
local TURN_MS = 10000

local gideons = {
    [5300757] = true, [5300758] = true, [5300759] = true, [5300760] = true,
    [5300761] = true, [5300762] = true, [5300763] = true, [5300764] = true,
}

local gideonEmotes = {1, 5, 6, 25, 273}

local function Gesture(eventId, delay, repeats, creature)
    if creature:IsAlive() and not creature:IsInCombat() then
        creature:PerformEmote(gideonEmotes[math.random(#gideonEmotes)])
    end
end

local function BeginTurns(eventId, delay, repeats, creature)
    Gesture(0, 0, 0, creature)
    creature:RegisterEvent(Gesture, TURN_MS, 0)
end

local function OnSpawn(event, creature)
    local guid = creature:GetDBTableGUIDLow()
    if gideons[guid] then
        creature:RegisterEvent(BeginTurns, TURN_MS, 1)
    end
end

RegisterCreatureEvent(GIDEON_ENTRY, CREATURE_EVENT_ON_SPAWN, OnSpawn)
