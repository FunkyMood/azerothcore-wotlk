
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
DROP TABLE IF EXISTS `bulletin_trophy_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_trophy_sources` (
  `board_id` mediumint unsigned NOT NULL,
  `item_id` mediumint unsigned NOT NULL,
  `creature_entry` mediumint unsigned NOT NULL,
  `camp_id` mediumint unsigned NOT NULL DEFAULT '0',
  `drop_chance` decimal(6,3) NOT NULL,
  `notes` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`board_id`,`item_id`,`creature_entry`),
  CONSTRAINT `fk_bulletin_trophy_sources_board` FOREIGN KEY (`board_id`) REFERENCES `bulletin_boards` (`board_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_trophy_sources` DISABLE KEYS */;
INSERT INTO `bulletin_trophy_sources` VALUES (1,755,6,101,20.000,'Melted Candle from Kobold Vermin in Diseased Young Wolf Ground'),(1,755,257,101,20.000,'Melted Candle from Kobold Worker in Diseased Young Wolf Ground'),(1,7073,69,101,36.300,'Broken Fang from Diseased Timber Wolf in Diseased Young Wolf Ground'),(1,7073,299,101,36.300,'Broken Fang from Diseased Young Wolf in Diseased Young Wolf Ground'),(1,7074,69,101,36.300,'Chipped Claw from Diseased Timber Wolf in Diseased Young Wolf Ground'),(1,7074,299,101,36.300,'Chipped Claw from Diseased Young Wolf in Diseased Young Wolf Ground'),(2,779,732,203,29.663,'Shiny Seashell from Murloc Lurker in Prowler Ground'),(2,1476,43,204,66.000,'Snapped Spider Limb from Mine Spider in Defias Thug Ground'),(2,2589,116,203,34.698,'Linen Cloth from Defias Bandit in Prowler Ground'),(2,2589,6093,203,34.698,'Linen Cloth from Dead-Tooth Jack in Prowler Ground'),(2,2672,525,202,77.135,'Stringy Wolf Meat from Mangy Wolf in Mangy Wolf Ground'),(2,3171,524,205,31.129,'Broken Boar Tusk from Rockhide Boar in Rockhide Boar Ground'),(2,7073,822,202,33.417,'Broken Fang from Young Forest Bear in Mangy Wolf Ground'),(5,7073,3102,503,36.300,'Broken Fang from Felstalker in Mottled Boar Ground'),(5,7074,3102,503,36.300,'Chipped Claw from Felstalker in Mottled Boar Ground'),(5,7099,3124,501,36.300,'Severed Pincer from Scorpid Worker in Mottled Boar Ground'),(5,7099,3281,501,36.300,'Severed Pincer from Sarkoth in Mottled Boar Ground'),(5,7101,3124,501,36.300,'Bug Eye from Scorpid Worker in Mottled Boar Ground'),(5,7101,3281,501,36.300,'Bug Eye from Sarkoth in Mottled Boar Ground');
/*!40000 ALTER TABLE `bulletin_trophy_sources` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

