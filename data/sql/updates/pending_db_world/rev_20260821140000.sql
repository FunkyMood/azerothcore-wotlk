-- Dungeon and heroic creatures should not repopulate during a normal run.
-- The map ids come from Map.dbc entries with map_type MAP_INSTANCE (1): raids
-- (MAP_RAID), battlegrounds, arenas, and open-world creatures are excluded.
UPDATE `creature`
SET `spawntimesecs` = GREATEST(`spawntimesecs`, 21600)
WHERE `map` IN (33, 34, 36, 43, 44, 47, 48, 70, 90, 109, 129, 189, 209, 229,
                230, 269, 289, 329, 349, 389, 429, 540, 542, 543, 545, 546,
                547, 552, 553, 554, 555, 556, 557, 558, 560, 574, 575, 576,
                578, 585, 595, 598, 599, 600, 601, 602, 604, 608, 619, 632,
                650, 658, 668);