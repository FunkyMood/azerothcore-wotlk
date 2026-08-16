-- Capital-city Gideon, kept separate from starting-zone Gideon (200000).
CREATE TEMPORARY TABLE `_gideon_capital_clone` LIKE `creature_template`;
INSERT INTO `_gideon_capital_clone`
SELECT * FROM `creature_template` WHERE `entry` = 200000;
UPDATE `_gideon_capital_clone` SET `entry` = 200001, `npcflag` = 17;
REPLACE INTO `creature_template` SELECT * FROM `_gideon_capital_clone`;
DROP TEMPORARY TABLE `_gideon_capital_clone`;

DELETE FROM `creature_template_model` WHERE `CreatureID` = 200001;
INSERT INTO `creature_template_model`
    (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 200001, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`
FROM `creature_template_model`
WHERE `CreatureID` = 200000;

-- One capital spawn for each Alliance and Horde capital.
DELETE FROM `creature` WHERE `id` = 200001;
INSERT INTO `creature`
    (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`,
     `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
     `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`,
     `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
VALUES
(5300711,200001,0,0,0,1,1,0,-8819.61,628.651,93.9659,3.84569,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Stormwind'),
(5300712,200001,0,0,0,1,1,0,-4915.39,-980.885,501.445,2.32115,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Ironforge'),
(5300713,200001,1,0,0,1,1,0,9940.45,2500.12,1317.93,3.9246,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Darnassus'),
(5300714,200001,530,0,0,1,1,0,-3924.34,-11605.8,-138.442,4.89698,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Exodar'),
(5300715,200001,1,0,0,1,1,0,1617.61,-4393.27,10.4764,4.08638,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Orgrimmar'),
(5300716,200001,1,0,0,1,1,0,-1235.29,70.6951,129.133,2.40317,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Thunder Bluff'),
(5300717,200001,0,0,0,1,1,0,1563.88,263.004,-43.103,5.38251,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Undercity'),
(5300718,200001,530,0,0,1,1,0,9519.27,-7262.85,14.3545,4.86495,300,0,0,40,120,0,0,0,0,'',NULL,0,'Capital Gideon - Silvermoon');
