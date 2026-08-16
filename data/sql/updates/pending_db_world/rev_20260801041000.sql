-- Capital Gideon (200001): universal class-spell trainer.
INSERT INTO `trainer` (`Id`, `Type`, `Requirement`, `Greeting`, `VerifiedBuild`)
SELECT 200001, `Type`, `Requirement`, `Greeting`, `VerifiedBuild`
FROM `trainer`
WHERE `Id` = 200000
ON DUPLICATE KEY UPDATE
    `Type` = VALUES(`Type`),
    `Requirement` = VALUES(`Requirement`),
    `Greeting` = VALUES(`Greeting`),
    `VerifiedBuild` = VALUES(`VerifiedBuild`);

UPDATE `creature_template` SET `npcflag` = 17 WHERE `entry` = 200001;

INSERT INTO `creature_default_trainer` (`CreatureId`, `TrainerId`)
VALUES (200001, 200001)
ON DUPLICATE KEY UPDATE `TrainerId` = VALUES(`TrainerId`);

DELETE FROM `trainer_spell` WHERE `TrainerId` = 200001;
INSERT INTO `trainer_spell`
    (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`,
     `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`)
SELECT
    200001, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`,
    `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`
FROM
(
    SELECT ts.*,
        ROW_NUMBER() OVER
            (PARTITION BY ts.`SpellId` ORDER BY ts.`ReqLevel`, ts.`MoneyCost`, ts.`TrainerId`) AS `rn`
    FROM `trainer_spell` ts
    INNER JOIN `trainer` t ON t.`Id` = ts.`TrainerId`
    WHERE t.`Type` = 0
      AND t.`Requirement` IN (1,2,3,4,5,6,7,8,9,11)
) AS `class_spells`
WHERE `rn` = 1;
