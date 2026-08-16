-- Sir Gideon offers the stock class-quest catalogue through the native quest
-- system.  Only quests already started by a real creature are copied: this
-- excludes internal, item-started, and otherwise inactive quest templates.
UPDATE `creature_template`
SET `npcflag` = `npcflag` | 2
WHERE `entry` IN (200000, 200001);

DROP TEMPORARY TABLE IF EXISTS `_gideon_class_quests`;
CREATE TEMPORARY TABLE `_gideon_class_quests` (
    `quest` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`quest`)
) ENGINE=MEMORY;

DELETE FROM `_gideon_class_quests`;
INSERT INTO `_gideon_class_quests` (`quest`)
SELECT DISTINCT `quest`.`ID`
FROM `quest_template` AS `quest`
INNER JOIN `quest_template_addon` AS `addon`
    ON `addon`.`ID` = `quest`.`ID`
INNER JOIN `creature_queststarter` AS `source`
    ON `source`.`quest` = `quest`.`ID`
WHERE `quest`.`QuestSortID` IN (-61, -81, -82, -141, -161, -162, -261, -262, -263, -372)
  AND `addon`.`AllowableClasses` > 0
  AND `source`.`id` NOT IN (200000, 200001);

DELETE `target`
FROM `creature_queststarter` AS `target`
INNER JOIN `quest_template` AS `quest`
    ON `quest`.`ID` = `target`.`quest`
INNER JOIN `quest_template_addon` AS `addon`
    ON `addon`.`ID` = `quest`.`ID`
WHERE `target`.`id` IN (200000, 200001)
  AND `quest`.`QuestSortID` IN (-61, -81, -82, -141, -161, -162, -261, -262, -263, -372)
  AND `addon`.`AllowableClasses` > 0;

INSERT INTO `creature_queststarter` (`id`, `quest`)
SELECT `gideon`.`id`, `class_quest`.`quest`
FROM (
    SELECT 200000 AS `id`
    UNION ALL
    SELECT 200001 AS `id`
) AS `gideon`
CROSS JOIN `_gideon_class_quests` AS `class_quest`
ORDER BY `gideon`.`id`, `class_quest`.`quest`;

DROP TEMPORARY TABLE IF EXISTS `_gideon_class_quests`;
