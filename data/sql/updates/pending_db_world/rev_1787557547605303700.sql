-- Argent Wayfinder beside the six new capital Bulletin Boards (Ironforge,
-- Undercity, Thunder Bluff, Darnassus, Silvermoon City, Exodar), reusing the
-- same creature_template entry 800020 the four existing wayfinders already
-- use - only new spawns are added here, the template stays untouched.
--
-- Also removes the scouting duplicates left behind at these same spots:
-- placing the boards/quartermaster/wayfinder to find the coordinates used
-- entries 800000/800010/800020, the same ones Stormwind's own board already
-- uses, so each scouted capital picked up an extra Stormwind-labelled copy
-- of all three. The real board and quartermaster for these six capitals are
-- emitted by make_boards.py under their own entries (800004-800009 and
-- 800014-800019); this migration only needs to clear the leftover copies and
-- add the one prop make_boards.py does not generate, the wayfinder.

-- Scouting duplicates: gameobject 800000 (Bulletin Board) spawned away from
-- Stormwind's own position.
DELETE FROM `gameobject` WHERE `id` = 800000
    AND NOT (`position_x` = -8887.26 AND `position_y` = 593.544);

-- Scouting duplicates: creature 800010 (Stormwind's own quartermaster
-- template) spawned away from Stormwind's own position.
DELETE FROM `creature` WHERE `id` = 800010
    AND NOT (`position_x` = -8889.73 AND `position_y` = 592.182);

-- Scouting duplicates: creature 800020 (Argent Wayfinder) spawned away from
-- the four real wayfinders' own positions.
DELETE FROM `creature` WHERE `id` = 800020 AND `guid` NOT IN
    (5980020, 5980021, 5980022, 5980023);

-- The six real wayfinders.
DELETE FROM `creature` WHERE `guid` BETWEEN 5980046 AND 5980051;
INSERT INTO `creature`
    (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,
     `position_z`,`orientation`,`spawntimesecs`,`MovementType`) VALUES
    (5980046,800020,0,1,1,-4891.63,-955.786,501.464,2.27009,300,0),
    (5980047,800020,0,1,1,1556.75,242.953,-43.1027,0.084979,300,0),
    (5980048,800020,1,1,1,-1212.95,51.9621,130.739,2.48955,300,0),
    (5980049,800020,1,1,1,9942.7,2406.02,1328.15,6.28312,300,0),
    (5980050,800020,530,1,1,9530.91,-7285.06,14.3756,1.64246,300,0),
    (5980051,800020,530,1,1,-3975.02,-11640.7,-138.929,5.78053,300,0);
