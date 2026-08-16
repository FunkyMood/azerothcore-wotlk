-- Sir Gideon Ofnir, the All-Knowing: universal class trainer NPC
-- Teaches all levels 1-10 spells for Warrior, Paladin, Hunter, Rogue, Priest, Shaman, Mage, Warlock, Druid.
-- Death Knight intentionally excluded (DK trainer spells all start at ReqLevel 55, DK has no 1-10 leveling path).
-- Entry/TrainerId 200000. Spawned once in every Alliance/Horde starting zone (same entry, multiple `creature` rows).
-- Trainer.Requirement = 0 bypasses the class check in Trainer::IsTrainerValidForPlayer, so every class can open
-- the trainer window; the spell list is still filtered per-player by Player::IsSpellFitByClassAndRace.

-- creature_template
DELETE FROM `creature_template` WHERE `entry` = 200000;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`,
    `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`,
    `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`,
    `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`,
    `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`,
    `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`,
    `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`,
    `flags_extra`, `ScriptName`) VALUES
(200000, 0, 0, 0, 0, 0,
    'Sir Gideon Ofnir', 'the All-Knowing', '', 0, 1, 1, 0, 35, 17,
    1, 1.14286, 1, 1, 20, 0, 0, 1,
    2000, 2000, 1, 1, 8, 0, 2048,
    0, 0, 7, 0, 0, 0, 0, 0,
    0, 0, 0, '', 0, 1, 1, 1,
    1, 1, 0, 0, 1, 0,
    0, '');

-- creature_template_model (Loremaster Zollinger's model - robed elder human, fits "All-Knowing" theme)
DELETE FROM `creature_template_model` WHERE `CreatureID` = 200000;
INSERT INTO `creature_template_model` (`CreatureID`, `CreatureDisplayID`, `DisplayScale`, `Probability`) VALUES
(200000, 26399, 1, 1);

-- trainer definition. Type = 0 (Class), Requirement = 0 (no class restriction, see note above).
DELETE FROM `trainer` WHERE `Id` = 200000;
INSERT INTO `trainer` (`Id`, `Type`, `Requirement`, `Greeting`, `VerifiedBuild`) VALUES
(200000, 0, 0, 'Ahh, I knew you\'d come.', 0);

-- link the creature to the trainer
DELETE FROM `creature_default_trainer` WHERE `CreatureId` = 200000;
INSERT INTO `creature_default_trainer` (`CreatureId`, `TrainerId`) VALUES
(200000, 200000);

-- trainer_spell: all levels 1-10 class spells, deduped across classes (some spell IDs, e.g. weapon-skill
-- grants, are legitimately shared by more than one class trainer - they need only one row here).
DELETE FROM `trainer_spell` WHERE `TrainerId` = 200000;
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`) VALUES
(200000, 17, 100, 0, 0, 0, 0, 0, 6),
(200000, 53, 100, 0, 0, 0, 0, 0, 4),
(200000, 99, 300, 0, 0, 0, 0, 0, 10),
(200000, 100, 100, 0, 0, 0, 0, 0, 4),
(200000, 116, 100, 0, 0, 0, 0, 0, 4),
(200000, 118, 200, 0, 0, 0, 0, 0, 8),
(200000, 122, 400, 0, 0, 0, 0, 0, 10),
(200000, 139, 200, 0, 0, 0, 0, 0, 8),
(200000, 143, 100, 0, 0, 133, 0, 0, 6),
(200000, 172, 100, 0, 0, 0, 0, 0, 4),
(200000, 205, 200, 0, 0, 116, 0, 0, 8),
(200000, 284, 200, 0, 0, 78, 0, 0, 8),
(200000, 324, 100, 0, 0, 0, 0, 0, 8),
(200000, 332, 100, 0, 0, 331, 0, 0, 6),
(200000, 339, 200, 0, 0, 0, 0, 0, 8),
(200000, 348, 10, 0, 0, 0, 0, 0, 3),
(200000, 465, 10, 0, 0, 0, 0, 0, 1),
(200000, 467, 100, 0, 0, 0, 0, 0, 6),
(200000, 498, 100, 0, 0, 0, 0, 0, 6),
(200000, 529, 100, 0, 0, 403, 0, 0, 8),
(200000, 586, 200, 0, 0, 0, 0, 0, 8),
(200000, 587, 100, 0, 0, 0, 0, 0, 6),
(200000, 589, 100, 0, 0, 0, 0, 0, 4),
(200000, 591, 100, 0, 0, 585, 0, 0, 6),
(200000, 594, 300, 0, 0, 589, 0, 0, 10),
(200000, 633, 300, 0, 0, 0, 0, 0, 10),
(200000, 639, 100, 0, 0, 635, 0, 0, 6),
(200000, 674, 300, 0, 0, 0, 0, 0, 10),
(200000, 688, 100, 0, 0, 0, 0, 0, 1),
(200000, 695, 100, 0, 0, 686, 0, 0, 6),
(200000, 696, 300, 0, 0, 687, 0, 0, 10),
(200000, 702, 100, 0, 0, 0, 0, 0, 4),
(200000, 707, 300, 0, 0, 348, 0, 0, 10),
(200000, 772, 100, 0, 0, 0, 0, 0, 4),
(200000, 774, 100, 0, 0, 0, 0, 0, 4),
(200000, 853, 100, 0, 0, 0, 0, 0, 8),
(200000, 921, 100, 0, 0, 0, 0, 0, 4),
(200000, 980, 200, 0, 0, 0, 0, 0, 8),
(200000, 1022, 300, 0, 0, 0, 0, 0, 10),
(200000, 1058, 300, 0, 0, 774, 0, 0, 10),
(200000, 1120, 300, 0, 0, 0, 0, 0, 10),
(200000, 1126, 10, 0, 0, 0, 0, 0, 1),
(200000, 1130, 100, 0, 0, 0, 0, 0, 6),
(200000, 1152, 100, 0, 0, 0, 0, 0, 8),
(200000, 1243, 10, 0, 0, 0, 0, 0, 1),
(200000, 1454, 100, 0, 0, 0, 0, 0, 6),
(200000, 1459, 10, 0, 0, 0, 0, 0, 1),
(200000, 1494, 10, 0, 0, 0, 0, 0, 2),
(200000, 1715, 200, 0, 0, 0, 0, 0, 8),
(200000, 1757, 100, 0, 0, 1752, 0, 0, 6),
(200000, 1776, 100, 0, 0, 0, 0, 0, 6),
(200000, 1784, 10, 0, 0, 0, 0, 0, 1),
(200000, 1978, 100, 0, 0, 0, 0, 0, 4),
(200000, 2006, 300, 0, 0, 0, 0, 0, 10),
(200000, 2052, 100, 0, 0, 2050, 0, 0, 4),
(200000, 2053, 300, 0, 0, 2052, 0, 0, 10),
(200000, 2136, 100, 0, 0, 0, 0, 0, 6),
(200000, 2484, 100, 0, 0, 0, 0, 0, 6),
(200000, 2687, 600, 0, 0, 0, 0, 0, 10),
(200000, 2983, 300, 0, 0, 0, 0, 0, 10),
(200000, 3044, 100, 0, 0, 0, 0, 0, 6),
(200000, 3127, 100, 0, 0, 0, 0, 0, 6),
(200000, 5116, 200, 0, 0, 0, 0, 0, 8),
(200000, 5143, 200, 0, 0, 0, 0, 0, 8),
(200000, 5171, 300, 0, 0, 0, 0, 0, 10),
(200000, 5177, 100, 0, 0, 5176, 0, 0, 6),
(200000, 5186, 200, 0, 0, 5185, 0, 0, 8),
(200000, 5232, 300, 0, 0, 1126, 0, 0, 10),
(200000, 5277, 200, 0, 0, 0, 0, 0, 8),
(200000, 5504, 100, 0, 0, 0, 0, 0, 4),
(200000, 5505, 400, 0, 0, 5504, 0, 0, 10),
(200000, 5730, 100, 0, 0, 0, 0, 0, 8),
(200000, 5782, 200, 0, 0, 0, 0, 0, 8),
(200000, 6201, 300, 0, 0, 0, 0, 0, 10),
(200000, 6343, 100, 0, 0, 0, 0, 0, 6),
(200000, 6546, 600, 0, 0, 772, 0, 0, 10),
(200000, 6673, 10, 0, 0, 0, 0, 0, 1),
(200000, 6760, 200, 0, 0, 2098, 0, 0, 8),
(200000, 6770, 300, 0, 0, 0, 0, 0, 10),
(200000, 7300, 400, 0, 0, 168, 0, 0, 10),
(200000, 8017, 10, 0, 0, 0, 0, 0, 1),
(200000, 8018, 100, 0, 0, 8017, 0, 0, 8),
(200000, 8024, 400, 0, 0, 0, 0, 0, 10),
(200000, 8042, 100, 0, 0, 0, 0, 0, 4),
(200000, 8044, 100, 0, 0, 8042, 0, 0, 8),
(200000, 8050, 400, 0, 0, 0, 0, 0, 10),
(200000, 8075, 400, 0, 0, 0, 0, 0, 10),
(200000, 8092, 300, 0, 0, 0, 0, 0, 10),
(200000, 8921, 100, 0, 0, 0, 0, 0, 4),
(200000, 8924, 300, 0, 0, 8921, 0, 0, 10),
(200000, 10290, 300, 0, 0, 465, 0, 0, 10),
(200000, 10321, 100, 0, 0, 0, 0, 0, 4),
(200000, 13163, 100, 0, 0, 0, 0, 0, 4),
(200000, 13165, 400, 0, 0, 0, 0, 0, 10),
(200000, 13549, 400, 0, 0, 1978, 0, 0, 10),
(200000, 14260, 200, 0, 0, 2973, 0, 0, 8),
(200000, 16689, 300, 0, 0, 339, 0, 0, 10),
(200000, 19740, 100, 0, 0, 0, 0, 0, 4),
(200000, 19883, 400, 0, 0, 0, 0, 0, 10),
(200000, 34428, 100, 0, 0, 0, 0, 0, 6);

-- creature spawns: intentionally NOT managed here. Placed by hand in game with `.npc add 200000` at each
-- starting zone (see `.npc delete` workflow) since guessed coordinates risked underground/wall placement.
-- Do not add a DELETE+INSERT block here or re-running this file will wipe out the hand-placed spawns.
