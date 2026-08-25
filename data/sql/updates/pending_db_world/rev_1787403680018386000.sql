-- Restore profession lines affected by the previous duplicate-line correction.
-- The profession is the parenthesized suffix in every work-order title.
UPDATE `quest_template` AS `quest`
JOIN `bulletin_contract` AS `contract` ON `contract`.`quest` = `quest`.`ID`
SET `quest`.`QuestDescription` = REPLACE(
    `quest`.`QuestDescription`,
    '1$B$B- ',
    CONCAT(
        '$B$BRequired profession: ',
        SUBSTRING_INDEX(SUBSTRING_INDEX(`quest`.`LogTitle`, ' (', -1), ')', 1),
        '.$B$B- '
    )
)
WHERE `contract`.`kind` = 'WORK_ORDER'
  AND `quest`.`QuestDescription` LIKE '%1$B$B- %';