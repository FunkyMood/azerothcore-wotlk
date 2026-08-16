-- All ARAC shamans begin with a small bag and the four elemental totems.
DELETE FROM `playercreateinfo_item`
WHERE `race` = 0
  AND `class` = 7
  AND `itemid` IN (4496,5175,5176,5177,5178);

INSERT INTO `playercreateinfo_item` (`race`, `class`, `itemid`, `amount`, `Note`) VALUES
(0,7,4496,1,'ARAC shaman starter totem bag'),
(0,7,5175,1,'Earth Totem'),
(0,7,5176,1,'Fire Totem'),
(0,7,5177,1,'Water Totem'),
(0,7,5178,1,'Air Totem');
