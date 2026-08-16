
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
DROP TABLE IF EXISTS `bulletin_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_zones` (
  `zone_id` smallint unsigned NOT NULL COMMENT 'AreaTable.dbc zone id',
  `name` varchar(100) NOT NULL,
  `map_id` smallint unsigned NOT NULL DEFAULT '0',
  `min_level` tinyint unsigned NOT NULL,
  `max_level` tinyint unsigned NOT NULL,
  `sort_order` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`zone_id`),
  KEY `idx_levels` (`min_level`,`max_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_zones` DISABLE KEYS */;
INSERT INTO `bulletin_zones` VALUES (1,'Dun Morogh',0,1,10,20),(3,'Badlands',0,35,45,200),(4,'Blasted Lands',0,45,55,250),(8,'Swamp of Sorrows',0,35,45,210),(10,'Duskwood',0,20,30,120),(11,'Wetlands',0,20,30,130),(12,'Elwynn Forest',0,1,10,10),(14,'Durotar',1,1,10,50),(15,'Dustwallow Marsh',1,35,45,220),(16,'Azshara',1,45,55,245),(17,'The Barrens',1,10,25,100),(28,'Western Plaguelands',0,51,58,280),(33,'Stranglethorn Vale',0,30,45,180),(38,'Loch Modan',0,10,20,70),(40,'Westfall',0,10,20,60),(44,'Redridge Mountains',0,15,25,110),(45,'Arathi Highlands',0,30,40,190),(46,'Burning Steppes',0,50,58,270),(47,'The Hinterlands',0,40,50,240),(51,'Searing Gorge',0,45,50,260),(65,'Dragonblight',571,71,75,400),(66,'Zul\'Drak',571,74,76,420),(67,'The Storm Peaks',571,76,80,440),(85,'Tirisfal Glades',0,1,10,30),(130,'Silverpine Forest',0,10,20,80),(139,'Eastern Plaguelands',0,53,60,290),(141,'Teldrassil',1,1,10,40),(148,'Darkshore',1,10,20,90),(210,'Icecrown',571,77,80,450),(215,'Mulgore',1,1,10,55),(267,'Hillsbrad Foothills',0,20,30,140),(331,'Ashenvale',1,18,30,150),(357,'Feralas',1,40,50,235),(361,'Felwood',1,48,55,265),(394,'Grizzly Hills',571,73,75,410),(400,'Thousand Needles',1,25,35,170),(405,'Desolace',1,30,40,195),(406,'Stonetalon Mountains',1,20,30,160),(440,'Tanaris',1,40,50,230),(490,'Un\'Goro Crater',1,48,55,255),(493,'Sholazar Basin',571,75,78,430),(495,'Howling Fjord',571,68,72,390),(618,'Winterspring',1,53,60,295),(1377,'Silithus',1,55,60,300),(3430,'Eversong Woods',530,1,10,35),(3433,'Ghostlands',530,10,20,85),(3483,'Hellfire Peninsula',530,58,63,310),(3518,'Nagrand',530,64,67,340),(3519,'Terokkar Forest',530,62,65,330),(3520,'Shadowmoon Valley',530,67,70,370),(3521,'Zangarmarsh',530,60,64,320),(3522,'Blade\'s Edge Mountains',530,65,68,350),(3523,'Netherstorm',530,67,70,360),(3524,'Azuremyst Isle',530,1,10,45),(3525,'Bloodmyst Isle',530,10,20,95),(3537,'Borean Tundra',571,68,72,380),(4197,'Wintergrasp',571,77,80,460);
/*!40000 ALTER TABLE `bulletin_zones` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

