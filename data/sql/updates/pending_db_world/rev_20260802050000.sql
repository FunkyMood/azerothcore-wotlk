START TRANSACTION;

-- Merchant Kalé: native profession trainer and profession-supply vendor.
UPDATE `creature_template`
SET `npcflag` = 145,
    `gossip_menu_id` = 0,
    `AIName` = '',
    `ScriptName` = ''
WHERE `entry` = 200002;

INSERT INTO `trainer` (`Id`,`Type`,`Requirement`,`Greeting`,`VerifiedBuild`)
VALUES
(200002,2,0,'Every craft begins with the proper lesson and the proper tool.',0)
ON DUPLICATE KEY UPDATE
    `Type`=VALUES(`Type`),
    `Requirement`=VALUES(`Requirement`),
    `Greeting`=VALUES(`Greeting`),
    `VerifiedBuild`=VALUES(`VerifiedBuild`);

INSERT INTO `creature_default_trainer` (`CreatureId`,`TrainerId`)
VALUES (200002,200002)
ON DUPLICATE KEY UPDATE `TrainerId`=VALUES(`TrainerId`);

DELETE FROM `trainer_spell` WHERE `TrainerId` = 200002;

-- Canonical classic trainers for the eleven primary and three secondary
-- professions. Include Apprentice, Journeyman and trainer recipes through
-- skill 150. Rank upgrades beginning at Expert (required skill 125) are
-- explicitly excluded while recipes usable within Journeyman remain present.
INSERT INTO `trainer_spell`
    (`TrainerId`,`SpellId`,`MoneyCost`,`ReqSkillLine`,`ReqSkillRank`,
     `ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`ReqLevel`,`VerifiedBuild`)
SELECT
    200002,ts.`SpellId`,ts.`MoneyCost`,ts.`ReqSkillLine`,ts.`ReqSkillRank`,
    ts.`ReqAbility1`,ts.`ReqAbility2`,ts.`ReqAbility3`,ts.`ReqLevel`,ts.`VerifiedBuild`
FROM `trainer_spell` ts
WHERE ts.`TrainerId` IN (60,61,67,69,74,77,80,83,92,96,98,100,111,119)
  AND
  (
      (ts.`ReqSkillLine` = 0 AND ts.`ReqSkillRank` = 0)
      OR
      (
          ts.`ReqSkillLine` <> 0
          AND ts.`ReqSkillRank` <= 150
          AND NOT (ts.`ReqAbility1` <> 0 AND ts.`ReqSkillRank` >= 125)
      )
  );

-- Only tools and vendor-supplied reagents are sold. Gathered or crafted
-- materials remain part of the world economy and Bulletin Board loop.
DELETE FROM `npc_vendor` WHERE `entry` = 200002;
INSERT INTO `npc_vendor`
    (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`VerifiedBuild`)
VALUES
(200002, 0,2901,0,0,0,0),   -- Mining Pick
(200002, 1,5956,0,0,0,0),   -- Blacksmith Hammer
(200002, 2,7005,0,0,0,0),   -- Skinning Knife
(200002, 3,6219,0,0,0,0),   -- Arclight Spanner
(200002, 4,20815,0,0,0,0),  -- Jeweler's Kit
(200002, 5,20824,0,0,0,0),  -- Simple Grinder
(200002, 6,39505,0,0,0,0),  -- Virtuoso Inking Set
(200002, 7,6217,0,0,0,0),   -- Copper Rod
(200002, 8,6256,0,0,0,0),   -- Fishing Pole
(200002, 9,6529,0,0,0,0),   -- Shiny Bauble
(200002,10,6530,0,0,0,0),   -- Nightcrawlers
(200002,11,6532,0,0,0,0),   -- Bright Baubles
(200002,12,3371,0,0,0,0),   -- Empty Vial
(200002,13,2880,0,0,0,0),   -- Weak Flux
(200002,14,2320,0,0,0,0),   -- Coarse Thread
(200002,15,2321,0,0,0,0),   -- Fine Thread
(200002,16,2324,0,0,0,0),   -- Bleach
(200002,17,2604,0,0,0,0),   -- Red Dye
(200002,18,2605,0,0,0,0),   -- Green Dye
(200002,19,6260,0,0,0,0),   -- Blue Dye
(200002,20,4340,0,0,0,0),   -- Gray Dye
(200002,21,4341,0,0,0,0),   -- Yellow Dye
(200002,22,4289,0,0,0,0),   -- Salt
(200002,23,39354,0,0,0,0),  -- Light Parchment
(200002,24,2678,0,0,0,0),   -- Mild Spices
(200002,25,30817,0,0,0,0),  -- Simple Flour
(200002,26,4470,0,0,0,0),   -- Simple Wood
(200002,27,4471,0,0,0,0),   -- Flint and Tinder
(200002,28,3857,0,0,0,0),   -- Coal
(200002,29,4399,0,0,0,0),   -- Wooden Stock
(200002,30,4400,0,0,0,0);   -- Heavy Stock

-- Preserve the eight player-selected Kalé and Pack Mule placements.
REPLACE INTO `creature`
    (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,
     `position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,
     `wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,
     `npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`,`CreateObject`,`Comment`)
VALUES
(5300721,200002,0,0,0,1,1,0,-9501.83,58.7467,56.8033,6.15004,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Goldshire'),
(5300722,16225,0,0,0,1,1,0,-9503.76,58.4586,57.1039,5.03086,300,0,0,42,0,0,0,0,0,'',NULL,0,'Pack Mule - Goldshire'),
(5300723,200002,0,0,0,1,1,0,-5623.89,-478.584,396.981,4.64827,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Kharanos'),
(5300724,16225,0,0,0,1,1,0,-5622.71,-476.969,396.981,5.66928,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Kharanos'),
(5300727,200002,1,0,0,1,1,0,9850.45,953.901,1307.25,0.664395,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Dolanaar'),
(5300728,16225,1,0,0,1,1,0,9848.79,952.426,1307.57,5.90693,300,0,0,42,0,0,0,0,0,'',NULL,0,'Pack Mule - Dolanaar'),
(5300729,200002,530,0,0,1,1,0,-4152.74,-12511.9,45.0273,1.42864,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Azure Watch'),
(5300730,16225,530,0,0,1,1,0,-4153.89,-12513.5,45.1995,2.03732,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Azure Watch'),
(5300731,200002,1,0,0,1,1,0,281.012,-4768.58,12.2866,0.865465,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Razor Hill'),
(5300732,16225,1,0,0,1,1,0,279.573,-4770.05,12.3227,1.76082,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Razor Hill'),
(5300733,200002,1,0,0,1,1,0,-2244.95,-359.688,-9.42489,4.54025,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Bloodhoof Village'),
(5300734,16225,1,0,0,1,1,0,-2243.39,-357.963,-9.42489,5.2471,300,0,0,42,0,0,0,0,0,'',NULL,0,'Pack Mule - Bloodhoof Village'),
(5300735,200002,0,0,0,1,1,0,2282.78,310.571,35.0689,2.74278,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Brill'),
(5300736,16225,0,0,0,1,1,0,2283.91,309.243,35.1448,3.48891,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Brill'),
(5300737,200002,530,0,0,1,1,0,9486.68,-6815.99,16.4921,0.686947,300,0,0,1299,1470,0,0,0,0,'',NULL,0,'Merchant Kale - Falconwing Square'),
(5300738,16225,530,0,0,1,1,0,9484.98,-6815.48,16.4921,1.3349,300,0,0,55,0,0,0,0,0,'',NULL,0,'Pack Mule - Falconwing Square');

UPDATE `version` SET `cache_id` = `cache_id` + 1;
COMMIT;
