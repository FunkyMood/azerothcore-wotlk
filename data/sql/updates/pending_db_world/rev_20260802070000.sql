-- Merchant Kale and Pack Mule placements in all eight faction capitals.
-- Coordinates were selected and verified in-game on Ironcore, then shared
-- with AzerothCore so both realms retain the same capital services.
START TRANSACTION;

REPLACE INTO `creature`
    (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,
     `position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,
     `wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,
     `npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`,`CreateObject`,`Comment`)
VALUES
(5300741,200002,0,0,0,1,1,0,-8810.07,621.398,94.5807,2.139,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Stormwind'),
(5300742,16225,0,0,0,1,1,0,-8809.85,619.616,94.9689,3.05399,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Stormwind'),
(5300743,200002,0,0,0,1,1,0,-4930.39,-992.791,501.442,2.17586,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Ironforge'),
(5300744,16225,0,0,0,1,1,0,-4930.5,-994.833,501.441,2.85209,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Ironforge'),
(5300745,200002,1,0,0,1,1,0,9924.4,2523.98,1319.37,2.97818,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Darnassus'),
(5300746,16225,1,0,0,1,1,0,9926.06,2522.42,1319.43,3.87746,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Darnassus'),
(5300747,200002,530,0,0,1,1,0,-3969.57,-11634.9,-138.921,6.08291,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Exodar'),
(5300748,16225,530,0,0,1,1,0,-3970.2,-11633.6,-138.933,0.479092,300,0,0,42,0,0,0,0,0,'',NULL,0,'Pack Mule - Exodar'),
(5300749,200002,1,0,0,1,1,0,1630.39,-4412.71,16.4731,1.17646,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Orgrimmar'),
(5300750,16225,1,0,0,1,1,0,1628.37,-4413.19,15.9786,1.70661,300,0,0,42,0,0,0,0,0,'',NULL,0,'Pack Mule - Orgrimmar'),
(5300751,200002,1,0,0,1,1,0,-1255.23,114.108,129.346,4.296,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Thunder Bluff'),
(5300752,16225,1,0,0,1,1,0,-1253.95,115.186,129.672,5.0594,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Thunder Bluff'),
(5300753,200002,0,0,0,1,1,0,1626.52,210.947,-43.1024,3.04594,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Undercity'),
(5300754,16225,0,0,0,1,1,0,1628.2,210.442,-43.1024,4.02692,300,0,0,42,0,0,0,0,0,'',NULL,0,'Pack Mule - Undercity'),
(5300755,200002,530,0,0,1,1,0,9472.96,-7295.25,14.3204,0.690853,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Silvermoon City'),
(5300756,16225,530,0,0,1,1,0,9471.11,-7294.93,14.3141,1.07963,300,0,0,42,0,0,0,0,0,'',NULL,0,'Pack Mule - Silvermoon City');

UPDATE `version` SET `cache_id` = `cache_id` + 1;
COMMIT;
