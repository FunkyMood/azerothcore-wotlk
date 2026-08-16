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
-- Temporary view structure for view `quartermaster_roll_group_violations`
--

DROP TABLE IF EXISTS `quartermaster_roll_group_violations`;
/*!50001 DROP VIEW IF EXISTS `quartermaster_roll_group_violations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `quartermaster_roll_group_violations` AS SELECT 
 1 AS `pool_id`,
 1 AS `cache`,
 1 AS `code`,
 1 AS `roll_group`,
 1 AS `rows_never_rolled`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `quartermaster_roll_group_violations`
--

/*!50001 DROP VIEW IF EXISTS `quartermaster_roll_group_violations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `quartermaster_roll_group_violations` AS select `ri`.`pool_id` AS `pool_id`,`ct`.`name` AS `cache`,`ct`.`code` AS `code`,`ri`.`roll_group` AS `roll_group`,count(0) AS `rows_never_rolled` from (`quartermaster_reward_items` `ri` join `quartermaster_cache_types` `ct` on((`ct`.`reward_pool_id` = `ri`.`pool_id`))) where (exists(select 1 from `quartermaster_profile_roll_groups` `g` where ((`g`.`profile_id` = `ct`.`profile_id`) and (`g`.`code` = `ct`.`code`))) and exists(select 1 from `quartermaster_profile_roll_groups` `g` where ((`g`.`profile_id` = `ct`.`profile_id`) and (`g`.`code` = `ct`.`code`) and ((`g`.`roll_group` collate utf8mb4_0900_ai_ci) = `ri`.`roll_group`) and (`g`.`weight` > 0))) is false) group by `ri`.`pool_id`,`ct`.`name`,`ct`.`code`,`ri`.`roll_group` */;
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

-- Dump completed on 2026-08-16 16:15:44
