-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: pcatdb2
-- ------------------------------------------------------
-- Server version	5.5.37-0ubuntu0.12.04.1

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
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `email` varchar(75) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_6340c63c` (`user_id`),
  CONSTRAINT `user_id_refs_id_4aacde5e` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
INSERT INTO `account_emailaddress` VALUES (5,6,'apardes1@binghamton.edu',1,1),(6,7,'aaronpardes@gmail.com',0,1),(7,1,'haye123@gmail.com',0,0),(8,8,'dipannaik@gmail.com',1,1),(9,9,'test@pcat.com',1,1),(10,10,'test@test.com',1,1),(11,12,'test1@test.com',1,1),(12,13,'test2@test.com',1,1);
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email_address_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `sent` datetime DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirmation_a659cab3` (`email_address_id`),
  CONSTRAINT `email_address_id_refs_id_6ea1eea3` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
INSERT INTO `account_emailconfirmation` VALUES (12,5,'2014-06-12 00:19:23','2014-06-12 00:19:28','c27b4410abf30f6aa52eef77895ef57e19d516e52b22969e4e6f713113187d06'),(13,6,'2014-06-12 00:46:08','2014-06-12 00:46:12','93d9155f5379599b78aefb472ee1faa755868a7d1a1e33518840b459ddc62ba4'),(14,7,'2014-07-09 19:22:41','2014-07-09 19:22:45','f4581e484e5e955bfdb44848bb41a41f0082a50bd2862a70c9cdcb8282267ee2');
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add student',7,'add_student'),(20,'Can change student',7,'change_student'),(21,'Can delete student',7,'delete_student'),(22,'Can add ranked',8,'add_ranked'),(23,'Can change ranked',8,'change_ranked'),(24,'Can delete ranked',8,'delete_ranked'),(25,'Can add unranked',9,'add_unranked'),(26,'Can change unranked',9,'change_unranked'),(27,'Can delete unranked',9,'delete_unranked'),(28,'Can add migration history',10,'add_migrationhistory'),(29,'Can change migration history',10,'change_migrationhistory'),(30,'Can delete migration history',10,'delete_migrationhistory'),(31,'Can add site',11,'add_site'),(32,'Can change site',11,'change_site'),(33,'Can delete site',11,'delete_site'),(34,'Can add email address',12,'add_emailaddress'),(35,'Can change email address',12,'change_emailaddress'),(36,'Can delete email address',12,'delete_emailaddress'),(37,'Can add email confirmation',13,'add_emailconfirmation'),(38,'Can change email confirmation',13,'change_emailconfirmation'),(39,'Can delete email confirmation',13,'delete_emailconfirmation'),(40,'Can add social app',14,'add_socialapp'),(41,'Can change social app',14,'change_socialapp'),(42,'Can delete social app',14,'delete_socialapp'),(43,'Can add social account',15,'add_socialaccount'),(44,'Can change social account',15,'change_socialaccount'),(45,'Can delete social account',15,'delete_socialaccount'),(46,'Can add social token',16,'add_socialtoken'),(47,'Can change social token',16,'change_socialtoken'),(48,'Can delete social token',16,'delete_socialtoken'),(49,'Can add api access',17,'add_apiaccess'),(50,'Can change api access',17,'change_apiaccess'),(51,'Can delete api access',17,'delete_apiaccess'),(52,'Can add api key',18,'add_apikey'),(53,'Can change api key',18,'change_apikey'),(54,'Can delete api key',18,'delete_apikey');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$AL0WpTMhmTS9$lxoABmtLUKsgxtYgC0zGUWZDML9LliDKIQBHhMkE0sg=','2014-08-25 19:08:56',1,'aaronpardes','','','haye123@gmail.com',1,1,'2014-05-11 03:59:21'),(6,'pbkdf2_sha256$12000$KdyyurNOiwjs$O9HtMNZO9J+eJL/V+J+CYoYyecEDGhEb5lDdgjh+j0o=','2014-07-11 16:04:21',0,'apardes1','','','apardes1@binghamton.edu',0,1,'2014-06-12 00:19:23'),(7,'pbkdf2_sha256$12000$60jvfT7JnISO$BYTCN9yTNGV6ODMFB0k/QZoNNVfdwsOiAC3WbwO2uLs=','2014-06-12 00:46:08',0,'aaronpardes2','','','aaronpardes@gmail.com',0,1,'2014-06-12 00:46:08'),(8,'pbkdf2_sha256$12000$A10aRJmVoI9C$FUP650plnaynX1lJxRVt6NN7VWzwkYTUuIDh83EtOUI=','2014-09-10 19:10:19',0,'dipannaik@gmail.com','','','dipannaik@gmail.com',0,1,'2014-08-12 22:49:01'),(9,'pbkdf2_sha256$12000$GwLyAf5fueFQ$+a+6fsdi7uzQm00jaPVzXfE84Wgxa4uiTyJ0AWjYokM=','2014-08-28 14:01:26',0,'test@pcat.com','','','test@pcat.com',0,1,'2014-08-13 17:58:33'),(10,'pbkdf2_sha256$12000$j7liAfIvPL24$/hUU+7yXtOjG3iLXy2oPUR24w/pYfSPs/IDcV9bpQ0Q=','2014-08-20 19:30:53',0,'test@test.com','','','test@test.com',0,1,'2014-08-20 18:17:36'),(12,'pbkdf2_sha256$12000$pQvwnwGlX7DM$HNI/XopZ9wt0ND4TzpUJavBeEl8MbTW08MwHmEqy0sc=','2014-08-20 18:19:01',0,'test1@test.com','','','test1@test.com',0,1,'2014-08-20 18:19:01'),(13,'pbkdf2_sha256$12000$tgMcxqt8QFvN$K4JHdqe65hD91TNaNYmgpKOWO6HkwFnIGn+rLGYb/xM=','2014-08-20 18:29:18',0,'test2@test.com','','','test2@test.com',0,1,'2014-08-20 18:29:06');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-05-11 04:06:01',1,8,'1','University of California, San Francisco',1,''),(2,'2014-05-11 04:06:53',1,8,'2','University of North Carolina, Chapel Hill',1,''),(3,'2014-05-11 04:13:52',1,8,'3','University of Minnesota',1,''),(4,'2014-05-11 04:15:23',1,8,'4','University of Texas, Austin',1,''),(5,'2014-05-11 04:17:14',1,8,'5','University of Kentucky',1,''),(6,'2014-05-11 04:20:18',1,8,'6','University of Wisconsin, Madison',1,''),(7,'2014-05-11 04:23:27',1,8,'7','Ohio State University',1,''),(8,'2014-05-11 04:24:56',1,8,'8','Purdue University',1,''),(9,'2014-05-11 04:28:22',1,8,'9','University of Michigan, Ann Arbor',1,''),(10,'2014-05-11 04:30:15',1,8,'10','University of Arizona',1,''),(11,'2014-05-11 04:54:53',1,8,'11','University of Southern California',1,''),(12,'2014-05-11 04:56:28',1,8,'12','University of Utah',1,''),(13,'2014-05-11 04:58:51',1,8,'13','University of Washington',1,''),(14,'2014-05-11 15:37:53',1,8,'14','University of Florida',1,''),(15,'2014-05-11 15:39:33',1,8,'15','University of Illinois, Chicago',1,''),(16,'2014-05-11 15:40:48',1,8,'16','University of Pittsburgh',1,''),(17,'2014-05-11 15:42:03',1,8,'17','University at Buffalo (SUNY)',1,''),(18,'2014-05-11 15:43:17',1,8,'18','University of Iowa',1,''),(19,'2014-05-11 15:48:19',1,8,'19','University of Maryland, Baltimore ',1,''),(20,'2014-05-11 15:50:13',1,8,'20','University of Tennessee Health Science Center ',1,''),(21,'2014-05-11 15:51:46',1,8,'21','University of Kansas',1,''),(22,'2014-05-11 15:53:02',1,8,'22','Virginia Commonwealth University',1,''),(23,'2014-05-11 15:54:12',1,8,'23','University of California, San Diego',1,''),(24,'2014-05-11 15:55:36',1,8,'24','University of Colorado, Denver',1,''),(25,'2014-05-11 15:57:11',1,8,'25','University of Mississippi',1,''),(26,'2014-05-11 15:58:48',1,8,'26','Auburn University (Harrison)',1,''),(27,'2014-05-11 16:00:01',1,8,'27','Medical University of South Carolina',1,''),(28,'2014-05-11 16:01:44',1,8,'28','Rutgers, the State University of New Jersey, New Brunswick',1,''),(29,'2014-05-11 16:03:46',1,8,'29','University of Connecticut',1,''),(30,'2014-05-11 16:04:41',1,8,'30','University of Georgia',1,''),(31,'2014-05-11 16:05:57',1,8,'31','West Virginia University',1,''),(32,'2014-05-11 16:07:14',1,8,'32','Texas Tech University Health Sciences Center',1,''),(33,'2014-05-11 16:08:17',1,8,'33','University of Arkansas for Medical Sciences',1,''),(34,'2014-05-11 16:09:31',1,8,'34','University of Cincinnati',1,''),(35,'2014-05-11 17:18:00',1,8,'35','St. Louis College of Pharmacy',1,''),(36,'2014-05-11 17:23:25',1,8,'36','University of Puerto Rico Medical Sciences Campus',1,''),(37,'2014-05-11 19:09:47',1,9,'1','Howard University College of Pharmacy',1,''),(38,'2014-05-11 19:21:57',1,9,'43','Western New England University College of Pharmacy',2,'No fields changed.'),(39,'2014-05-11 19:22:09',1,9,'43','Western New England University College of Pharmacy',2,'No fields changed.'),(40,'2014-05-11 19:33:02',1,8,'60','Massachusetts College of Pharmacy and Health Sciences--Boston',2,'Changed zip_code.'),(41,'2014-05-11 19:33:25',1,8,'79','Massachusetts College of Pharmacy and Health Sciences--Worcester',2,'Changed zip_code.'),(42,'2014-05-11 19:33:35',1,8,'48','University of Rhode Island',2,'Changed zip_code.'),(43,'2014-05-11 19:34:04',1,8,'41','Northeastern University',2,'Changed zip_code.'),(44,'2014-05-11 19:34:17',1,8,'28','Rutgers, the State University of New Jersey, New Brunswick',2,'Changed zip_code.'),(45,'2014-05-11 19:34:29',1,8,'36','University of Puerto Rico Medical Sciences Campus',2,'Changed zip_code.'),(46,'2014-05-11 19:34:42',1,8,'29','University of Connecticut',2,'Changed zip_code.'),(47,'2014-05-11 19:35:22',1,9,'43','Western New England University College of Pharmacy',2,'Changed zip_code.'),(48,'2014-05-11 19:35:30',1,9,'42','University of St. Joseph School of Pharmacy',2,'Changed zip_code.'),(49,'2014-05-11 19:35:36',1,9,'40','University of New England College of Pharmacy',2,'Changed zip_code.'),(50,'2014-05-11 19:38:25',1,9,'13','Husson University School of Pharmacy',2,'Changed zip_code.'),(51,'2014-05-11 19:38:35',1,9,'10','Fairleigh Dickinson University School of Pharmacy',2,'Changed zip_code.'),(52,'2014-05-11 22:22:55',1,8,'1','University of California, San Francisco',2,'Changed gpa_expected and min_pcat.'),(53,'2014-05-11 22:23:09',1,8,'8','Purdue University',2,'Changed min_pcat.'),(54,'2014-05-11 22:23:17',1,8,'11','University of Southern California',2,'Changed min_pcat.'),(55,'2014-05-11 22:23:31',1,8,'23','University of California, San Diego',2,'Changed min_pcat.'),(56,'2014-05-11 22:23:50',1,8,'30','University of Georgia',2,'Changed gpa_overall and gpa_expected.'),(57,'2014-05-11 22:24:00',1,8,'28','Rutgers, the State University of New Jersey, New Brunswick',2,'Changed min_pcat.'),(58,'2014-05-12 04:59:33',1,8,'34','University of Cincinnati',2,'Changed city.'),(59,'2014-05-13 23:00:09',1,8,'36','University of Puerto Rico Medical Sciences Campus',2,'Changed lat and lon.'),(60,'2014-05-13 23:01:31',1,9,'1','Howard University College of Pharmacy',2,'Changed lat and lon.'),(61,'2014-05-14 20:03:20',1,11,'1','PCATapp',2,'Changed domain and name.'),(62,'2014-05-14 20:04:38',1,11,'1','1',2,'Changed domain and name.'),(63,'2014-06-05 14:57:15',1,9,'44','University of North Texas System College of Pharmacy',2,'Changed gpa_expected.'),(64,'2014-06-05 14:57:26',1,9,'23','PCOM School of Pharmacy--Georgia',2,'Changed gpa_expected.'),(65,'2014-06-05 14:57:36',1,9,'21','Pacific University School of Pharmacy',2,'Changed gpa_expected.'),(66,'2014-06-05 14:57:50',1,9,'19','Marshall University School of Pharmacy',2,'Changed gpa_overall and gpa_expected.'),(67,'2014-06-05 15:04:40',1,9,'11','Hampton University School of Pharmacy',2,'Changed gpa_expected.'),(68,'2014-06-10 21:19:37',1,7,'1','Student object',1,''),(69,'2014-06-10 22:43:35',1,4,'2','apardes1',3,''),(70,'2014-06-10 23:11:35',1,4,'3','apardes1',3,''),(71,'2014-06-11 02:04:27',1,4,'4','apardes1',3,''),(72,'2014-06-12 00:18:59',1,4,'5','apardes1',3,''),(73,'2014-06-12 00:43:26',1,11,'1','127.0.0.1:8000',2,'Changed domain.'),(74,'2014-06-16 15:45:41',1,9,'5','Cedarville University School of Pharmacy',2,'Changed full_accred and cand_accred.'),(75,'2014-06-16 15:46:00',1,9,'7','Concordia University',2,'Changed full_accred and cand_accred.'),(76,'2014-06-16 15:46:31',1,9,'8','D\'Youville College School of Pharmacy',2,'Changed full_accred and cand_accred.'),(77,'2014-06-16 15:46:49',1,9,'10','Fairleigh Dickinson University School of Pharmacy',2,'Changed full_accred and cand_accred.'),(78,'2014-06-16 15:47:09',1,9,'13','Husson University School of Pharmacy',2,'Changed full_accred and cand_accred.'),(79,'2014-06-16 15:47:27',1,9,'19','Marshall University School of Pharmacy',2,'Changed full_accred and cand_accred.'),(80,'2014-06-16 15:47:35',1,9,'19','Marshall University School of Pharmacy',2,'No fields changed.'),(81,'2014-06-16 15:47:42',1,9,'18','Manchester University College of Pharmacy',2,'Changed full_accred and cand_accred.'),(82,'2014-06-16 15:48:10',1,9,'23','PCOM School of Pharmacy--Georgia',2,'Changed full_accred and cand_accred.'),(83,'2014-06-16 15:48:16',1,9,'24','Presbyterian College School of Pharmacy',2,'Changed full_accred and cand_accred.'),(84,'2014-06-16 15:48:32',1,9,'27','Rosalind Franklin University of Medicine and Sciences',2,'Changed full_accred and cand_accred.'),(85,'2014-06-16 15:48:37',1,9,'26','Roosevelt University',2,'Changed full_accred and cand_accred.'),(86,'2014-06-16 15:48:55',1,9,'29','South College School of Pharmacy',2,'Changed full_accred and cand_accred.'),(87,'2014-06-16 15:49:11',1,9,'41','University of South Florida',2,'Changed full_accred and cand_accred.'),(88,'2014-06-16 15:49:31',1,9,'42','University of St. Joseph School of Pharmacy',2,'Changed full_accred and cand_accred.'),(89,'2014-06-16 15:49:41',1,9,'43','Western New England University College of Pharmacy',2,'Changed full_accred and cand_accred.'),(90,'2014-06-16 15:49:55',1,9,'44','University of North Texas System College of Pharmacy',2,'Changed full_accred and prec_accred.'),(91,'2014-06-20 21:10:10',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed name.'),(92,'2014-06-20 21:10:23',1,8,'2','University of North Carolina Eshelman School of Pharmacy',2,'Changed name.'),(93,'2014-06-20 21:10:43',1,8,'3','University of Minnesota College of Pharmacy',2,'Changed name.'),(94,'2014-06-20 21:11:16',1,8,'4','University of Texas College of Pharmacy',2,'Changed name.'),(95,'2014-06-20 21:11:29',1,8,'6','University of Wisconsin School of Pharmacy',2,'Changed name.'),(96,'2014-06-20 21:11:44',1,8,'5','University of Kentucky College of Pharmacy',2,'Changed name.'),(97,'2014-06-20 21:12:10',1,8,'9','University of Michigan College of Pharmacy',2,'Changed name.'),(98,'2014-06-20 21:12:25',1,8,'8','Purdue University College of Pharmacy',2,'Changed name.'),(99,'2014-06-20 21:12:37',1,8,'7','Ohio State UniversityOhio State University College of Pharmacy',2,'Changed name.'),(100,'2014-06-20 21:13:02',1,8,'13','University of Washington School of Pharmacy',2,'Changed name.'),(101,'2014-06-20 21:13:16',1,8,'12','University of Utah College of Pharmacy',2,'Changed name.'),(102,'2014-06-20 21:13:51',1,8,'11','University of Southern California School of Pharmacy John Stauffer Pharmaceutical Sciences Center',2,'Changed name.'),(103,'2014-06-20 21:14:03',1,8,'10','University of Arizona College of Pharmacy',2,'Changed name.'),(104,'2014-06-20 21:20:54',1,8,'16','University of Pittsburgh School of Pharmacy',2,'Changed name.'),(105,'2014-06-20 21:21:08',1,8,'15','University of Illinois--Chicago College of Pharmacy',2,'Changed name.'),(106,'2014-06-20 21:27:34',1,8,'14','University of Florida College of Pharmacy',2,'Changed name.'),(107,'2014-06-20 21:28:32',1,8,'20','University of Tennessee Health Science Center College of Pharmacy',2,'Changed name.'),(108,'2014-06-20 21:28:44',1,8,'19','University of Maryland School of Pharmacy',2,'Changed name.'),(109,'2014-06-20 21:28:56',1,8,'18','University of Iowa College of Pharmacy',2,'Changed name.'),(110,'2014-06-20 21:29:11',1,8,'17','University at Buffalo--SUNY School of Pharmacy and Pharmaceutical Sciences',2,'Changed name.'),(111,'2014-06-20 21:30:01',1,8,'22','Virginia Commonwealth University School of Pharmacy',2,'Changed name.'),(112,'2014-06-20 21:30:15',1,8,'21','University of KansasUniversity of Kansas School of Pharmacy',2,'Changed name.'),(113,'2014-06-20 21:30:34',1,8,'21','University of Kansas School of Pharmacy',2,'Changed name.'),(114,'2014-06-20 21:30:48',1,8,'23','University of California--San Diego Skaggs School of Pharmacy and Pharmaceutical Sciences',2,'Changed name.'),(115,'2014-06-20 21:31:13',1,8,'25','University of Mississippi School of Pharmacy',2,'Changed name.'),(116,'2014-06-20 21:34:43',1,8,'24','University of Colorado School of Pharmacy',2,'Changed name.'),(117,'2014-06-20 21:34:58',1,8,'31','West Virginia University School of Pharmacy',2,'Changed name.'),(118,'2014-06-20 21:35:09',1,8,'30','University of Georgia College of Pharmacy',2,'Changed name.'),(119,'2014-06-20 21:35:28',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed name.'),(120,'2014-06-20 21:35:50',1,8,'28','Rutgers University Ernest Mario School of Pharmacy',2,'Changed name.'),(121,'2014-06-20 21:36:52',1,8,'27','Medical University of South Carolina',2,'No fields changed.'),(122,'2014-06-20 21:37:11',1,8,'26','Auburn University Harrison School of Pharmacy',2,'Changed name.'),(123,'2014-06-20 21:38:30',1,8,'38','University of Oklahoma College of Pharmacy',2,'Changed name.'),(124,'2014-06-20 21:39:05',1,8,'39','Creighton University School of Pharmacy and Health Professions',2,'Changed name.'),(125,'2014-06-20 21:40:04',1,8,'37','University of Nebraska Medical Center College of Pharmacy',2,'Changed name.'),(126,'2014-06-20 21:40:21',1,8,'34','University of Cincinnati The James L. Winkle College of Pharmacy',2,'Changed name.'),(127,'2014-06-20 21:41:00',1,8,'33','University of Arkansas for Medical Sciences College of Pharmacy',2,'Changed name.'),(128,'2014-06-20 21:41:10',1,8,'32','Texas Tech University Health Sciences Center School of Pharmacy',2,'Changed name.'),(129,'2014-06-20 21:41:35',1,8,'40','University of Missouri--Kansas City School of Pharmacy',2,'Changed name.'),(130,'2014-06-20 22:05:39',1,8,'44','Wayne State University Eugene Applebaum College of Pharmacy and Health Sciences',2,'Changed name.'),(131,'2014-06-20 22:05:54',1,8,'43','Washington State University College of Pharmacy',2,'Changed name.'),(132,'2014-06-20 22:06:22',1,8,'42','Oregon State University College of Pharmacy',2,'Changed name.'),(133,'2014-06-20 22:06:34',1,8,'41','Northeastern University School of Pharmacy',2,'Changed name.'),(134,'2014-06-20 22:09:38',1,8,'48','University of Rhode Island College of Pharmacy',2,'Changed name.'),(135,'2014-06-20 22:09:52',1,8,'47','University of the Sciences in Philadelphia College of Pharmacy',2,'Changed name.'),(136,'2014-06-20 22:10:05',1,8,'46','Mercer University College of Pharmacy',2,'Changed name.'),(137,'2014-06-20 22:10:19',1,8,'35','St. Louis College of Pharmacy',2,'No fields changed.'),(138,'2014-06-20 22:10:35',1,8,'45','Drake University College of Pharmacy & Health Sciences',2,'Changed name.'),(139,'2014-06-20 22:11:02',1,8,'56','University of the Pacific Thomas J. Long School of Pharmacy and Health Sciences',2,'Changed name.'),(140,'2014-06-20 22:11:26',1,8,'55','University of New Mexico Health Sciences Center College of Pharmacy',2,'Changed name.'),(141,'2014-06-20 22:13:09',1,8,'54','University of Montana Skaggs School of Pharmacy',2,'Changed name.'),(142,'2014-06-20 22:13:24',1,8,'53','University of Houston College of Pharmacy',2,'Changed name.'),(143,'2014-06-20 22:14:50',1,8,'52','Texas A&M Health Science Center Irma Rangel College of Pharmacy',2,'Changed name.'),(144,'2014-06-20 22:15:03',1,8,'51','South Carolina College of Pharmacy',2,'No fields changed.'),(145,'2014-06-20 22:15:15',1,8,'50','Duquesne University Mylan School of Pharmacy',2,'Changed name.'),(146,'2014-06-20 22:16:03',1,8,'58','Univerisity of Wyoming School of Pharmacy',2,'Changed name.'),(147,'2014-06-20 22:16:22',1,8,'57','Campbell University College of Pharmacy and Health Sciences',2,'Changed name.'),(148,'2014-06-20 22:16:38',1,8,'62','Temple University School of Pharmacy',2,'Changed name.'),(149,'2014-06-20 22:16:50',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed name.'),(150,'2014-06-20 22:17:29',1,8,'69','University of Toledo College of Pharmacy',2,'Changed name.'),(151,'2014-06-20 22:17:50',1,8,'68','St. John\'s University College of Pharmacy and Allied Health Professions',2,'Changed name.'),(152,'2014-06-20 22:18:07',1,8,'67','Southern Illinois University Edwardsville  School of Pharmacy',2,'Changed name.'),(153,'2014-06-20 22:18:25',1,8,'66','South Dakota State University College of Pharmacy',2,'Changed name.'),(154,'2014-06-20 22:18:51',1,8,'65','Samford University  McWhorter School of Pharmacy',2,'Changed name.'),(155,'2014-06-20 22:19:04',1,8,'64','Idaho State University College of Pharmacy',2,'Changed name.'),(156,'2014-06-20 22:19:17',1,8,'63','Ferris State University College of Pharmacy',2,'Changed name.'),(157,'2014-06-20 22:19:37',1,8,'71','Ohio Northern University College of Pharmacy',2,'Changed name.'),(158,'2014-06-20 22:20:09',1,8,'74','Western University of Health Sciences College of Pharmacy',2,'Changed name.'),(159,'2014-06-20 22:20:22',1,8,'73','Shenandoah University  School of Pharmacy',2,'Changed name.'),(160,'2014-06-20 22:20:39',1,8,'72','Northeast Ohio Medical University College of Pharmacy (NEOMED)  College of Pharmacy',2,'Changed name.'),(161,'2014-06-20 22:20:57',1,8,'77','Wilkes University  Nesbitt School of Pharmacy',2,'Changed name.'),(162,'2014-06-20 22:21:10',1,8,'76','The University of Louisiana at Monroe  College of Pharmacy',2,'Changed name.'),(163,'2014-06-20 22:21:33',1,8,'75','University of Hawaii--Hilo College of Pharmacy',2,'Changed name.'),(164,'2014-06-20 22:22:11',1,8,'78','Long Island University Arnold & Marie Schwartz College of Pharmacy and Health Sciences',2,'Changed name.'),(165,'2014-06-20 22:22:21',1,8,'87','Xavier University of Louisiana College of Pharmacy',2,'Changed name.'),(166,'2014-06-20 22:22:31',1,8,'86','Wingate University School of Pharmacy',2,'Changed name.'),(167,'2014-06-20 22:22:52',1,8,'85','University of the Incarnate Word Feik School of Pharmacy',2,'Changed name.'),(168,'2014-06-20 22:23:08',1,8,'83','Texas Southern University College of Pharmacy and Health Sciences',2,'Changed name.'),(169,'2014-06-20 22:23:23',1,8,'82','Nova Southeastern University College of Pharmacy',2,'Changed name.'),(170,'2014-06-20 22:23:30',1,8,'81','Florida A&M University College of Pharmacy',2,'Changed name.'),(171,'2014-06-20 22:23:52',1,8,'36','University of Puerto Rico Medical Sciences Campus',2,'No fields changed.'),(172,'2014-06-20 22:30:59',1,8,'65','Samford University McWhorter School of Pharmacy',2,'Changed name.'),(173,'2014-06-20 22:33:55',1,8,'67','Southern Illinois University Edwardsville School of Pharmacy',2,'Changed name.'),(174,'2014-06-20 22:34:27',1,8,'72','Northeast Ohio Medical University College of Pharmacy (NEOMED) College of Pharmacy',2,'Changed name.'),(175,'2014-06-20 22:35:47',1,8,'73','Shenandoah University School of Pharmacy',2,'Changed name.'),(176,'2014-06-20 23:41:25',1,8,'73','Shenandoah UniversitySchool of Pharmacy',2,'Changed name.'),(177,'2014-06-20 23:41:42',1,8,'76','The University of Louisiana at Monroe College of Pharmacy',2,'Changed name.'),(178,'2014-06-20 23:42:57',1,8,'86','Wingate University School of Pharmacy',2,'Changed name.'),(179,'2014-06-20 23:43:57',1,8,'73','Shenandoah University School of Pharmacy',2,'Changed name.'),(180,'2014-06-20 23:46:22',1,9,'3','Belmont University College of Pharmacy',2,'Changed name.'),(181,'2014-06-20 23:46:41',1,9,'6','Chicago State University College of Pharmacy',2,'Changed name.'),(182,'2014-06-20 23:46:52',1,9,'7','Concordia University School of Pharmacy',2,'Changed name.'),(183,'2014-06-20 23:47:13',1,9,'9','East Tennessee State University Bill Gatton College of Pharmacy',2,'Changed name.'),(184,'2014-06-20 23:48:48',1,9,'22','Palm Beach Atlantic University (Gregory) Lloyd L. Gregory School of Pharmacy',2,'Changed name.'),(185,'2014-06-20 23:49:24',1,9,'25','Regis University School of Pharmacy  Rueckert - Hartman College for Health Professions',2,'Changed name.'),(186,'2014-06-20 23:49:33',1,9,'26','Roosevelt University College of Pharmacy',2,'Changed name.'),(187,'2014-06-20 23:50:04',1,9,'28','Roseman University of Health Sciences College of Pharmacy',2,'Changed name.'),(188,'2014-06-20 23:50:32',1,9,'30','South University School of Pharmacy',2,'Changed name.'),(189,'2014-06-20 23:52:10',1,9,'31','Southwestern Oklahoma State University School of Pharmacy',2,'Changed name.'),(190,'2014-06-20 23:52:34',1,9,'32','St. John Fisher College Wegmans School of Pharmacy',2,'Changed name.'),(191,'2014-06-20 23:52:58',1,9,'34','Thomas Jefferson University Jefferson School of Pharmacy',2,'Changed name.'),(192,'2014-06-20 23:53:37',1,9,'35','Touro College of Pharmacy - New York  College of Pharmacy',2,'Changed name.'),(193,'2014-06-20 23:53:53',1,9,'36','Union University School of Pharmacy',2,'Changed name.'),(194,'2014-06-20 23:54:44',1,9,'41','University of South Florida School of Pharmacy',2,'Changed name.'),(195,'2014-06-20 23:57:46',1,9,'25','Regis University School of Pharmacy Rueckert - Hartman College for Health Professions',2,'Changed name.'),(196,'2014-06-20 23:59:34',1,9,'25','Regis University School of Pharmacy Rueckert - Hartman College for Health Professions',2,'Changed name.'),(197,'2014-06-23 19:06:42',1,8,'7','Ohio State University College of Pharmacy',2,'Changed name.'),(198,'2014-06-23 19:11:43',1,8,'72','Northeast Ohio Medical University College of Pharmacy (NEOMED)',2,'Changed name.'),(199,'2014-06-23 19:13:47',1,8,'36','University of Puerto Rico--Medical Sciences Campus',2,'Changed name.'),(200,'2014-06-23 19:18:01',1,9,'25','Regis University School of Pharmacy Rueckert-Hartman College for Health Professions',2,'Changed name.'),(201,'2014-06-23 19:18:29',1,9,'27','Rosalind Franklin University of Medicine and Sciences College of Pharmacy',2,'Changed name.'),(202,'2014-06-23 19:19:35',1,9,'35','Touro College of Pharmacy - New York College of Pharmacy',2,'Changed name.'),(203,'2014-06-23 19:21:18',1,8,'68','St. John\'s University College of Pharmacy and Allied Health Professions',2,'No fields changed.'),(204,'2014-06-23 19:21:42',1,8,'77','Wilkes University Nesbitt School of Pharmacy',2,'Changed name.'),(205,'2014-06-23 19:23:20',1,8,'68','St. John\'s University College of Pharmacy and Allied Health Professions',2,'No fields changed.'),(206,'2014-06-23 19:31:54',1,8,'68','St. John\'s University College of Pharmacy and Allied Health Professions',2,'Changed street, school_url, email and phone.'),(207,'2014-06-23 19:38:57',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed street, school_url, email and phone.'),(208,'2014-06-23 19:40:20',1,8,'2','University of North Carolina Eshelman School of Pharmacy',2,'Changed street, school_url, email and phone.'),(209,'2014-06-23 19:42:30',1,8,'3','University of Minnesota College of Pharmacy',2,'Changed street, school_url, email and phone.'),(210,'2014-06-23 21:40:18',1,8,'4','University of Texas College of Pharmacy',2,'Changed street.'),(211,'2014-06-23 21:40:35',1,8,'5','University of Kentucky College of Pharmacy',2,'Changed street.'),(212,'2014-06-25 16:44:32',1,8,'13','University of Washington School of Pharmacy',2,'Changed min_pcat and school_url.'),(213,'2014-06-25 16:45:40',1,8,'13','University of Washington School of Pharmacy',2,'Changed school_url.'),(214,'2014-06-25 16:46:40',1,8,'76','The University of Louisiana at Monroe College of Pharmacy',2,'Changed min_pcat.'),(215,'2014-06-25 16:47:02',1,8,'83','Texas Southern University College of Pharmacy and Health Sciences',2,'Changed min_pcat.'),(216,'2014-06-25 16:47:26',1,9,'32','St. John Fisher College Wegmans School of Pharmacy',2,'Changed min_pcat.'),(217,'2014-06-25 16:48:33',1,8,'48','University of Rhode Island College of Pharmacy',2,'Changed regional_tuition.'),(218,'2014-06-25 16:48:54',1,8,'6','University of Wisconsin School of Pharmacy',2,'Changed regional_tuition.'),(219,'2014-06-25 16:49:21',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed regional_tuition.'),(220,'2014-06-25 16:49:36',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed regional_tuition.'),(221,'2014-06-25 16:50:30',1,8,'66','South Dakota State University College of Pharmacy',2,'Changed regional_tuition.'),(222,'2014-07-09 18:51:04',1,8,'66','South Dakota State University College of Pharmacy',2,'Changed regional_tuition.'),(223,'2014-07-09 18:51:14',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed regional_tuition.'),(224,'2014-07-09 18:51:28',1,8,'48','University of Rhode Island College of Pharmacy',2,'Changed regional_tuition.'),(225,'2014-07-09 18:51:39',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed regional_tuition.'),(226,'2014-07-09 18:51:47',1,8,'6','University of Wisconsin School of Pharmacy',2,'Changed regional_tuition.'),(227,'2014-07-09 19:13:56',1,8,'36','University of Puerto Rico--Medical Sciences Campus',2,'No fields changed.'),(228,'2014-07-09 19:14:40',1,8,'36','University of Puerto Rico--Medical Sciences Campus',2,'Changed rank.'),(229,'2014-07-09 19:15:19',1,8,'36','University of Puerto Rico--Medical Sciences Campus',2,'Changed rank.'),(230,'2014-07-09 19:59:55',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed gpa_expected and gpa_avg.'),(231,'2014-07-09 20:00:47',1,8,'32','Texas Tech University Health Sciences Center School of Pharmacy',2,'Changed gpa_expected.'),(232,'2014-07-09 20:02:24',1,9,'11','Hampton University School of Pharmacy',2,'Changed gpa_expected and gpa_avg.'),(233,'2014-07-09 20:02:54',1,9,'21','Pacific University School of Pharmacy',2,'Changed gpa_expected and gpa_avg.'),(234,'2014-07-09 20:03:28',1,9,'44','University of North Texas System College of Pharmacy',2,'Changed gpa_expected and gpa_avg.'),(235,'2014-07-10 20:07:52',1,8,'88','University of Puerto Rico - Medical Sciences Campus',1,''),(236,'2014-07-10 20:10:10',1,8,'88','University of Puerto Rico - Medical Sciences Campus',2,'No fields changed.'),(237,'2014-07-10 20:10:57',1,8,'36','University of Puerto Rico--Medical Sciences Campus',3,''),(238,'2014-07-10 21:05:47',1,8,'93','University of Puerto Rico - Medical Sciences Campus',2,'Changed supplemental, school_url and phone.'),(239,'2014-07-10 21:05:56',1,8,'93','University of Puerto Rico - Medical Sciences Campus',2,'No fields changed.'),(240,'2014-07-10 21:06:09',1,8,'92','University of Puerto Rico - Medical Sciences Campus',3,''),(241,'2014-07-10 21:06:09',1,8,'91','University of Puerto Rico - Medical Sciences Campus',3,''),(242,'2014-07-10 21:06:09',1,8,'90','University of Puerto Rico - Medical Sciences Campus',3,''),(243,'2014-07-10 21:06:09',1,8,'89','University of Puerto Rico - Medical Sciences Campus',3,''),(244,'2014-07-11 14:27:37',1,9,'23','PCOM School of Pharmacy--Georgia',2,'Changed gpa_expected and gpa_avg.'),(245,'2014-07-17 14:44:03',1,8,'66','South Dakota State University College of Pharmacy',2,'Changed regional_tuition and regional_bool.'),(246,'2014-07-17 14:44:14',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed regional_tuition and regional_bool.'),(247,'2014-07-17 14:44:24',1,8,'48','University of Rhode Island College of Pharmacy',2,'Changed regional_tuition and regional_bool.'),(248,'2014-07-17 14:44:38',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed regional_tuition and regional_bool.'),(249,'2014-07-17 14:44:49',1,8,'6','University of Wisconsin School of Pharmacy',2,'Changed regional_tuition and regional_bool.'),(250,'2014-07-17 14:47:11',1,9,'1','Howard University College of Pharmacy',3,''),(251,'2014-08-08 19:27:55',1,8,'94','St. Louis College of Pharmacy1',1,''),(252,'2014-08-08 19:34:53',1,8,'94','St. Louis College of Pharmacy1',2,'No fields changed.'),(253,'2014-08-08 19:39:10',1,8,'3','University of Minnesota College of Pharmacy',2,'Changed street and school_url.'),(254,'2014-08-08 19:43:09',1,8,'94','St. Louis College of Pharmacy1',3,''),(255,'2014-08-12 22:01:15',1,8,'28','Rutgers University Ernest Mario School of Pharmacy',2,'No fields changed.'),(256,'2014-08-12 22:01:35',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed regional_tuition.'),(257,'2014-08-13 17:26:46',1,8,'3','University of Minnesota College of Pharmacy',2,'Changed zip_code and phone.'),(258,'2014-08-13 18:40:02',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed regional_tuition.'),(259,'2014-08-13 19:02:23',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed street.'),(260,'2014-08-13 19:03:02',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed street.'),(261,'2014-08-13 19:06:16',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed regional_tuition and street.'),(262,'2014-08-13 19:09:00',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed street.'),(263,'2014-08-13 19:09:20',1,8,'3','University of Minnesota College of Pharmacy',2,'Changed street.'),(264,'2014-08-13 19:09:37',1,8,'43','Washington State University College of Pharmacy',2,'Changed street.'),(265,'2014-08-13 19:09:58',1,8,'18','University of Iowa College of Pharmacy',2,'Changed street.'),(266,'2014-08-13 19:10:35',1,8,'33','University of Arkansas for Medical Sciences College of Pharmacy',2,'Changed street.'),(267,'2014-08-13 19:11:04',1,8,'55','University of New Mexico Health Sciences Center College of Pharmacy',2,'Changed street.'),(268,'2014-08-13 19:11:24',1,8,'53','University of Houston College of Pharmacy',2,'Changed street.'),(269,'2014-08-13 19:11:55',1,8,'51','South Carolina College of Pharmacy',2,'Changed street.'),(270,'2014-08-13 19:12:23',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed street.'),(271,'2014-08-13 19:12:41',1,8,'66','South Dakota State University College of Pharmacy',2,'Changed street.'),(272,'2014-08-13 19:13:07',1,9,'22','Palm Beach Atlantic University (Gregory) Lloyd L. Gregory School of Pharmacy',2,'Changed street.'),(273,'2014-08-13 19:13:28',1,9,'34','Thomas Jefferson University Jefferson School of Pharmacy',2,'Changed street.'),(274,'2014-08-13 19:13:48',1,9,'36','Union University School of Pharmacy',2,'Changed street.'),(275,'2014-08-13 19:13:59',1,9,'41','University of South Florida School of Pharmacy',2,'Changed street.'),(276,'2014-08-13 19:18:30',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed regional_tuition.'),(277,'2014-08-13 20:28:06',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed regional_tuition.'),(278,'2014-08-14 21:11:03',1,8,'13','University of Washington School of Pharmacy',2,'Changed street.'),(279,'2014-08-15 04:54:35',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed street.'),(280,'2014-08-15 04:55:41',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed street.'),(281,'2014-08-15 05:07:14',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed zip_code.'),(282,'2014-08-15 05:08:12',1,8,'1','University of California San Francisco School of Pharmacy',2,'Changed zip_code.'),(283,'2014-08-15 05:09:12',1,8,'2','University of North Carolina Eshelman School of Pharmacy',2,'Changed zip_code and street.'),(284,'2014-08-15 05:22:58',1,8,'3','University of Minnesota College of Pharmacy',2,'No fields changed.'),(285,'2014-08-15 05:24:36',1,8,'4','University of Texas College of Pharmacy',2,'Changed zip_code.'),(286,'2014-08-15 05:26:38',1,8,'5','University of Kentucky College of Pharmacy',2,'Changed zip_code.'),(287,'2014-08-15 05:27:25',1,8,'6','University of Wisconsin School of Pharmacy',2,'Changed zip_code.'),(288,'2014-08-15 05:28:18',1,8,'7','Ohio State University College of Pharmacy',2,'Changed street.'),(289,'2014-08-15 05:29:59',1,8,'7','Ohio State University College of Pharmacy',2,'Changed zip_code.'),(290,'2014-08-15 05:32:44',1,8,'9','University of Michigan College of Pharmacy',2,'Changed zip_code and school_url.'),(291,'2014-08-15 05:35:16',1,8,'10','University of Arizona College of Pharmacy',2,'Changed zip_code and street.'),(292,'2014-08-15 05:37:23',1,8,'11','University of Southern California School of Pharmacy John Stauffer Pharmaceutical Sciences Center',2,'Changed zip_code and street.'),(293,'2014-08-15 05:40:34',1,8,'12','University of Utah College of Pharmacy',2,'Changed zip_code, street and school_url.'),(294,'2014-08-15 05:43:10',1,8,'13','University of Washington School of Pharmacy',2,'Changed zip_code and street.'),(295,'2014-08-15 05:48:47',1,8,'14','University of Florida College of Pharmacy',2,'Changed zip_code, street and school_url.'),(296,'2014-08-15 05:50:27',1,8,'15','University of Illinois--Chicago College of Pharmacy',2,'Changed zip_code.'),(297,'2014-08-15 05:52:46',1,8,'16','University of Pittsburgh School of Pharmacy',2,'Changed zip_code and street.'),(298,'2014-08-15 05:53:42',1,8,'17','University at Buffalo--SUNY School of Pharmacy and Pharmaceutical Sciences',2,'Changed zip_code.'),(299,'2014-08-15 05:54:45',1,8,'18','University of Iowa College of Pharmacy',2,'Changed zip_code.'),(300,'2014-08-15 05:58:40',1,8,'19','University of Maryland School of Pharmacy',2,'Changed street and school_url.'),(301,'2014-08-15 06:00:58',1,8,'20','University of Tennessee Health Science Center College of Pharmacy',2,'Changed zip_code and street.'),(302,'2014-08-15 06:01:59',1,8,'21','University of Kansas School of Pharmacy',2,'Changed zip_code.'),(303,'2014-08-15 06:04:03',1,8,'22','Virginia Commonwealth University School of Pharmacy',2,'Changed zip_code, street and school_url.'),(304,'2014-08-15 06:07:03',1,8,'23','University of California--San Diego Skaggs School of Pharmacy and Pharmaceutical Sciences',2,'Changed zip_code, street and school_url.'),(305,'2014-08-15 06:07:56',1,8,'24','University of Colorado School of Pharmacy',2,'Changed zip_code and street.'),(306,'2014-08-15 06:08:59',1,8,'25','University of Mississippi School of Pharmacy',2,'Changed street.'),(307,'2014-08-15 06:10:03',1,8,'26','Auburn University Harrison School of Pharmacy',2,'Changed zip_code.'),(308,'2014-08-15 06:11:46',1,8,'27','Medical University of South Carolina',2,'Changed zip_code and street.'),(309,'2014-08-15 06:14:17',1,8,'29','University of Connecticut School of Pharmacy',2,'Changed zip_code.'),(310,'2014-08-15 06:14:57',1,8,'30','University of Georgia College of Pharmacy',2,'Changed zip_code.'),(311,'2014-08-15 06:17:32',1,8,'31','West Virginia University School of Pharmacy',2,'Changed zip_code and street.'),(312,'2014-08-15 06:19:17',1,8,'32','Texas Tech University Health Sciences Center School of Pharmacy',2,'Changed zip_code and street.'),(313,'2014-08-15 06:24:06',1,8,'33','University of Arkansas for Medical Sciences College of Pharmacy',2,'Changed zip_code and street.'),(314,'2014-08-15 06:25:20',1,8,'34','University of Cincinnati The James L. Winkle College of Pharmacy',2,'Changed zip_code.'),(315,'2014-08-15 06:26:40',1,8,'35','St. Louis College of Pharmacy',2,'Changed zip_code.'),(316,'2014-08-15 06:29:07',1,8,'37','University of Nebraska Medical Center College of Pharmacy',2,'Changed zip_code.'),(317,'2014-08-15 06:30:02',1,8,'38','University of Oklahoma College of Pharmacy',2,'Changed zip_code.'),(318,'2014-08-15 14:28:08',1,8,'39','Creighton University School of Pharmacy and Health Professions',2,'Changed zip_code.'),(319,'2014-08-15 14:28:48',1,8,'40','University of Missouri--Kansas City School of Pharmacy',2,'Changed zip_code and street.'),(320,'2014-08-15 14:29:46',1,8,'41','Northeastern University School of Pharmacy',2,'Changed zip_code.'),(321,'2014-08-15 14:30:11',1,8,'42','Oregon State University College of Pharmacy',2,'Changed zip_code.'),(322,'2014-08-15 14:31:01',1,8,'43','Washington State University College of Pharmacy',2,'Changed zip_code.'),(323,'2014-08-15 14:32:05',1,8,'44','Wayne State University Eugene Applebaum College of Pharmacy and Health Sciences',2,'Changed street.'),(324,'2014-08-15 14:32:24',1,8,'45','Drake University College of Pharmacy & Health Sciences',2,'Changed zip_code.'),(325,'2014-08-15 14:32:50',1,8,'46','Mercer University College of Pharmacy',2,'Changed zip_code and street.'),(326,'2014-08-15 14:33:56',1,8,'47','University of the Sciences in Philadelphia College of Pharmacy',2,'Changed zip_code and street.'),(327,'2014-08-15 14:34:33',1,8,'48','University of Rhode Island College of Pharmacy',2,'No fields changed.'),(328,'2014-08-15 14:34:55',1,8,'49','Butler University',2,'Changed zip_code.'),(329,'2014-08-15 14:35:30',1,8,'50','Duquesne University Mylan School of Pharmacy',2,'Changed zip_code.'),(330,'2014-08-15 14:36:18',1,8,'51','South Carolina College of Pharmacy',2,'Changed zip_code and street.'),(331,'2014-08-15 14:37:04',1,8,'52','Texas A&M Health Science Center Irma Rangel College of Pharmacy',2,'Changed street and school_url.'),(332,'2014-08-15 14:38:04',1,8,'53','University of Houston College of Pharmacy',2,'Changed zip_code and street.'),(333,'2014-08-15 14:38:38',1,8,'54','University of Montana Skaggs School of Pharmacy',2,'Changed zip_code.'),(334,'2014-08-15 14:39:39',1,8,'55','University of New Mexico Health Sciences Center College of Pharmacy',2,'Changed zip_code and street.'),(335,'2014-08-15 14:40:08',1,8,'56','University of the Pacific Thomas J. Long School of Pharmacy and Health Sciences',2,'Changed zip_code.'),(336,'2014-08-15 14:44:01',1,8,'58','Univerisity of Wyoming School of Pharmacy',2,'Changed zip_code and street.'),(337,'2014-08-15 14:46:47',1,8,'59','Albany College of Pharmacy and Health Sciences',2,'Changed zip_code.'),(338,'2014-08-15 14:47:05',1,8,'60','Massachusetts College of Pharmacy and Health Sciences--Boston',2,'Changed zip_code.'),(339,'2014-08-15 14:48:41',1,8,'61','North Dakota State University College of Pharmacy',2,'Changed zip_code.'),(340,'2014-08-15 14:49:10',1,8,'62','Temple University School of Pharmacy',2,'Changed zip_code.'),(341,'2014-08-15 14:49:51',1,8,'64','Idaho State University College of Pharmacy',2,'Changed zip_code and street.'),(342,'2014-08-15 14:50:34',1,8,'65','Samford University McWhorter School of Pharmacy',2,'Changed zip_code.'),(343,'2014-08-15 14:55:12',1,8,'66','South Dakota State University College of Pharmacy',2,'Changed zip_code.'),(344,'2014-08-15 14:55:55',1,8,'67','Southern Illinois University Edwardsville School of Pharmacy',2,'Changed street.'),(345,'2014-08-15 14:56:32',1,8,'68','St. John\'s University College of Pharmacy and Allied Health Professions',2,'Changed zip_code.'),(346,'2014-08-15 14:56:54',1,8,'69','University of Toledo College of Pharmacy',2,'Changed zip_code and street.'),(347,'2014-08-15 15:14:46',1,8,'71','Ohio Northern University College of Pharmacy',2,'Changed zip_code.'),(348,'2014-08-15 15:15:22',1,8,'72','Northeast Ohio Medical University College of Pharmacy (NEOMED)',2,'Changed street.'),(349,'2014-08-15 15:18:04',1,8,'74','Western University of Health Sciences College of Pharmacy',2,'Changed city, state and zip_code.'),(350,'2014-08-15 15:18:55',1,8,'77','Wilkes University Nesbitt School of Pharmacy',2,'Changed zip_code.'),(351,'2014-08-15 15:19:31',1,8,'79','Massachusetts College of Pharmacy and Health Sciences--Worcester',2,'Changed zip_code.'),(352,'2014-08-15 15:19:50',1,8,'80','Midwestern University College of Pharmacy',2,'Changed zip_code.'),(353,'2014-08-15 15:20:11',1,8,'81','Florida A&M University College of Pharmacy',2,'Changed zip_code.'),(354,'2014-08-15 15:20:26',1,8,'82','Nova Southeastern University College of Pharmacy',2,'Changed zip_code.'),(355,'2014-08-15 16:06:09',1,8,'83','Texas Southern University College of Pharmacy and Health Sciences',2,'Changed zip_code.'),(356,'2014-08-15 16:06:34',1,8,'84','Touro University--California College of Pharmacy',2,'Changed zip_code.'),(357,'2014-08-15 16:07:10',1,8,'85','University of the Incarnate Word Feik School of Pharmacy',2,'Changed zip_code.'),(358,'2014-08-15 16:07:29',1,8,'86','Wingate University School of Pharmacy',2,'Changed street.'),(359,'2014-08-15 16:08:07',1,8,'87','Xavier University of Louisiana College of Pharmacy',2,'Changed zip_code.'),(360,'2014-08-15 16:09:50',1,8,'93','University of Puerto Rico - Medical Sciences Campus',2,'Changed zip_code and street.'),(361,'2014-08-15 16:13:55',1,9,'3','Belmont University College of Pharmacy',2,'Changed zip_code.'),(362,'2014-08-15 16:14:26',1,9,'4','California Northstate University College of Pharmacy',2,'Changed zip_code.'),(363,'2014-08-15 16:15:21',1,9,'6','Chicago State University College of Pharmacy',2,'Changed zip_code and street.'),(364,'2014-08-15 16:16:23',1,9,'9','East Tennessee State University Bill Gatton College of Pharmacy',2,'Changed zip_code, street and school_url.'),(365,'2014-08-15 16:17:07',1,9,'10','Fairleigh Dickinson University School of Pharmacy',2,'Changed zip_code and street.'),(366,'2014-08-15 16:17:56',1,9,'11','Hampton University School of Pharmacy',2,'Changed zip_code.'),(367,'2014-08-15 16:18:36',1,9,'12','Harding University College of Pharmacy',2,'Changed zip_code and street.'),(368,'2014-08-15 16:19:38',1,9,'45','Howard University College of Pharmacy',2,'Changed zip_code and school_url.'),(369,'2014-08-15 16:20:20',1,9,'14','LECOM School of Pharmacy',2,'Changed zip_code.'),(370,'2014-08-15 16:20:45',1,9,'15','LECOM School of Pharmacy--Bradenton',2,'Changed zip_code.'),(371,'2014-08-15 16:21:07',1,9,'16','Lipscomb University College of Pharmacy and Health Sciences',2,'Changed zip_code and school_url.'),(372,'2014-08-15 16:21:35',1,9,'17','Loma Linda University School of Pharmacy',2,'Changed street.'),(373,'2014-08-15 16:22:05',1,9,'18','Manchester University College of Pharmacy',2,'Changed zip_code.'),(374,'2014-08-15 16:22:29',1,9,'19','Marshall University School of Pharmacy',2,'Changed zip_code.'),(375,'2014-08-15 16:22:58',1,9,'20','Notre Dame of Maryland University School of Pharmacy',2,'Changed zip_code.'),(376,'2014-08-15 16:23:35',1,9,'22','Palm Beach Atlantic University (Gregory) Lloyd L. Gregory School of Pharmacy',2,'Changed zip_code.'),(377,'2014-08-15 16:25:13',1,9,'23','PCOM School of Pharmacy--Georgia',2,'Changed zip_code.'),(378,'2014-08-15 16:26:53',1,9,'25','Regis University School of Pharmacy Rueckert-Hartman College for Health Professions',2,'Changed zip_code.'),(379,'2014-08-15 16:28:30',1,9,'26','Roosevelt University College of Pharmacy',2,'Changed zip_code.'),(380,'2014-08-15 16:29:40',1,9,'28','Roseman University of Health Sciences College of Pharmacy',2,'Changed zip_code.'),(381,'2014-08-15 16:29:59',1,9,'29','South College School of Pharmacy',2,'Changed zip_code.'),(382,'2014-08-15 16:32:47',1,9,'30','South University School of Pharmacy',2,'Changed zip_code.'),(383,'2014-08-15 16:33:17',1,9,'32','St. John Fisher College Wegmans School of Pharmacy',2,'Changed zip_code.'),(384,'2014-08-15 16:33:31',1,9,'33','Sullivan University College of Pharmacy',2,'Changed zip_code.'),(385,'2014-08-15 16:34:04',1,9,'34','Thomas Jefferson University Jefferson School of Pharmacy',2,'Changed zip_code and street.'),(386,'2014-08-15 16:34:36',1,9,'35','Touro College of Pharmacy - New York College of Pharmacy',2,'Changed zip_code.'),(387,'2014-08-15 16:35:16',1,9,'36','Union University School of Pharmacy',2,'Changed zip_code and street.'),(388,'2014-08-15 16:36:01',1,9,'37','University of Charleston School of Pharmacy',2,'Changed zip_code.'),(389,'2014-08-15 16:36:21',1,9,'38','University of Findlay College of Pharmacy',2,'Changed zip_code.'),(390,'2014-08-15 16:37:23',1,9,'40','University of New England College of Pharmacy',2,'Changed zip_code.'),(391,'2014-08-15 16:38:01',1,9,'41','University of South Florida School of Pharmacy',2,'Changed zip_code and street.'),(392,'2014-08-15 16:38:22',1,9,'42','University of St. Joseph School of Pharmacy',2,'Changed zip_code.'),(393,'2014-08-15 16:38:46',1,9,'43','Western New England University College of Pharmacy',2,'Changed zip_code.'),(394,'2014-08-15 16:39:08',1,9,'44','University of North Texas System College of Pharmacy',2,'Changed zip_code.'),(395,'2014-08-15 16:43:01',1,9,'39','University of Maryland--Eastern Shore School of Pharmacy',2,'Changed street.'),(396,'2014-08-19 16:59:50',1,8,'74','Western University of Health Sciences College of Pharmacy',2,'Changed city, state, zip_code and street.'),(397,'2014-08-25 17:59:40',1,8,'43','Washington State University College of Pharmacy',2,'Changed city.'),(398,'2014-08-25 19:10:13',1,8,'35','St. Louis College of Pharmacy',2,'Changed zip_code.');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'student','pcatapp','student'),(8,'ranked','pcatapp','ranked'),(9,'unranked','pcatapp','unranked'),(10,'migration history','south','migrationhistory'),(11,'site','sites','site'),(12,'email address','account','emailaddress'),(13,'email confirmation','account','emailconfirmation'),(14,'social app','socialaccount','socialapp'),(15,'social account','socialaccount','socialaccount'),(16,'social token','socialaccount','socialtoken'),(17,'api access','tastypie','apiaccess'),(18,'api key','tastypie','apikey');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('270ufx36myes7ww3ajvz8fdg30rkxtt7','OTc0MTRiMjRjNWRiM2QyMzNlYTM4NmU1NGFkOGMwMDUyOTBkNWMxYzp7Il9hdXRoX3VzZXJfaWQiOjgsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-09-21 05:06:49'),('3cqh18lpu1jodh4siwtvvyj26a1cn8mo','NGEzMDZjYWY1ZDc5OGJhNjdiNmNmMmU0MzQ5OTFkNGIzOTRiZDRkYzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MSwiX21lc3NhZ2VzIjoiW1tcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlRoZSByYW5rZWQgXFxcIlNvdXRoIERha290YSBTdGF0ZSBVbml2ZXJzaXR5IENvbGxlZ2Ugb2YgUGhhcm1hY3lcXFwiIHdhcyBjaGFuZ2VkIHN1Y2Nlc3NmdWxseS5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiVGhlIHJhbmtlZCBcXFwiTm9ydGggRGFrb3RhIFN0YXRlIFVuaXZlcnNpdHkgQ29sbGVnZSBvZiBQaGFybWFjeVxcXCIgd2FzIGNoYW5nZWQgc3VjY2Vzc2Z1bGx5LlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJUaGUgcmFua2VkIFxcXCJVbml2ZXJzaXR5IG9mIFJob2RlIElzbGFuZCBDb2xsZWdlIG9mIFBoYXJtYWN5XFxcIiB3YXMgY2hhbmdlZCBzdWNjZXNzZnVsbHkuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlRoZSByYW5rZWQgXFxcIlVuaXZlcnNpdHkgb2YgQ29ubmVjdGljdXQgU2Nob29sIG9mIFBoYXJtYWN5XFxcIiB3YXMgY2hhbmdlZCBzdWNjZXNzZnVsbHkuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlRoZSByYW5rZWQgXFxcIlVuaXZlcnNpdHkgb2YgV2lzY29uc2luIFNjaG9vbCBvZiBQaGFybWFjeVxcXCIgd2FzIGNoYW5nZWQgc3VjY2Vzc2Z1bGx5LlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJTdWNjZXNzZnVsbHkgZGVsZXRlZCAxIHVucmFua2VkLlwiXV0ifQ==','2014-07-31 14:47:11'),('3vkivbcd7pb2sxpgr15atomyox8ru7i8','NjdkNTRjOTUxNWNlZmU2YTNhNTE1OTlkMzJiNGFhN2UwMzg2OTUxMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-08-22 19:21:37'),('48myp19o052axa6khgxficm0lod2i5nk','MWY5YWU0MmZlZTgzOTIzM2Q4YzRiZjg5NTU2ZDBkMzI5YzI5Y2I3Zjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6OH0=','2014-09-24 19:10:19'),('6vnlmvrgjuxs6cju1vh4gpbr43uwd1p8','MjY3MzMwZmE1OTJmNzZlOGQwN2VhYWZjN2YzN2Q5YjE2YTk2MjUxMTp7Il9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWxsYXV0aC5hY2NvdW50LmF1dGhfYmFja2VuZHMuQXV0aGVudGljYXRpb25CYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6OH0=','2014-08-26 22:53:07'),('7lj8zyv8a2vaix6xn4t3j556m65o5ip9','MWQ4MGFkNmU5NDBiNjc5OWMwZTRkNGI0MGFiMjE0NzY4MmMwYTg3OTp7Il9tZXNzYWdlcyI6IltbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjAsXCJDb25maXJtYXRpb24gZS1tYWlsIHNlbnQgdG8gYXBhcmRlczFAYmluZ2hhbXRvbi5lZHVcIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiWW91IGhhdmUgY29uZmlybWVkIGFwYXJkZXMxQGJpbmdoYW10b24uZWR1LlwiXV0iLCJhY2NvdW50X3ZlcmlmaWVkX2VtYWlsIjpudWxsfQ==','2014-06-26 00:20:40'),('85ky2yxapyt6uuw4h3a66qoclxtsd4zc','ZjgxZGEyMmIyZWM1MGY4ODgzMWQyMDQ2NmYwN2NlNWQ5YTY1OTk2ZDp7fQ==','2014-08-26 22:53:55'),('cu05z4rhrued1g44r6sksq1duqntsx27','NDE5ZDZjYTZjODIxMjVkM2ZhYzU1MDgxMTRmNzIzMDEyMmVhZDQ5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6OX0=','2014-08-27 18:00:53'),('fouxbkbr7r14fj6tr1crz18yopw5xsrf','MDRlOTMwNzZkYTc3ODk3OGQ5YzExNGIyNGRjYjM3OWQ4MjhjMjlhMTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTB9','2014-09-03 19:09:55'),('g7xhdca1wx26azd7gjbyhngg3sbjs2zz','NDE5ZDZjYTZjODIxMjVkM2ZhYzU1MDgxMTRmNzIzMDEyMmVhZDQ5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6OX0=','2014-08-27 20:34:08'),('guih9georw1v3ofpcygrft4au2froi4z','ZjgxZGEyMmIyZWM1MGY4ODgzMWQyMDQ2NmYwN2NlNWQ5YTY1OTk2ZDp7fQ==','2014-07-04 02:52:28'),('gv65hzebs7gh7j1nk3sycr930aug7vcj','NDE5ZDZjYTZjODIxMjVkM2ZhYzU1MDgxMTRmNzIzMDEyMmVhZDQ5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6OX0=','2014-08-27 17:58:34'),('jpqmghzex7fjm3x4fv0m9qqw12y4h65z','NjdkNTRjOTUxNWNlZmU2YTNhNTE1OTlkMzJiNGFhN2UwMzg2OTUxMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-09-08 17:23:04'),('jzxj9f7fftn91ftkg3k3ovyt7ptejr2p','NjdkNTRjOTUxNWNlZmU2YTNhNTE1OTlkMzJiNGFhN2UwMzg2OTUxMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-05-30 23:00:50'),('lrofgobvplifc2j3v4pth0snkjcmyl7q','ZjgxZGEyMmIyZWM1MGY4ODgzMWQyMDQ2NmYwN2NlNWQ5YTY1OTk2ZDp7fQ==','2014-06-24 01:18:55'),('m5lhv798jim1dm8f26rg8xswiduzm78s','Y2MxNWVjY2MzNGJiZTIxNzJkZThiNGY1NjlmMDA2NTVkMjEwZmUwMjp7Il9zZXNzaW9uX2V4cGlyeSI6MCwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYWxsYXV0aC5hY2NvdW50LmF1dGhfYmFja2VuZHMuQXV0aGVudGljYXRpb25CYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NiwiX21lc3NhZ2VzIjoiW1tcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIllvdSBoYXZlIHNpZ25lZCBvdXQuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlN1Y2Nlc3NmdWxseSBzaWduZWQgaW4gYXMgYXBhcmRlczEuXCJdXSJ9','2014-07-25 16:04:21'),('n62q7v0j8dpeludpq3powccg0ucscdsv','M2Y0MTJiNTU3Zjg2MTM1NmYxNmQxOGE4NmE1MWE1NmZhNzVjOGFlMjp7Il9hdXRoX3VzZXJfaWQiOjksIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-09-11 14:01:26'),('pbpcte05hc7cpg5phhdmtnwo1wdu7wrd','OTc0MTRiMjRjNWRiM2QyMzNlYTM4NmU1NGFkOGMwMDUyOTBkNWMxYzp7Il9hdXRoX3VzZXJfaWQiOjgsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-08-26 22:49:23'),('pybqs4a2nriog78kkkcdkdztyhiq1ux8','ZjgxZGEyMmIyZWM1MGY4ODgzMWQyMDQ2NmYwN2NlNWQ5YTY1OTk2ZDp7fQ==','2014-07-04 16:12:53'),('q57g96rzogm70jwxvu80l9mzwi4bck6c','NThkOTAzNDI5ZDBmYjVkZDg4NjIyOGRiZDUyMWU2ZTZiNmI5YTQ5Mzp7Il9hdXRoX3VzZXJfaWQiOjEwLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2014-09-03 19:30:53'),('qezc1qyx6jco2texsjia23067scjwshp','YmRhZWFlMzhhN2M3ODE4NjJkYTdlZjRjOTE2YWRmOTM3OWYzNGM0YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MSwiX21lc3NhZ2VzIjoiW1tcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlRoZSByYW5rZWQgXFxcIlNvdXRoIENhcm9saW5hIENvbGxlZ2Ugb2YgUGhhcm1hY3lcXFwiIHdhcyBjaGFuZ2VkIHN1Y2Nlc3NmdWxseS5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiVGhlIHJhbmtlZCBcXFwiTm9ydGggRGFrb3RhIFN0YXRlIFVuaXZlcnNpdHkgQ29sbGVnZSBvZiBQaGFybWFjeVxcXCIgd2FzIGNoYW5nZWQgc3VjY2Vzc2Z1bGx5LlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJUaGUgcmFua2VkIFxcXCJTb3V0aCBEYWtvdGEgU3RhdGUgVW5pdmVyc2l0eSBDb2xsZWdlIG9mIFBoYXJtYWN5XFxcIiB3YXMgY2hhbmdlZCBzdWNjZXNzZnVsbHkuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlRoZSB1bnJhbmtlZCBcXFwiUGFsbSBCZWFjaCBBdGxhbnRpYyBVbml2ZXJzaXR5IChHcmVnb3J5KSBMbG95ZCBMLiBHcmVnb3J5IFNjaG9vbCBvZiBQaGFybWFjeVxcXCIgd2FzIGNoYW5nZWQgc3VjY2Vzc2Z1bGx5LlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJUaGUgdW5yYW5rZWQgXFxcIlRob21hcyBKZWZmZXJzb24gVW5pdmVyc2l0eSBKZWZmZXJzb24gU2Nob29sIG9mIFBoYXJtYWN5XFxcIiB3YXMgY2hhbmdlZCBzdWNjZXNzZnVsbHkuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlRoZSB1bnJhbmtlZCBcXFwiVW5pb24gVW5pdmVyc2l0eSBTY2hvb2wgb2YgUGhhcm1hY3lcXFwiIHdhcyBjaGFuZ2VkIHN1Y2Nlc3NmdWxseS5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiVGhlIHVucmFua2VkIFxcXCJVbml2ZXJzaXR5IG9mIFNvdXRoIEZsb3JpZGEgU2Nob29sIG9mIFBoYXJtYWN5XFxcIiB3YXMgY2hhbmdlZCBzdWNjZXNzZnVsbHkuXCJdLFtcIl9fanNvbl9tZXNzYWdlXCIsMCwyNSxcIlRoZSByYW5rZWQgXFxcIk5vcnRoIERha290YSBTdGF0ZSBVbml2ZXJzaXR5IENvbGxlZ2Ugb2YgUGhhcm1hY3lcXFwiIHdhcyBjaGFuZ2VkIHN1Y2Nlc3NmdWxseS5cIl0sW1wiX19qc29uX21lc3NhZ2VcIiwwLDI1LFwiVGhlIHJhbmtlZCBcXFwiTm9ydGggRGFrb3RhIFN0YXRlIFVuaXZlcnNpdHkgQ29sbGVnZSBvZiBQaGFybWFjeVxcXCIgd2FzIGNoYW5nZWQgc3VjY2Vzc2Z1bGx5LlwiXSxbXCJfX2pzb25fbWVzc2FnZVwiLDAsMjUsXCJUaGUgcmFua2VkIFxcXCJVbml2ZXJzaXR5IG9mIFdhc2hpbmd0b24gU2Nob29sIG9mIFBoYXJtYWN5XFxcIiB3YXMgY2hhbmdlZCBzdWNjZXNzZnVsbHkuXCJdXSJ9','2014-08-28 21:11:03'),('ra71urm59yiug53aym89yx3hgk4idjmr','ZjgxZGEyMmIyZWM1MGY4ODgzMWQyMDQ2NmYwN2NlNWQ5YTY1OTk2ZDp7fQ==','2014-09-03 01:13:59'),('s0asov3io9e7w028a548pfrinb9zhjp9','ZjgxZGEyMmIyZWM1MGY4ODgzMWQyMDQ2NmYwN2NlNWQ5YTY1OTk2ZDp7fQ==','2014-06-30 15:50:10'),('wcdzsbk0sr1wjorabxwksoj40y1dyzl3','NjdkNTRjOTUxNWNlZmU2YTNhNTE1OTlkMzJiNGFhN2UwMzg2OTUxMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-09-08 19:08:56'),('z4jqobwqn5uid5e8yy7l9ysqge7ksotj','ZjgxZGEyMmIyZWM1MGY4ODgzMWQyMDQ2NmYwN2NlNWQ5YTY1OTk2ZDp7fQ==','2014-05-28 20:04:42');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'127.0.0.1:8000','1');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pcatapp_ranked`
--

DROP TABLE IF EXISTS `pcatapp_ranked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcatapp_ranked` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(30) NOT NULL,
  `zip_code` varchar(5) NOT NULL,
  `gpa_overall` decimal(3,2) DEFAULT NULL,
  `gpa_expected` decimal(3,2) DEFAULT NULL,
  `min_pcat` int(11) DEFAULT NULL,
  `resident_tuition` int(11) NOT NULL,
  `nonresident_tuition` int(11) NOT NULL,
  `supplemental` tinyint(1) NOT NULL,
  `three_year` tinyint(1) NOT NULL,
  `dual_degree` tinyint(1) NOT NULL,
  `rank` int(11) NOT NULL,
  `lat` decimal(7,4) DEFAULT NULL,
  `lon` decimal(7,4) DEFAULT NULL,
  `gpa_avg` decimal(3,2) DEFAULT NULL,
  `full_accred` tinyint(1) NOT NULL,
  `cand_accred` tinyint(1) NOT NULL,
  `prec_accred` tinyint(1) NOT NULL,
  `school_url` varchar(75) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  `regional_tuition` varchar(100) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `regional_bool` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pcatapp_ranked`
--

LOCK TABLES `pcatapp_ranked` WRITE;
/*!40000 ALTER TABLE `pcatapp_ranked` DISABLE KEYS */;
INSERT INTO `pcatapp_ranked` VALUES (1,'University of California San Francisco School of Pharmacy','San Francisco','CA','94143',2.80,0.00,0,35368,47613,1,0,1,1,37.6574,-122.4235,2.80,1,0,0,'http://pharmacy.ucsf.edu/','513 Parnassus Avenue<br>UCSF Box 0150, Room S-960','osaca@pharmacy.ucsf.edu','0','415-476-2732',0),(2,'University of North Carolina Eshelman School of Pharmacy','Chapel Hill','NC','27599',2.80,3.50,65,18904,40247,1,0,1,2,35.9203,-79.0372,3.15,1,0,0,'https://pharmacy.unc.edu/','UNC Eshelman School of Pharmacy<br>CB#7355','pharmacy_admissions@unc.edu','0','919-966-9429',0),(3,'University of Minnesota College of Pharmacy','Minneapolis','MN','55455',3.00,3.50,0,23784,35184,1,0,1,3,44.9462,-93.2000,3.25,1,0,0,'http://pharmd.umn.edu/','5-130 Weaver-Densford Hall <br>308 Harvard Street SE','pharmacy@umn.edu','0','612-624-9490',0),(4,'University of Texas College of Pharmacy','Austin','TX','78712',2.50,3.60,50,15830,40920,1,0,1,4,30.3264,-97.7713,3.05,1,0,0,'http://www.utexas.edu/pharmacy/admissions/pharmd.html','2409 University Ave. Stop: A1900','PharmDadmit@austin.utexas.edu','0','512-471-1737',0),(5,'University of Kentucky College of Pharmacy','Lexington','KY','40536',2.50,3.00,0,25672,46614,1,0,1,5,38.0378,-84.6164,2.75,1,0,0,'http://pharmacy.mc.uky.edu/','789 S. Limestone','stephanie.wurth@uky.edu','0','859-323-5023',0),(6,'University of Wisconsin School of Pharmacy','Madison','WI','53705',3.00,3.50,0,16286,28744,1,0,1,5,43.0696,-89.4239,3.25,1,0,0,'http://pharmacy.wisc.edu/pharmd/admissions','777 Highland Ave','pharminfo@pharmacy.wisc.edu','$24,914 (Minnesota Residents)','608-262-6234',1),(7,'Ohio State University College of Pharmacy','Columbus','OH','43210',3.00,3.50,50,20473,39073,1,0,1,7,40.0999,-83.0157,3.25,1,0,0,'http://pharmacy.osu.edu/futurestudents/?subsec=pharmd','150 Parks Hall<br>500 West 12th Ave','admissions@pharmacy.ohio-state.edu','0','614-292-1662',0),(8,'Purdue University College of Pharmacy','West Lafayette','IN','47907',3.10,3.20,0,21448,39708,1,0,1,7,40.4440,-86.9237,3.15,1,0,0,'http://www.pharmacy.purdue.edu/','575 Stadium Mall Drive','georgetp@purdue.edu','0','765-494-9395',0),(9,'University of Michigan College of Pharmacy','Ann Arbor','MI','48109',2.80,3.40,50,22066,37734,1,0,1,7,42.2794,-83.7840,3.10,1,0,0,'https://pharmacy.umich.edu/','428 Church Street','mich.pharm.admissions@umich.edu','0','734-764-7312',0),(10,'University of Arizona College of Pharmacy','Tucson','AZ','85721',3.00,3.50,50,22930,38342,0,0,1,10,32.2139,-110.9694,3.25,1,0,0,'http://www.pharmacy.arizona.edu/','1295 N. Martin<br>PO Box 210202','admissionsinfo@pharmacy.arizona.edu','0','520-626-1427',0),(11,'University of Southern California School of Pharmacy John Stauffer Pharmaceutical Sciences Center','Los Angeles','CA','90089',3.00,3.57,0,46862,46862,1,0,1,10,33.9731,-118.2479,3.28,1,0,0,'http://pharmacyschool.usc.edu/','1985 Zonal Avenue<br>PSC 206A','xgong@usc.edu','0','323-442-1466',0),(12,'University of Utah College of Pharmacy','Salt Lake City','UT','84112',2.75,3.50,65,24306,46282,1,0,1,10,40.7559,-111.8967,3.12,1,0,0,'http://www.pharmacy.utah.edu/','30 South 2000 East<br>Room 105','kristen.mahoney@pharm.utah.edu','0','801-581-6731',0),(13,'University of Washington School of Pharmacy','Seattle','WA','98195',2.80,3.00,50,24018,43688,1,0,1,10,47.4323,-121.8034,2.90,1,0,0,'http://sop.washington.edu/students/','1959 NE Pacific Street <br>H362 Health Sciences Building<br>Box 357631','pharminf@uw.edu','0','206-543-6100',0),(14,'University of Florida College of Pharmacy','Gainesville','FL','32610',3.00,3.50,60,26689,49828,1,0,1,14,29.6489,-82.3250,3.25,1,0,0,'http://pharmacy.ufl.edu/','College of Pharmacy<br>Box 100495','frontdesk@cop.ufl.edu','0','352-273-6217',0),(15,'University of Illinois--Chicago College of Pharmacy','Chicago','IL','60612',2.75,3.50,0,13708,21120,1,0,1,14,42.3247,-87.8564,3.12,1,0,0,'http://www.uic.edu/pharmacy/student_affairs','833 South Wood Street (MC874)','pharmosa@uic.edu','0','312-996-7242',0),(16,'University of Pittsburgh School of Pharmacy','Pittsburgh','PA','15261',3.00,3.00,50,24835,27588,1,0,1,14,40.4036,-79.8389,3.00,1,0,0,'http://www.pharmacy.pitt.edu/','3501 Terrace Street<br>904 Salk Hall','rxschool@pitt.edu','0','412-383-9000',0),(17,'University at Buffalo--SUNY School of Pharmacy and Pharmaceutical Sciences','Buffalo','NY','14214',3.00,3.00,0,22610,43840,1,0,1,17,42.8967,-78.8846,3.00,1,0,0,'http://pharmacy.buffalo.edu/','270 Kapoor Hall','pharm-admit@buffalo.edu','0','716-645-2825',0),(18,'University of Iowa College of Pharmacy','Iowa City','IA','52242',2.50,3.40,0,10700,19300,1,0,1,17,41.6355,-91.5016,2.95,1,0,0,'http://pharmacy.uiowa.edu/pharmd-admissions','115 S. Grand Ave. <br>127 Pharmacy Building','pharmacy-admissions@uiowa.edu','0','319-335-8795',0),(19,'University of Maryland School of Pharmacy','Baltimore','MD','21201',2.50,3.00,70,19589,35397,1,0,1,17,39.2946,-76.6252,2.75,1,0,0,'http://www.pharmacy.umaryland.edu/','20 N Pine St.<br>Suite S722','jbrammer@rx.umaryland.edu','0','410-706-3904',0),(20,'University of Tennessee Health Science Center College of Pharmacy','Memphis','TN','38163',2.50,3.00,0,20496,39316,1,0,1,17,35.1693,-89.9904,2.75,1,0,0,'http://www.uthsc.edu/pharmacy','881 Madison Avenue<br>Room 243','pharmadmiss@uthsc.edu','0','901-448-7172',0),(21,'University of Kansas School of Pharmacy','Lawrence','KS','66047',2.50,3.00,0,19400,35300,1,0,1,21,39.0289,-95.2086,2.75,1,0,0,'http://pharmacy.ku.edu/','2010 Becker Dr','pharmacy@ku.edu','0','785-864-3591',0),(22,'Virginia Commonwealth University School of Pharmacy','Richmond','VA','23298',2.90,3.40,0,13223,18770,1,0,1,21,37.5242,-77.4932,3.15,1,0,0,'http://www.pharmacy.vcu.edu/','Room 500, Smith Building<br>410 North 12th Street','pharmacy@vcu.edu','0','800-330-0519',0),(23,'University of California--San Diego Skaggs School of Pharmacy and Pharmaceutical Sciences','La Jolla','CA','92093',3.00,3.40,0,12192,35070,1,0,1,23,32.8455,-117.2521,3.20,1,0,0,'http://www.pharmacy.ucsd.edu/','9500 Gilman Drive<br>Mail Code 0657','sppsadmissions@ucsd.edu','0','858-822-4900',0),(24,'University of Colorado School of Pharmacy','Aurora','CO','80045',2.50,3.50,20,22582,37758,1,0,0,24,39.7368,-104.8646,3.00,1,0,0,'http://www.ucdenver.edu/Pharmacy','12850 E. Montview Blvd.<br>Mailstop C238','PharmD.Info@ucdenver.edu','0','303-724-2882',0),(25,'University of Mississippi School of Pharmacy','University','MS','38677',2.75,3.25,40,17898,38036,1,0,0,24,34.3396,-89.5736,3.00,1,0,0,'http://www.pharmacy.olemiss.edu/','University of Mississippi<br>P.O. Box 1848','pharmstuservices@olemiss.edu','0','662-915-7996',0),(26,'Auburn University Harrison School of Pharmacy','Auburn','AL','36849',2.50,3.20,40,20006,35738,1,0,1,26,32.5475,-85.4682,2.85,1,0,0,'http://pharmacy.auburn.edu/','2316 Walker Building','kenneyl@auburn.edu','0','334-844-8348',0),(27,'Medical University of South Carolina','Charleston','SC','29425',2.50,3.50,0,24487,35243,1,0,1,26,32.7795,-79.9371,3.00,1,0,0,'http://academicdepartments.musc.edu/musc/','45 Courtenay Drive<br>MSC 203','coatess@musc.edu','0','843-792-8722',0),(28,'Rutgers University Ernest Mario School of Pharmacy','Piscataway','NJ','08854',2.80,3.50,0,15552,29832,0,0,1,26,40.5515,-74.4590,3.15,1,0,0,'http://pharmacy.rutgers.edu/','160 Frelinghuysen Road','','0','848-445-2675',0),(29,'University of Connecticut School of Pharmacy','Storrs','CT','06269',3.00,3.30,60,12022,30970,0,0,1,26,41.7997,-72.2478,3.15,1,0,0,'http://pharmacy.uconn.edu/','69 North Eagleville Rd. <br> Unit 3092  ','PharmacyProf@uconn.edu','$18,964 <br> (New England Regional Residents)','860-486-2216',1),(30,'University of Georgia College of Pharmacy','Athens','GA','30602',0.00,0.00,0,16898,36898,1,0,1,26,33.9761,-83.3632,2.00,1,0,0,'http://www.rx.uga.edu/','250 West Green Street','sherda@rx.uga.edu','0','706-542-5278',0),(31,'West Virginia University School of Pharmacy','Morgantown','WV','26506',3.00,3.60,60,16974,36343,1,0,1,26,39.6099,-79.9831,3.30,1,0,0,'http://pharmacy.hsc.wvu.edu/Pages/','1 Medical Center Drive<br>P.O. Box 9500','jeclutter@hsc.wvu.edu','0','304-293-1552',0),(32,'Texas Tech University Health Sciences Center School of Pharmacy','Amarillo','TX','79106',3.00,0.00,50,12100,23173,1,0,1,32,35.2032,-101.8421,3.00,1,0,0,'http://www.ttuhsc.edu/sop/','1300 Coulter St.<br>Suite 2210','sopadmissions@ttuhsc.edu','0','806-414-9393',0),(33,'University of Arkansas for Medical Sciences College of Pharmacy','Little Rock','AR','72205',2.50,3.50,30,15731,29751,1,0,1,32,34.9074,-92.1397,3.00,1,0,0,'http://pharmcollege.uams.edu/','4301 W. Markham Street<br>Slot #522','orearkathym@uams.edu','0','501-686-6499',0),(34,'University of Cincinnati The James L. Winkle College of Pharmacy','Cincinnati','OH','45267',3.00,3.50,0,17930,30606,1,0,0,32,39.1668,-84.5382,3.25,1,0,0,'http://www.pharmacy.uc.edu/','3225 Eden Avenue','pharmacy@uc.edu','0','513-558-3784',0),(35,'St. Louis College of Pharmacy','St. Louis','MO','63110',3.00,3.20,60,24518,24518,0,0,0,43,38.6272,90.1978,3.10,1,0,0,'http://www.stlcop.edu/index.html','4588 Parkview Place','tim.ellis@stlcop.edu','0','314-446-8322',0),(37,'University of Nebraska Medical Center College of Pharmacy','Omaha','NE','68178',2.50,3.50,0,17666,34310,1,0,1,32,41.2917,-96.1711,3.00,1,0,0,'http://www.unmc.edu/pharmacy/','986000 NebraskaMedical Center','copadmin@unmc.edu','0','402-559-4333',0),(38,'University of Oklahoma College of Pharmacy','Oklahoma City','OK','73117',2.50,3.00,50,20969,38397,1,0,1,32,35.3513,-97.4953,2.75,1,0,0,'http://pharmacy.ouhsc.edu/','1110 N. Stonewall Avenue','OUPharmD@ouhsc.edu','0','405-271-6598',0),(39,'Creighton University School of Pharmacy and Health Professions','Omaha','NE','68178',2.50,3.25,45,32428,32428,1,0,1,37,41.2917,-96.1711,2.88,1,0,0,'http://spahp.creighton.edu/admission','2500 California Plaza','phaadmis@creighton.edu','0','402-280-2662',0),(40,'University of Missouri--Kansas City School of Pharmacy','Kansas City','MO','64108',2.75,3.50,0,19754,41810,1,0,1,37,39.1024,-94.5986,3.12,1,0,0,'http://pharmacy.umkc.edu/','2464 Charlotte Street<br>Suite 1219','pharmacy@umkc.edu','0','816-235-1613',0),(41,'Northeastern University School of Pharmacy','Boston','MA','02115',3.00,3.00,0,38340,38340,0,0,0,39,42.3706,-71.0270,3.00,1,0,0,'http://www.northeastern.edu/bouve/pharmacy/index.html','360 Huntington Avenue','admissions@neu.edu','0','617-373-7000',0),(42,'Oregon State University College of Pharmacy','Corvallis','OR','97331',2.75,3.25,0,20160,34704,1,0,1,39,44.5904,-123.2722,3.00,1,0,0,'http://pharmacy.oregonstate.edu/','203 Pharmacy Building','pharmacy@oregonstate.edu','0','541-737-3424',0),(43,'Washington State University College of Pharmacy','Spokane','WA','99210',3.00,3.40,0,20502,37156,1,0,1,39,46.7352,-117.1729,3.20,1,0,0,'http://www.pharmacy.wsu.edu/','Pharmacy Student Services <br>P.O. Box 1495','admissions@pharmacy.wsu.edu','0','509-368-6605',0),(44,'Wayne State University Eugene Applebaum College of Pharmacy and Health Sciences','Detroit','MI','48201',3.00,3.50,50,20300,38790,0,0,1,39,42.3474,-83.0604,3.25,1,0,0,'http://www.cphs.wayne.edu/pharmd/','259 Mack<br>Ste. 2610','tamra.watt@wayne.edu','0','313-577-4928',0),(45,'Drake University College of Pharmacy & Health Sciences','Des Moines','IA','50311',3.00,3.40,50,34350,34350,1,0,1,43,41.5805,-93.7447,3.20,1,0,0,'http://www.drake.edu/cphs/','2507 University Ave.','jessica.lang@drake.edu','0','515-271-3018',0),(46,'Mercer University College of Pharmacy','Atlanta','GA','30341',2.75,3.40,50,32716,32716,1,0,1,43,33.8444,-84.4740,3.08,1,0,0,'http://pharmacy.mercer.edu/','3001 Mercer University Dr<br>PAC-121','pharmd@mercer.edu','0','678-547-6232',0),(47,'University of the Sciences in Philadelphia College of Pharmacy','Philadelphia','PA','19104',3.00,3.00,75,36352,36352,0,0,0,43,40.6754,-76.1558,3.00,1,0,0,'http://www.usciences.edu/academics/collegesdepts/pcp/','600 S. 43rd Street<br>Box 4','a.viggiani@usciences.edu','0','888-996-8747',0),(48,'University of Rhode Island College of Pharmacy','Kingston','RI','02881',2.50,2.50,75,28620,59752,0,0,1,43,41.4803,-71.5292,2.50,1,0,0,'http://web.uri.edu/pharmacy/','7 Greenhouse Road','pharmcol@etal.uri.edu','$44,940 (Regional Residents)','401-874-2761',1),(49,'Butler University','Indianapolis','IN','46208',3.00,3.00,55,36120,36120,0,0,1,48,39.7750,-86.1093,3.00,1,0,0,'http://www.butler.edu/cophs/?pg=2048&parentID=2024','4600 Sunset Avenue','erobison@butler.edu','0','888-940-8100',0),(50,'Duquesne University Mylan School of Pharmacy','Pittsburgh','PA','15282',2.50,3.00,50,43172,43172,0,0,0,48,40.4036,-79.8389,2.75,1,0,0,'http://www.duq.edu/academics/schools/pharmacy','600 Forbes Avenue','pharmadmission@duq.edu','0','412-396-6393',0),(51,'South Carolina College of Pharmacy','Columbia','SC','29425',2.50,3.50,0,24487,35243,1,0,1,48,33.9950,-81.0888,3.00,1,0,0,'http://www.sccp.sc.edu/','45 Courtenay Dr<br>Room 359 MSC 203','coatess@musc.edu','0','843-792-8722',0),(52,'Texas A&M Health Science Center Irma Rangel College of Pharmacy','Kingsville','TX','78363',2.75,3.50,40,7632,45540,0,0,1,48,27.4229,-97.8407,3.12,1,0,0,'http://pharmacy.tamhsc.edu/','1010 West Avenue B<br>MSC 131','cop-admissions@tamhsc.edu','0','361-221-0648',0),(53,'University of Houston College of Pharmacy','Houston','TX','77204',2.50,3.25,65,13903,23203,1,0,1,48,29.8131,-95.3098,2.88,1,0,0,'http://www.uh.edu/pharmacy/prospective-students/pharmd/index.php','141 Science & Research II<br>Room 122<br>PHA 5000','UHCOPapply@uh.edu','0','713-743-1239',0),(54,'University of Montana Skaggs School of Pharmacy','Missoula','MT','59812',2.50,3.50,0,10705,27420,0,0,0,48,46.8563,-114.0252,3.00,1,0,0,'http://pharmacy.health.umt.edu/','341 Skaggs Building','pharmacy@umontana.edu','0','406-243-4656',0),(55,'University of New Mexico Health Sciences Center College of Pharmacy','Albuquerque','NM','87131',2.50,3.00,30,17720,39172,1,0,1,48,35.1996,-106.6448,2.75,1,0,0,'http://hsc.unm.edu/pharmacy/','Office of Student Services<br>MSC09 53601<br>University of New Mexico','kmccutchen@salud.unm.edu','0','505-272-0583',0),(56,'University of the Pacific Thomas J. Long School of Pharmacy and Health Sciences','Stockton','CA','95211',2.70,3.40,30,65860,65860,1,1,1,48,37.9580,-121.2876,3.05,1,0,0,'http://www.pacific.edu/pharmd','3601 Pacific Avenue','vsemler@pacific.edu','0','209-946-2211',0),(57,'Campbell University College of Pharmacy and Health Sciences','Buies Creek','NC','27506',2.50,3.40,0,32980,32980,1,0,1,56,35.4205,-78.7137,2.95,1,0,0,'http://www.campbell.edu/cphs','PO Box 1090','pharmacy@campbell.edu','0','800-760-9734',0),(58,'Univerisity of Wyoming School of Pharmacy','Laramie','WY','82071',2.80,3.50,0,14322,28908,0,0,1,56,41.1095,-106.2190,3.15,1,0,0,'http://www.uwyo.edu/pharmacy','HS 295<br>Dept 3375<br>1000 E University Ave.','mariav@uwyo.edu','0','307-766-6132',0),(59,'Albany College of Pharmacy and Health Sciences','Albany','NY','12208',2.50,3.00,0,32150,32150,1,0,1,58,42.6149,-73.9708,2.75,1,0,0,'http://www.acphs.edu/','106 New Scotland Ave','admissions@acphs.edu','0','518-694-7221',0),(60,'Massachusetts College of Pharmacy and Health Sciences--Boston','Boston','MA','02208',2.70,3.00,0,32985,32985,1,0,1,58,42.3706,-71.0270,2.85,1,0,0,'http://www.mcphs.edu/','179 Longwood Avenue','elizabeth.duggan@mcphs.edu','0','617-732-2850',0),(61,'North Dakota State University College of Pharmacy','Fargo','ND','58108',3.00,3.60,0,12502,33380,1,0,0,58,46.8907,-96.9258,3.30,1,0,0,'http://www.ndsu.edu/pharmacy/','NDSU Dept <br>PO Box 6050','','$13,305 (Minnesota Residents) <br>$18,753 (Tuition Exchange Resident)','701-231-7456',1),(62,'Temple University School of Pharmacy','Philadelphia','PA','19140',3.00,3.35,50,29796,35134,1,0,0,58,40.6754,-76.1558,3.18,1,0,0,'http://www.temple.edu/pharmacy/','3307 N. Broad Street','joan.hankins@temple.edu','0','215-707-4900',0),(63,'Ferris State University College of Pharmacy','Big Rapids','MI','49307',2.50,3.00,0,19665,29433,0,0,1,62,43.6897,-85.4797,2.75,1,0,0,'http://www.ferris.edu/colleges/pharmacy','220 Ferris Drive','leet@ferris.edu','0','231-591-3780',0),(64,'Idaho State University College of Pharmacy','Pocatello','ID','83209',2.50,3.40,0,17228,33560,1,0,1,62,42.8876,-112.4381,2.95,1,0,0,'http://pharmacy.isu.edu/live/','970 South 5th Ave.<br>Stop 8288','pharmd@pharmacy.isu.edu','0','208-282-3475',0),(65,'Samford University McWhorter School of Pharmacy','Birmingham','AL','35229',2.75,3.20,40,33730,33730,1,0,1,62,33.4564,-86.8019,2.98,1,0,0,'http://samford.edu/pharmacy','800 Lakeshore Drive','cbfoster@samford.edu','0','205-726-2982',0),(66,'South Dakota State University College of Pharmacy','Brookings','SD','57007',3.00,3.60,33,16762,25146,1,0,0,62,44.3056,-96.7914,3.30,1,0,0,'http://www.sdstate.edu/pha/','Avera Health and Science Center 133 <br>Box: 2202C','sdsu.pharmacy@sdstate.edu','$21,454 (Minnesota Residents)','605-688-6197',1),(67,'Southern Illinois University Edwardsville School of Pharmacy','Edwardsville','IL','62025',2.75,3.60,33,26998,31548,1,0,1,62,38.8050,-89.9637,3.18,1,0,0,'http://www.siue.edu/pharmacy','200 University Park Drive<br>Suite 220','ccarr@siue.edu','0','618-650-5159',0),(68,'St. John\'s University College of Pharmacy and Allied Health Professions','Jamaica','NY','11439',2.75,3.60,0,41730,41730,1,0,0,62,40.6913,-73.8059,3.18,1,0,0,'http://goo.gl/UjNals','8000 Utopia Parkway','pahpdean@stjohns.edu','0','718-990-6275',0),(69,'University of Toledo College of Pharmacy','Toledo','OH','43614',2.70,3.60,0,17968,28228,0,0,0,62,41.7207,-83.5694,3.15,1,0,0,'http://www.utoledo.edu/pharmacy/','3000 Arlington Ave<br>MS 1014','pharmacy@utoledo.edu','0','419-530-2010',0),(70,'Midwestern University--Chicago College of Pharmacy','Downers Grove','IL','60515',2.50,2.75,50,37403,37403,1,0,0,69,41.8034,-88.0138,2.62,1,0,0,'http://www.midwestern.edu/','555 31st Street','admissil@midwestern.edu','0','630-743-4500',0),(71,'Ohio Northern University College of Pharmacy','Ada','OH','43810',3.00,3.75,50,41240,41240,0,0,0,69,40.0793,-81.8718,3.38,1,0,0,'http://www.onu.edu/academics/pharmacy','525 South Main St.','pharmacy@onu.edu','0','419-772-2275',0),(72,'Northeast Ohio Medical University College of Pharmacy (NEOMED)','Rootstown','OH','44272',2.50,3.25,50,20707,39027,1,0,1,71,41.0995,-81.2026,2.88,1,0,0,'http://www.neomed.edu/admissions/pharmd','4209 State Route 44<br>P.O. Box 95','pharmacy@neomed.edu','0','330-325-6270',0),(73,'Shenandoah University School of Pharmacy','Winchester','VA','22601',2.50,3.40,0,31320,31320,1,0,1,71,39.1858,-78.1827,2.95,1,0,0,'http://pharmacy.su.edu/','1460 University Drive','pharmd@su.edu','0','540-678-4340',0),(74,'Western University of Health Sciences College of Pharmacy','Pomona','CA','91766',2.75,3.40,0,45810,45810,1,0,0,71,34.0418,-117.7569,3.08,1,0,0,'http://www.wne.edu/pharmacy','309 E. Second St.','bonnie.mannix@wne.edu','0','413-796-2073',0),(75,'University of Hawaii--Hilo College of Pharmacy','Hilo','HI','96720',2.75,3.30,0,19660,36964,1,0,0,74,19.7025,-155.0939,3.02,1,0,0,'http://pharmacy.uhh.hawaii.edu/','200 W. Kawili Street','kristyna@hawaii.edu','0','808-932-7140',0),(76,'The University of Louisiana at Monroe College of Pharmacy','Monroe','LA','71201',2.75,3.40,65,19830,37528,1,0,0,74,32.5286,-92.1061,3.08,1,0,0,'http://www.ulm.edu/pharmacy/','1800 Bienville Dr.','caldwell@ulm.edu','0','318-342-3800',0),(77,'Wilkes University Nesbitt School of Pharmacy','Wilkes Barre','PA','18766',2.50,3.50,25,33232,33232,0,0,0,74,41.2436,-75.8850,3.00,1,0,0,'http://www.wilkes.edu/pages/390.asp','84 West South Street','Karen.atiyeh@wilkes.edu','0','570-408-4280',0),(78,'Long Island University Arnold & Marie Schwartz College of Pharmacy and Health Sciences','Brooklyn','NY','11201',3.00,3.40,48,32370,32370,1,0,0,77,40.6940,-73.9903,3.20,1,0,0,'http://www.liu.edu/pharmacy/index.html','1 University Plaza','admissions@brooklyn.liu.edu','0','718-488-1011',0),(79,'Massachusetts College of Pharmacy and Health Sciences--Worcester','Worcester','MA','01608',2.50,3.40,48,44530,44530,1,1,0,77,42.2653,-71.8794,2.95,1,0,0,'http://www.mcphs.edu/','19 Foster Street','bryan.witham@mcphs.edu','0','508-373-5607',0),(80,'Midwestern University College of Pharmacy','Glendale','AZ','85308',2.50,3.00,50,48169,48169,1,1,0,77,33.5311,-112.1767,2.75,1,0,0,'http://www.midwestern.edu/','19555 N. 59th Ave','admissaz@midwestern.edu','0','623-572-3275',0),(81,'Florida A&M University College of Pharmacy','Tallahassee','FL','32307',2.75,3.00,50,22580,33674,1,0,1,80,30.4286,-84.2593,2.88,1,0,0,'http://pharmacy.famu.edu/','1415 S. Martin Luther King, Jr. Blvd','michael.thompson@famu.edu','0','850-599-3301',0),(82,'Nova Southeastern University College of Pharmacy','Fort Lauderdale','FL','33328',2.75,2.75,0,29550,33250,1,0,1,80,26.1216,-80.1288,2.75,1,0,0,'http://pharmacy.nova.edu/','3200 S. University Drive','desideri@nova.edu','0','954-262-1112',0),(83,'Texas Southern University College of Pharmacy and Health Sciences','Houston','TX','77004',2.75,3.00,65,12656,19346,1,0,0,80,29.8131,-95.3098,2.88,1,0,0,'http://goo.gl/tdka76','3100 Cleburne Street','Liang_DX@tsu.edu','0','713-313-7011',0),(84,'Touro University--California College of Pharmacy','Vallejo','CA','94592',2.75,3.00,60,42390,42390,1,0,1,80,38.1582,-122.2804,2.88,1,0,0,'http://admissions.tu.edu/cop','1310 Club Drive','marcos.villa@tu.edu','0','707-638-5200',0),(85,'University of the Incarnate Word Feik School of Pharmacy','San Antonio','TX','78209',2.50,3.20,0,33160,33160,1,0,0,80,29.4711,-98.5356,2.85,1,0,0,'http://sites.uiw.edu/pharmacy/','4301 Broadway CPO #99','rxadmissions@uiwtx.edu','0','210-883-1000',0),(86,'Wingate University School of Pharmacy','Wingate','NC','28174',3.00,3.00,50,29840,29840,1,0,1,80,34.9847,-80.4476,3.00,1,0,0,'http://pharmacy.wingate.edu/','515 N Main Street<br>P.O. Box 159','pharmacy@wingate.edu','0','704-233-8324',0),(87,'Xavier University of Louisiana College of Pharmacy','New Orleans','LA','70125',2.75,3.20,0,28825,28825,0,0,0,80,29.9605,-90.0753,2.98,1,0,0,'http://www.xula.edu/cop/','1 Drexel Drive','','0','504-486-7411',0),(93,'University of Puerto Rico - Medical Sciences Campus','San Juan','Puerto Rico','00936',2.75,3.50,10,6912,7978,1,0,0,80,18.4659,-66.1036,3.13,1,0,0,'http://farmacia.rcm.upr.edu/','PO Box 365067','josephine.picorelly@upr.edu',NULL,'787-758-2525',0);
/*!40000 ALTER TABLE `pcatapp_ranked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pcatapp_student`
--

DROP TABLE IF EXISTS `pcatapp_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcatapp_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gpa` decimal(3,2) DEFAULT NULL,
  `zip_code` varchar(5) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `pcat` int(11) DEFAULT NULL,
  `min_tuition` int(11) DEFAULT NULL,
  `max_tuition` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_5be142e9` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pcatapp_student`
--

LOCK TABLES `pcatapp_student` WRITE;
/*!40000 ALTER TABLE `pcatapp_student` DISABLE KEYS */;
INSERT INTO `pcatapp_student` VALUES (1,3.50,'07645',1,NULL,NULL,NULL),(2,2.20,'11949',6,20,NULL,NULL),(3,3.50,'07012',8,80,NULL,NULL),(4,NULL,NULL,9,NULL,NULL,NULL);
/*!40000 ALTER TABLE `pcatapp_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pcatapp_student_ranked_favorites`
--

DROP TABLE IF EXISTS `pcatapp_student_ranked_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcatapp_student_ranked_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `ranked_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pcatapp_student_ranked_favorit_student_id_3af80143a090a078_uniq` (`student_id`,`ranked_id`),
  KEY `pcatapp_student_ranked_favorites_94741166` (`student_id`),
  KEY `pcatapp_student_ranked_favorites_095fd4df` (`ranked_id`),
  CONSTRAINT `ranked_id_refs_id_7f79388d` FOREIGN KEY (`ranked_id`) REFERENCES `pcatapp_ranked` (`id`),
  CONSTRAINT `student_id_refs_id_3fc82dc1` FOREIGN KEY (`student_id`) REFERENCES `pcatapp_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pcatapp_student_ranked_favorites`
--

LOCK TABLES `pcatapp_student_ranked_favorites` WRITE;
/*!40000 ALTER TABLE `pcatapp_student_ranked_favorites` DISABLE KEYS */;
INSERT INTO `pcatapp_student_ranked_favorites` VALUES (3,2,29),(4,3,1),(5,3,2),(6,3,4),(7,3,8),(8,3,23),(9,3,25),(10,3,27),(11,3,28),(17,4,6),(22,4,11);
/*!40000 ALTER TABLE `pcatapp_student_ranked_favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pcatapp_student_unranked_favorites`
--

DROP TABLE IF EXISTS `pcatapp_student_unranked_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcatapp_student_unranked_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `unranked_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pcatapp_student_unranked_favor_student_id_2b7f4e3c2911abe8_uniq` (`student_id`,`unranked_id`),
  KEY `pcatapp_student_unranked_favorites_94741166` (`student_id`),
  KEY `pcatapp_student_unranked_favorites_3ca0fc34` (`unranked_id`),
  CONSTRAINT `student_id_refs_id_ad4700ab` FOREIGN KEY (`student_id`) REFERENCES `pcatapp_student` (`id`),
  CONSTRAINT `unranked_id_refs_id_01722187` FOREIGN KEY (`unranked_id`) REFERENCES `pcatapp_unranked` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pcatapp_student_unranked_favorites`
--

LOCK TABLES `pcatapp_student_unranked_favorites` WRITE;
/*!40000 ALTER TABLE `pcatapp_student_unranked_favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `pcatapp_student_unranked_favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pcatapp_unranked`
--

DROP TABLE IF EXISTS `pcatapp_unranked`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcatapp_unranked` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(30) NOT NULL,
  `zip_code` varchar(5) NOT NULL,
  `gpa_overall` decimal(3,2) DEFAULT NULL,
  `gpa_expected` decimal(3,2) DEFAULT NULL,
  `min_pcat` int(11) DEFAULT NULL,
  `resident_tuition` int(11) NOT NULL,
  `nonresident_tuition` int(11) NOT NULL,
  `supplemental` tinyint(1) NOT NULL,
  `three_year` tinyint(1) NOT NULL,
  `dual_degree` tinyint(1) NOT NULL,
  `lat` decimal(7,4) DEFAULT NULL,
  `lon` decimal(7,4) DEFAULT NULL,
  `gpa_avg` decimal(3,2) DEFAULT NULL,
  `full_accred` tinyint(1) NOT NULL,
  `cand_accred` tinyint(1) NOT NULL,
  `prec_accred` tinyint(1) NOT NULL,
  `school_url` varchar(75) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `email` varchar(75) DEFAULT NULL,
  `regional_tuition` varchar(100) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `regional_bool` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pcatapp_unranked`
--

LOCK TABLES `pcatapp_unranked` WRITE;
/*!40000 ALTER TABLE `pcatapp_unranked` DISABLE KEYS */;
INSERT INTO `pcatapp_unranked` VALUES (2,'Appalachian College of Pharmacy','Oakwood','VA','24631',2.50,3.20,50,37000,37000,1,1,0,37.2138,-81.9917,2.85,1,0,0,'http://www.acp.edu/','1060 Dragon Road','acpinfo@acp.edu','0','276-498-4190',0),(3,'Belmont University College of Pharmacy','Nashville','TN','37212',2.70,3.30,0,31525,31525,1,0,0,36.1657,-86.7781,3.00,1,0,0,'http://belmont.edu/pharmacy/index.html','1900 Belmont Blvd','pharmacy@belmont.edu','0','615-460-8122',0),(4,'California Northstate University College of Pharmacy','Rancho Cordova','CA','95757',2.80,3.00,0,44668,44668,1,0,0,38.6072,-121.2761,2.90,1,0,0,'http://pharmacy.cnsu.edu/','9700 West Taron Drive','admissions@cnsu.edu','0','916-686-7400',0),(5,'Cedarville University School of Pharmacy','Cedarville','OH','45314',3.00,3.20,50,30558,30558,1,0,0,39.7484,-83.8013,3.10,0,1,0,'http://www.cedarville.edu/Academics/Pharmacy.aspx','251 N. Main Street','kateford@cedarville.edu','0','937-766-7480',0),(6,'Chicago State University College of Pharmacy','Chicago','IL','60628',2.50,3.20,0,25741,37237,1,0,0,42.3247,-87.8564,2.85,1,0,0,'http://www.csu.edu/pharmacy/','9501 S King Drive<br>Douglas Hall 206','pharmacy@csu.edu','0','773-821-2500',0),(7,'Concordia University School of Pharmacy','Mequon','WI','53097',2.75,3.20,40,30505,30505,0,0,0,43.2461,-88.0046,2.98,0,1,0,'http://www.cuw.edu/Programs/pharmacy','12800 N Lake Shore Drive','peter.welch@cuw.edu','0','262-243-2747',0),(8,'D\'Youville College School of Pharmacy','Buffalo','NY','14201',2.50,3.00,0,29600,29600,0,0,0,42.8967,-78.8846,2.75,0,1,0,'https://www.dyc.edu/academics/pharmacy/','320 Porter Avenue','pharmacyadmissions@dyc.edu','0','716-829-8440',0),(9,'East Tennessee State University Bill Gatton College of Pharmacy','Johnson City','TN','37614',2.50,3.00,0,31539,31539,1,0,1,36.3339,-82.3408,2.75,1,0,0,'http://www.etsu.edu/pharmacy/','Admissions Office<br>Box 70414','pharmacy@etsu.edu','0','423-439-6338',0),(10,'Fairleigh Dickinson University School of Pharmacy','Madison','NJ','07932',2.75,3.00,0,33500,33500,0,0,1,40.7599,-74.4179,2.88,0,1,0,'http://www.fdu.edu/academic/pharmacy/','230 Park Avenue<br>M-SP1-01','pharmacy@fdu.edu','0','973-443-8401',0),(11,'Hampton University School of Pharmacy','Hampton','VA','23668',2.75,0.00,0,28044,28044,0,0,0,37.0727,-76.3899,2.75,1,0,0,'http://pharm.hamptonu.edu/','100 E Queen St','','0','757-727-5071',0),(12,'Harding University College of Pharmacy','Searcy','AR','72149',2.75,3.30,0,33686,33686,1,0,0,35.2436,-91.7317,3.02,1,0,0,'http://www.harding.edu/pharmacy/','Director of Admissions<br>HU Box 12230','pharmacy@harding.edu','0','501-279-5528',0),(13,'Husson University School of Pharmacy','Bangor','ME','04401',2.75,3.50,0,30240,30240,0,0,0,44.8242,-68.7918,3.12,0,1,0,'http://www.husson.edu/pharmacy','1 College Circle','cardk@husson.edu','0','207-404-5660',0),(14,'LECOM School of Pharmacy','Erie','PA','16509',2.70,3.50,0,25500,25500,1,1,0,42.1260,-80.0860,3.10,1,0,0,'http://lecom.edu/school-pharmacy.php','1858 W. Grandview Boulevard','pharmacy@lecom.edu','0','814-866-6641',0),(15,'LECOM School of Pharmacy--Bradenton','Bradenton','FL','34211',2.70,3.50,0,22140,25312,1,0,0,27.4047,-82.4705,3.10,1,0,0,'http://lecom.edu/school-pharmacy.php','5000 Lakewood Ranch Boulevard','pharmacy@lecom.edu','0','941-756-0690',0),(16,'Lipscomb University College of Pharmacy and Health Sciences','Nashville','TN','37204',2.50,3.30,45,35946,35946,1,0,0,36.1657,-86.7781,2.90,1,0,0,'http://pharmacy.lipscomb.edu/','One University Park Drive','pharmapp@lipscomb.edu','0','615-966-1000',0),(17,'Loma Linda University School of Pharmacy','Loma Linda','CA','92350',2.75,3.40,45,43599,43599,1,0,1,34.8400,-115.9671,3.08,1,0,0,'http://www.llu.edu/pharmacy','School of Pharmacy<br>Shryock Hall, Room 106','admissions.sp@llu.edu','0','909-558-1300',0),(18,'Manchester University College of Pharmacy','Fort Wayne','IN','46845',2.50,3.00,45,37000,37000,1,0,0,41.0938,-85.0707,2.75,0,1,0,'http://www.manchester.edu/pharmacy/','10627 Diebold Road','pharmacy@manchester.edu','0','260-470-2703',0),(19,'Marshall University School of Pharmacy','Huntington','WV','25755',0.00,0.00,45,16926,28916,1,0,0,38.4097,-82.4423,2.00,0,1,0,'http://www.marshall.edu/pharmacy','One John Marshall Drive','ogg2@marshall.edu','0','304-696-7352',0),(20,'Notre Dame of Maryland University School of Pharmacy','Baltimore','MD','21210',2.50,3.00,50,37500,37500,1,0,0,39.2946,-76.6252,2.75,1,0,0,'http://www.ndm.edu/','4701 North Charles Street','lshattuck@ndm.edu','0','410-532-5551',0),(21,'Pacific University School of Pharmacy','Hillsboro','OR','97123',2.70,0.00,0,43932,43932,1,1,1,45.4984,-122.9570,2.70,1,0,0,'http://www.pacificu.edu/pharmd/','222 SE 8th Ave','gradadmissions@pacificu.edu','0','503-352-7283',0),(22,'Palm Beach Atlantic University (Gregory) Lloyd L. Gregory School of Pharmacy','West Palm Beach','FL','33416',2.75,3.34,60,33000,33000,1,0,1,26.7165,-80.0679,3.04,1,0,0,'https://www.pba.edu/school-of-pharmacy','901 South Flagler Drive <br>P.O. Box 24708','Pharmacy_Admissions@PBA.edu','0','561-803-2750',0),(23,'PCOM School of Pharmacy--Georgia','Suwanee','GA','19131',2.50,3.00,0,33905,33905,1,0,0,34.0425,-84.0262,2.75,0,1,0,'http://goo.gl/N86cYW','4170 City Avenue','Pharmdadmissions@pcom.edu','0','215-871-6100',0),(24,'Presbyterian College School of Pharmacy','Clinton','SC','29325',2.50,3.25,0,33000,33000,1,0,0,34.4707,-81.8772,2.88,0,1,0,'http://pharmacy.presby.edu/','307 North Broad Street','pharmacy@presby.edu','0','864-938-3911',0),(25,'Regis University School of Pharmacy Rueckert-Hartman College for Health Professions','Denver','CO','80221',2.50,3.20,30,37190,37190,0,0,0,39.7263,-104.8568,2.85,1,0,0,'http://www.regis.edu/pharmacy','3333 Regis Boulevard, G-9','pharmacy@regis.edu','0','303-458-4344',0),(26,'Roosevelt University College of Pharmacy','Schaumburg','IL','60173',2.75,2.75,40,45250,45250,0,1,1,41.8119,-87.6873,2.75,0,1,0,'http://www.roosevelt.edu/pharmacy','1400 N. Roosevelt Boulevard','skeating@roosevelt.edu','0','847-330-4500',0),(27,'Rosalind Franklin University of Medicine and Sciences College of Pharmacy','North Chicago','IL','60064',2.50,3.20,0,30870,30870,1,0,0,42.3247,-87.8564,2.85,0,1,0,'http://www.rosalindfranklin.edu/Degreeprograms/Pharmacy.aspx','3333 Green Bay Road','pharmacy.admissions@rosalindfranklin.edu','0','847-578-3204',0),(28,'Roseman University of Health Sciences College of Pharmacy','Henderson','NV','89014',2.80,3.50,0,45500,45500,1,1,1,36.0008,-114.9588,3.15,1,0,0,'http://www.roseman.edu/','11 Sunset Way','mdeyoung@roseman.edu','0','702-968-2006',0),(29,'South College School of Pharmacy','Knoxville','TN','37922',2.50,3.25,20,41274,41274,1,1,0,36.0323,-83.8848,2.88,0,1,0,'http://www.southcollegetn.edu/pharmacy/main.htm','400 Goody\'s Lane','dsmith1@southcollegetn.edu','0','865-288-5871',0),(30,'South University School of Pharmacy','Savannah','GA','31406',2.80,3.00,0,44540,44540,1,1,1,32.0749,-81.0883,2.90,1,0,0,'http://www.southuniversity.edu/pharmacy','709 Mall Blvd','mjones@southuniversity.edu','0','912-201-8120',0),(31,'Southwestern Oklahoma State University School of Pharmacy','Weatherford','OK','73096',2.50,3.30,50,7832,14600,1,0,0,35.5350,-98.6996,2.90,1,0,0,'http://www.swosu.edu/academics/PHARMACY/','100 Campus Drive','pharmacy@swosu.edu','0','580-774-3105',0),(32,'St. John Fisher College Wegmans School of Pharmacy','Rochester','NY','14618',2.75,3.40,65,34760,34760,0,0,1,43.1128,-77.4906,3.08,1,0,0,'http://www.sjfc.edu/pharmacy/admissions/','3690 East Avenue','pharmacy@sjfc.edu','0','800-444-4640',0),(33,'Sullivan University College of Pharmacy','Louisville','KY','40205',2.50,3.30,70,44334,44334,0,1,1,38.1890,-85.6768,2.90,1,0,0,'http://www.sullivan.edu/pharmacy','2100 Gardiner Lane','FFacione@sullivan.edu','0','502-413-8643',0),(34,'Thomas Jefferson University Jefferson School of Pharmacy','Philadelphia','PA','19107',2.70,3.00,70,34600,34600,1,0,0,40.6754,-76.1558,2.85,1,0,0,'http://www.jefferson.edu/jchp/pharmacy/','130 S. 9th Street<br>Suite 100','niki.kelley@jefferson.edu','0','215-503-1041',0),(35,'Touro College of Pharmacy - New York College of Pharmacy','New York','NY','10027',2.50,3.00,70,38300,38300,1,0,0,40.7069,-73.6731,2.75,1,0,0,'http://www1.touro.edu/pharmacy/','230 West 125th Street','admissions.pharmacy@touro.edu','0','212-851-1192',0),(36,'Union University School of Pharmacy','Jackson','TN','38305',2.50,2.50,0,31790,31790,1,0,1,35.6102,-88.8140,2.50,1,0,0,'http://www.uu.edu/programs/pharmacy/','1050 Union University Drive<br>BOX 1802','khmartin@uu.edu','0','731-661-5910',0),(37,'University of Charleston School of Pharmacy','Charleston','WV','25304',2.75,3.20,50,28000,28000,1,0,0,38.3490,-81.6306,2.98,1,0,0,'http://www.ucwv.edu/pharmacy','2300 MacCorkle Avenue, SE','pharmacy@ucwv.edu','0','304-357-4889',0),(38,'University of Findlay College of Pharmacy','Findlay','OH','45840',3.30,3.30,50,38200,38200,1,0,1,40.9933,-83.6507,3.30,1,0,0,'http://goo.gl/DSi3gb','1000 N. Main Street','adepuy@findlay.edu','0','419-434-4636',0),(39,'University of Maryland--Eastern Shore School of Pharmacy','Princess Anne','MD','21853',2.75,3.00,40,29015,52614,1,1,0,38.1919,-75.7072,2.88,1,0,0,'http://www.umes.edu/pharmacy','1 Backbone Road, Somerset Hall ','rxstudentaffairs@umes.edu','0','410-621-2292',0),(40,'University of New England College of Pharmacy','Portland','ME','04103',2.50,2.80,35,37335,37335,0,0,0,43.6606,-70.2589,2.65,1,0,0,'http://www.une.edu/pharmacy/admissions','716 Stevens Avenue','gradadmissions@une.edu','0','207-221-4225',0),(41,'University of South Florida School of Pharmacy','Tampa','FL','33612',2.75,3.20,65,18175,35920,1,0,0,27.9961,-82.5820,2.98,0,1,0,'http://health.usf.edu/nocms/pharmacy/','12901 Bruce B Downs Blvd<br>MDC 30','pharmdadmissions@health.usf.edu','0','813-974-2340',0),(42,'University of St. Joseph School of Pharmacy','Hartford','CT','06103',2.80,3.00,0,43704,43704,1,1,0,41.8468,-73.0104,2.90,0,1,0,'http://www.usj.edu/pharmacy','229 Trumbull Street','bnicholas@usj.edu','0','860-231-5869',0),(43,'Western New England University College of Pharmacy','Springfield','MA','01119',2.80,3.30,0,38820,38820,0,0,1,42.1151,-72.6411,3.05,0,1,0,'http://www.wne.edu/pharmacy','1215 Wilbraham Road','bonnie.mannix@wne.edu','0','413-796-2073',0),(44,'University of North Texas System College of Pharmacy','Fort Worth','TX','76107',2.50,0.00,0,19501,33541,1,0,0,32.7714,-97.2915,2.50,0,0,1,'http://web.unthsc.edu/','3500 Camp Bowie Blvd.','pharmapp@unthsc.edu','0','817-735-2381',0),(45,'Howard University College of Pharmacy','Washington','D.C.','20059',2.50,3.20,0,27997,27997,0,0,0,38.9122,-77.0177,2.85,1,0,0,'http://pharmacy.howard.edu/','2300 Fourth Street NW','marlon.prince@howard.edu',NULL,'202-806-6533',0);
/*!40000 ALTER TABLE `pcatapp_unranked` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `extra_data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_uid_5ac8b4eb459472be_uniq` (`uid`,`provider`),
  KEY `socialaccount_socialaccount_6340c63c` (`user_id`),
  CONSTRAINT `user_id_refs_id_b4f0248b` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `key` varchar(100) NOT NULL,
  `secret` varchar(100) NOT NULL,
  `client_id` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_711547c3e6a002b_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_f2973cd1` (`socialapp_id`),
  KEY `socialaccount_socialapp_sites_99732b5c` (`site_id`),
  CONSTRAINT `site_id_refs_id_05d6147e` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `socialapp_id_refs_id_e7a43014` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_697928748c2e1968_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_socialtoken_60fc113e` (`app_id`),
  KEY `socialaccount_socialtoken_93025c2f` (`account_id`),
  CONSTRAINT `account_id_refs_id_1337a128` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `app_id_refs_id_edac8a54` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'pcatapp','0001_initial','2014-05-11 19:31:10'),(2,'pcatapp','0002_auto__chg_field_ranked_zip_code','2014-05-11 19:31:22'),(3,'pcatapp','0003_auto__chg_field_unranked_zip_code','2014-05-11 19:35:07'),(4,'pcatapp','0004_auto__add_field_ranked_lat__add_field_ranked_lon__add_field_unranked_l','2014-05-12 04:40:48'),(5,'pcatapp','0005_auto__chg_field_ranked_lon__chg_field_ranked_lat__chg_field_unranked_l','2014-05-12 05:13:30'),(6,'socialaccount','0001_initial','2014-05-14 19:55:33'),(7,'socialaccount','0002_genericmodels','2014-05-14 19:55:33'),(8,'socialaccount','0003_auto__add_unique_socialaccount_uid_provider','2014-05-14 19:55:33'),(9,'socialaccount','0004_add_sites','2014-05-14 19:55:33'),(10,'socialaccount','0005_set_sites','2014-05-14 19:55:33'),(11,'socialaccount','0006_auto__del_field_socialapp_site','2014-05-14 19:55:33'),(12,'socialaccount','0007_auto__add_field_socialapp_client_id','2014-05-14 19:55:33'),(13,'socialaccount','0008_client_id','2014-05-14 19:55:33'),(14,'socialaccount','0009_auto__add_field_socialtoken_expires_at','2014-05-14 19:55:33'),(15,'socialaccount','0010_auto__chg_field_socialtoken_token','2014-05-14 19:55:33'),(16,'socialaccount','0011_auto__chg_field_socialtoken_token','2014-05-14 19:55:33'),(18,'tastypie','0001_initial','2014-05-21 14:09:44'),(19,'tastypie','0002_add_apikey_index','2014-05-21 14:09:44'),(20,'pcatapp','0006_auto__chg_field_student_gpa__chg_field_student_zip_code','2014-06-04 15:49:09'),(21,'pcatapp','0007_auto__chg_field_student_gpa__chg_field_student_zip_code','2014-06-06 16:42:02'),(22,'pcatapp','0008_auto__chg_field_student_gpa__chg_field_student_zip_code','2014-06-06 16:42:16'),(23,'pcatapp','0009_auto__add_field_student_pcat__add_field_student_min_tuition__add_field','2014-06-10 21:18:21'),(24,'pcatapp','0010_auto__add_field_ranked_gpa_avg__add_field_unranked_gpa_avg','2014-06-14 23:11:09'),(25,'pcatapp','0011_auto__del_field_ranked_accred_status__add_field_ranked_full_accred__ad','2014-06-14 23:37:33'),(26,'pcatapp','0012_auto__del_field_unranked_accred_status__add_field_unranked_full_accred','2014-06-14 23:43:09'),(27,'pcatapp','0013_auto__add_field_ranked_school_url__add_field_ranked_street__add_field_','2014-06-20 16:17:32'),(28,'pcatapp','0014_auto','2014-06-20 16:17:32'),(29,'pcatapp','0015_auto__add_field_ranked_regional_tuition__add_field_unranked_regional_t','2014-06-20 16:17:32'),(30,'pcatapp','0016_auto__del_field_ranked_regional_tuition__del_field_unranked_regional_t','2014-06-20 16:17:32'),(31,'pcatapp','0017_auto__add_field_ranked_regional_tuition__add_field_unranked_regional_t','2014-06-20 16:17:32'),(32,'pcatapp','0018_auto__add_field_ranked_phone__add_field_unranked_phone','2014-06-23 19:28:22'),(33,'pcatapp','0019_auto__chg_field_ranked_phone__chg_field_unranked_phone','2014-06-23 19:30:35'),(34,'pcatapp','0020_auto__chg_field_ranked_regional_tuition__chg_field_unranked_regional_t','2014-06-25 15:34:29'),(35,'pcatapp','0021_auto__chg_field_ranked_regional_tuition__chg_field_unranked_regional_t','2014-06-25 16:20:34'),(36,'pcatapp','0022_auto__add_field_ranked_regional_bool__add_field_unranked_regional_bool','2014-07-10 20:51:32');
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tastypie_apiaccess`
--

DROP TABLE IF EXISTS `tastypie_apiaccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tastypie_apiaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `request_method` varchar(10) NOT NULL,
  `accessed` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tastypie_apiaccess`
--

LOCK TABLES `tastypie_apiaccess` WRITE;
/*!40000 ALTER TABLE `tastypie_apiaccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `tastypie_apiaccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tastypie_apikey`
--

DROP TABLE IF EXISTS `tastypie_apikey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tastypie_apikey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `key` varchar(256) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_990aee10` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tastypie_apikey`
--

LOCK TABLES `tastypie_apikey` WRITE;
/*!40000 ALTER TABLE `tastypie_apikey` DISABLE KEYS */;
/*!40000 ALTER TABLE `tastypie_apikey` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-09-12 15:37:08
