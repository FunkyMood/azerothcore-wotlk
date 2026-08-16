
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
DROP TABLE IF EXISTS `quartermaster_cache_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quartermaster_cache_types` (
  `cache_type_id` mediumint unsigned NOT NULL,
  `tier_id` tinyint unsigned NOT NULL,
  `profile_id` smallint unsigned DEFAULT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `item_id` mediumint unsigned NOT NULL,
  `reward_pool_id` mediumint unsigned NOT NULL,
  `loot_token_item_id` mediumint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cache_type_id`),
  UNIQUE KEY `uq_quartermaster_cache_types_item` (`item_id`),
  KEY `fk_quartermaster_cache_types_tier` (`tier_id`),
  KEY `fk_quartermaster_cache_types_pool` (`reward_pool_id`),
  KEY `fk_quartermaster_cache_types_profile` (`profile_id`),
  CONSTRAINT `fk_quartermaster_cache_types_pool` FOREIGN KEY (`reward_pool_id`) REFERENCES `quartermaster_reward_pools` (`pool_id`),
  CONSTRAINT `fk_quartermaster_cache_types_profile` FOREIGN KEY (`profile_id`) REFERENCES `bulletin_board_profiles` (`profile_id`),
  CONSTRAINT `fk_quartermaster_cache_types_tier` FOREIGN KEY (`tier_id`) REFERENCES `bulletin_voucher_tiers` (`tier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `quartermaster_cache_types` DISABLE KEYS */;
INSERT INTO `quartermaster_cache_types` VALUES (101,1,1,'WEAPON','Recruit Weapon Cache',13247,101,823),(102,1,1,'ARMOR','Recruit Armor Cache',23271,102,842),(103,1,1,'TROPHY','Recruit Trophy Cache',32547,103,903),(201,1,2,'WEAPON','Recruit Weapon Cache',32543,201,875),(202,1,2,'ARMOR','Recruit Armor Cache',8502,202,1042),(203,1,2,'TROPHY','Recruit Trophy Cache',8503,203,1043),(501,1,1,'WEAPON','Recruit Weapon Cache',813,501,1222),(502,1,1,'ARMOR','Recruit Armor Cache',894,502,1255),(503,1,1,'TROPHY','Recruit Trophy Cache',1016,503,1500);
/*!40000 ALTER TABLE `quartermaster_cache_types` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

