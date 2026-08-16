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
-- Temporary view structure for view `bulletin_board_unique_item_violations`
--

DROP TABLE IF EXISTS `bulletin_board_unique_item_violations`;
/*!50001 DROP VIEW IF EXISTS `bulletin_board_unique_item_violations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bulletin_board_unique_item_violations` AS SELECT 
 1 AS `board_id`,
 1 AS `quest_id`,
 1 AS `item_slot`,
 1 AS `item_id`,
 1 AS `required_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `bulletin_board_unique_item_violations`
--

/*!50001 DROP VIEW IF EXISTS `bulletin_board_unique_item_violations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bulletin_board_unique_item_violations` AS select `bq`.`board_id` AS `board_id`,`bq`.`quest_id` AS `quest_id`,1 AS `item_slot`,`qt`.`RequiredItemId1` AS `item_id`,`qt`.`RequiredItemCount1` AS `required_count` from ((`bulletin_board_quests` `bq` join `quest_template` `qt` on((`qt`.`ID` = `bq`.`quest_id`))) join `item_template` `it` on((`it`.`entry` = `qt`.`RequiredItemId1`))) where ((`qt`.`RequiredItemId1` <> 0) and (`qt`.`RequiredItemCount1` > 1) and (`it`.`maxcount` = 1)) union all select `bq`.`board_id` AS `board_id`,`bq`.`quest_id` AS `quest_id`,2 AS `2`,`qt`.`RequiredItemId2` AS `RequiredItemId2`,`qt`.`RequiredItemCount2` AS `RequiredItemCount2` from ((`bulletin_board_quests` `bq` join `quest_template` `qt` on((`qt`.`ID` = `bq`.`quest_id`))) join `item_template` `it` on((`it`.`entry` = `qt`.`RequiredItemId2`))) where ((`qt`.`RequiredItemId2` <> 0) and (`qt`.`RequiredItemCount2` > 1) and (`it`.`maxcount` = 1)) union all select `bq`.`board_id` AS `board_id`,`bq`.`quest_id` AS `quest_id`,3 AS `3`,`qt`.`RequiredItemId3` AS `RequiredItemId3`,`qt`.`RequiredItemCount3` AS `RequiredItemCount3` from ((`bulletin_board_quests` `bq` join `quest_template` `qt` on((`qt`.`ID` = `bq`.`quest_id`))) join `item_template` `it` on((`it`.`entry` = `qt`.`RequiredItemId3`))) where ((`qt`.`RequiredItemId3` <> 0) and (`qt`.`RequiredItemCount3` > 1) and (`it`.`maxcount` = 1)) union all select `bq`.`board_id` AS `board_id`,`bq`.`quest_id` AS `quest_id`,4 AS `4`,`qt`.`RequiredItemId4` AS `RequiredItemId4`,`qt`.`RequiredItemCount4` AS `RequiredItemCount4` from ((`bulletin_board_quests` `bq` join `quest_template` `qt` on((`qt`.`ID` = `bq`.`quest_id`))) join `item_template` `it` on((`it`.`entry` = `qt`.`RequiredItemId4`))) where ((`qt`.`RequiredItemId4` <> 0) and (`qt`.`RequiredItemCount4` > 1) and (`it`.`maxcount` = 1)) union all select `bq`.`board_id` AS `board_id`,`bq`.`quest_id` AS `quest_id`,5 AS `5`,`qt`.`RequiredItemId5` AS `RequiredItemId5`,`qt`.`RequiredItemCount5` AS `RequiredItemCount5` from ((`bulletin_board_quests` `bq` join `quest_template` `qt` on((`qt`.`ID` = `bq`.`quest_id`))) join `item_template` `it` on((`it`.`entry` = `qt`.`RequiredItemId5`))) where ((`qt`.`RequiredItemId5` <> 0) and (`qt`.`RequiredItemCount5` > 1) and (`it`.`maxcount` = 1)) union all select `bq`.`board_id` AS `board_id`,`bq`.`quest_id` AS `quest_id`,6 AS `6`,`qt`.`RequiredItemId6` AS `RequiredItemId6`,`qt`.`RequiredItemCount6` AS `RequiredItemCount6` from ((`bulletin_board_quests` `bq` join `quest_template` `qt` on((`qt`.`ID` = `bq`.`quest_id`))) join `item_template` `it` on((`it`.`entry` = `qt`.`RequiredItemId6`))) where ((`qt`.`RequiredItemId6` <> 0) and (`qt`.`RequiredItemCount6` > 1) and (`it`.`maxcount` = 1)) */;
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
