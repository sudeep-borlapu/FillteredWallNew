-- MySQL dump 10.15  Distrib 10.0.21-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: fwdev
-- ------------------------------------------------------
-- Server version	10.0.21-MariaDB-1~trusty-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `fk_comments_posts` (`pid`),
  CONSTRAINT `fk_comments_posts` FOREIGN KEY (`pid`) REFERENCES `posts` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversations` (
  `conv_id` int(11) NOT NULL AUTO_INCREMENT,
  `p1` int(11) DEFAULT NULL,
  `p2` int(11) DEFAULT NULL,
  PRIMARY KEY (`conv_id`),
  UNIQUE KEY `p1` (`p1`,`p2`),
  KEY `fk_conv_person2` (`p2`),
  CONSTRAINT `fk_conv_person1` FOREIGN KEY (`p1`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_conv_person2` FOREIGN KEY (`p2`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (2,6,7),(1,6,11);
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `friendid` int(11) NOT NULL AUTO_INCREMENT,
  `sentfrom` int(11) DEFAULT NULL,
  `sentto` int(11) DEFAULT NULL,
  `fromdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`friendid`),
  UNIQUE KEY `sentto` (`sentto`,`sentfrom`),
  KEY `fk_freinds_person1` (`sentfrom`),
  CONSTRAINT `fk_freinds_person1` FOREIGN KEY (`sentfrom`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_friends_person2` FOREIGN KEY (`sentto`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (2,11,6,'2015-03-17 08:52:20','accept'),(7,7,11,'2015-03-10 10:56:28','sent'),(8,7,6,'2015-03-10 11:03:41','accept'),(9,14,6,'2015-03-29 13:45:52','accept');
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  PRIMARY KEY (`lid`),
  UNIQUE KEY `pid` (`pid`,`id`),
  KEY `fk_like_person` (`id`),
  CONSTRAINT `fk_like_person` FOREIGN KEY (`id`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_likes_posts` FOREIGN KEY (`pid`) REFERENCES `posts` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (5,1,6),(26,1,13),(106,2,6),(105,3,6),(104,4,6),(103,5,6),(102,6,6),(101,7,6),(99,8,6),(100,9,6),(98,10,6),(97,11,6),(96,12,6),(95,13,6),(94,14,6),(93,15,6),(92,16,6),(91,17,6),(90,18,6),(89,19,6),(88,20,6),(87,21,6),(86,22,6),(85,23,6),(84,24,6),(83,25,6),(82,26,6),(81,27,6),(80,28,6),(79,29,6),(78,30,6),(77,31,6),(76,32,6),(74,33,6),(75,34,6),(73,35,6),(72,36,6),(71,37,6),(70,38,6),(69,39,6),(68,40,6),(67,41,6),(66,42,6),(65,43,6),(64,44,6),(63,45,6),(62,46,6),(61,47,6),(60,48,6),(58,49,6),(59,50,6),(57,51,6),(56,52,6),(55,53,6),(12,53,11),(54,54,6),(53,55,6),(7,56,6),(52,58,6),(51,59,6),(50,60,6),(49,61,6),(11,61,11),(6,62,6),(25,62,13),(48,63,6),(47,64,6),(46,65,6),(45,66,6),(44,67,6),(43,68,6),(4,69,6),(24,69,13),(42,70,6),(41,71,6),(40,72,6),(23,72,13),(39,73,6),(38,74,6),(37,75,6),(20,78,6),(22,78,13),(21,79,13),(19,80,6),(113,81,6),(10,81,11),(2,82,6),(9,82,11),(111,83,6),(8,83,11),(18,84,6),(17,85,6),(16,86,6),(14,87,6),(27,88,6),(36,89,6),(30,90,6),(28,92,6),(32,93,6),(112,94,6),(35,95,6);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `msgfrom` int(11) DEFAULT NULL,
  `msgto` int(11) DEFAULT NULL,
  `tym` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `message` varchar(500) DEFAULT NULL,
  `conv_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`mid`),
  KEY `fk_msgfrom_id` (`msgfrom`),
  KEY `fk_msgto_id` (`msgto`),
  KEY `fk_mssages_converations` (`conv_id`),
  CONSTRAINT `fk_msgfrom_id` FOREIGN KEY (`msgfrom`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_msgto_id` FOREIGN KEY (`msgto`) REFERENCES `person` (`id`),
  CONSTRAINT `fk_mssages_converations` FOREIGN KEY (`conv_id`) REFERENCES `conversations` (`conv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,6,7,'2015-03-16 07:25:19','Hi',2),(2,7,6,'2015-03-16 07:25:30','Hi..',2),(3,11,6,'2015-03-16 07:25:42','Hi..',1),(4,6,11,'2015-03-16 07:25:53','Hi',1),(5,6,11,'2015-03-16 07:25:58','oye',1),(6,6,11,'2015-03-16 07:26:02','bye',1),(7,6,7,'2015-03-17 08:17:28','kdjlskf',2),(8,6,7,'2015-03-17 08:19:33','kdjhkds',2),(9,6,7,'2015-03-17 08:19:46','lkdfsjl',2),(10,6,7,'2015-03-17 08:20:34','ldskfjlkds',2),(11,6,7,'2015-03-17 08:22:33','llfdkdsfjf',2),(12,6,7,'2015-03-17 08:57:16',' ',2),(13,7,6,'2015-03-17 08:58:37','hai....',2),(14,6,7,'2015-03-17 08:58:46','hi',2),(15,6,7,'2015-03-17 08:58:54','whats going on...',2),(16,7,6,'2015-03-17 08:59:19','listening songs.....',2),(17,6,7,'2015-03-17 08:59:28','ok enjoy!!!',2),(18,7,6,'2015-03-17 09:02:08','ha ha ha ha ha.....',2),(19,7,6,'2015-03-17 09:02:18','',2),(20,7,6,'2015-03-17 09:02:19','',2),(21,7,6,'2015-03-17 09:02:21','',2),(22,7,6,'2015-03-17 09:02:23','',2),(23,7,6,'2015-03-17 09:02:26','',2),(24,7,6,'2015-03-17 09:02:27','',2),(25,7,6,'2015-03-17 09:02:28','',2),(26,7,6,'2015-03-17 09:02:29','',2),(27,7,6,'2015-03-17 09:02:32','',2),(28,7,6,'2015-03-17 09:02:33','',2),(29,7,6,'2015-03-17 09:02:37','',2),(30,7,6,'2015-03-17 09:02:39','',2),(31,7,6,'2015-03-17 09:02:40','',2),(32,7,6,'2015-03-17 09:02:47','',2),(33,7,6,'2015-03-17 09:02:50','',2),(34,7,6,'2015-03-17 09:02:51','',2),(35,7,6,'2015-03-17 09:02:52','',2),(36,6,11,'2015-03-17 09:11:18','kdjfskj',1),(37,6,7,'2015-03-17 09:11:38','what the hell u did??',2);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(40) DEFAULT NULL,
  `fname` varchar(40) DEFAULT NULL,
  `lname` varchar(40) DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `dob` varchar(15) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(40) DEFAULT NULL,
  `dp` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (6,'sud','Sudeep Reddy','Borlapu','m','sudeep.borlapu@gmail.com','12/08/1991','9491009331','sudeep','t'),(7,'dev','Ram','Charan','m','dev','01/01/1986',NULL,'dev','f'),(11,NULL,'Sudeep','Borlam','m','borlamsudeep@gmail.com','12/08/1991',NULL,'sudeep1','f'),(12,NULL,'abc','abc','m','abc@gmail.com','2015/03/02',NULL,'abc','f'),(13,NULL,'Vikranth Reddy','Ummanagari','m','rebelvikranth1234@gmail.com','2000/03/26',NULL,'vikki','f'),(14,'ajith','ajith','reddy','m','majith1223@gmail.com','1992/08/06',NULL,'ajith','f');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `body` varchar(1000) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `onwall` int(11) DEFAULT NULL,
  PRIMARY KEY (`pid`),
  KEY `fk_post_person` (`id`),
  CONSTRAINT `fk_post_person` FOREIGN KEY (`id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'Hi....',6,'2015-08-04 06:07:11',6),(2,'good mrng!',6,'2015-08-04 06:07:11',6),(3,'why should I say...?',7,'2015-08-04 06:08:58',7),(4,'thokkale...\r\n',7,'2015-08-04 06:08:58',7),(5,'thokkale...\r\n',7,'2015-08-04 06:08:58',7),(6,'feeling some what....************',7,'2015-08-04 06:08:58',7),(7,'',7,'2015-08-04 06:08:58',7),(8,'',7,'2015-08-04 06:08:58',7),(9,'',7,'2015-08-04 06:08:58',7),(10,'',7,'2015-08-04 06:08:58',7),(11,'~!@#$%^&*()_+',7,'2015-08-04 06:08:58',7),(12,'~!@#$%^&*()_+',7,'2015-08-04 06:08:58',7),(13,'~!@#$%^&*()_+',7,'2015-08-04 06:08:58',7),(14,'',7,'2015-08-04 06:08:58',7),(15,'',7,'2015-08-04 06:08:58',7),(16,'',7,'2015-08-04 06:08:58',7),(17,'',7,'2015-08-04 06:08:58',7),(18,'',7,'2015-08-04 06:08:58',7),(19,'',7,'2015-08-04 06:08:58',7),(20,'abc',7,'2015-08-04 06:08:58',7),(21,'abc',7,'2015-08-04 06:08:58',7),(22,'abc',7,'2015-08-04 06:08:58',7),(23,'abc',7,'2015-08-04 06:08:58',7),(24,'vellavayya vellu..',7,'2015-08-04 06:08:58',7),(25,'vellavayya vellu..',7,'2015-08-04 06:08:58',7),(26,'Good Night!\r\n',6,'2015-08-04 06:07:11',6),(27,'Vikranth Reddy\r\n',6,'2015-08-04 06:07:11',6),(28,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(29,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(30,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(31,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(32,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(33,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(34,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(35,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(36,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(37,'Sudhakar Reddy',6,'2015-08-04 06:07:11',6),(38,'Good Mrng!',6,'2015-08-04 06:07:11',6),(39,'Hi',6,'2015-08-04 06:07:11',6),(40,'Hi... This is test sendRedirect...',6,'2015-08-04 06:07:11',6),(41,'Hi... This is test sendRedirect...',6,'2015-08-04 06:07:11',6),(42,'sudeep borlapu\r\n',6,'2015-08-04 06:07:11',6),(43,'Ragavendra',6,'2015-08-04 06:07:11',6),(44,'Devendra.. Gud Mrng!!!',6,'2015-08-04 06:07:11',6),(45,'No refresh worked!!!',6,'2015-08-04 06:07:11',6),(46,'',6,'2015-08-04 06:07:11',6),(47,'',6,'2015-08-04 06:07:11',6),(48,'',6,'2015-08-04 06:05:18',6),(49,'',6,'2015-08-04 06:05:18',6),(50,'',6,'2015-08-04 06:05:18',6),(51,'',6,'2015-08-04 06:05:18',6),(52,'Empty posts are not allowed from now!',6,'2015-08-04 06:05:18',6),(53,'my next flim is with seenu vaitla....\r\n',7,'2015-08-04 06:08:58',7),(54,'busy in shooting..\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n',7,'2015-08-04 06:08:58',7),(55,'hey\r\n\r\n\r\n\r\n^',7,'2015-08-04 06:08:58',7),(56,'hai...\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nhow r u...?\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nwer r u....?',7,'2015-08-04 06:08:58',7),(57,'Hi...\r\n',12,'2015-08-04 06:09:36',12),(58,'2maro holiday..\r\n',7,'2015-08-04 06:08:58',7),(59,'Hi...\r\nGuys!\r\nHow is it going!!',6,'2015-08-04 06:05:18',6),(60,'New Lines now working in\r\n\r\ntext area!!',6,'2015-08-04 06:05:18',6),(61,'H\r\n\r\n\r\n\r\n\r\n\r\n\r\nA\r\n\r\n\r\n\r\n\r\np\r\n\r\n\r\n\r\n\r\n\r\np\r\n\r\n\r\n\r\n\r\ny\r\n\r\n\r\n\r\n\r\n\r\nh\r\n\r\n\r\n\r\no\r\n\r\n\r\n\r\nl\r\n\r\n\r\n\r\ni\r\n\r\n\r\n\r\n........\r\n',7,'2015-08-04 06:08:58',7),(62,'TO work textarea in new lines then place the body part in <pre> tag',6,'2015-08-04 06:05:18',6),(63,'sdjkfhd',7,'2015-08-04 06:08:58',7),(64,'.',7,'2015-08-04 06:08:58',7),(65,',,,,',7,'2015-08-04 06:08:58',7),(66,'Now u can even change ur passwords tooo!',6,'2015-08-04 06:05:18',6),(67,'Now u can send friend requests',6,'2015-08-04 06:05:18',6),(68,'Confirm friend requests, or deny friend requests\r\n\r\nView sent friend requests,',6,'2015-08-04 06:05:18',6),(69,'Cancel Sent Friend Requests\r\n',6,'2015-08-04 06:05:18',6),(70,'Test\r\n\r\n\r\n\r\n',6,'2015-08-04 06:05:18',6),(71,'Now u can view ur friends list',6,'2015-08-04 06:05:18',6),(72,'Profile Photos for list have been enabled',6,'2015-08-04 06:05:18',6),(73,'To navigate to home page from any other page u can click on the Filtered Wall which is on the top right of the page',6,'2015-08-04 06:05:18',6),(74,'if the text hides on overflow set the CSS property white-space to \"nowrap\"',6,'2015-08-04 06:05:18',6),(75,'select * from friend',6,'2015-08-04 06:05:18',6),(76,'\" shutdown --;',6,'2015-08-04 06:05:18',6),(77,'hey',6,'2015-08-04 06:05:18',6),(78,'Now u can view ur friend suggestions!',6,'2015-08-04 06:05:18',6),(79,'Hello',6,'2015-08-04 06:05:18',6),(80,'Tuesday....',7,'2015-08-04 06:08:58',7),(81,'.',7,'2015-08-04 06:08:58',7),(82,'Hello Tuesday....',7,'2015-08-04 06:08:58',7),(83,'successfull upto this....',7,'2015-08-04 06:08:58',7),(84,'Feeling very happy that my brother has secured AIR 882 in GATE 2015!',11,'2015-08-04 06:09:18',11),(85,'Feeling very happy that my brother has secured AIR 882 in GATE 2015! Congrats Bro!',11,'2015-08-04 06:09:18',11),(86,'................................................................................................................................',11,'2015-08-04 06:09:18',11),(87,'.......................................................>>>>>>>>>>>>>>>>>>>>.........................>>>>>>>>>>>>>>>>>>>>>>>>>>>>...........>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>........>>>>>>>>>>>>>>>>>>>>>>>>>>>.......>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>',11,'2015-08-04 06:09:18',11),(88,'. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .',11,'2015-08-04 06:09:18',11),(89,'.',7,'2015-08-04 06:08:58',7),(90,'Hui',6,'2015-03-21 07:38:39',7),(91,'Hui',6,'2015-03-21 07:39:27',7),(92,'Hui',6,'2015-03-21 07:41:19',7),(93,'You can set your username now!',6,'2015-08-04 06:05:18',6),(94,'HEllo!!',6,'2015-03-27 06:54:49',7),(95,'hv ghfh',6,'2015-08-04 06:05:18',6),(96,'Hello \r\nHello\r\nHello\r\nHello\r\nHelloHello \r\nHello\r\nHello\r\nHello\r\nHelloHello \r\nHello\r\nHello\r\nHello\r\nHello\r\nHello \r\nHello\r\nHello\r\nHello\r\nHello',6,'2015-08-04 06:02:17',6),(97,'Hi Sudeep! How are you!',14,'2015-03-29 13:48:14',6),(98,'Hi...',6,'2015-04-10 15:55:16',7),(99,'Hidi',6,'2015-08-04 06:01:24',6),(100,'Abdul Kalam expired!',6,'2015-08-04 06:00:58',6),(101,'Hurayyyy',6,'2015-08-04 06:01:03',6),(102,'Heeee',6,'2015-08-04 06:01:05',6),(103,'Up',6,'2015-08-04 06:01:08',6),(104,'egg mrng!!',6,'2015-08-04 06:01:12',6),(105,'Hi....',6,'2015-08-04 05:58:23',14);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-20 11:58:17
