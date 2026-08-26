-- mod-challenge-modes: Shrine of Challenge gameobject + spawns.
-- Ships the module's own 9 starting-zone spawns plus 10 new ones in the
-- graveyards of every major city (8 capitals, Shattrath, Dalaran) so the
-- challenges are reachable at any level, not just while starting a fresh
-- character. Orgrimmar and Exodar have no in-city graveyard in this data
-- set (dying there routes to the outdoor Durotar / Azuremyst graveyards),
-- so those two use the nearest real graveyard on record instead (Northern
-- Durotar, Stillpine GY) rather than an arbitrary in-city coordinate.
DELETE FROM `gameobject_template` WHERE `entry`=254605;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(254605, 2, 6925, 'Shrine of Challenge', '', '', '', 1.2, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'gobject_challenge_modes', 0);

DELETE FROM `gameobject` WHERE `guid` BETWEEN 5530536 AND 5530544;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(5530536, 254605, 0, 0, 0, 1, 1, -8920.64, -178.191, 80.891, 4.3208, -0, -0, -0.83116, 0.556033, 300, 0, 1, '', 0),
(5530537, 254605, 0, 0, 0, 1, 1, -6135.29, 336.119, 402.238, 5.55195, -0, -0, -0.357526, 0.933903, 300, 0, 1, '', 0),
(5530538, 254605, 1, 0, 0, 1, 1, 10415.2, 809.575, 1318.19, 2.37082, -0, -0, -0.926654, -0.375916, 300, 0, 1, '', 0),
(5530539, 254605, 530, 0, 0, 1, 1, -4147.11, -13667.7, 75.8166, 5.06421, -0, -0, -0.572447, 0.819942, 300, 0, 1, '', 0),
(5530540, 254605, 1, 0, 0, 1, 1, -658.88, -4311.88, 45.666, 3.06225, -0, -0, -0.999213, -0.0396603, 300, 0, 1, '', 0),
(5530541, 254605, 0, 0, 0, 1, 1, 1842.91, 1651.33, 95.6206, 1.58336, -0, -0, -0.711535, -0.702651, 300, 0, 1, '', 0),
(5530542, 254605, 1, 0, 0, 1, 1, -2994.22, -136.321, 77.9491, 1.05411, -0, -0, -0.502992, -0.864291, 300, 0, 1, '', 0),
(5530543, 254605, 530, 0, 0, 1, 1, 10452, -6389.91, 43.7962, 1.84851, -0, -0, -0.798173, -0.602429, 300, 0, 1, '', 0),
(5530544, 254605, 609, 0, 0, 1, 1, 2415.84, -5649.91, 376.819, 1.87356, -0, -0, -0.805655, -0.592385, 300, 0, 1, '', 0);

DELETE FROM `gameobject` WHERE `guid` BETWEEN 5714561 AND 5714570;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(5714561, 254605, 0, 0, 0, 1, 1, -9151.98, 410.944, 92.6966, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714562, 254605, 0, 0, 0, 1, 1, -5165.52, -874.664, 507.177, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714563, 254605, 1, 0, 0, 1, 1, 10054.3, 2117.12, 1329.63, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714564, 254605, 530, 0, 0, 1, 1, -3324.31, -12089.9, 28.2748, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714565, 254605, 1, 0, 0, 1, 1, 1177.78, -4464.24, 21.3539, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714566, 254605, 1, 0, 0, 1, 1, -981.917, -74.6465, 20.1265, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714567, 254605, 0, 0, 0, 1, 1, 1822.61, 214.674, 60.1402, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714568, 254605, 530, 0, 0, 1, 1, 9407, -6847.67, 16, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714569, 254605, 530, 0, 0, 1, 1, -1793.42, 4931.61, -22.2095, 0, 0, 0, 0, 1, 300, 0, 1, '', 0),
(5714570, 254605, 571, 0, 0, 1, 1, 5849.21, 763.311, 641.053, 0, 0, 0, 0, 1, 300, 0, 1, '', 0);
