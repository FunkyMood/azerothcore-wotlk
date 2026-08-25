-- Reverts "Capital Cities" travel and the Shattrath/Dalaran hops this file
-- originally added to the Argent Wayfinder's gossip menu: paying money at an
-- NPC to jump straight to a capital read as breaking immersion. The dungeon
-- travel menus this NPC already carried (rev_1787238348192837900.sql) are
-- untouched - only options 6 through 9 on the main menu (800020) and the two
-- submenus (800025, 800125) they opened are removed.

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 800020 AND `OptionID` IN (6,7,8,9);

DELETE FROM `gossip_menu` WHERE `MenuID` IN (800025,800125);
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (800025,800125);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` IN (800025,800125);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 800020 AND `SourceEntry` IN (6,7,8,9);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 800020 AND `source_type` = 0 AND `id` BETWEEN 86 AND 103;
