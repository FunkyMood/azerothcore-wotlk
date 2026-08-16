
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
DROP TABLE IF EXISTS `bulletin_quest_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_quest_categories` (
  `category_id` tinyint unsigned NOT NULL,
  `code` varchar(32) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL,
  `ignore_level_limits` tinyint unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_bulletin_quest_categories_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_quest_categories` DISABLE KEYS */;
INSERT INTO `bulletin_quest_categories` VALUES (1,'KILLING','Hunting','Defeat ordinary threats in the local area.',0,1),(2,'DROP_MATERIAL','Recovery','Recover useful or identifying materials from enemies.',0,1),(3,'KILL_BOSS','Bounty','Defeat a named field boss, rare or elite.',0,1),(4,'GATHERING','Gathering','Gather materials through herbalism, mining or skinning.',1,1),(5,'WORK_ORDER','Work Order','Produce requested goods through a profession.',1,1),(6,'DELIVERY','Delivery','Deliver an object or report to another character.',0,1),(7,'SCOUTING','Scouting','Survey a location, camp, cave or route.',0,0),(8,'SALVAGE','Salvage','Recover supplies from objects in the world.',0,0),(9,'DEFENSE','Defense','Defend, rescue or escort local people.',0,1),(10,'FINAL','Final Contract','Complete the culminating contract for the Board.',0,0),(11,'DUNGEON','Dungeon Contract','Complete an objective in a nearby dungeon.',0,1);
/*!40000 ALTER TABLE `bulletin_quest_categories` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

