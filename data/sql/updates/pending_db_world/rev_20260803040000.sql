-- Merchant Kale: teach every standard trainer-learned profession spell through
-- Grand Master (450), while preserving native prices and prerequisites.
-- The canonical source trainers cover the eleven primary and three secondary
-- professions. Recipes learned through drops, vendors, quests, reputation or
-- profession specializations are intentionally not part of these trainer lists.

DELETE FROM `trainer_spell` WHERE `TrainerId` = 200002;

INSERT INTO `trainer_spell`
    (`TrainerId`,`SpellId`,`MoneyCost`,`ReqSkillLine`,`ReqSkillRank`,
     `ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`ReqLevel`,`VerifiedBuild`)
SELECT
    200002,ts.`SpellId`,ts.`MoneyCost`,ts.`ReqSkillLine`,ts.`ReqSkillRank`,
    ts.`ReqAbility1`,ts.`ReqAbility2`,ts.`ReqAbility3`,ts.`ReqLevel`,ts.`VerifiedBuild`
FROM `trainer_spell` ts
WHERE ts.`TrainerId` IN (60,61,67,69,74,77,80,83,92,96,98,100,111,119);
