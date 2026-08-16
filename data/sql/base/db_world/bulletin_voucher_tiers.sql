
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
DROP TABLE IF EXISTS `bulletin_voucher_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletin_voucher_tiers` (
  `tier_id` tinyint unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `item_id` mediumint unsigned NOT NULL,
  `min_level` tinyint unsigned NOT NULL,
  `max_level` tinyint unsigned NOT NULL,
  `coverage_pct` tinyint unsigned NOT NULL DEFAULT '50' COMMENT 'share of this band experience that should come from Boards',
  `seconds_per_kill` smallint unsigned NOT NULL DEFAULT '12' COMMENT 'combat time for one kill at this band, search excluded',
  `copper_reward` int unsigned NOT NULL DEFAULT '0' COMMENT 'total copper the Boards of this band should pay out',
  PRIMARY KEY (`tier_id`),
  UNIQUE KEY `uq_bulletin_voucher_tiers_item` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `bulletin_voucher_tiers` DISABLE KEYS */;
INSERT INTO `bulletin_voucher_tiers` VALUES (1,'Recruit Voucher',37742,1,10,40,6,6300),(2,'Scout Voucher',37711,11,20,40,10,28700),(3,'Ranger Voucher',38644,21,30,55,12,173400),(4,'Veteran Voucher',41749,31,40,65,13,336600),(5,'Sentinel Voucher',43949,41,50,70,14,400000),(6,'Vanguard Voucher',44209,51,60,75,15,600000),(7,'Champion Voucher',37836,61,70,85,15,1000000),(8,'Warlord Voucher',40752,71,80,90,15,1600000);
/*!40000 ALTER TABLE `bulletin_voucher_tiers` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

