-- Merchant Kale must be able to teach Mining to a character who does not
-- already know it.  The stock Mining trainer row is the sole first-rank
-- profession lesson carrying its own skill line as a rank-zero requirement;
-- Kale's multi-profession visibility filter would otherwise hide that lesson.
UPDATE `trainer_spell`
SET `ReqSkillLine` = 0
WHERE `TrainerId` = 200002
  AND `SpellId` = 2581
  AND `ReqSkillLine` = 186
  AND `ReqSkillRank` = 0;
