-- Fixes 7 rows the last "2026_08_19_04_bulletin_boards.sql" apply silently dropped:
-- the Stormwind board (gameobject 800000) and six quartermasters (creature 800010
-- through 800015, Stormwind/Orgrimmar/Shattrath/Dalaran/Ironforge/Darnassus).
--
-- Every row furniture() writes gets its guid from
-- `(SELECT MAX(guid) + 1 FROM creature)`, re-evaluated fresh for each of the ten
-- cities in the same run. Ten INSERTs that close that fast on one connection can
-- outrun the read each one depends on - the second sees the same MAX the first saw,
-- both compute the same next guid, and the later INSERT dies on the primary key with
-- no error surfacing in dbimport's own log. Four cities (Exodar onward) landed with
-- clean sequential guids; the six ahead of them did not.
--
-- Explicit guids here, not another `MAX + 1`, so this migration cannot repeat the
-- failure it is fixing.

DELETE FROM `gameobject` WHERE `id` = 800000;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
    (5714520,800000,0,1,1,-8887.26,593.544,94.0959,5.30693,0.0,0.0,0.46897303144408664,-0.8832124861991839,300,100,1);

DELETE FROM `creature` WHERE `id` IN (800010,800011,800012,800013,800014,800015);
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`MovementType`) VALUES
    (5980056,800010,0,1,1,-8889.73,592.182,94.0926,5.33913,300,0),
    (5980057,800011,1,1,1,1579.57,-4422.05,7.28159,3.68507,300,0),
    (5980058,800012,530,1,1,-1844.97,5345.74,-12.428,4.84037,300,0),
    (5980059,800013,571,1,1,5840.52,449.452,658.783,3.06394,300,0),
    (5980060,800014,0,1,1,-4887.59,-952.515,501.467,2.29759,300,0),
    (5980061,800015,1,1,1,9943.02,2399.65,1328.53,0.0329218,300,0);
