
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
DROP TABLE IF EXISTS `bulletin_board_quest_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_board_quest_rules` (
  `board_id` mediumint unsigned NOT NULL,
  `quest_id` mediumint unsigned NOT NULL,
  `category_id` tinyint unsigned NOT NULL,
  `contract_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0 zone contract, 1 daily bounty, 2 repeatable',
  `recommended_level` tinyint unsigned NOT NULL,
  `required_skill_id` smallint unsigned NOT NULL DEFAULT '0',
  `required_skill_value` smallint unsigned NOT NULL DEFAULT '0',
  `required_skill_name` varchar(64) NOT NULL DEFAULT '',
  `always_visible` tinyint unsigned NOT NULL DEFAULT '1',
  `xp_weight` decimal(6,3) NOT NULL DEFAULT '1.000',
  `gold_weight` decimal(6,3) NOT NULL DEFAULT '1.000',
  `voucher_amount` tinyint unsigned NOT NULL DEFAULT '1',
  `camp_id` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'where the work happens; 0 for contracts that happen nowhere in particular',
  `turnin_creature_entry` mediumint unsigned NOT NULL DEFAULT '0' COMMENT 'who receives the finished work; 0 means the Board itself',
  PRIMARY KEY (`board_id`,`quest_id`),
  KEY `idx_bulletin_board_quest_rules_category` (`category_id`),
  CONSTRAINT `fk_bulletin_board_quest_rules_board` FOREIGN KEY (`board_id`) REFERENCES `bulletin_boards` (`board_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bulletin_board_quest_rules_category` FOREIGN KEY (`category_id`) REFERENCES `bulletin_quest_categories` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_board_quest_rules` DISABLE KEYS */;
INSERT INTO `bulletin_board_quest_rules` VALUES (1,90101,3,0,5,0,0,'',1,2.000,2.000,1,102,823),(1,90102,2,0,2,0,0,'',1,1.000,1.000,1,101,11940),(1,90103,1,0,1,0,0,'',1,1.000,1.000,1,101,197),(1,90104,1,0,1,0,0,'',1,1.000,1.000,1,101,823),(1,90105,1,0,3,0,0,'',1,1.000,1.000,1,101,11940),(1,90106,1,0,2,0,0,'',1,1.000,1.000,1,101,197),(1,90107,1,0,3,0,0,'',1,1.000,1.000,1,101,823),(1,90108,6,0,2,0,0,'',1,1.000,1.000,0,0,200000),(2,90201,3,0,8,0,0,'',1,2.000,2.000,1,201,240),(2,90202,4,0,7,0,0,'',1,0.600,0.600,1,0,240),(2,90203,5,0,7,0,0,'',1,0.700,0.700,1,0,241),(2,90204,5,0,7,0,0,'',1,0.700,0.700,1,0,6121),(2,90205,1,0,5,0,0,'',1,1.000,1.000,1,202,241),(2,90206,1,0,9,0,0,'',1,1.000,1.000,1,203,6121),(2,90207,1,0,8,0,0,'',1,1.000,1.000,1,204,240),(2,90208,2,0,7,0,0,'',1,1.000,1.000,1,205,241),(2,90209,1,0,5,0,0,'',1,1.000,1.000,1,206,6121),(2,90210,1,0,8,0,0,'',1,1.000,1.000,1,207,240),(5,90501,3,0,5,0,0,'',1,2.000,2.000,1,504,3158),(5,90502,2,0,4,0,0,'',1,1.000,1.000,1,501,9796),(5,90503,1,0,1,0,0,'',1,1.000,1.000,1,502,3882),(5,90504,2,0,1,0,0,'',1,1.000,1.000,1,501,3158),(5,90505,1,0,3,0,0,'',1,1.000,1.000,1,501,9796),(5,90506,2,0,1,0,0,'',1,1.000,1.000,1,501,3882),(5,90507,1,0,3,0,0,'',1,1.000,1.000,1,503,3158),(5,90508,6,0,2,0,0,'',1,1.000,1.000,0,0,200000);
/*!40000 ALTER TABLE `bulletin_board_quest_rules` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

