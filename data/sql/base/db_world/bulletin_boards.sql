
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
DROP TABLE IF EXISTS `bulletin_boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_boards` (
  `board_id` mediumint unsigned NOT NULL,
  `gameobject_entry` mediumint unsigned NOT NULL,
  `gameobject_guid` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `zone_id` smallint unsigned NOT NULL DEFAULT '0',
  `kind_id` tinyint unsigned NOT NULL DEFAULT '1',
  `profile_id` smallint unsigned NOT NULL DEFAULT '2',
  `min_level` tinyint unsigned NOT NULL DEFAULT '1',
  `max_level` tinyint unsigned NOT NULL DEFAULT '0',
  `voucher_item` mediumint unsigned NOT NULL,
  `quartermaster_entry` mediumint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`board_id`),
  UNIQUE KEY `uq_bulletin_boards_gameobject_guid` (`gameobject_guid`),
  KEY `fk_bulletin_boards_profile` (`profile_id`),
  KEY `idx_zone` (`zone_id`),
  KEY `idx_bulletin_boards_kind` (`kind_id`),
  CONSTRAINT `fk_bulletin_boards_kind` FOREIGN KEY (`kind_id`) REFERENCES `bulletin_board_kinds` (`kind_id`),
  CONSTRAINT `fk_bulletin_boards_profile` FOREIGN KEY (`profile_id`) REFERENCES `bulletin_board_profiles` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_boards` DISABLE KEYS */;
INSERT INTO `bulletin_boards` VALUES (1,90001,5714464,'Northshire Valley Bulletin Board',12,1,1,1,5,37742,90010),(2,90002,5714489,'Goldshire Bulletin Board',12,1,2,5,10,37742,90010),(5,92501,5900501,'Valley of Trials Bulletin Board',14,1,1,1,5,37742,90010);
/*!40000 ALTER TABLE `bulletin_boards` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

