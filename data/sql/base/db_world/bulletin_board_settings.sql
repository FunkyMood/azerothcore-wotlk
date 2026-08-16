
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
DROP TABLE IF EXISTS `bulletin_board_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_board_settings` (
  `board_id` mediumint unsigned NOT NULL,
  `zone_min_level` tinyint unsigned NOT NULL,
  `zone_max_level` tinyint unsigned NOT NULL,
  `accept_grace_level` tinyint unsigned NOT NULL,
  `max_active_contracts` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '0 means unlimited',
  `completion_bonus_rate` decimal(5,2) NOT NULL DEFAULT '25.00',
  `completion_organization` varchar(64) NOT NULL DEFAULT 'Argent Dawn',
  PRIMARY KEY (`board_id`),
  CONSTRAINT `fk_bulletin_board_settings_board` FOREIGN KEY (`board_id`) REFERENCES `bulletin_boards` (`board_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_board_settings` DISABLE KEYS */;
INSERT INTO `bulletin_board_settings` VALUES (1,1,5,7,0,25.00,'Argent Dawn'),(2,5,10,11,0,25.00,'Argent Dawn'),(5,1,5,7,0,25.00,'Argent Dawn');
/*!40000 ALTER TABLE `bulletin_board_settings` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

