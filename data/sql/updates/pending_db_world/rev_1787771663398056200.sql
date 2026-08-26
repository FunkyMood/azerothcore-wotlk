-- Retire the Shrine of Challenge gameobject entirely - Sir Gideon now hosts
-- the same challenge-modes menu via Lua, so players interact with an NPC
-- they already know rather than a standalone prop.
DELETE FROM `gameobject` WHERE `guid` BETWEEN 5530536 AND 5530544;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 5714561 AND 5714570;
DELETE FROM `gameobject_template` WHERE `entry`=254605;

-- Gideon exists as two parallel creature_template entries (200000 and
-- 200001, both "Sir Gideon Ofnir the All-Knowing", same 186 quests each).
-- Entry 200001 already stands in all 8 capitals; only Ebon Hold (the Death
-- Knight starting zone) had no Gideon of either entry, so that's the only
-- new spawn needed here. 5980103-5980112 were an earlier, redundant attempt
-- at spawning entry 200000 in the capitals before this was known - drop them.
DELETE FROM `creature` WHERE `guid` BETWEEN 5980102 AND 5980112;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `CreateObject`) VALUES
(5980102, 200000, 609, 0, 0, 1, 1, 0, 2415.84, -5649.91, 376.819, 1.87356, 300, 0, 0, 40, 120, 0, 0, 0, 0, '', 0);
