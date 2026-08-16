-- Capital-grade Sir Gideon beside Merchant Kale in the eight major starting
-- towns.  Each Gideon stands three yards in front of Kale and faces him.
-- These GUIDs are also the allow-list used by starting_town_conversation.lua.
DELETE FROM `creature` WHERE `guid` BETWEEN 5300757 AND 5300764;
INSERT INTO `creature`
    (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,
     `position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,
     `wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,
     `npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`,`CreateObject`,`Comment`)
VALUES
(5300757,200001,0,0,0,1,1,0,-9498.857,58.349,56.8033,3.00845,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Goldshire'),
(5300758,200001,0,0,0,1,1,0,-5624.082,-481.578,396.981,1.50668,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Kharanos'),
(5300759,200001,1,0,0,1,1,0,9852.811,955.751,1307.25,3.80599,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Dolanaar'),
(5300760,200001,530,0,0,1,1,0,-4152.315,-12508.931,45.0273,4.57023,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Azure Watch'),
(5300761,200001,1,0,0,1,1,0,282.959,-4766.296,12.2866,4.00706,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Razor Hill'),
(5300762,200001,1,0,0,1,1,0,-2245.464,-362.644,-9.42489,1.39866,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Bloodhoof Village'),
(5300763,200001,0,0,0,1,1,0,2280.017,311.735,35.0689,5.88437,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Brill'),
(5300764,200001,530,0,0,1,1,0,9488.999,-6814.090,16.4921,3.82854,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Sir Gideon - Falconwing Square');
