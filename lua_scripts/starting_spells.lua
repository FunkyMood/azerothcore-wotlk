local PLAYER_EVENT_ON_LOGIN = 3

-- Spells every character should have. Deliberately NOT using playercreateinfo_spell_custom: that table
-- ships pre-populated with ~7000 base-game race/class rows gated by a single global config
-- (PlayerStart.CustomSpells), so enabling it to grant just our spells also activates everything already
-- in there. Also deliberately NOT using PLAYER_EVENT_ON_CHARACTER_CREATE: that hook fires on a transient
-- Player object AFTER it has already been saved to the DB (see CharacterHandler.cpp, SaveToDB happens
-- before sScriptMgr->OnPlayerCreate), so anything learned there is silently lost, never persisted.
--
-- ON_LOGIN fires on the live, in-world, already-saved character, so LearnSpell here actually persists
-- through the normal save cycle. The HasSpell guard makes it idempotent (no repeated "you learned X"
-- message every login) and, as a side effect, backfills any pre-existing character that never got it.
local STARTING_SPELLS = {
    818,  -- Camp (Basic Campfire)
}

local function OnLogin(event, player)
    for _, spellId in ipairs(STARTING_SPELLS) do
        if not player:HasSpell(spellId) then
            player:LearnSpell(spellId)
        end
    end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
