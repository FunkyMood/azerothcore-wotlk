-- Collapse a duplicated profession line left by an earlier Bulletin Board update.
-- The expression is idempotent and affects work orders only.
UPDATE `quest_template` AS `quest`
JOIN `bulletin_contract` AS `contract` ON `contract`.`quest` = `quest`.`ID`
SET `quest`.`QuestDescription` = REGEXP_REPLACE(
    `quest`.`QuestDescription`,
    '(\\$B\\$BRequired profession: ([[:alpha:] ]+)\\.)(\\$B\\$BRequired profession: \\2\\.)',
    '\\1'
)
WHERE `contract`.`kind` = 'WORK_ORDER';