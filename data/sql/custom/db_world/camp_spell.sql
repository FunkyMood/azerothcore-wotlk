-- "Camp" starting spell: reuses the native 3.3.5a spell 818 "Basic Campfire" (SPELL_EFFECT_TRANS_DOOR,
-- see src/server/scripts/Spells/spell_generic.cpp spell_gen_basic_campfire) instead of a custom DBC spell.
-- Already present in every stock client - no DBC edit, no MPQ patch needed.
--
-- NOTE: granting this at level 1 is done via lua_scripts/starting_spells.lua (PLAYER_EVENT_ON_CHARACTER_CREATE),
-- NOT via playercreateinfo_spell_custom - that table ships pre-populated with ~7000 base-game race/class rows
-- gated by the single global config PlayerStart.CustomSpells, so enabling it to add just this one row also
-- activates all the pre-existing ones. Keep PlayerStart.CustomSpells = 0.

-- Remove the client-side cooldown entirely (server-side override, no DBC edit needed - see
-- SpellMgr::LoadSpellCooldownOverrides / GetSpellCooldownOverride in src/server/game/Spells/SpellMgr.cpp).
DELETE FROM `spell_cooldown_overrides` WHERE `Id` = 818;
INSERT INTO `spell_cooldown_overrides` (`Id`, `RecoveryTime`, `CategoryRecoveryTime`, `StartRecoveryTime`, `StartRecoveryCategory`, `Comment`) VALUES
(818, 0, 0, 0, 0, 'Camp - Basic Campfire, no cooldown');
