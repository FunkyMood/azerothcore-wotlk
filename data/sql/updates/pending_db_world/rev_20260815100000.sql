-- Sir Gideon is an entry point, not a replacement for the stock class-quest
-- flow. Offer only the first stage of each class chain. Breadcrumb quests take
-- precedence over their destination for the races they serve; later stages
-- remain available only from their normal quest givers.
--
-- ARAC enables every race/class pairing but stock quests still encode their
-- narrative lineage through quest-giver geography. Non-canonical pairings use
-- one deterministic same-faction lineage instead of seeing every racial copy.

CREATE TABLE IF NOT EXISTS `gideon_arac_lineages` (
    `race_id` TINYINT UNSIGNED NOT NULL,
    `class_id` TINYINT UNSIGNED NOT NULL,
    `quest_race_mask` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`race_id`, `class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `gideon_class_quest_rules` (
    `quest_id` INT UNSIGNED NOT NULL,
    `race_mask` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Canonical masks from AzerothCore's base quest_template before mod-arac
-- broadens class quests to every playable race. Keeping this snapshot local to
-- Gideon preserves ARAC globally while retaining each quest's narrative origin.
CREATE TABLE IF NOT EXISTS `gideon_stock_quest_races` (
    `quest_id` INT UNSIGNED NOT NULL,
    `race_mask` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`quest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `gideon_stock_quest_races`;
INSERT INTO `gideon_stock_quest_races` (`quest_id`, `race_mask`) VALUES
(26,8),
(27,32),
(28,32),
(29,8),
(30,32),
(31,32),
(63,690),
(96,690),
(100,690),
(220,690),
(272,8),
(972,0),
(1103,690),
(1442,1101),
(1462,690),
(1463,690),
(1464,690),
(1471,16),
(1472,690),
(1473,16),
(1474,690),
(1476,690),
(1478,16),
(1498,690),
(1499,130),
(1501,2),
(1502,690),
(1503,690),
(1504,2),
(1505,690),
(1506,2),
(1507,690),
(1508,690),
(1509,690),
(1510,690),
(1511,690),
(1512,690),
(1513,690),
(1515,690),
(1516,130),
(1517,130),
(1518,130),
(1519,32),
(1520,32),
(1521,32),
(1522,690),
(1523,690),
(1524,690),
(1525,690),
(1526,690),
(1528,690),
(1529,690),
(1530,690),
(1531,690),
(1532,690),
(1534,690),
(1535,690),
(1536,690),
(1638,1101),
(1639,1101),
(1640,1101),
(1641,1),
(1643,1),
(1644,1),
(1645,4),
(1647,4),
(1648,4),
(1650,1101),
(1651,1101),
(1652,1101),
(1653,1101),
(1654,1101),
(1655,1101),
(1665,1101),
(1666,1101),
(1667,1101),
(1678,68),
(1679,68),
(1680,1101),
(1681,1101),
(1682,1101),
(1683,1101),
(1684,1101),
(1685,1101),
(1686,1101),
(1688,1101),
(1689,1101),
(1692,1101),
(1693,1101),
(1698,1101),
(1699,1101),
(1700,1),
(1701,1101),
(1702,1101),
(1703,8),
(1704,68),
(1705,1101),
(1706,1101),
(1708,1101),
(1709,1101),
(1710,1101),
(1711,1101),
(1712,0),
(1713,0),
(1715,1101),
(1716,1101),
(1717,1101),
(1718,0),
(1719,0),
(1738,1101),
(1739,1101),
(1740,0),
(1758,1101),
(1778,4),
(1779,4),
(1780,1),
(1781,1),
(1783,4),
(1784,4),
(1785,4),
(1786,1),
(1787,1),
(1788,1),
(1789,4),
(1790,1),
(1791,0),
(1792,0),
(1793,1101),
(1794,1101),
(1795,0),
(1796,0),
(1798,1101),
(1799,0),
(1801,690),
(1802,1101),
(1803,690),
(1804,1101),
(1805,690),
(1806,1101),
(1818,690),
(1819,690),
(1820,690),
(1821,690),
(1822,690),
(1823,690),
(1824,690),
(1825,690),
(1838,690),
(1839,690),
(1840,690),
(1841,690),
(1842,690),
(1843,690),
(1844,690),
(1845,690),
(1846,690),
(1847,690),
(1848,690),
(1858,690),
(1859,690),
(1860,1101),
(1861,1),
(1879,1101),
(1880,1101),
(1881,690),
(1882,690),
(1883,690),
(1884,690),
(1885,690),
(1919,1101),
(1920,1101),
(1921,1101),
(1938,1101),
(1939,1101),
(1940,1101),
(1941,1101),
(1942,1101),
(1943,690),
(1944,690),
(1945,690),
(1946,690),
(1947,0),
(1948,0),
(1949,0),
(1950,0),
(1951,0),
(1952,0),
(1953,0),
(1954,0),
(1955,0),
(1956,0),
(1957,0),
(1958,0),
(1959,690),
(1960,690),
(1961,690),
(1962,690),
(1963,690),
(1978,690),
(1998,690),
(1999,690),
(2019,0),
(2205,1101),
(2206,1101),
(2218,1101),
(2238,1101),
(2239,1101),
(2241,1101),
(2242,1101),
(2259,1101),
(2260,1101),
(2281,1101),
(2282,1101),
(2298,1101),
(2299,1101),
(2300,1101),
(2358,0),
(2359,1101),
(2360,1101),
(2378,690),
(2379,690),
(2380,690),
(2381,690),
(2382,690),
(2383,2),
(2458,690),
(2460,690),
(2478,690),
(2479,690),
(2480,690),
(2607,1101),
(2608,1101),
(2609,1101),
(2983,690),
(2984,690),
(2985,690),
(2986,0),
(2996,690),
(2997,4),
(2998,1),
(2999,4),
(3000,4),
(3001,690),
(3065,128),
(3082,128),
(3083,128),
(3084,128),
(3085,128),
(3086,128),
(3087,2),
(3088,2),
(3089,2),
(3090,2),
(3091,690),
(3092,690),
(3093,690),
(3094,690),
(3095,0),
(3096,0),
(3097,0),
(3098,0),
(3099,0),
(3100,1),
(3101,1),
(3102,1),
(3103,1),
(3104,1),
(3105,1),
(3106,4),
(3107,4),
(3108,4),
(3109,4),
(3110,4),
(3112,64),
(3113,64),
(3114,64),
(3115,64),
(3116,1101),
(3117,1101),
(3118,1101),
(3119,1101),
(3120,1101),
(3681,1),
(4485,1101),
(4486,1101),
(4736,1101),
(4737,690),
(4738,1101),
(4739,690),
(4781,0),
(4782,0),
(4783,0),
(4784,0),
(4785,0),
(4786,0),
(4961,0),
(4962,0),
(4963,0),
(4964,0),
(4965,1101),
(4967,1101),
(4968,0),
(4969,690),
(4975,0),
(4976,0),
(5061,8),
(5621,8),
(5622,8),
(5623,1101),
(5624,1101),
(5625,1101),
(5626,1101),
(5648,690),
(5649,690),
(5650,690),
(5651,690),
(5921,8),
(5922,32),
(5923,8),
(5924,8),
(5925,8),
(5926,32),
(5927,32),
(5928,32),
(5929,8),
(5930,32),
(5931,8),
(5932,32),
(6001,8),
(6002,32),
(6061,32),
(6062,130),
(6063,8),
(6064,4),
(6065,32),
(6066,32),
(6067,32),
(6068,130),
(6069,130),
(6070,130),
(6071,8),
(6072,8),
(6073,8),
(6074,4),
(6075,4),
(6076,4),
(6081,130),
(6082,130),
(6083,130),
(6084,4),
(6085,4),
(6086,4),
(6087,32),
(6088,32),
(6089,32),
(6101,8),
(6102,8),
(6103,8),
(6121,1101),
(6122,1101),
(6123,1101),
(6124,1101),
(6125,1101),
(6126,690),
(6127,690),
(6128,690),
(6129,690),
(6130,690),
(6701,0),
(7562,595),
(7563,595),
(7564,595),
(7581,0),
(7582,0),
(7583,0),
(7601,0),
(7602,0),
(7603,0),
(7621,0),
(7622,0),
(7623,595),
(7624,595),
(7625,595),
(7626,595),
(7627,595),
(7628,595),
(7629,595),
(7630,595),
(7631,595),
(7633,0),
(7634,0),
(7635,0),
(7636,0),
(7637,1029),
(7638,1029),
(7639,1029),
(7640,1029),
(7641,1029),
(7642,1029),
(7643,1029),
(7644,1029),
(7645,1029),
(7646,1029),
(7647,1029),
(7648,1101),
(7666,1101),
(7667,690),
(7669,0),
(7670,1029),
(8151,0),
(8153,0),
(8231,0),
(8232,0),
(8233,0),
(8234,0),
(8235,0),
(8236,0),
(8250,0),
(8251,0),
(8252,0),
(8253,0),
(8254,0),
(8255,0),
(8256,0),
(8257,0),
(8258,690),
(8328,512),
(8410,0),
(8412,0),
(8413,0),
(8414,1101),
(8415,1101),
(8416,1101),
(8417,0),
(8418,1101),
(8419,0),
(8420,0),
(8421,0),
(8422,0),
(8423,0),
(8424,0),
(8425,0),
(8563,512),
(8564,512),
(9051,0),
(9052,0),
(9053,0),
(9063,0),
(9287,1024),
(9288,1024),
(9289,0),
(9290,1024),
(9291,1024),
(9362,0),
(9364,0),
(9392,512),
(9393,512),
(9402,690),
(9403,690),
(9404,690),
(9421,1024),
(9449,1101),
(9450,1101),
(9451,1101),
(9460,690),
(9461,0),
(9462,1101),
(9464,1101),
(9465,1101),
(9467,1101),
(9468,1101),
(9484,512),
(9485,512),
(9486,512),
(9487,0),
(9488,690),
(9489,690),
(9491,690),
(9500,1024),
(9501,1024),
(9502,0),
(9503,1024),
(9504,1024),
(9508,1024),
(9509,1024),
(9529,512),
(9532,690),
(9547,1024),
(9551,1024),
(9552,1024),
(9553,1024),
(9554,1024),
(9555,1101),
(9582,1101),
(9586,1101),
(9591,1024),
(9592,1024),
(9593,1024),
(9595,1101),
(9598,1024),
(9600,1024),
(9601,690),
(9617,512),
(9618,690),
(9673,512),
(9675,1024),
(9676,512),
(9677,512),
(9678,512),
(9681,512),
(9684,512),
(9685,512),
(9686,512),
(9690,512),
(9691,512),
(9692,512),
(9707,512),
(9710,512),
(9721,512),
(9722,512),
(9723,512),
(9725,0),
(9735,512),
(9736,512),
(9737,512),
(9757,1024),
(10350,1101),
(10366,1024),
(10371,0),
(10372,690),
(10490,1024),
(10491,1024),
(10548,690),
(10590,690),
(10592,690),
(10593,690),
(10605,0),
(10788,512),
(10789,16),
(10790,2),
(10794,690),
(10955,0),
(10961,0),
(10964,0),
(10965,0),
(10978,0),
(10979,0),
(10980,0),
(10986,0),
(10987,0),
(10988,0),
(10990,0),
(10991,0),
(10992,0),
(10993,0),
(10994,0),
(11001,0),
(11011,0),
(12172,1101),
(12173,690),
(12593,0),
(12619,0),
(12636,0),
(12641,0),
(12657,0),
(12670,0),
(12678,0),
(12679,0),
(12680,0),
(12687,0),
(12697,0),
(12698,0),
(12700,0),
(12701,0),
(12706,0),
(12714,0),
(12715,0),
(12716,0),
(12717,0),
(12719,0),
(12720,0),
(12722,0),
(12723,0),
(12724,0),
(12725,0),
(12727,0),
(12733,0),
(12738,0),
(12739,32),
(12742,1),
(12743,8),
(12744,4),
(12745,64),
(12746,1024),
(12747,512),
(12748,2),
(12749,128),
(12750,16),
(12751,0),
(12754,0),
(12755,0),
(12756,0),
(12757,0),
(12778,0),
(12779,0),
(12800,0),
(12801,0),
(12842,0),
(12848,0),
(12849,0),
(12850,0),
(13165,0),
(13166,0),
(13188,1101),
(13189,690),
(14100,0),
(14111,0),
(14418,690),
(14419,690),
(14420,690),
(14421,690);

DROP TEMPORARY TABLE IF EXISTS `_gideon_races`;
CREATE TEMPORARY TABLE `_gideon_races` (
    `race_id` TINYINT UNSIGNED NOT NULL,
    `race_mask` INT UNSIGNED NOT NULL,
    `faction` ENUM('ALLIANCE', 'HORDE') NOT NULL,
    PRIMARY KEY (`race_id`)
) ENGINE=MEMORY;

INSERT INTO `_gideon_races` (`race_id`, `race_mask`, `faction`) VALUES
(1,    1, 'ALLIANCE'), -- Human
(2,    2, 'HORDE'),    -- Orc
(3,    4, 'ALLIANCE'), -- Dwarf
(4,    8, 'ALLIANCE'), -- Night Elf
(5,   16, 'HORDE'),    -- Undead
(6,   32, 'HORDE'),    -- Tauren
(7,   64, 'ALLIANCE'), -- Gnome
(8,  128, 'HORDE'),    -- Troll
(10, 512, 'HORDE'),    -- Blood Elf
(11,1024, 'ALLIANCE'); -- Draenei

DROP TEMPORARY TABLE IF EXISTS `_gideon_classes`;
CREATE TEMPORARY TABLE `_gideon_classes` (
    `class_id` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (`class_id`)
) ENGINE=MEMORY;

INSERT INTO `_gideon_classes` (`class_id`) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(11);

DELETE FROM `gideon_arac_lineages`;
INSERT INTO `gideon_arac_lineages` (`race_id`, `class_id`, `quest_race_mask`)
SELECT `race`.`race_id`, `class`.`class_id`,
    CASE
      -- Warrior: Blood Elves inherit the Orc lineage; every other race has a
      -- native WotLK warrior lineage.
      WHEN `class`.`class_id` = 1 AND `race`.`race_id` = 10 THEN 2
      WHEN `class`.`class_id` = 1 THEN `race`.`race_mask`

      -- Paladin: Human is the Alliance fallback, Blood Elf the Horde fallback.
      WHEN `class`.`class_id` = 2 AND `race`.`race_id` IN (1,3,10,11) THEN `race`.`race_mask`
      WHEN `class`.`class_id` = 2 AND `race`.`faction` = 'ALLIANCE' THEN 1
      WHEN `class`.`class_id` = 2 THEN 512

      -- Hunter: Night Elf and Orc are the faction fallbacks.
      WHEN `class`.`class_id` = 3 AND `race`.`race_id` IN (2,3,4,6,8,10,11) THEN `race`.`race_mask`
      WHEN `class`.`class_id` = 3 AND `race`.`faction` = 'ALLIANCE' THEN 8
      WHEN `class`.`class_id` = 3 THEN 2

      -- Rogue: Human and Orc are the faction fallbacks.
      WHEN `class`.`class_id` = 4 AND `race`.`race_id` IN (1,2,3,4,5,7,8,10) THEN `race`.`race_mask`
      WHEN `class`.`class_id` = 4 AND `race`.`faction` = 'ALLIANCE' THEN 1
      WHEN `class`.`class_id` = 4 THEN 2

      -- Priest: Human and Undead are the faction fallbacks.
      WHEN `class`.`class_id` = 5 AND `race`.`race_id` IN (1,3,4,5,8,10,11) THEN `race`.`race_mask`
      WHEN `class`.`class_id` = 5 AND `race`.`faction` = 'ALLIANCE' THEN 1
      WHEN `class`.`class_id` = 5 THEN 16

      -- Death Knight has a native lineage for every playable race.
      WHEN `class`.`class_id` = 6 THEN `race`.`race_mask`

      -- Shaman: Draenei and Orc are the faction fallbacks.
      WHEN `class`.`class_id` = 7 AND `race`.`race_id` IN (2,6,8,11) THEN `race`.`race_mask`
      WHEN `class`.`class_id` = 7 AND `race`.`faction` = 'ALLIANCE' THEN 1024
      WHEN `class`.`class_id` = 7 THEN 2

      -- Mage: Human and Undead are the faction fallbacks.
      WHEN `class`.`class_id` = 8 AND `race`.`race_id` IN (1,5,7,8,10,11) THEN `race`.`race_mask`
      WHEN `class`.`class_id` = 8 AND `race`.`faction` = 'ALLIANCE' THEN 1
      WHEN `class`.`class_id` = 8 THEN 16

      -- Warlock: Human and Orc are the faction fallbacks.
      WHEN `class`.`class_id` = 9 AND `race`.`race_id` IN (1,2,5,7,10) THEN `race`.`race_mask`
      WHEN `class`.`class_id` = 9 AND `race`.`faction` = 'ALLIANCE' THEN 1
      WHEN `class`.`class_id` = 9 THEN 2

      -- Druid: Night Elf and Tauren are the faction lineages.
      WHEN `class`.`class_id` = 11 AND `race`.`faction` = 'ALLIANCE' THEN 8
      WHEN `class`.`class_id` = 11 THEN 32
    END
FROM `_gideon_races` AS `race`
CROSS JOIN `_gideon_classes` AS `class`
ORDER BY `race`.`race_id`, `class`.`class_id`;

DROP TEMPORARY TABLE IF EXISTS `_gideon_race_homes`;
CREATE TEMPORARY TABLE `_gideon_race_homes` (
    `map_id` SMALLINT UNSIGNED NOT NULL,
    `x` FLOAT NOT NULL,
    `y` FLOAT NOT NULL,
    `race_mask` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`map_id`, `race_mask`)
) ENGINE=MEMORY;

INSERT INTO `_gideon_race_homes` (`map_id`, `x`, `y`, `race_mask`) VALUES
(0,  -8949.95,  -132.493,    1),
(1,   -618.518, -4251.67,   130), -- Orc and Troll
(0,  -6240.32,    331.033,   68), -- Dwarf and Gnome
(1,  10311.3,     832.463,    8),
(0,   1676.35,   1677.45,    16),
(1,  -2917.58,   -257.980,   32),
(530, 10349.6,  -6357.29,   512),
(530, -3961.64, -13931.2,  1024);

DROP TEMPORARY TABLE IF EXISTS `_gideon_all_class_quests`;
CREATE TEMPORARY TABLE `_gideon_all_class_quests` (
    `quest` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`quest`)
) ENGINE=MEMORY;

INSERT INTO `_gideon_all_class_quests` (`quest`)
SELECT DISTINCT `quest`.`ID`
FROM `quest_template` AS `quest`
INNER JOIN `quest_template_addon` AS `addon`
    ON `addon`.`ID` = `quest`.`ID`
INNER JOIN `creature_queststarter` AS `source`
    ON `source`.`quest` = `quest`.`ID`
WHERE `quest`.`QuestSortID` IN (-61,-81,-82,-141,-161,-162,-261,-262,-263,-372)
  AND `addon`.`AllowableClasses` > 0
  AND `source`.`id` NOT IN (200000,200001);

DROP TEMPORARY TABLE IF EXISTS `_gideon_class_successors`;
CREATE TEMPORARY TABLE `_gideon_class_successors` (
    `quest` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`quest`)
) ENGINE=MEMORY;

INSERT IGNORE INTO `_gideon_class_successors` (`quest`)
SELECT `quest`.`RewardNextQuest`
FROM `_gideon_all_class_quests` AS `class_quest`
INNER JOIN `quest_template` AS `quest`
    ON `quest`.`ID` = `class_quest`.`quest`
WHERE `quest`.`RewardNextQuest` <> 0;

INSERT IGNORE INTO `_gideon_class_successors` (`quest`)
SELECT `addon`.`NextQuestID`
FROM `_gideon_all_class_quests` AS `class_quest`
INNER JOIN `quest_template_addon` AS `addon`
    ON `addon`.`ID` = `class_quest`.`quest`
WHERE `addon`.`NextQuestID` <> 0;

DROP TEMPORARY TABLE IF EXISTS `_gideon_incipits`;
CREATE TEMPORARY TABLE `_gideon_incipits` (
    `quest` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`quest`)
) ENGINE=MEMORY;

INSERT INTO `_gideon_incipits` (`quest`)
SELECT `all_quest`.`quest`
FROM `_gideon_all_class_quests` AS `all_quest`
INNER JOIN `quest_template_addon` AS `addon`
    ON `addon`.`ID` = `all_quest`.`quest`
LEFT JOIN `quest_template_addon` AS `previous`
    ON `previous`.`ID` = ABS(`addon`.`PrevQuestID`)
WHERE (`addon`.`PrevQuestID` = 0
       OR COALESCE(`previous`.`AllowableClasses`, 0) = 0)
  AND NOT EXISTS (
      SELECT 1
      FROM `_gideon_class_successors` AS `successor`
      WHERE `successor`.`quest` = `all_quest`.`quest`
  );

DROP TEMPORARY TABLE IF EXISTS `_gideon_inferred_races`;
CREATE TEMPORARY TABLE `_gideon_inferred_races` (
    `quest` INT UNSIGNED NOT NULL,
    `race_mask` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`quest`)
) ENGINE=MEMORY;

INSERT INTO `_gideon_inferred_races` (`quest`, `race_mask`)
SELECT `ranked`.`quest`, BIT_OR(`ranked`.`race_mask`)
FROM (
    SELECT `source`.`quest`, `spawn`.`guid`, `home`.`race_mask`,
           ROW_NUMBER() OVER (
               PARTITION BY `source`.`quest`, `spawn`.`guid`
               ORDER BY
                 POW(`spawn`.`position_x` - `home`.`x`, 2)
                   + POW(`spawn`.`position_y` - `home`.`y`, 2),
                 `home`.`race_mask`
           ) AS `home_rank`
    FROM `creature_queststarter` AS `source`
    INNER JOIN `creature` AS `spawn`
        ON `spawn`.`id` = `source`.`id`
    INNER JOIN `_gideon_race_homes` AS `home`
        ON `home`.`map_id` = `spawn`.`map`
       AND POW(`spawn`.`position_x` - `home`.`x`, 2)
           + POW(`spawn`.`position_y` - `home`.`y`, 2) <= 36000000
    INNER JOIN `_gideon_incipits` AS `incipit`
        ON `incipit`.`quest` = `source`.`quest`
    WHERE `source`.`id` NOT IN (200000,200001)
) AS `ranked`
WHERE `ranked`.`home_rank` = 1
GROUP BY `ranked`.`quest`;

DROP TEMPORARY TABLE IF EXISTS `_gideon_candidate_routes`;
CREATE TEMPORARY TABLE `_gideon_candidate_routes` (
    `quest` INT UNSIGNED NOT NULL,
    `native_mask` INT UNSIGNED NOT NULL,
    `class_mask` INT UNSIGNED NOT NULL,
    `route_target` INT UNSIGNED NOT NULL,
    `is_breadcrumb` TINYINT UNSIGNED NOT NULL,
    `min_level` TINYINT UNSIGNED NOT NULL,
    `title_key` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`quest`)
) ENGINE=MEMORY;

INSERT INTO `_gideon_candidate_routes`
    (`quest`, `native_mask`, `class_mask`, `route_target`, `is_breadcrumb`,
     `min_level`, `title_key`)
SELECT `incipit`.`quest`,
       COALESCE(NULLIF(`stock`.`race_mask`, 0), `inferred`.`race_mask`,
                NULLIF(`quest`.`AllowableRaces`, 0), 1791),
       `addon`.`AllowableClasses`,
       CASE
         WHEN `addon`.`BreadcrumbForQuestId` <> 0 THEN `addon`.`BreadcrumbForQuestId`
         WHEN `quest`.`RewardNextQuest` <> 0 THEN `quest`.`RewardNextQuest`
         WHEN `addon`.`NextQuestID` <> 0 THEN `addon`.`NextQuestID`
         ELSE `incipit`.`quest`
       END,
       (`addon`.`BreadcrumbForQuestId` <> 0),
       `quest`.`MinLevel`,
       LOWER(TRIM(CASE
         WHEN `quest`.`LogTitle` LIKE 'The %' THEN SUBSTRING(`quest`.`LogTitle`, 5)
         ELSE `quest`.`LogTitle`
       END))
FROM `_gideon_incipits` AS `incipit`
INNER JOIN `quest_template` AS `quest`
    ON `quest`.`ID` = `incipit`.`quest`
INNER JOIN `quest_template_addon` AS `addon`
    ON `addon`.`ID` = `incipit`.`quest`
LEFT JOIN `_gideon_inferred_races` AS `inferred`
    ON `inferred`.`quest` = `incipit`.`quest`
LEFT JOIN `gideon_stock_quest_races` AS `stock`
    ON `stock`.`quest_id` = `incipit`.`quest`;

-- Several trainers can post equivalent introductions to the same next quest.
-- Select one deterministic incipit per native race lineage and route. Prefer a
-- breadcrumb over offering its destination directly, then the most specific
-- geographical mask, then the lowest stable stock quest id.
DELETE FROM `gideon_class_quest_rules`;
INSERT INTO `gideon_class_quest_rules` (`quest_id`, `race_mask`)
SELECT `ranked`.`quest`, BIT_OR(`ranked`.`race_mask`)
FROM (
    SELECT `route_winner`.*,
           ROW_NUMBER() OVER (
               PARTITION BY `route_winner`.`race_mask`, `route_winner`.`class_mask`,
                            `route_winner`.`min_level`, `route_winner`.`title_key`
               ORDER BY `route_winner`.`is_breadcrumb` DESC,
                        BIT_COUNT(`route_winner`.`native_mask`),
                        `route_winner`.`quest`
           ) AS `title_rank`
    FROM (
      SELECT `candidate`.`quest`, `race`.`race_mask`, `candidate`.`native_mask`,
             `candidate`.`class_mask`, `candidate`.`is_breadcrumb`,
             `candidate`.`min_level`, `candidate`.`title_key`,
           ROW_NUMBER() OVER (
               PARTITION BY `race`.`race_mask`, `candidate`.`class_mask`, `candidate`.`route_target`
               ORDER BY `candidate`.`is_breadcrumb` DESC,
                        BIT_COUNT(`candidate`.`native_mask`),
                        `candidate`.`quest`
           ) AS `route_rank`
      FROM `_gideon_candidate_routes` AS `candidate`
      INNER JOIN `_gideon_races` AS `race`
          ON (`candidate`.`native_mask` & `race`.`race_mask`) <> 0
    ) AS `route_winner`
    WHERE `route_winner`.`route_rank` = 1
) AS `ranked`
WHERE `ranked`.`title_rank` = 1
GROUP BY `ranked`.`quest`;

DELETE `target`
FROM `creature_queststarter` AS `target`
INNER JOIN `quest_template` AS `quest`
    ON `quest`.`ID` = `target`.`quest`
INNER JOIN `quest_template_addon` AS `addon`
    ON `addon`.`ID` = `quest`.`ID`
WHERE `target`.`id` IN (200000,200001)
  AND `quest`.`QuestSortID` IN (-61,-81,-82,-141,-161,-162,-261,-262,-263,-372)
  AND `addon`.`AllowableClasses` > 0;

INSERT INTO `creature_queststarter` (`id`, `quest`)
SELECT `gideon`.`id`, `rule`.`quest_id`
FROM (
    SELECT 200000 AS `id`
    UNION ALL
    SELECT 200001 AS `id`
) AS `gideon`
CROSS JOIN `gideon_class_quest_rules` AS `rule`
ORDER BY `gideon`.`id`, `rule`.`quest_id`;

DROP TEMPORARY TABLE IF EXISTS `_gideon_inferred_races`;
DROP TEMPORARY TABLE IF EXISTS `_gideon_candidate_routes`;
DROP TEMPORARY TABLE IF EXISTS `_gideon_incipits`;
DROP TEMPORARY TABLE IF EXISTS `_gideon_class_successors`;
DROP TEMPORARY TABLE IF EXISTS `_gideon_all_class_quests`;
DROP TEMPORARY TABLE IF EXISTS `_gideon_race_homes`;
DROP TEMPORARY TABLE IF EXISTS `_gideon_classes`;
DROP TEMPORARY TABLE IF EXISTS `_gideon_races`;

UPDATE `version` SET `cache_id` = `cache_id` + 1;
