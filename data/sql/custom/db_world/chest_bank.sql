-- Personal bank chest attempt: reverted. Every summon approach tried (GameObject + invisible Creature via
-- WorldObject:SummonCreature, Player:SummonCreature, PerformIngameSpawn) either failed at runtime in this
-- Eluna build or produced a broken/duplicated bank NPC in game. Cleaning up all leftover custom rows so the
-- Camp scene goes back to exactly campfire + tent + hookah (see lua_scripts/hookah_emote.lua).
DELETE FROM `gameobject_template` WHERE `entry` = 500004;
DELETE FROM `creature_template_model` WHERE `CreatureID` = 200002;
DELETE FROM `creature_template` WHERE `entry` = 200002;
