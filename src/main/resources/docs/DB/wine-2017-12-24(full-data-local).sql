-- MySQL dump 10.13  Distrib 5.7.18, for osx10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: wine
-- ------------------------------------------------------
-- Server version	5.7.18

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
-- Current Database: `wine`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wine` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `wine`;

--
-- Table structure for table `bannar`
--

DROP TABLE IF EXISTS `bannar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bannar` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'bannarID',
  `img` varchar(200) DEFAULT NULL COMMENT 'banner图片',
  `title` varchar(100) DEFAULT NULL COMMENT '图片居中标题',
  `description` varchar(200) DEFAULT NULL COMMENT '图片居中详述',
  `idx` int(6) unsigned DEFAULT NULL COMMENT 'bannar位置',
  `item_id` int(10) unsigned DEFAULT NULL COMMENT '商品ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_idx` (`idx`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='首屏bannar表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bannar`
--

LOCK TABLES `bannar` WRITE;
/*!40000 ALTER TABLE `bannar` DISABLE KEYS */;
INSERT INTO `bannar` VALUES (1,'images/banner-1.jpg','经典洋河好酒','酒体饱满丰润，珍藏版佳酿！',1,1,'2017-08-06 07:45:28',NULL),(2,'images/banner-2.jpg','长城 干红葡萄酒','细选葡萄原料，用心酿制而成！',2,2,'2017-08-06 07:45:28',NULL),(3,'images/banner-3.jpg','茅台 15年贵州茅台酒','天贵人和，厚德致远！',3,3,'2017-08-06 07:45:28',NULL),(4,'images/banner-4.jpg','郎酒 红花郎酒','自然美景，良好水源，天宝洞藏！',4,4,'2017-08-06 07:45:28',NULL),(5,'images/banner-5.jpg','小糊涂仙 浓香型','选用高粱，秉承传统工艺酿造而成！',5,5,'2017-08-06 07:45:28',NULL);
/*!40000 ALTER TABLE `bannar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '目录ID',
  `name` varchar(20) DEFAULT NULL COMMENT '目录名称',
  `level` int(6) DEFAULT '1' COMMENT '目录层级',
  `idx` int(11) DEFAULT NULL COMMENT '本层级内的排列位置',
  `parent_id` int(10) unsigned DEFAULT '0' COMMENT '父目录ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_parent_id_idx` (`parent_id`,`idx`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='商品类目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'酒水',1,1,0,'2017-08-13 08:22:50','2017-08-19 07:21:15'),(2,'茶叶',1,2,0,'2017-08-13 08:22:50','2017-08-19 07:21:21'),(3,'礼品',1,3,0,'2017-08-13 08:22:50','2017-08-19 07:21:28'),(4,'集市',1,4,0,'2017-08-13 08:22:50','2017-08-19 07:21:31'),(5,'白酒',2,1,1,'2017-08-13 08:22:50','2017-08-19 07:21:34'),(6,'红酒',2,2,1,'2017-08-13 08:22:51','2017-08-19 07:21:35'),(7,'啤酒',2,3,1,'2017-08-13 08:22:51','2017-08-19 07:21:36'),(8,'碧螺春',2,1,2,'2017-08-13 08:22:51','2017-08-19 07:21:38'),(9,'龙井',2,2,2,'2017-08-13 08:22:51','2017-08-19 07:21:39'),(10,'海鲜',2,1,3,'2017-08-13 08:22:51','2017-08-19 07:21:41'),(11,'肉',2,2,3,'2017-08-13 08:22:51','2017-08-19 07:21:44'),(12,'鱼',2,3,3,'2017-08-13 08:22:51','2017-08-19 07:21:49');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `icon` varchar(200) DEFAULT NULL COMMENT '商品缩略图',
  `detail` varchar(200) DEFAULT '' COMMENT '商品详情描述',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT '目录ID',
  `normal_price` decimal(10,2) DEFAULT NULL COMMENT '普通价格',
  `vip_price` decimal(10,2) DEFAULT NULL COMMENT '会员价格',
  `back_points` int(10) unsigned DEFAULT NULL COMMENT '返送积分',
  `sales` int(11) DEFAULT NULL COMMENT '商品销量',
  `status` int(6) DEFAULT '2' COMMENT '商品状态（1：上架、2：下架、3：删除）',
  `title_imgs` varchar(1000) DEFAULT NULL COMMENT '商品预览图片（以，分隔）',
  `detail_imgs` varchar(1000) DEFAULT NULL COMMENT '商品详情图片（以，分隔）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='商品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'泸州老窖 国窖 1573','images/product-1.jpg','洋河蓝色经典 天之蓝 46度 480ml 绵柔浓香型',5,12.80,12.80,1000,44,1,'images/p1-1.jpg,images/p1-2.jpg,images/p1-3.jpg,images/p1-6.jpg,images/p1-4.jpg,images/p1-5.jpg','images/p1-img1.jpg,images/p1-img2.jpg,images/p1-img3.jpg,images/p1-img4.jpg,images/p1-img5.jpg,images/p1-img6.jpg,images/p1-img7.jpg,images/p1-img8.jpg,images/p1-img9.jpg,images/p1-img10.jpg,images/p1-img11.jpg,images/p1-img12.jpg,images/p1-img13.jpg,images/p1-img14.jpg','2017-08-13 08:28:14','2017-11-13 03:08:08'),(2,'小糊涂仙 浓香型','images/product-2.jpg','小糊涂仙 浓香型白酒 52度 100ml 精致小酒版',5,1200.00,800.00,1000,25,1,NULL,NULL,'2017-08-13 08:28:14','2017-11-13 03:44:11'),(3,'郎酒 红花郎酒','images/product-3.jpg','茅台 王子 53度 单瓶装白酒 500ml 口感酱香型',5,1200.00,800.00,1000,19,1,NULL,NULL,'2017-08-13 08:28:14','2017-09-10 11:19:15'),(4,'茅台 15年贵州茅台酒','images/product-4.jpg','酱香型！ 贵州茅台，国货匠心， 收藏精品，越品越有味！“风味隔壁三家醉，雨后开瓶十里芳”！',5,1200.00,800.00,1000,21,1,NULL,NULL,'2017-08-13 08:28:14','2017-10-01 11:24:14'),(5,'巴黎之花 PerrierJouet特级干型香槟','images/product-5.jpg','',6,1200.00,800.00,1000,20,1,NULL,NULL,'2017-08-13 08:28:14','2017-09-02 18:56:10'),(6,'长城 干红葡萄酒','images/product-6.jpg','',6,1200.00,800.00,1000,19,1,NULL,NULL,'2017-08-13 08:28:14','2017-09-02 18:56:10'),(7,'1664白啤酒','images/product-7.jpg','',7,1200.00,800.00,1000,18,1,NULL,NULL,'2017-08-13 08:28:14',NULL),(8,'Baileys/百利甜酒 爱尔兰甜酒','images/product-8.jpg','',7,1200.00,800.00,1000,19,1,NULL,NULL,'2017-08-13 08:28:14','2017-09-10 11:12:43'),(11,'测试888','images/icon-X39ShJkx.png','测试888',7,1000.00,100.00,NULL,100,1,'images/title-r7fqePoo.png,images/title-9NwMunOv.png,images/title-BSqe4ioI.png,images/title-onnkeOzl.png','images/detail-ZuIGN1aw.png,images/detail-LOoscejk.png,images/detail-mftsz0am.png,images/detail-vYH8WOgg.png,images/detail-TaKrSAC3.png,images/detail-rJXqnhxl.png,images/detail-XTkcwgvN.png,images/detail-HadZgm7U.png,images/detail-9pi7LcCv.png','2017-09-27 14:10:28','2017-09-27 14:17:02');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总额',
  `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '支付金额',
  `coupons` int(10) DEFAULT NULL COMMENT '使用积分',
  `address` varchar(200) DEFAULT NULL COMMENT '订单地址',
  `ships` decimal(10,2) DEFAULT NULL COMMENT '运费',
  `ship_type` int(6) DEFAULT '1' COMMENT '派送方式：（1：快递，2：同城快速配送）',
  `status` int(6) DEFAULT '1' COMMENT '订单状态（位表示法，第1位：是否下单，第2位：是否取消订单，第3位：是否开始送货，第4位：是否送货完成，第5位：是否支付完成）',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '下单用户ID',
  `contactor` varchar(20) DEFAULT NULL COMMENT '订单联系人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `remark` varchar(200) DEFAULT NULL COMMENT '订单备注',
  `items` varchar(200) DEFAULT NULL COMMENT '订单商品列表（id|count[,id|count]）',
  `source_type` varchar(50) DEFAULT NULL COMMENT '订单来源类型（normal：普通商品，rush：1元购活动）',
  `spm` varchar(200) DEFAULT NULL COMMENT '推广源跟踪（a.b.c.d）',
  `pay_id` varchar(64) DEFAULT NULL COMMENT '微信统一下单的预支付ID',
  `pay_type` int(6) DEFAULT '0' COMMENT '支付类型（0：微信支付，1：现金）',
  `pay_status` int(6) DEFAULT '0' COMMENT '支付状态（0：未支付，1：支付成功，2：支付失败，3：转入退款，4：已关闭，5：已撤销（刷卡支付），6： 用户支付中）',
  `pay_time` datetime DEFAULT NULL COMMENT '支付完成时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (3,2400.00,NULL,100,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'5:2,6:1','normal',NULL,NULL,0,0,NULL,'2017-09-02 18:56:09',NULL),(4,1600.00,NULL,400,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1,4:1','normal',NULL,NULL,0,0,NULL,'2017-09-02 19:00:18',NULL),(5,710.00,NULL,100,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-03 02:38:22',NULL),(6,710.00,NULL,100,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-03 03:01:19',NULL),(7,810.00,NULL,0,'如东县环镇乡',10.00,1,3,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,'',0,0,NULL,'2017-09-03 03:05:39','2017-09-03 03:35:57'),(8,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'2:1','normal',NULL,'',0,0,NULL,'2017-09-03 04:00:17','2017-09-03 04:00:32'),(9,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-03 04:03:25',NULL),(10,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'2:1','normal',NULL,'',0,0,NULL,'2017-09-03 04:03:38','2017-09-03 04:03:41'),(11,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-08 00:01:08',NULL),(12,1600.00,1610.00,0,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'2:1,8:1','normal',NULL,'',0,0,NULL,'2017-09-10 11:12:43','2017-10-01 11:24:32'),(13,3200.00,2210.00,1000,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'3:1,4:1,2:1,1:1','normal',NULL,NULL,0,0,NULL,'2017-09-10 11:19:15',NULL),(14,800.00,810.00,0,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'2:1','normal',NULL,NULL,0,0,NULL,'2017-09-10 11:21:40',NULL),(15,800.00,810.00,0,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'2:1','normal',NULL,NULL,0,0,NULL,'2017-09-10 11:22:26',NULL),(16,2400.00,2000.00,406,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:3','normal',NULL,NULL,0,0,NULL,'2017-09-10 16:54:20',NULL),(17,800.00,806.00,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'4:1','normal',NULL,NULL,0,0,NULL,'2017-10-01 11:24:13',NULL),(18,800.00,806.00,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-03 10:41:11',NULL),(19,12.80,1.80,17,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:30:04',NULL),(20,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:31:05',NULL),(21,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:34:12',NULL),(22,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:40:19',NULL),(23,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:41:47',NULL),(24,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:48:09',NULL),(25,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:49:33',NULL),(26,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:51:50',NULL),(27,51.20,57.20,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:4','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:59:38',NULL),(28,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 18:03:37',NULL),(29,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-11-13 01:54:04',NULL),(30,12.80,18.80,0,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-11-13 03:08:08',NULL),(31,800.00,810.00,0,'如东县环镇乡',10.00,2,1,2,'印霞','13122876562',NULL,'2:1','normal',NULL,NULL,0,0,NULL,'2017-11-13 03:44:11',NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `point_detail`
--

DROP TABLE IF EXISTS `point_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `point_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '积分明细ID',
  `points` int(10) unsigned DEFAULT NULL COMMENT '积分数额',
  `type` char(1) DEFAULT NULL COMMENT '积分记录类型（+：加分、-：扣分）',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `order_id` int(10) unsigned DEFAULT NULL COMMENT '订单ID（返送积分缘由：购买商品）',
  `promotee_id` int(10) unsigned DEFAULT NULL COMMENT '介绍购买的用户ID（返送积分缘由：推荐会员）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(200) DEFAULT NULL COMMENT '明细备注',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='账户积分明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_detail`
--

LOCK TABLES `point_detail` WRITE;
/*!40000 ALTER TABLE `point_detail` DISABLE KEYS */;
INSERT INTO `point_detail` VALUES (6,100,'-',1,3,NULL,'2017-09-02 18:56:10',NULL,NULL),(7,400,'-',1,4,NULL,'2017-09-02 19:00:18',NULL,NULL),(8,100,'-',2,5,NULL,'2017-09-03 02:38:22',NULL,'2017-09-04 07:24:39'),(9,100,'-',1,6,NULL,'2017-09-03 03:01:19',NULL,NULL),(10,0,'-',1,7,NULL,'2017-09-03 03:05:39',NULL,NULL),(11,0,'-',2,8,NULL,'2017-09-03 04:00:17',NULL,'2017-09-04 07:24:20'),(12,0,'-',1,9,NULL,'2017-09-03 04:03:25',NULL,NULL),(13,0,'-',1,10,NULL,'2017-09-03 04:03:38',NULL,NULL),(14,1000,'-',2,13,NULL,'2017-09-10 11:19:15',NULL,NULL),(15,406,'-',2,16,NULL,'2017-09-10 16:54:20',NULL,NULL),(16,1111,'+',1,NULL,NULL,'2017-09-28 20:21:26','管理员加分',NULL),(17,17,'-',2,19,NULL,'2017-10-09 17:30:04','积分消费',NULL),(18,4423,'+',2,NULL,NULL,'2017-12-24 11:08:59','管理员加分',NULL);
/*!40000 ALTER TABLE `point_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rush_item`
--

DROP TABLE IF EXISTS `rush_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rush_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '1元抢购商品ID',
  `name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `icon` varchar(200) DEFAULT NULL COMMENT '商品缩略图',
  `detail` varchar(200) DEFAULT '' COMMENT '商品详情描述',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT '目录ID',
  `normal_price` decimal(10,2) DEFAULT NULL COMMENT '普通价格',
  `vip_price` decimal(10,2) DEFAULT NULL COMMENT '会员价格',
  `back_points` int(10) unsigned DEFAULT NULL COMMENT '返送积分',
  `buyers` int(11) DEFAULT NULL COMMENT '参与人数',
  `counts` int(11) DEFAULT NULL COMMENT '抢购份数',
  `status` int(6) DEFAULT '2' COMMENT '商品状态（1：进行中、2：未开始、3：已结束）',
  `start_tiem` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `images` varchar(1000) DEFAULT NULL COMMENT '商品图片（以，分隔）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='1元抢购商品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rush_item`
--

LOCK TABLES `rush_item` WRITE;
/*!40000 ALTER TABLE `rush_item` DISABLE KEYS */;
INSERT INTO `rush_item` VALUES (1,'经典海之蓝','images/offer-1 (2).jpg','',5,1200.00,800.00,1000,98,198,1,NULL,NULL,NULL,'2017-08-13 09:27:33','2017-08-20 02:46:28'),(2,'法国精品葡萄酒','images/offer-8.jpg','',5,1200.00,800.00,1000,78,198,1,NULL,NULL,NULL,'2017-08-13 09:28:55','2017-08-20 02:46:44');
/*!40000 ALTER TABLE `rush_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `name` varchar(20) DEFAULT NULL COMMENT '用户名字',
  `phone` varchar(11) DEFAULT NULL COMMENT '用户手机',
  `type` int(10) DEFAULT '0' COMMENT '用户类型（0：会员、1：代理商）',
  `points` int(10) unsigned DEFAULT '0' COMMENT '用户积分',
  `open_id` varchar(50) DEFAULT NULL COMMENT '微信open_id',
  `unionid` varchar(50) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL COMMENT '用户昵称',
  `sex` char(1) DEFAULT NULL,
  `language` varchar(15) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL COMMENT '常用地址',
  `city` varchar(15) DEFAULT NULL,
  `province` varchar(15) DEFAULT NULL,
  `country` varchar(15) DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL COMMENT '推广人ID',
  `subscribe_time` datetime DEFAULT NULL,
  `qrcode_ticket` varchar(200) DEFAULT NULL COMMENT '推广二维码ticket',
  `qrcode_url` varchar(200) DEFAULT NULL COMMENT '推广二维码最终链接',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_OPEN_ID` (`open_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'顾汉杰','13052333613',1,6666,'123',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2017-08-27 01:56:23','2017-09-28 20:21:26'),(2,'印霞','13122876562',1,8000,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2017-08-27 02:14:41','2017-12-24 11:08:59');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vip_item`
--

DROP TABLE IF EXISTS `vip_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vip_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `name` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `icon` varchar(200) DEFAULT NULL COMMENT '商品缩略图',
  `detail` varchar(200) DEFAULT '' COMMENT '商品详情描述',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT '目录ID',
  `normal_price` decimal(10,2) DEFAULT NULL COMMENT '普通价格',
  `vip_price` decimal(10,2) DEFAULT NULL COMMENT '会员价格',
  `back_points` int(10) unsigned DEFAULT NULL COMMENT '返送积分',
  `sales` int(11) DEFAULT NULL COMMENT '商品销量',
  `status` int(6) DEFAULT '2' COMMENT '商品状态（1：上架、2：下架、3：删除）',
  `title_imgs` varchar(1000) DEFAULT NULL COMMENT '商品预览图片（以，分隔）',
  `detail_imgs` varchar(1000) DEFAULT NULL COMMENT '商品详情图片（以，分隔）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='VIP商品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vip_item`
--

LOCK TABLES `vip_item` WRITE;
/*!40000 ALTER TABLE `vip_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `vip_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wine'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-24 21:28:29
