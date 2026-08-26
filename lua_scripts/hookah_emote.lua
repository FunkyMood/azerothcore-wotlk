local GAMEOBJECT_EVENT_ON_USE = 14
local PLAYER_EVENT_ON_SPELL_CAST = 5
local HOOKAH_ENTRY = 500001
local CAMP_SPELL_ID = 818  -- "Camp" (Basic Campfire), already granted to every character at level 1
local HOOKAH_RESPAWN_SECONDS = 300  -- matches Camp's own campfire lifetime (5 minutes)
local TENT_ENTRY = 500002
local TENT_RESPAWN_SECONDS = 300
local RUG_ENTRY = 500003
local RUG_RESPAWN_SECONDS = 300
local EMOTE_STATE_EAT = 418  -- closest native animation available; WotLK 3.3.5a has no dedicated "smoking" emote

local UNIT_STAND_STATE_SIT = 1

-- EmoteState (the UNIT_NPC_EMOTESTATE field) doesn't visibly animate players, only creatures - despite the
-- name suggesting a generic "continuous emote", it's NPC-only in practice. To fake a looping animation on a
-- player we repeat the one-shot PerformEmote on a timer instead, for a ~30s "smoking session".
local PUFF_INTERVAL_MS = 1500
local PUFF_REPEATS = 20

local function OnHookahUse(event, go, player)
    player:SetStandState(UNIT_STAND_STATE_SIT)
    player:PerformEmote(EMOTE_STATE_EAT)
    player:RegisterEvent(function(eventId, delay, repeats, p)
        -- moving always stands the player back up (native WoW behaviour, same as any chair) - once that
        -- happens, stop trying to re-trigger the animation instead of puffing away while walking around
        if p:GetStandState() ~= UNIT_STAND_STATE_SIT then
            p:RemoveEventById(eventId)
            return
        end
        p:PerformEmote(EMOTE_STATE_EAT)
    end, PUFF_INTERVAL_MS, PUFF_REPEATS)
    return true  -- suppress the object's own native GOOBER behavior
end

-- When a player casts Camp, also drop the hookah a few yards to the side of the campfire, and the tent on
-- the opposite side, so all three props appear together as one "camping scene".
local function OnCampCast(event, player, spell, skipCheck)
    if spell:GetEntry() ~= CAMP_SPELL_ID then
        return
    end

    local x, y, z, o = player:GetX(), player:GetY(), player:GetZ(), player:GetO()
    local map = player:GetMap()

    -- tent farther out in front of the player, entrance facing back toward the player (orientation
    -- flipped 180 degrees from the player's own facing). Terrain height is queried at the tent's own
    -- offset position rather than reused from the player - on sloped ground the player's Z is wrong by
    -- the time you're 6.5 yards away, which is what made the tent float or clip into the ground.
    local tentDist = 6.5
    local tentX = x + tentDist * math.cos(o)
    local tentY = y + tentDist * math.sin(o)
    local tentZ = map:GetHeight(tentX, tentY) or z
    local tentO = o + math.pi
    player:SummonGameObject(TENT_ENTRY, tentX, tentY, tentZ, tentO, TENT_RESPAWN_SECONDS)

    -- rug placed exactly under the tent (same position/orientation)
    player:SummonGameObject(RUG_ENTRY, tentX, tentY, tentZ, tentO, RUG_RESPAWN_SECONDS)

    -- hookah placed inside the tent, on its left side (offset relative to the tent's own position/facing,
    -- not the player's - so it sits inside the tent wherever the tent ends up)
    local hookahOffset = 0.7
    local hookahX = tentX + hookahOffset * math.cos(tentO + math.pi / 2)
    local hookahY = tentY + hookahOffset * math.sin(tentO + math.pi / 2)
    local hookahZ = map:GetHeight(hookahX, hookahY) or tentZ
    player:SummonGameObject(HOOKAH_ENTRY, hookahX, hookahY, hookahZ, tentO, HOOKAH_RESPAWN_SECONDS)
end

RegisterGameObjectEvent(HOOKAH_ENTRY, GAMEOBJECT_EVENT_ON_USE, OnHookahUse)
RegisterPlayerEvent(PLAYER_EVENT_ON_SPELL_CAST, OnCampCast)
