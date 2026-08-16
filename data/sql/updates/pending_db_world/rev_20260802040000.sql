-- Kalé placement template. Profession trainer data is intentionally added in
-- a later migration after the player-selected spawns have been verified.
DROP TEMPORARY TABLE IF EXISTS `tmp_kale_template`;
CREATE TEMPORARY TABLE `tmp_kale_template` LIKE `creature_template`;

INSERT INTO `tmp_kale_template`
SELECT * FROM `creature_template` WHERE `entry` = 20242;

UPDATE `tmp_kale_template`
SET `entry` = 200002,
    `name` = CONVERT(0x4D65726368616E74204B616CC3A9 USING utf8mb4),
    `subname` = 'Master of Trades',
    `gossip_menu_id` = 0,
    `minlevel` = 20,
    `maxlevel` = 20,
    `faction` = 35,
    `npcflag` = 1,
    `AIName` = '',
    `ScriptName` = '';

REPLACE INTO `creature_template` SELECT * FROM `tmp_kale_template`;
DROP TEMPORARY TABLE `tmp_kale_template`;

DELETE FROM `creature_template_model` WHERE `CreatureID` = 200002;
INSERT INTO `creature_template_model`
    (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`)
VALUES
    (200002,0,18660,1,1,NULL);
