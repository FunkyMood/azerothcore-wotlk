
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
DROP TABLE IF EXISTS `bulletin_board_camps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_board_camps` (
  `camp_id` mediumint unsigned NOT NULL,
  `board_id` mediumint unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `map_id` smallint unsigned NOT NULL,
  `center_x` float NOT NULL,
  `center_y` float NOT NULL,
  `center_z` float NOT NULL,
  `radius` float NOT NULL,
  `min_level` tinyint unsigned NOT NULL,
  `max_level` tinyint unsigned NOT NULL,
  PRIMARY KEY (`camp_id`),
  KEY `idx_bulletin_board_camps_board` (`board_id`),
  CONSTRAINT `fk_bulletin_board_camps_board` FOREIGN KEY (`board_id`) REFERENCES `bulletin_boards` (`board_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_board_camps` DISABLE KEYS */;
INSERT INTO `bulletin_board_camps` VALUES (101,1,'Abbey Hunting Grounds',0,-8857.86,-194.951,81.238,284,1,4),(102,1,'Wolfscar Rise',0,-8737.38,-74.467,92.353,60,5,5),(201,2,'Goldtooth\'s Claim',0,-9745.84,87.567,12.774,60,8,8),(202,2,'Forest\'s Edge',0,-9691.39,741.219,33.09,146,5,9),(203,2,'Eastvale Timberlands',0,-9775.37,-1477.97,42.827,259.1,8,11),(204,2,'Jasperlode Approaches',0,-9046.24,-401.102,69.117,244.7,3,9),(205,2,'Brackwell Fields',0,-9772.87,-592.757,39.15,259.1,7,10),(206,2,'Maclure Farmland',0,-9926.44,238.306,33.369,267.6,5,9),(207,2,'Eastvale Woods',0,-9416.82,-1446.35,63.691,192.8,8,10),(501,5,'Valley Hunting Ground',1,-557.872,-4283.21,53.251,268.1,1,4),(502,5,'Boar Track',1,-732.698,-4214.68,45.056,203.7,1,3),(503,5,'Burning Blade Approach',1,-283.12,-4278.32,56.792,274.5,1,4),(504,5,'Bloodtusk\'s Lair',1,-399.583,-4161.85,51.608,60,5,5);
/*!40000 ALTER TABLE `bulletin_board_camps` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

