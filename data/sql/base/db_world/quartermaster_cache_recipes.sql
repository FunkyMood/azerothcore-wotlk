
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
DROP TABLE IF EXISTS `quartermaster_cache_recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quartermaster_cache_recipes` (
  `recipe_id` mediumint unsigned NOT NULL,
  `board_id` mediumint unsigned NOT NULL,
  `cache_type_id` mediumint unsigned NOT NULL,
  `cost_category` tinyint unsigned NOT NULL COMMENT '1 vouchers, 2 trophies',
  `name` varchar(100) NOT NULL,
  `output_count` tinyint unsigned NOT NULL DEFAULT '1',
  `daily_limit` tinyint unsigned NOT NULL DEFAULT '0',
  `sort_order` smallint unsigned NOT NULL DEFAULT '0',
  `rotation_order` smallint unsigned NOT NULL DEFAULT '0',
  `rotation_slots` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`recipe_id`),
  KEY `idx_quartermaster_cache_recipes_board_category` (`board_id`,`cost_category`,`sort_order`),
  KEY `fk_quartermaster_cache_recipes_type` (`cache_type_id`),
  CONSTRAINT `fk_quartermaster_cache_recipes_board` FOREIGN KEY (`board_id`) REFERENCES `bulletin_boards` (`board_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_quartermaster_cache_recipes_type` FOREIGN KEY (`cache_type_id`) REFERENCES `quartermaster_cache_types` (`cache_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `quartermaster_cache_recipes` DISABLE KEYS */;
INSERT INTO `quartermaster_cache_recipes` VALUES (101,1,101,1,'Recruit Weapon Cache',1,0,10,0,0),(102,1,102,1,'Recruit Armor Cache',1,0,20,0,0),(103,1,103,2,'Fangwarden\'s Cache',1,3,30,1,2),(104,1,103,2,'Candlebreaker\'s Cache',1,3,40,2,2),(105,1,103,2,'Abbey Hunter\'s Cache',1,3,50,3,2),(201,2,201,1,'Recruit Weapon Cache',1,0,10,0,0),(202,2,202,1,'Recruit Armor Cache',1,0,20,0,0),(203,2,203,2,'Wolfhunter\'s Cache',1,3,30,1,3),(204,2,203,2,'Fangwarden\'s Cache',1,3,40,2,3),(205,2,203,2,'Frontier Cloth Cache',1,3,50,3,3),(206,2,203,2,'Spiderbane Cache',1,3,60,4,3),(207,2,203,2,'Weaver\'s Cache',1,3,70,5,3),(208,2,203,2,'Tuskbreaker\'s Cache',1,3,80,6,3),(501,5,501,1,'Recruit Weapon Cache',1,0,10,0,0),(502,5,502,1,'Recruit Armor Cache',1,0,20,0,0),(503,5,503,2,'Pincerbreaker\'s Cache',1,3,30,1,3),(504,5,503,2,'Fanghunter\'s Cache',1,3,40,2,3),(505,5,503,2,'Valley Watcher\'s Cache',1,3,50,3,3),(506,5,503,2,'Clawbreaker\'s Cache',1,3,60,4,3);
/*!40000 ALTER TABLE `quartermaster_cache_recipes` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

