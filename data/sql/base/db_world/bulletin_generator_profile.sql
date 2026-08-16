
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `bulletin_generator_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_generator_profile` (
  `scope` enum('ALL','PROFILE','BOARD') NOT NULL DEFAULT 'ALL',
  `scope_id` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'the Board or the profile this applies to; ignored when scope is ALL',
  `name` varchar(48) NOT NULL,
  `value` int NOT NULL,
  `description` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`scope`,`scope_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_generator_profile` DISABLE KEYS */;
INSERT INTO `bulletin_generator_profile` VALUES ('ALL',0,'accept_grace_levels',1,'levels past the top a Board still accepts from'),('ALL',0,'cache_trophy_seconds',60,'killing a trophy recipe should be worth'),('ALL',0,'gathering_count',8,'how many of a stacking material to ask for'),('ALL',0,'max_contract_seconds',900,'longest a contract should take'),('ALL',0,'max_contracts',12,'most contracts a Board may carry'),('ALL',0,'max_drop_material_count',10,'largest time-derived material recovery request unless a Board overrides it'),('ALL',0,'max_kill_count',15,'largest ordinary Hunting objective on a LOCAL World Board'),('ALL',0,'max_recovery_kills',15,'largest expected kill count behind a Recovery objective'),('ALL',0,'max_target_level_ahead',3,'world Boards may inspect nearby enemies slightly above their nominal band'),('ALL',0,'min_cache_trophy_chance',20,'how often a trophy must drop to be worth a cache recipe'),('ALL',0,'min_contract_seconds',300,'shortest a contract should take'),('ALL',0,'min_contracts',6,'fewest contracts a Board may carry'),('ALL',0,'min_GATHERING',1,'contracts asking for something picked'),('ALL',0,'min_KILL_BOSS',1,'a named field boss worth hunting'),('ALL',0,'min_trophy_chance',40,'how often a trophy must drop to be worth asking for'),('ALL',0,'min_WORK_ORDER',2,'contracts asking for something made'),('ALL',0,'pool_equipment_count',24,'how many pieces of equipment a pool holds'),('ALL',0,'pool_material_count',12,'how many kinds of material a trophy pool holds'),('ALL',0,'quality_weight_2',100,'uncommon: what a world Board hands out'),('ALL',0,'random_fill',1,'fill the remaining slots from what the camps allow'),('ALL',0,'starting_gideon_introduction',0,'non-STARTING Boards do not add the Sir Gideon introduction'),('ALL',0,'starting_gideon_money_copper',50,'small fixed copper payment for the Sir Gideon introduction'),('ALL',0,'trophy_recipes',3,'how many ordinary trophy caches a Board offers'),('ALL',0,'trophy_rotation_candidates',6,''),('ALL',0,'weight_DROP_MATERIAL',100,'the same work as a hunt, with a chance attached'),('ALL',0,'weight_GATHERING',60,'picking is worth less than the fighting it is averaged against'),('ALL',0,'weight_KILL_BOSS',200,'a named enemy is worth double, as an elite is'),('ALL',0,'weight_KILLING',100,'the baseline everything else is measured against'),('ALL',0,'weight_WORK_ORDER',70,'the same, allowing for the cost of the materials'),('ALL',0,'work_order_count',3,'how many of a crafted item to ask for'),('PROFILE',1,'accept_grace_levels',2,'a starting area gives one more, having nowhere else to send anyone'),('PROFILE',1,'max_contract_seconds',300,'longest a starting-area contract should take'),('PROFILE',1,'max_contracts',10,'most contracts a starting Board may carry'),('PROFILE',1,'max_drop_material_count',6,'starting-area recovery requests stay short and readable'),('PROFILE',1,'max_kill_count',10,'largest ordinary Hunting objective on a LOCAL Starting Board'),('PROFILE',1,'max_recovery_kills',10,'largest expected kill count behind a Starting Recovery objective'),('PROFILE',1,'max_target_level_ahead',0,'starting Boards never send a new character beyond their own maximum level'),('PROFILE',1,'min_contract_seconds',120,'shortest a starting-area contract should take'),('PROFILE',1,'min_contracts',8,'fewest contracts a starting Board may carry'),('PROFILE',1,'min_GATHERING',0,'starting Boards do not generate Gathering contracts'),('PROFILE',1,'min_WORK_ORDER',0,'starting Boards do not generate Work Orders'),('PROFILE',1,'quality_weight_0',70,'poor: most of what a starting area hands out'),('PROFILE',1,'quality_weight_2',30,'uncommon: the rest of it'),('PROFILE',1,'starting_gideon_introduction',1,'every LOCAL STARTING Board adds the level-two Sir Gideon introduction'),('PROFILE',2,'max_contracts',14,'WORLD menus paginate, allowing broad zones more coverage without crowding one page'),('PROFILE',2,'min_contracts',10,'one WORLD hub needs enough notices to cover distinct sectors and distant camps'),('PROFILE',2,'trophy_quality_weight_0',50,'WORLD Trophy Cache equipment: poor (grey) half of the quality roll'),('PROFILE',2,'trophy_quality_weight_2',50,'WORLD Trophy Cache equipment: uncommon (green) half of the quality roll');
/*!40000 ALTER TABLE `bulletin_generator_profile` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

