DROP SCHEMA IF EXISTS `eventappdb`;
CREATE SCHEMA `eventappdb`;
USE `eventappdb`;
-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: eventappdb
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `activity_tracking`
--

DROP TABLE IF EXISTS `activity_tracking`;
/*!50001 DROP VIEW IF EXISTS `activity_tracking`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `activity_tracking` AS SELECT 
 1 AS `city`,
 1 AS `events_created`,
 1 AS `active_monthly_users`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `timestamp` timestamp NOT NULL,
  `text` varchar(500) NOT NULL,
  `postID` bigint NOT NULL,
  `userID` bigint NOT NULL,
  PRIMARY KEY (`timestamp`,`postID`),
  KEY `fk_comment_post1_idx` (`postID`),
  KEY `fk_comment_user1_idx` (`userID`),
  CONSTRAINT `fk_comment_post1` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`),
  CONSTRAINT `fk_comment_user1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES ('2022-05-11 02:12:08','Dance like nothing is going to stop us now!',3,103),('2022-05-17 01:24:34','Everyone wanna get these vibes and the Constantinople',2,100);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `company_earnings`
--

DROP TABLE IF EXISTS `company_earnings`;
/*!50001 DROP VIEW IF EXISTS `company_earnings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `company_earnings` AS SELECT 
 1 AS `donationEarnings`,
 1 AS `entryEarnings`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `donate`
--

DROP TABLE IF EXISTS `donate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donate` (
  `eventID` bigint NOT NULL,
  `userID` bigint NOT NULL,
  `amount` int unsigned NOT NULL,
  PRIMARY KEY (`eventID`,`userID`),
  KEY `fk_event_has_user3_user1_idx` (`userID`),
  KEY `fk_event_has_user3_event1_idx` (`eventID`),
  CONSTRAINT `fk_event_has_user3_event1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`),
  CONSTRAINT `fk_event_has_user3_user1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donate`
--

LOCK TABLES `donate` WRITE;
/*!40000 ALTER TABLE `donate` DISABLE KEYS */;
INSERT INTO `donate` VALUES (1,103,10),(2,100,1),(3,101,25);
/*!40000 ALTER TABLE `donate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `eventID` bigint NOT NULL,
  `isActive` bit(1) NOT NULL,
  `datetime` datetime NOT NULL,
  `description` varchar(500) NOT NULL,
  `capacity` int unsigned NOT NULL,
  `entryPrice` int unsigned NOT NULL,
  `theme` enum('Sports','Conferences','Expo','Concert','Community','Performing Art','Festival') NOT NULL,
  `locationID` bigint NOT NULL,
  PRIMARY KEY (`eventID`),
  KEY `fk_event_location_idx` (`locationID`),
  CONSTRAINT `fk_event_location` FOREIGN KEY (`locationID`) REFERENCES `location` (`locationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,_binary '','2022-05-12 20:00:00','an event with traditional greek dances',1000,5,'Festival',10),(2,_binary '','2022-05-18 19:00:00','Greek traditional music and Byzantine music',3500,5,'Festival',11),(3,_binary '\0','2022-03-01 19:00:00','Environmental community talk',200,0,'Community',12),(4,_binary '','2022-05-15 19:30:00','Pub cafe night with alternative rock from LinkinPark, Paramore, Muse, The Killers, Evanescence and more ',125,2,'Community',14),(5,_binary '','2022-12-25 12:00:00','Embrace the chance to create a virtual assistant on dFlow hackathon',50,0,'Community',13);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_has_sponsor`
--

DROP TABLE IF EXISTS `event_has_sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_has_sponsor` (
  `eventID` bigint NOT NULL,
  `sponsorID` bigint NOT NULL,
  PRIMARY KEY (`eventID`,`sponsorID`),
  KEY `fk_event_has_sponsor_sponsor1_idx` (`sponsorID`),
  KEY `fk_event_has_sponsor_event1_idx` (`eventID`),
  CONSTRAINT `fk_event_has_sponsor_event1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`),
  CONSTRAINT `fk_event_has_sponsor_sponsor1` FOREIGN KEY (`sponsorID`) REFERENCES `sponsor` (`sponsorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_has_sponsor`
--

LOCK TABLES `event_has_sponsor` WRITE;
/*!40000 ALTER TABLE `event_has_sponsor` DISABLE KEYS */;
INSERT INTO `event_has_sponsor` VALUES (1,1000),(2,1000),(4,1000),(5,1000),(1,1001),(5,1003);
/*!40000 ALTER TABLE `event_has_sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendship`
--

DROP TABLE IF EXISTS `friendship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friendship` (
  `sender_userID` bigint NOT NULL,
  `accepter_userID` bigint NOT NULL,
  `since` datetime NOT NULL,
  PRIMARY KEY (`sender_userID`,`accepter_userID`),
  KEY `fk_user_has_user_user2_idx` (`accepter_userID`),
  KEY `fk_user_has_user_user1_idx` (`sender_userID`),
  CONSTRAINT `fk_user_has_user_user1` FOREIGN KEY (`sender_userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `fk_user_has_user_user2` FOREIGN KEY (`accepter_userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendship`
--

LOCK TABLES `friendship` WRITE;
/*!40000 ALTER TABLE `friendship` DISABLE KEYS */;
INSERT INTO `friendship` VALUES (100,104,'2018-10-01 11:23:16'),(101,100,'2019-05-13 15:34:32'),(101,103,'2019-05-09 16:14:38'),(102,101,'2020-09-27 19:13:43');
/*!40000 ALTER TABLE `friendship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host`
--

DROP TABLE IF EXISTS `host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `host` (
  `eventID` bigint NOT NULL,
  `userID` bigint NOT NULL,
  PRIMARY KEY (`eventID`,`userID`),
  KEY `fk_event_has_user1_user1_idx` (`userID`),
  KEY `fk_event_has_user1_event1_idx` (`eventID`),
  CONSTRAINT `fk_event_has_user1_event1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`),
  CONSTRAINT `fk_event_has_user1_user1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host`
--

LOCK TABLES `host` WRITE;
/*!40000 ALTER TABLE `host` DISABLE KEYS */;
INSERT INTO `host` VALUES (1,101),(2,101),(3,103),(5,103),(4,104);
/*!40000 ALTER TABLE `host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `locationID` bigint NOT NULL,
  `city` varchar(35) NOT NULL,
  `zipCode` char(5) NOT NULL,
  `street` varchar(35) NOT NULL,
  `address` varchar(35) NOT NULL,
  PRIMARY KEY (`locationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (10,'chania','73131','anagnwstou gogoni','43'),(11,'kozani','50100','pavlou mela','3'),(12,'thessaloniki','54453','kleanthous','45'),(13,'thessaloniki','54636','egnatia','154'),(14,'thessaloniki','54645','georgiou papandreou','20'),(15,'athina','10435','iera odos','32');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `sender_userID` bigint NOT NULL,
  `accepter_userID` bigint NOT NULL,
  `timestamp` timestamp NOT NULL,
  `text` varchar(500) NOT NULL,
  PRIMARY KEY (`sender_userID`,`accepter_userID`,`timestamp`),
  KEY `fk_user_has_user1_user2_idx` (`accepter_userID`),
  KEY `fk_user_has_user1_user1_idx` (`sender_userID`),
  CONSTRAINT `fk_user_has_user1_user1` FOREIGN KEY (`sender_userID`) REFERENCES `user` (`userID`),
  CONSTRAINT `fk_user_has_user1_user2` FOREIGN KEY (`accepter_userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (100,104,'2022-09-06 16:34:25','Poso xrono sas edwse o ntelo sthn eksetash auth thn fora?'),(101,103,'2022-09-06 19:29:39','Maria thes na peraseis mia bolta apo to spiti gia netflix?'),(102,101,'2022-09-06 19:29:39','John have you checked the new seminar of Ioannis Pitas?');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participate`
--

DROP TABLE IF EXISTS `participate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participate` (
  `eventID` bigint NOT NULL,
  `userID` bigint NOT NULL,
  PRIMARY KEY (`eventID`,`userID`),
  KEY `fk_event_has_user2_user1_idx` (`userID`),
  KEY `fk_event_has_user2_event1_idx` (`eventID`),
  CONSTRAINT `fk_event_has_user2_event1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`),
  CONSTRAINT `fk_event_has_user2_user1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participate`
--

LOCK TABLES `participate` WRITE;
/*!40000 ALTER TABLE `participate` DISABLE KEYS */;
INSERT INTO `participate` VALUES (1,100),(2,100),(4,100),(3,101),(3,102),(1,103);
/*!40000 ALTER TABLE `participate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `postID` bigint NOT NULL,
  `timestamp` timestamp NOT NULL,
  `text` varchar(500) NOT NULL,
  `eventID` bigint NOT NULL,
  `userID` bigint NOT NULL,
  PRIMARY KEY (`postID`),
  KEY `fk_post_event1_idx` (`eventID`),
  KEY `fk_post_user1_idx` (`userID`),
  CONSTRAINT `fk_post_event1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`),
  CONSTRAINT `fk_post_user1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'2022-05-17 00:14:08','Who wanna get old school vibes tomorrow?',2,101),(2,'2022-05-11 02:05:18','Let’s dance like our ancestors.',1,103),(3,'2022-05-10 02:05:17','Of course we will dance and then eat a little bit.',1,101);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `eventID` bigint NOT NULL,
  `userID` bigint NOT NULL,
  `rating` int unsigned NOT NULL,
  `comment` varchar(500) NOT NULL,
  PRIMARY KEY (`eventID`,`userID`),
  KEY `fk_event_has_user_user1_idx` (`userID`),
  KEY `fk_event_has_user_event1_idx` (`eventID`),
  CONSTRAINT `fk_event_has_user_event1` FOREIGN KEY (`eventID`) REFERENCES `event` (`eventID`),
  CONSTRAINT `fk_event_has_user_user1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,103,5,'Fantastic experience'),(4,102,4,'I didn’t like the atmosphere'),(4,103,5,'It could be better');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsor` (
  `sponsorID` bigint NOT NULL,
  `brand` varchar(45) NOT NULL,
  PRIMARY KEY (`sponsorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
INSERT INTO `sponsor` VALUES (1000,'Red Bull'),(1001,'Coca-Cola'),(1002,'Adidas'),(1003,'Issel');
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` bigint NOT NULL,
  `email` varchar(35) NOT NULL,
  `username` varchar(35) NOT NULL,
  `password` varchar(35) NOT NULL,
  `age` int unsigned NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (100,'vasileie@auth.gr','Bill','aA5!@#p',22,'Male'),(101,'johnPap@auth.gr','John','e321#@!',21,'Male'),(102,'fsajdkf@gmail.com','PartyAnimal','1234567',17,'Male'),(103,'mariadb@yahoo.gr','Maraki99','brunoM4r$',23,'Female'),(104,'smpoulio@auth.gr','stavrosb00','mund14l22',22,'Male');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `weekly_events`
--

DROP TABLE IF EXISTS `weekly_events`;
/*!50001 DROP VIEW IF EXISTS `weekly_events`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `weekly_events` AS SELECT 
 1 AS `eventID`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `activity_tracking`
--

/*!50001 DROP VIEW IF EXISTS `activity_tracking`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `activity_tracking` AS select `t1`.`city` AS `city`,`t2`.`events_created` AS `events_created`,`t1`.`active_monthly_users` AS `active_monthly_users` from ((select `b`.`city` AS `city`,count(0) AS `active_monthly_users` from (select distinct `a`.`city` AS `city`,`participate`.`userID` AS `userID` from ((select `event`.`eventID` AS `eventID`,`location`.`city` AS `city` from (`event` join `location` on((`event`.`locationID` = `location`.`locationID`))) where ((now() >= `event`.`datetime`) and (`event`.`datetime` >= (now() - interval 56 week)))) `a` join `participate` on((`a`.`eventID` = `participate`.`eventID`)))) `b` group by `b`.`city`) `t1` join (select `a`.`city` AS `city`,count(0) AS `events_created` from (select `event`.`eventID` AS `eventID`,`location`.`city` AS `city` from (`event` join `location` on((`event`.`locationID` = `location`.`locationID`))) where ((now() >= `event`.`datetime`) and (`event`.`datetime` >= (now() - interval 56 week)))) `a` group by `a`.`city`) `t2` on((`t1`.`city` = `t2`.`city`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `company_earnings`
--

/*!50001 DROP VIEW IF EXISTS `company_earnings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `company_earnings` AS select (`t11`.`donationMoney` * 0.02) AS `donationEarnings`,(`t12`.`entryMoney` * 0.16) AS `entryEarnings` from ((select sum(`t1`.`amount`) AS `donationMoney` from (select `donate`.`eventID` AS `eventID`,`donate`.`userID` AS `userID`,`donate`.`amount` AS `amount` from ((select `event`.`eventID` AS `eventID`,`event`.`entryPrice` AS `entryPrice` from `event` where (((now() - interval 56 week) <= `event`.`datetime`) and (`event`.`datetime` <= now()))) `a` join `donate` on((`a`.`eventID` = `donate`.`eventID`)))) `t1`) `t11` join (select sum(`t2`.`entryPrice`) AS `entryMoney` from (select `participate`.`eventID` AS `eventID`,`participate`.`userID` AS `userID`,`a`.`entryPrice` AS `entryPrice` from ((select `event`.`eventID` AS `eventID`,`event`.`entryPrice` AS `entryPrice` from `event` where (((now() - interval 56 week) <= `event`.`datetime`) and (`event`.`datetime` <= now()))) `a` join `participate` on((`a`.`eventID` = `participate`.`eventID`)))) `t2`) `t12`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `weekly_events`
--

/*!50001 DROP VIEW IF EXISTS `weekly_events`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `weekly_events` AS select `event`.`eventID` AS `eventID` from `event` where (((now() + interval 1 week) > `event`.`datetime`) and (`event`.`datetime` > now()) and (`event`.`isActive` = 1)) */;
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

-- Dump completed on 2022-12-20 11:35:28
