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
-- Temporary view structure for view `bulletin_board_work_order_requirements`
--

DROP TABLE IF EXISTS `bulletin_board_work_order_requirements`;
/*!50001 DROP VIEW IF EXISTS `bulletin_board_work_order_requirements`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bulletin_board_work_order_requirements` AS SELECT 
 1 AS `board_id`,
 1 AS `quest_id`,
 1 AS `item_slot`,
 1 AS `item_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `bulletin_board_work_order_requirements`
--

/*!50001 DROP VIEW IF EXISTS `bulletin_board_work_order_requirements`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `bulletin_board_work_order_requirements` AS select `qr`.`board_id` AS `board_id`,`qr`.`quest_id` AS `quest_id`,1 AS `item_slot`,`qt`.`RequiredItemId1` AS `item_id` from ((`bulletin_board_quest_rules` `qr` join `bulletin_quest_categories` `qc` on((`qc`.`category_id` = `qr`.`category_id`))) join `quest_template` `qt` on((`qt`.`ID` = `qr`.`quest_id`))) where ((`qc`.`code` = 'WORK_ORDER') and (`qt`.`RequiredItemId1` <> 0)) union all select `qr`.`board_id` AS `board_id`,`qr`.`quest_id` AS `quest_id`,2 AS `2`,`qt`.`RequiredItemId2` AS `RequiredItemId2` from ((`bulletin_board_quest_rules` `qr` join `bulletin_quest_categories` `qc` on((`qc`.`category_id` = `qr`.`category_id`))) join `quest_template` `qt` on((`qt`.`ID` = `qr`.`quest_id`))) where ((`qc`.`code` = 'WORK_ORDER') and (`qt`.`RequiredItemId2` <> 0)) union all select `qr`.`board_id` AS `board_id`,`qr`.`quest_id` AS `quest_id`,3 AS `3`,`qt`.`RequiredItemId3` AS `RequiredItemId3` from ((`bulletin_board_quest_rules` `qr` join `bulletin_quest_categories` `qc` on((`qc`.`category_id` = `qr`.`category_id`))) join `quest_template` `qt` on((`qt`.`ID` = `qr`.`quest_id`))) where ((`qc`.`code` = 'WORK_ORDER') and (`qt`.`RequiredItemId3` <> 0)) union all select `qr`.`board_id` AS `board_id`,`qr`.`quest_id` AS `quest_id`,4 AS `4`,`qt`.`RequiredItemId4` AS `RequiredItemId4` from ((`bulletin_board_quest_rules` `qr` join `bulletin_quest_categories` `qc` on((`qc`.`category_id` = `qr`.`category_id`))) join `quest_template` `qt` on((`qt`.`ID` = `qr`.`quest_id`))) where ((`qc`.`code` = 'WORK_ORDER') and (`qt`.`RequiredItemId4` <> 0)) union all select `qr`.`board_id` AS `board_id`,`qr`.`quest_id` AS `quest_id`,5 AS `5`,`qt`.`RequiredItemId5` AS `RequiredItemId5` from ((`bulletin_board_quest_rules` `qr` join `bulletin_quest_categories` `qc` on((`qc`.`category_id` = `qr`.`category_id`))) join `quest_template` `qt` on((`qt`.`ID` = `qr`.`quest_id`))) where ((`qc`.`code` = 'WORK_ORDER') and (`qt`.`RequiredItemId5` <> 0)) union all select `qr`.`board_id` AS `board_id`,`qr`.`quest_id` AS `quest_id`,6 AS `6`,`qt`.`RequiredItemId6` AS `RequiredItemId6` from ((`bulletin_board_quest_rules` `qr` join `bulletin_quest_categories` `qc` on((`qc`.`category_id` = `qr`.`category_id`))) join `quest_template` `qt` on((`qt`.`ID` = `qr`.`quest_id`))) where ((`qc`.`code` = 'WORK_ORDER') and (`qt`.`RequiredItemId6` <> 0)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-16 16:15:43
