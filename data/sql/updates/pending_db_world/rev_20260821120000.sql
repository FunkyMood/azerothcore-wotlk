-- Give the starting-zone Gideon his own greeting while retaining the standard quest and trainer options.
-- The menu options are copied from MenuID 0 unchanged.

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 200010;
DELETE FROM `gossip_menu` WHERE `MenuID` = 200010;
DELETE FROM `npc_text` WHERE `ID` = 200010;

INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES
(200010, 'Greetings, $N.$B$BI can train you in the ways of your class. If a class quest is available to you, you will find it in my list of quests.');

INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(200010, 200010);

INSERT INTO `gossip_menu_option`
    (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT 200010, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`
FROM `gossip_menu_option`
WHERE `MenuID` = 0 AND `OptionID` IN (0, 3);

UPDATE `creature_template` SET `gossip_menu_id` = 200010 WHERE `entry` = 200000;
