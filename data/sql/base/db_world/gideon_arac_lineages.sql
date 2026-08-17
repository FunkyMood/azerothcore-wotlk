-- MySQL dump 10.13  Distrib 8.4.10, for Linux (x86_64)
--
-- Host: localhost    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.4.10

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

--
-- Table structure for table `gideon_arac_lineages`
--

DROP TABLE IF EXISTS `gideon_arac_lineages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gideon_arac_lineages` (
  `race_id` tinyint unsigned NOT NULL,
  `class_id` tinyint unsigned NOT NULL,
  `quest_race_mask` int unsigned NOT NULL,
  PRIMARY KEY (`race_id`,`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gideon_arac_lineages`
--

/*!40000 ALTER TABLE `gideon_arac_lineages` DISABLE KEYS */;
INSERT INTO `gideon_arac_lineages` VALUES (1,1,1),(1,2,1),(1,3,8),(1,4,1),(1,5,1),(1,6,1),(1,7,1024),(1,8,1),(1,9,1),(1,11,8),(2,1,2),(2,2,512),(2,3,2),(2,4,2),(2,5,16),(2,6,2),(2,7,2),(2,8,16),(2,9,2),(2,11,32),(3,1,4),(3,2,4),(3,3,4),(3,4,4),(3,5,4),(3,6,4),(3,7,1024),(3,8,1),(3,9,1),(3,11,8),(4,1,8),(4,2,1),(4,3,8),(4,4,8),(4,5,8),(4,6,8),(4,7,1024),(4,8,1),(4,9,1),(4,11,8),(5,1,16),(5,2,512),(5,3,2),(5,4,16),(5,5,16),(5,6,16),(5,7,2),(5,8,16),(5,9,16),(5,11,32),(6,1,32),(6,2,512),(6,3,32),(6,4,2),(6,5,16),(6,6,32),(6,7,32),(6,8,16),(6,9,2),(6,11,32),(7,1,64),(7,2,1),(7,3,8),(7,4,64),(7,5,1),(7,6,64),(7,7,1024),(7,8,64),(7,9,64),(7,11,8),(8,1,128),(8,2,512),(8,3,128),(8,4,128),(8,5,128),(8,6,128),(8,7,128),(8,8,128),(8,9,2),(8,11,32),(10,1,2),(10,2,512),(10,3,512),(10,4,512),(10,5,512),(10,6,512),(10,7,2),(10,8,512),(10,9,512),(10,11,32),(11,1,1024),(11,2,1024),(11,3,1024),(11,4,1),(11,5,1024),(11,6,1024),(11,7,1024),(11,8,1024),(11,9,1),(11,11,8);
/*!40000 ALTER TABLE `gideon_arac_lineages` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-17  6:17:42
