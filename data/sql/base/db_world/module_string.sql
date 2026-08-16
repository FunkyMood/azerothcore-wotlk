
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
DROP TABLE IF EXISTS `module_string`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `module_string` (
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'module dir name, eg mod-cfbg',
  `id` int unsigned NOT NULL,
  `string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`module`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `module_string` DISABLE KEYS */;
INSERT INTO `module_string` VALUES ('mod-transmog',1,'Item successfully transmogrified.'),('mod-transmog',2,'Equipment slot is empty.'),('mod-transmog',3,'Invalid source item selected.'),('mod-transmog',4,'Source item does not exist.'),('mod-transmog',5,'Destination item does not exist.'),('mod-transmog',6,'Selected items are invalid.'),('mod-transmog',7,'You don\'t have enough money.'),('mod-transmog',8,'You don\'t have enough tokens.'),('mod-transmog',9,'All your transmogrifications were removed.'),('mod-transmog',10,'No transmogrification found.'),('mod-transmog',11,'Invalid name inserted.'),('mod-transmog',12,'Showing transmogrified items, relog to update the current area.'),('mod-transmog',13,'Hiding transmogrified items, relog to update the current area.'),('mod-transmog',14,'The selected item is not suitable for transmogrification.'),('mod-transmog',15,'The selected item cannot be used for transmogrification of the target player.'),('mod-transmog',16,'Performing transmog appearance sync...'),('mod-transmog',17,'Appearance sync complete.'),('mod-transmog',18,'The transmog NPC will now display available appearances as a vendor interface, allowing preview. \nDISCLAIMER: If you have too many appearances, some will not be displayed due to a client limitation. In that case, disable this option.'),('mod-transmog',19,'The transmog NPC will now display available appearances as gossip list.'),('mod-transmog',20,'How does transmogrification work?'),('mod-transmog',21,'Manage sets'),('mod-transmog',22,'Remove all transmogrifications'),('mod-transmog',23,'Remove transmogrifications from all equipped items?'),('mod-transmog',24,'Update menu'),('mod-transmog',25,'How do sets work?'),('mod-transmog',26,'Save set'),('mod-transmog',27,'Back...'),('mod-transmog',28,'Use this set'),('mod-transmog',29,'Using this set for transmogrify will bind transmogrified items to you and make them non-refundable and non-tradeable.\nDo you wish to continue?\n\n'),('mod-transmog',30,'Delete set'),('mod-transmog',31,'Are you sure you want to delete '),('mod-transmog',32,'Insert set name'),('mod-transmog',33,'Search...'),('mod-transmog',34,'Searching for: '),('mod-transmog',35,'Search for what item?'),('mod-transmog',36,'You are hiding the item in this slot.\nDo you wish to continue?\n\n'),('mod-transmog',37,'Hide Slot'),('mod-transmog',38,'Remove transmogrification from the slot?'),('mod-transmog',39,'Using this item for transmogrify will bind it to you and make it non-refundable and non-tradeable.\nDo you wish to continue?\n\n'),('mod-transmog',40,'Previous Page'),('mod-transmog',41,'Next Page'),('mod-transmog',42,'has been added to your appearance collection.'),('mod-transmog',43,'|cFF4DB3FFSet bonuses won\'t appear in the item tooltip while transmogrified, but they are still fully active.\nTo stop seeing this notice, type |cFFFFFFFF.transmog disclaimer off|cFF4DB3FF.|r'),('mod-transmog',44,'Set bonus disclaimer enabled.'),('mod-transmog',45,'Set bonus disclaimer disabled.');
/*!40000 ALTER TABLE `module_string` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

