-- MySQL dump 10.13  Distrib 5.6.37, for linux-glibc2.12 (x86_64)
--
-- Host: 127.0.0.1    Database: wine
-- ------------------------------------------------------
-- Server version	5.6.37-log

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

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wine` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `wine`;

--
-- Table structure for table `bannar`
--

DROP TABLE IF EXISTS `bannar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bannar` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'bannarID',
  `img` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'banner图片',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片居中标题',
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片居中详述',
  `idx` int(6) unsigned DEFAULT NULL COMMENT 'bannar位置',
  `item_id` int(10) unsigned DEFAULT NULL COMMENT '商品ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_idx` (`idx`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='首屏bannar表';
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
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '目录名称',
  `level` int(6) DEFAULT '1' COMMENT '目录层级',
  `idx` int(11) DEFAULT NULL COMMENT '本层级内的排列位置',
  `parent_id` int(10) unsigned DEFAULT '0' COMMENT '父目录ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_parent_id_idx` (`parent_id`,`idx`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品类目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'酒水饮料',1,1,0,'2017-09-28 16:11:24',NULL),(2,'茶叶礼品',1,2,0,'2017-09-28 16:11:24',NULL),(3,'吃货天堂',1,3,0,'2017-09-28 16:11:24',NULL),(4,'家居百货',1,4,0,'2017-09-28 16:11:24',NULL),(5,'手机数码',1,5,0,'2017-09-28 16:11:24',NULL),(6,'电脑办公',1,6,0,'2017-09-28 16:11:24',NULL),(7,'美妆护理',1,7,0,'2017-09-28 16:11:24',NULL),(8,'白酒',2,1,1,'2017-09-28 16:11:24',NULL),(9,'红酒',2,2,1,'2017-09-28 16:11:24',NULL),(10,'洋酒',2,3,1,'2017-09-28 16:11:24',NULL),(11,'饮料',2,4,1,'2017-09-28 16:11:24',NULL),(12,'整机',2,1,6,'2017-09-28 16:11:24',NULL),(13,'配件',2,2,6,'2017-09-28 16:11:24',NULL),(14,'耗材',2,3,6,'2017-09-28 16:11:24',NULL);
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `icon` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品缩略图',
  `detail` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '商品详情描述',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT '目录ID',
  `normal_price` decimal(10,2) DEFAULT NULL COMMENT '普通价格',
  `vip_price` decimal(10,2) DEFAULT NULL COMMENT '会员价格',
  `back_points` int(10) unsigned DEFAULT NULL COMMENT '返送积分',
  `sales` int(11) DEFAULT NULL COMMENT '商品销量',
  `status` int(6) DEFAULT '2' COMMENT '商品状态（1：上架、2：下架、3：删除）',
  `title_imgs` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品预览图片（以，分隔）',
  `detail_imgs` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品详情图片（以，分隔）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (12,'洋河海之蓝','images/icon-mKRpIWZL.png','生产许可证编号: QS320015010829\n 厂名: 江苏洋河酒厂股份有限公司\n 厂址: 江苏省宿迁市洋河中大街118号、江苏省宿迁市泗阳县来安中大街118号\n 厂家联系方式: 4009991919\n 配料表: 水、高粱、大米、糯米、玉米、小麦、大麦、豌豆.食品添加剂: 无\n 体积(ml): 480\n 品牌: 洋河\n 品名: 海之蓝\n 是否为有机食品: 否\n 产地:',8,128.00,118.00,NULL,26,1,'images/title-fVRkZrhl.jpg,images/title-aJLdD2mC.jpg,images/title-ppIna8cW.jpg','images/detail-jy8FWH3V.png','2017-09-25 04:35:53','2017-10-09 23:58:06'),(13,'天之蓝','images/icon-2U5zpPgk.jpg','生产许可证编号：QS3200 1501 0829 \n 厂名：江苏洋河酒厂股份有限公司\n 厂址：江苏省宿迁市洋河中大街118号、江苏省宿迁市泗阳县来安中大街118号\n 厂家联系方式：4008281589\n 保质期：9999 天\n 产品名称：洋河 天之蓝  42%...\n 体积(ml): 2250\n 品牌: 洋河\n 品名: 天之蓝\n 产地: 中国大陆地区\n 省份: 江苏\n 香型: 浓香型',8,398.00,298.00,NULL,28,1,'images/title-SPPPrfVw.jpg','images/detail-83F3WS59.jpg,images/detail-SHMbqBlD.jpg,images/detail-LzcrdoM8.jpg,images/detail-LokV529S.jpg','2017-09-25 04:47:28','2017-10-09 23:57:50'),(14,'梦之蓝M3','images/icon-svK9Vl1i.jpg','生产许可证编号：QS3200 1501 0829 \n 产品标准号：GB/T22046\n 厂名：江苏洋河酒厂股份有限公司\n 厂址：江苏省宿迁市洋河中大街118号、江苏省宿迁市泗阳县来安中大街118号\n 厂家联系方式：95019\n 配料表：水、高粱、大米、糯米、玉米、小麦、大麦、豌豆\n 储藏方法：阴凉干燥处常温储存\n 保质期：99999 天\n 食品添加剂：无\n 体积(ml): 500\n 品牌: 洋河',8,398.00,375.00,NULL,6,1,'images/title-J0cWe5Iw.jpg','images/detail-Q4jGIPW7.png,images/detail-mhip2Gu1.png,images/detail-476q5QxV.jpg,images/detail-u535dY8e.png','2017-09-25 05:06:31','2017-10-09 23:57:37'),(15,'梦之蓝M6 40.8','images/icon-GzdeOXxh.jpg','生产许可证编号：QS3200 1501 0829 \n 产品标准号：GB/T22046\n 厂名：江苏洋河酒厂股份有限公司\n 厂址：江苏省宿迁市洋河中大街118号、江苏省宿迁市泗阳县来安中大街118号\n 厂家联系方式：95019\n 配料表：水、高粱、大米、糯米、玉米、小麦、大麦、豌豆\n 储藏方法：阴凉干燥处常温储存\n 保质期：99999 天\n 食品添加剂：无\n 体积(ml): 500\n 品牌: 洋河',8,498.00,480.00,NULL,0,1,'images/title-yzIlJKPd.jpg','images/detail-lxZgziDK.jpg,images/detail-PQF38IE3.jpg,images/detail-5gxQr5sq.jpg,images/detail-9dOHXcLC.jpg','2017-09-25 05:12:46','2017-10-09 23:57:24'),(16,'洋河梦想家','images/icon-R5aVpf25.jpg','生产许可证编号：SC11532139200465\n 产品标准号：GB/T22046\n 厂名：江苏洋河酒厂股份有限公司\n 厂址：江苏省宿迁市洋河中大街118号、江苏省宿迁市泗阳县来安中大街118号\n 厂家联系方式：400-118-5919\n 配料表：水、高粱、大米、糯米、小麦、玉米、大麦、豌豆\n 储藏方法：阴凉干燥处常温贮存\n 保质期：36500 天\n 品牌: 洋河\n 品名: 洋河梦想家(大师级酿造',8,299.00,258.00,NULL,12,1,'images/title-Hl4TcoB8.jpg','images/detail-nJNqvmGF.jpg,images/detail-aTHVDy1o.jpg,images/detail-TN7654G2.jpg,images/detail-L8iRVaQK.jpg,images/detail-BHAP6u6C.jpg,images/detail-eX4sZCsQ.jpg','2017-09-25 05:22:29','2017-10-09 23:57:10'),(17,'Cremaschi Furlotti 智利格雷曼-家族精选赤霞珠干红葡萄酒750ml 原瓶进口正品保证','images/icon-zbN0W1pf.jpg','酒精含量 13.5 容量百分比 \n产地 **智利(Chile)** \n品牌 格雷曼 \n封口类型 橡木塞 \n生产国 CL \n成分 葡萄汁 \n容量 750 \nThe Cabernet Sauvignon was crafted from grapes grown in the beautiful Central Valley from Chile. The vineyards are blessed',9,238.00,150.00,NULL,114,1,'images/title-L4YtNa6i.jpg','images/detail-JAyVncZP.jpg,images/detail-UeZWN9ST.jpg,images/detail-EuyyB4kR.jpg','2017-09-25 05:35:27','2017-12-01 00:20:40'),(18,'Cremaschi Furlotti 智利格雷曼-家族窖藏卡曼尼干红葡萄酒750ml 原瓶进口正品保证','images/icon-Y3hzO5FI.jpg','酒精含量 13.5 容量百分比 \n产地 **智利(Chile)** \n品牌 格雷曼 \n咖啡因含量 30 克 \n包装信息 瓶装 \n生产国 CL \n成分 葡萄汁 \n容量 750 毫升 \n液体容量 750 毫升 \n制造商 智利格雷曼酒庄 \n包装信息 瓶装 \n购买年龄限制 18.00 \n生产地区 **智利(Chile)** \n葡萄酒区域评级 智利格雷曼酒庄 \n特殊特性  不含人工色素, 不含防腐剂, 原瓶',9,368.00,289.00,NULL,83,1,'images/title-7asv13tc.jpg','images/detail-UMkB6TGt.jpg,images/detail-cpd87j8d.jpg,images/detail-nJ4GcZRf.jpg,images/detail-CYwFWTy0.jpg','2017-09-25 05:47:33','2017-11-27 13:15:05'),(19,'CREMASCHI FURLOTTI 格雷曼家族 小产区黑比诺干红葡萄酒 Pinot Noir Single Vineyard','images/icon-g3Lx8ztC.jpg','酒精含量 13.5 容量百分比 \n产地 **智利(Chile)** \n获得奖项 2002 智利圣地亚哥 葡萄酒竞赛 金奖, BRC 全球标准食品分类A级证书, 荣获国际食品标准 高级水平证书, 荣获法国必维国际检验集团食品检验证书, 2002中国 国际葡萄酒及烈酒评酒会荣誉奖 \n酒体描述 红葡萄酒 \n品牌 CREMASCHI FURLOTTI 格雷曼家族 \n包装信息 玻璃 \n生产国 智利 \n菜系',9,598.00,450.00,NULL,44,1,'images/title-xqPNkAM4.jpg','images/detail-AG8muPdx.jpg','2017-09-25 05:51:06','2017-12-12 00:04:10'),(20,'CREMASCHI FURLOTTI 格雷曼家族 小产区梅洛干红葡萄酒 Merlot Single Vineyard 750ML','images/icon-6kce3ts7.jpg','酒精含量 14 容量百分比 \n产地 **智利(Chile)** \n获得奖项 BRC 全球标准食品分类A级证书, 获国际食品标准 高级水平证书, 2002中国 国际葡萄酒及烈酒评酒会荣誉奖, 荣获法国必维国际检验集团食品检验证书, 2011年在加拿大 举办的《世界精选葡萄酒大赛》最高奖金奖 \n酒体描述 红葡萄酒 \n品牌 CREMASCHI FURLOTTI 格雷曼家族 \n包装信息 玻璃 \n生产国 智',9,598.00,450.00,NULL,28,1,'images/title-feEJEshe.jpg','images/detail-FRz5E0Aj.jpg','2017-09-25 05:53:40','2017-10-09 23:56:06'),(21,'双沟原生态苏酒3A','images/icon-Kmxcoo2a.jpg','生产许可证编号: QS320015010780\n 厂名: 江苏双沟酿酒厂\n 厂址: 江苏省宿迁市泗洪县双沟镇东大街88号\n 厂家联系方式: 0527-86720972\n 配料表: 见包装\n 储藏方法: 见包 装\n 保质期: 3650\n 食品添加剂: 见包装\n 品牌: 原生态\n 年份: 1年(含)-3年(含)\n 是否为有机食品: 否\n 产地: 中国大陆地区\n 省份: 江苏',8,168.00,133.00,NULL,0,1,'images/title-NtBReBYx.jpg','images/detail-IRznoj9j.jpg,images/detail-HCEavDvm.jpg','2017-09-25 06:13:07','2017-10-09 23:55:35'),(22,'双沟原生态5A','images/icon-1diJOxGh.jpg','江苏双沟酿酒厂出品\n\n5A 原生态苏酒\n\n香型：浓香型\n\n酒精纯度：42度\n\n原料：小麦，水，高粱，大麦，玉米，豌豆\n\n产地：江苏宿迁双沟\n\n储存条件：阴凉，干燥，避光',8,280.00,230.00,NULL,0,1,'images/title-TGkK0Kpq.jpg','images/detail-hYIaBjOr.jpg','2017-09-25 06:23:40','2017-10-09 23:55:17'),(23,'泸州老窖绿豆大曲','images/icon-kdHVniSD.jpg','原料：白酒、水、绿豆、山药、龙眼肉\n 产品规格：净含量500ml  \n酒精度41.8%vol/51.8%vol\n产品酒体澄明，色泽微黄，具有清新的绿豆香，烘培的甜香及优雅的陈酒香，香气优雅协调，醇和甘润，回味香甜持久，协调舒爽，具有绿豆酒清新甜润的风格。是社会精英人士的健康饮酒的首选产品。',8,180.00,158.00,NULL,2,1,'images/title-S3YvLuHV.png','images/detail-0P2qPQAA.jpg,images/detail-xzEktfxd.jpg,images/detail-F8IrOb0v.jpg','2017-09-25 06:33:08','2017-10-09 23:55:03'),(24,'郎牌T6','images/icon-bRUbN0JP.jpg','产品参数：\n生产许可证编号：QS5100 1501 0376 \n 厂名：四川省古蔺郎酒厂有限公司\n 厂址：1.四川省泸州市古蔺县二郎镇2.四川省泸州市龙马潭区鱼塘镇\n 厂家联系方式：510015010376\n 配料表：水、小麦、高粱 \n 储藏方法：阴凉、干燥、密封保存\n 保质期：9999999 天\n 产品名称：郎 郎牌特曲T6 500ml*2 5...',8,90.00,85.00,NULL,5,1,'images/title-eGa6uhwb.jpg','images/detail-2PekccXG.jpg,images/detail-V31JSFRu.jpg,images/detail-WOTvcKQh.jpg,images/detail-J7TwzwOt.jpg','2017-09-25 06:39:44','2017-10-11 11:25:57'),(25,'郎牌T9','images/icon-9sgkQlH7.jpg','生产许可证编号：QS5100 1501 0376 \n 产品标准号：GB/T10781.1(优级）\n 厂名：四川省古蔺郎酒厂有限公司\n 厂址：四川省泸州市古蔺县二郎镇\n 厂家联系方式：4008066969\n 配料表：水、高粱、小麦\n 储藏方法：避光、干燥处\n 保质期：9999 天\n 产品名称：郎 郎牌特曲T9 500ml 42度\n 体积(ml): 500\n 品牌: 郎\n 品名: 郎牌特曲T9',8,215.00,200.00,NULL,13,1,'images/title-ZPmNsUMf.jpg','images/detail-T53D5iFE.jpg,images/detail-WPRnDfpr.jpg,images/detail-LDIgEs1x.jpg,images/detail-nkExOZLQ.jpg,images/detail-4QMkIDIG.jpg','2017-09-25 06:44:07','2017-10-11 11:25:03'),(26,'双沟紫砂苏酒','images/icon-MwDAzZdK.jpg','生产许可证编号：QS3200 1501 0780 \n 产品标准号：GB/T10781.1\n 厂名：江苏双沟酿酒厂\n 厂址：江苏省宿迁市泗洪县双沟镇东大街88号\n 厂家联系方式：15896082075\n 配料表：水、高粱、小麦、大麦、豌豆\n 保质期：9999 天\n 产品名称：紫砂苏 N30 480mL 40.8%...\n 品牌: 紫砂苏\n 品名: N30\n 产地: 中国大陆地区\n 省份: 江苏',8,298.00,248.00,NULL,8,1,'images/title-JbWKnywr.jpg','images/detail-c2voM2Ku.jpg,images/detail-HmZQz9vW.jpg,images/detail-lKPL912m.jpg,images/detail-hwXLEodc.jpg,images/detail-AcFEgj1W.jpg,images/detail-MyuzvMBS.jpg','2017-09-25 06:53:29','2017-10-09 23:54:15'),(27,'联想潮7000小新轻薄游戏笔记本','images/icon-cj7Vtc2R.jpg','证书编号：2016010902879616证书状态：有效产品名称：便携式计算机3C规格型号：Lenovo ideapad 310-14ISKxxxxxx, Lenovo XiaoXin 310...产品名称：Lenovo/联想 小新 潮7000...品牌: Lenovo/联想型号: 潮7000 I5屏幕尺寸: 14英寸CPU: 英特尔 酷睿 i7-7200U显卡类型: NVIDIA GeForce',12,5350.00,5290.00,NULL,0,1,'images/title-5I0kS7or.jpg,images/title-GplJBaDc.jpg','images/detail-6ApKDuD6.jpg,images/detail-6zyAtWZn.jpg,images/detail-AjtQbqUm.jpg,images/detail-WhbIE6qM.jpg,images/detail-aMdtE9Oq.jpg,images/detail-T5PgPDWJ.jpg','2017-09-28 23:13:28','2017-10-09 23:59:06'),(28,'FAST迅捷FW326R无线路由器真四天线家用穿墙王wifi高速别墅智能AP','images/icon-XxclCkmU.jpg','产品参数：\n证书编号：2015011608797040\n 证书状态：有效\n 申请人名称：深圳市友佳联科技有限公司\n 制造商名称：深圳市友佳联科技有限公司\n 产品名称：超强型300M无线路由器\n 3C产品型号：FW326R：9VDC 0.85A\n 产品名称：FAST FW326R\n 型号: FW326R\n 是否无线: 无线\n 是否支持VPN: 不支持\n 是否内置防火墙: 是\n 是否支持WDS: 支持',13,80.00,70.00,NULL,17,1,'images/title-gtclLegp.jpg','images/detail-FAWWRgfA.jpg,images/detail-C76R7jvm.jpg,images/detail-sDdwilVd.jpg,images/detail-4ALupIZI.jpg,images/detail-17hMfNAI.jpg','2017-09-29 01:49:40','2017-10-11 08:29:54'),(29,'TP-LINK无线路由器WR886N家用 穿墙王450M高速穿墙wifi光纤tplink','images/icon-pI1xJNgh.jpg','产品参数：\n证书编号：2016011608896807\n 证书状态：有效\n 产品名称：450M无线路由器(集线器功能）\n 3C规格型号：TL-WR886N：9VDC 0.6A（电源适配器：T090060-2A1、M090060-2A1、...\n 产品名称：TP-Link/普联技术 TL-W...\n TP-Link型号: TL-WR886N\n 是否无线: 无线\n 是否支持VPN: 不支持\n 是否内置',13,99.00,93.00,NULL,23,1,'images/title-GCyN1vl5.jpg','images/detail-bxFyYPNZ.jpg,images/detail-ecKAlkS3.jpg,images/detail-pdwzv6XE.jpg,images/detail-543NmndL.jpg,images/detail-7Cv5lP77.jpg,images/detail-u54GeDd9.jpg','2017-09-29 01:58:55','2017-10-11 08:31:51'),(30,'苏州绿叶爱生活牙膏清新口气就用天然海藻牙膏120g去口臭清新口气','images/icon-1pgUKZFf.jpg','功效: 口气清新\n 品牌: ILife/爱生活\n 型号: yagao\n 是否量贩装: 否\n 功能: 去烟渍 口气清新 清洁 健龈 有效防蛀\n 净含量: 120g\n 适用对象: 成人\n 规格类型: 常规单品\n 保质期: 3年\n 是否含氟: 不含氟\n 产地: 中国大陆',4,9.90,9.00,NULL,12,1,'images/title-DDNh7sjr.jpg','images/detail-IuJuzm92.jpg,images/detail-I6TxwRhT.jpg,images/detail-pCpnJ8LL.jpg','2017-09-29 02:59:20','2017-10-09 23:53:29'),(31,'绿叶爱生活高浓度深层清洁家庭清洁无磷不伤手家用正品多效洗衣液','images/icon-nfZnzj4w.png','净含量: 1L(含)-2L(含)\n 品牌: ILife/爱生活\n 型号: 多效洗衣液\n 是否量贩装: 否\n 毛重: 1KG\n 适用范围: 棉麻织物 丝绸、毛料 贴身内衣/婴儿衣物...\n 产地: 中国大陆\n 计价单位: 瓶',4,20.00,15.00,NULL,2,1,'images/title-4guVKzYW.jpg','images/detail-zxuiY3Ot.jpg,images/detail-qBmw5MuQ.jpg,images/detail-NGLTjmoS.jpg,images/detail-UZv2oqkI.jpg,images/detail-zeVoaJf3.jpg,images/detail-BDyaUIx4.jpg,images/detail-RkmVPwki.jpg','2017-09-29 03:06:22','2017-10-09 23:53:09'),(32,'爱生活多可丽天然洗衣液无磷内衣除菌抗氧化无荧光剂柔顺婴儿专用','images/icon-rFAav5Ai.jpg','净含量: 501mL(含)-1000mL(含)\n 品牌: ILife/爱生活\n 型号: 天然三合一洗衣液\n 是否量贩装: 否\n 产地: 中国大陆',4,45.00,30.00,NULL,4,1,'images/title-1XAbNtGf.jpg,images/title-9si4Sw3d.jpg','images/detail-4LkYY3La.jpg,images/detail-O2m0kgPa.jpg,images/detail-SzreZ4wd.jpg,images/detail-c5lgxmDq.jpg,images/detail-QXBUJkqN.jpg','2017-09-29 23:28:41','2017-10-09 23:52:53'),(33,'绿叶爱生活植物小分子家庭瓶装去渍留香护色无磷无荧光剂洗衣液','images/icon-Diwev46q.jpg','净含量: 1L(含)-2L(含)\n 功效: 护色/增艳\n 品牌: 绿叶\n 型号: 植物小分子\n 是否量贩装: 否\n 适用范围: 棉麻织物 丝绸、毛料 贴身内衣/婴儿衣物\n 产地: 中国大陆\n 香味: 自然香型',4,22.00,17.00,NULL,0,1,'images/title-VmBXdtZR.jpg','images/detail-RAHzUrLf.jpg,images/detail-bKFG03Zc.jpg,images/detail-XIMTRceP.jpg,images/detail-S34LidsX.jpg,images/detail-Bhh9E9kK.jpg,images/detail-UgAuaXj5.jpg','2017-09-29 23:38:11','2017-10-09 23:52:00'),(34,'绿叶爱生活绿派天然皂液洗衣液 顽固污渍洗衣液皂液无荧光剂','images/icon-hOyW6Xgh.jpg','净含量: 1L(含)-2L(含)\n 功效: 护色/增艳\n 品牌: ILife/爱生活\n 型号: 绿叶爱生活\n 是否量贩装: 否\n 毛重: 1.2\n 适用范围: 棉麻织物 丝绸、毛料 贴身内衣/婴儿衣物\n 产地: 中国大陆\n 计价单位: 瓶\n 香味: 自然香型',4,28.00,24.00,NULL,1,1,'images/title-UouJnYjn.jpg','images/detail-UMZW7eNE.gif,images/detail-X2rhilLn.gif,images/detail-jIqo8CeB.gif','2017-09-29 23:46:51','2017-10-09 23:52:23'),(35,'绿叶爱生活滋养柔顺洗发水止痒去屑修护清爽顺滑正品','images/icon-VklKlwfC.jpg','是否为特殊用途化妆品: 否\n 品牌: ILife/爱生活\n 型号: 柔顺\n 是否量贩装: 否\n 功效: 柔软顺滑 去屑止痒 滋润营养 控油 损伤修护\n 净含量: 500ml\n 适用对象: 通用\n 规格类型: 常规单品\n 保质期: 3年\n 产地: 中国大陆',4,28.00,24.00,NULL,0,1,'images/title-yfVNI9CO.jpg','images/detail-ZttL6wFm.jpg,images/detail-X1i2HWvl.jpg,images/detail-LiiF1GuS.jpg,undefined,images/detail-AzH6E3Ky.jpg,images/detail-soUbZ3Ye.jpg','2017-09-29 23:54:59','2017-10-09 23:52:11'),(36,'绿叶爱生活 玫瑰精油滋养柔顺洗发水 天然去屑止痒','images/icon-4RRRssX6.jpg','是否为特殊用途化妆品: 否\n 品牌: ILife/爱生活\n 型号: k123\n 是否量贩装: 否\n 功效: 柔软顺滑 去屑止痒 滋润 清洁发丝头皮\n 净含量: 500ml\n 适用对象: 通用\n 规格类型: 常规单品\n 产地: 中国大陆\n 适用发质: 所有发质',4,25.00,35.00,NULL,0,1,'images/title-kvKllm5X.jpg','images/detail-nnvCuUe7.jpg,images/detail-UStB6irm.jpg,images/detail-ExWagGkx.jpg,images/detail-3KBoUIXQ.jpg,images/detail-henmDmzZ.jpg,images/detail-k77DWXQ0.jpg','2017-09-30 00:41:10','2017-10-09 23:52:36'),(37,'爱生活清盈滋养沐浴露','images/icon-6WLoWASc.jpg','品牌: ILife/爱生活\n 型号: 爱生活清盈滋养沐浴露\n 是否为特殊用途化妆品: 否\n 是否量贩装: 否\n 适合肤质: 任何肤质\n 功能: 深层清洁 滋润保湿 控油 清凉舒爽\n 净含量: 500ml\n 适用对象: 通用\n 规格类型: 常规单品\n 产地: 中国大陆',4,29.00,20.00,NULL,1,1,'images/title-389M7bw3.jpg','images/detail-qePfrT61.jpg,images/detail-UPEdAEjA.jpg,images/detail-OHLtMY21.jpg,images/detail-f5yv7w5V.jpg,images/detail-LIo5bSEX.jpg,images/detail-HZMwdOOw.jpg','2017-09-30 01:06:53','2017-10-09 23:51:48'),(38,'绿叶爱生活卡丽施乳木果油滋养香皂宝宝孕可用','images/icon-b5WHAKB9.jpg','是否为特殊用途化妆品: 否\n 规格类型: 正常规格\n 精油皂功效: 清洁 补水 保湿 抗痘 控油\n 品牌: Green Leaf/绿叶\n 产地: 中国',4,14.80,12.00,NULL,2,1,'images/title-AN1rf3WE.jpg','images/detail-rq9knahK.jpg,images/detail-tMbVlOhi.jpg,images/detail-OypZ21VX.jpg,images/detail-rznyvNPj.jpg','2017-09-30 01:16:31','2017-10-09 23:51:31'),(39,'绿叶爱生活 洋甘菊泡沫洗手液 植物精粹婴幼儿适用','images/icon-pjtVI3wp.jpg','品牌: 绿叶\n 型号: 005\n 是否为特殊用途化妆品: 否\n 是否量贩装: 否\n 毛重: 500g\n 功能: 抗菌 保湿 控油 清洁 清凉舒爽\n 净含量: 500ml\n 适用对象: 通用\n 规格类型: 常规单品\n 产地: 中国大陆',4,14.80,12.00,NULL,3,1,'images/title-ZEKR2dX1.jpg','images/detail-Xu9OZuaw.jpg,images/detail-OyozNQur.jpg,images/detail-hXA52V4Y.jpg,images/detail-0GlUn5jx.jpg,images/detail-y6hoDVXx.jpg,images/detail-7F11xTYF.jpg','2017-09-30 01:24:15','2017-10-09 23:51:03'),(40,'叶爱生活高效洗洁精浓缩型无磷不伤手无残留多效洗洁精','images/icon-vCS6r5fq.jpg','品牌: ILife/爱生活\n 货号: 高效\n 是否量贩装: 否\n 毛重: 1L\n 净含量: 1000g(含)-2000g(含)\n 香味: 其他\n 计价单位: 瓶\n 适用范围: 通用',4,29.00,20.00,NULL,7,1,'images/title-TZreJhy0.jpg','images/detail-9AkehEAl.jpg,images/detail-OXgfUGk0.jpg,images/detail-UM1WKPvj.jpg,images/detail-i1A6cvSf.jpg','2017-09-30 01:37:53','2017-10-09 23:50:49'),(41,'绿叶爱生活强效去污洁厕净马桶除臭去垢洁厕剂浓缩清洁剂','images/icon-GmsdguJt.jpg','体积(ml): 500\n 品牌: ILife/爱生活\n 货号: 洁厕净\n 是否量贩装: 否\n 物理形态: 液体',4,11.80,8.00,NULL,7,1,'images/title-gPT2Yesx.jpg','images/detail-q8rlcBy5.jpg,images/detail-LTftZjAc.jpg,images/detail-EyJBvWDM.jpg,images/detail-WnWABehC.jpg,images/detail-yjbv7Yj5.jpg,images/detail-S3yzKnMN.jpg,images/detail-HqF3I15G.jpg','2017-09-30 01:44:46','2017-12-01 00:46:12'),(42,'绿叶爱生活油污净高效清洁去污厨房强抽油烟机免拆洗清洁剂送喷头','images/icon-64WY18oo.jpg','品牌: 爱生活\n 是否量贩装: 否\n 物理形态: 液体\n 产品PH值: PH=7\n 净含量: 500ml',4,20.80,15.00,NULL,5,1,'images/title-Ug2tQZgX.jpg','images/detail-5zS7sdDH.jpg,images/detail-hHvoEvqY.jpg,images/detail-YZEiF41K.jpg,images/detail-B3yrjVcS.jpg','2017-09-30 01:50:19','2017-10-09 23:50:22'),(43,'绿叶爱生活植物多效一喷净天然餐具果蔬清洗液','images/icon-xdXVC4TN.jpg','品牌: 绿叶爱生活\n 货号: 植物多效一喷净\n 物理形态: 液体\n 净含量: 1L\n 香味: 其他',4,78.00,50.00,NULL,0,1,'images/title-83RvQLhB.jpg','images/detail-7OQuxKIi.jpg,images/detail-diDlG1wR.png,images/detail-MuS961OR.png,images/detail-QszNjVzb.jpg','2017-09-30 01:57:36','2017-10-09 23:49:58'),(44,'绿叶爱生活家得丽多效电解水去污杀菌除异味除甲醛农残','images/icon-napNiDjm.jpg','体积(ml): 300\n 品牌: 家得丽\n 物理形态: 液体\n 适用空间: 家用\n 产品PH值: PH>7\n 净含量: 300mL\n 香味: 其他',4,28.80,25.00,NULL,0,1,'images/title-ib5Knbn5.jpg','images/detail-Lffd2dsX.jpg,images/detail-Ve5KyYO7.jpg,images/detail-7MMldKfF.jpg,images/detail-TTtno3k2.png','2017-09-30 02:02:57','2017-10-09 23:49:45'),(45,'绿叶爱生活植物乌黑养发液 纯植物天然染发剂 绿色健康环保染发剂','images/icon-fYIYZyVY.jpg','是否为特殊用途化妆品: 否\n 产地: 中国大陆地区\n 品牌: Green Leaf/绿叶\n 单品: 绿叶爱生活\n 规格类型: 正常规格\n 功效: 固发修复\n 化妆品净含量: 其他/other',4,155.00,135.00,NULL,1,1,'images/title-2rcnjxXE.png','images/detail-NAUGGvFc.jpg,images/detail-ftAQv1L0.gif,images/detail-4Igh19kU.gif,images/detail-B5SUcYtW.gif,images/detail-Dy24OT1t.gif,images/detail-V9v65zZ3.gif,images/detail-Ot0TdZ2s.gif','2017-09-30 02:11:07','2017-10-09 23:49:11'),(46,'爱生活轻盈柔顺护发素','images/icon-XxsVufjE.png','品牌: ILife/爱生活\n 型号: hufa\n 是否为特殊用途化妆品: 否\n 是否量贩装: 否\n 功能: 柔软顺滑 养润修复\n 净含量: 500ml\n 适用对象: 男女通用\n 规格类型: 常规单品\n 产地: 中国大陆',4,28.80,25.00,NULL,2,1,'images/title-JfEnzUGz.png','images/detail-R5yXgrMU.png,images/detail-6huJFbxg.png,images/detail-9gSs5ezT.png,images/detail-0gS9pTAD.png','2017-09-30 02:15:31','2017-10-09 23:48:56'),(47,'绿叶爱生活背心式垃圾袋不易破 加厚点断式接口便捷PE材质30只4卷','images/icon-uIuTl1EQ.jpg','厚薄: 加厚\n 品牌: 亲天力\n 是否量贩装: 否\n 颜色分类: 红色 黄色 绿色 蓝色 紫色',4,12.80,12.00,NULL,3,1,'images/title-MxxGn0WW.jpg','images/detail-vg4Kr1Pl.jpg,images/detail-nlmb4Jom.jpg,images/detail-BpUqhjhR.jpg,images/detail-NoIYyvDa.jpg,images/detail-depmzpD0.jpg','2017-09-30 02:36:37','2017-10-14 00:49:26'),(48,'绿叶爱生活抽绳式垃圾袋45*50手提塑料袋子','images/icon-ZdVVB0ig.jpg','厚薄: 加厚\n 品牌: 绿叶\n 是否量贩装: 否\n 颜色分类: 颜色随机\n 款式: 穿绳式\n 垃圾袋属性: 卷装',4,16.00,15.00,NULL,2,1,'images/title-jlK033FS.jpg','images/detail-nw0eeFVS.jpg,images/detail-mHTDlyym.jpg,images/detail-18BBzG1T.jpg,images/detail-hqYA7dAH.jpg,images/detail-Lsl4zkyI.jpg,images/detail-cBBAAoDm.jpg','2017-09-30 05:29:39','2017-10-10 04:17:07'),(49,'电脑系统安装调试','images/icon-fGIdrwzk.jpg','电脑安装系统，苹果电脑除外，不上门服务',13,15.00,10.00,NULL,18,1,'images/title-hhA9sIZu.jpg','images/detail-YSsOfsJO.jpg','2017-10-11 07:20:53','2017-10-14 02:57:22'),(50,'格雷曼入门级红酒20瓶（代理商）','images/icon-gQTEuNFw.jpg','该酒拥有红宝石的色泽，带有成熟李子、黑浆果等成熟水果的香味以及咖啡、香草和巧克力的优雅香气。 \n• 它口感呈现出浓郁的酒体、柔和的单宁和愉悦的回味。 \n• 理想的食物搭配为红肉类和奶酪等。 \n• 智利原瓶进口，正品保证。',9,4800.00,2400.00,NULL,5,1,'images/title-P9yE0Zrj.jpg,images/title-VLvjw2eX.jpg','images/detail-UyrMyPQA.jpg,images/detail-Oz91CvPW.jpg','2017-12-01 00:17:49','2017-12-01 00:42:20'),(51,'密诗安面部排毒专家(代理商）','images/icon-4VYgQblL.jpg','密诗安---能给你真正健康美的肌肤！\n\n她，从德国“皮肤管理学”与韩国“焕肤术”中汲取灵感，成功将东方草药精粹与西方护肤技术完美融合，促成中国中医药大学与韩国江南大学两大学府首度合作；\n\n她，理念新、选材珍、加工精、设计美，诚意臻于每处细节；\n\n她，安全、天然、零添加、可入口、获国家药监总局备案；\n\n她，有效；治愈率高达99%；\n\n她，承诺：永久解决激素脸、暗黄肌、色斑、敏感、等肌肤问题！',7,4800.00,2400.00,NULL,7,1,'images/title-mCQmibRm.jpg,images/title-ocGGFcdy.jpg,images/title-NpM6rZas.jpg,images/title-ILFLDlOL.jpg,images/title-NIpSqHm2.jpg','images/detail-SSHjG9gz.jpg','2017-12-01 00:29:50','2017-12-01 00:41:58'),(52,'食用斗鸡现杀真空包装','images/icon-XqJHc10U.jpg','食用斗鸡现杀真空包装',2,199.00,150.00,NULL,81,1,'images/title-0zzysLq4.jpg','images/detail-yptJzFD3.jpg','2017-12-11 03:06:11','2017-12-11 03:15:15'),(53,'食用孔雀现杀真空包装','images/icon-EO9ENLp6.jpg','食用孔雀现杀真空包装',2,399.00,350.00,NULL,23,1,'images/title-ovf3zRWW.jpg','images/detail-E8rgyjq3.jpg','2017-12-11 03:08:31',NULL),(54,'闪迪U盘16G','images/icon-Fh4BybPc.png','产品名称：SANDISK CZ50(16G)\n 品牌: Sandisk/闪迪\n SANDISK型号: CZ50(16G)\n 闪存容量: 16GB\n 颜色分类: 天蓝色 U盘+OTG读卡器 黑色\n 成色: 全新\n 是否支持防伪查询: 支持\n 售后服务: 全国联保\n USB类型: USB2.0',13,45.00,35.00,NULL,6,1,'images/title-0sSdDMVx.jpg,images/title-j5sqV59P.png','images/detail-BE6JXMwf.png','2017-12-13 01:18:38',NULL),(55,'200元现金兑换','images/icon-Ug80JJrg.jpg','代理商赚的积分以1：1兑换现金',7,220.00,200.00,NULL,0,1,'images/title-etQVvYPI.jpg','images/detail-cGOov8ci.jpg','2017-12-14 04:54:09',NULL);
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
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单地址',
  `ships` decimal(10,2) DEFAULT NULL COMMENT '运费',
  `ship_type` int(6) DEFAULT '1' COMMENT '派送方式：（1：快递，2：同城快速配送）',
  `status` int(6) DEFAULT '1' COMMENT '订单状态（位表示法，第1位：是否下单，第2位：是否取消订单，第3位：是否开始送货，第4位：是否送货完成，第5位：是否支付完成）',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '下单用户ID',
  `contactor` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单联系人',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单备注',
  `items` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单商品列表（id|count[,id|count]）',
  `source_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单来源类型（normal：普通商品，rush：1元购活动）',
  `spm` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推广源跟踪（a.b.c.d）',
  `pay_id` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信统一下单的预支付ID',
  `pay_type` int(6) DEFAULT '0' COMMENT '支付类型（0：微信支付，1：现金）',
  `pay_status` int(6) DEFAULT '0' COMMENT '支付状态（0：未支付，1：支付成功，2：支付失败，3：转入退款，4：已关闭，5：已撤销（刷卡支付），6： 用户支付中）',
  `pay_time` datetime DEFAULT NULL COMMENT '支付完成时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (3,2400.00,NULL,100,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'5:2,6:1','normal',NULL,NULL,0,0,NULL,'2017-09-02 18:56:09',NULL),(4,1600.00,NULL,400,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1,4:1','normal',NULL,NULL,0,0,NULL,'2017-09-02 19:00:18',NULL),(5,710.00,NULL,100,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-03 02:38:22',NULL),(6,710.00,NULL,100,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-03 03:01:19',NULL),(7,810.00,NULL,0,'如东县环镇乡',10.00,1,3,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,'',0,0,NULL,'2017-09-03 03:05:39','2017-09-03 03:35:57'),(8,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'2:1','normal',NULL,'',0,0,NULL,'2017-09-03 04:00:17','2017-09-03 04:00:32'),(9,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-03 04:03:25',NULL),(10,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'2:1','normal',NULL,'',0,0,NULL,'2017-09-03 04:03:38','2017-09-03 04:03:41'),(11,810.00,NULL,0,'如东县环镇乡',10.00,1,1,1,'顾汉杰','13052333613',NULL,'1:1','normal',NULL,NULL,0,0,NULL,'2017-09-08 00:01:08',NULL),(12,1600.00,1610.00,0,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'2:1,8:1','normal',NULL,NULL,0,0,NULL,'2017-09-10 11:12:43',NULL),(13,3200.00,2210.00,1000,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'3:1,4:1,2:1,1:1','normal',NULL,NULL,0,0,NULL,'2017-09-10 11:19:15',NULL),(14,800.00,810.00,0,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'2:1','normal',NULL,NULL,0,0,NULL,'2017-09-10 11:21:40',NULL),(15,800.00,810.00,0,'如东县环镇乡',10.00,1,1,2,'印霞','13122876562',NULL,'2:1','normal',NULL,NULL,0,0,NULL,'2017-09-10 11:22:26',NULL),(16,2400.00,2000.00,406,'如东县环镇乡',6.00,1,1,2,'印霞','13122876562',NULL,'1:3','normal',NULL,NULL,0,0,NULL,'2017-09-10 16:54:20',NULL),(17,118.00,124.00,0,'如东县掘港镇范堤路3-6号方正科技',6.00,1,3,3,'方正科技','13382376111',NULL,'12:1','normal',NULL,'wx201710020832387e554257330856313418',0,0,NULL,'2017-10-02 00:31:31','2017-10-10 04:26:10'),(18,90.00,96.00,0,'掘港镇范堤路3-6号',6.00,1,3,3,'方正科技','13382376111',NULL,'24:1','normal',NULL,'wx201710051057382ee1d8e5600766191781',0,0,NULL,'2017-10-05 02:57:06','2017-10-11 07:48:56'),(19,298.00,304.00,0,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'26:1','normal',NULL,'wx20171005173643a2c408e5e60458727776',0,0,NULL,'2017-10-05 09:36:28','2017-10-05 09:36:43'),(20,1788.00,1789.00,5,'掘港灯塔小区四区二排二号',6.00,1,1,12,'先锋科技','13073220456',NULL,'26:6','normal',NULL,NULL,0,0,NULL,'2017-10-05 12:49:53',NULL),(21,430.00,436.00,0,'收拾收拾',6.00,1,3,3,'方正科技','13382376111',NULL,'25:2','normal',NULL,NULL,0,0,NULL,'2017-10-09 01:53:24','2017-10-11 07:48:52'),(22,215.00,221.00,0,'清清浅浅',6.00,1,3,3,'方正科技','13382376111',NULL,'25:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 13:52:03','2017-10-10 04:26:03'),(23,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 17:28:54',NULL),(24,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 18:07:16',NULL),(25,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx20171010020749751d3267e70128316940',0,0,NULL,'2017-10-09 18:07:46','2017-10-09 18:07:49'),(26,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx2017101002144990d8eb99a80308629119',0,0,NULL,'2017-10-09 18:14:46','2017-10-09 18:14:49'),(27,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx20171010023319cb46cc8af80393673701',0,0,NULL,'2017-10-09 18:32:49','2017-10-09 18:33:19'),(28,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx201710100251443a5f60f7d10365596450',0,0,NULL,'2017-10-09 18:51:42','2017-10-09 18:51:44'),(29,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx20171010025445ebac59725e0529375957',0,0,NULL,'2017-10-09 18:54:41','2017-10-09 18:54:45'),(30,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx20171010031250b1cb4400370982548623',0,0,NULL,'2017-10-09 19:12:47','2017-10-09 19:12:50'),(31,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx20171010031648c17c1169d30019100195',0,0,NULL,'2017-10-09 19:16:46','2017-10-09 19:16:48'),(32,215.00,221.00,0,'哥哥哥哥',6.00,1,3,3,'方正科技','13382376111',NULL,'25:1','normal',NULL,NULL,0,0,NULL,'2017-10-09 23:45:27','2017-10-10 09:27:02'),(33,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx20171010103440b302e7ffc60541498029',0,0,NULL,'2017-10-10 02:34:37','2017-10-10 02:34:40'),(34,12.80,0.80,18,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx2017101010350718cb7fd6c50727951960',0,0,NULL,'2017-10-10 02:35:03','2017-10-10 02:35:07'),(35,95.00,1.00,100,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'24:1','normal',NULL,'wx20171010103652f9e39c159b0402785922',0,0,NULL,'2017-10-10 02:36:49','2017-10-10 02:36:52'),(36,16.00,1.00,21,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'48:1','normal',NULL,'wx20171010110905d8f8340eb30385467051',0,0,NULL,'2017-10-10 03:09:00','2017-10-10 03:09:05'),(37,16.00,1.00,21,'如东',6.00,1,1,10,'空气+','13052333613',NULL,'48:1','normal',NULL,'wx201710101217113a11a4514e0104382933',0,0,NULL,'2017-10-10 04:17:07','2017-10-10 04:17:11'),(38,215.00,221.00,0,'嗡嗡嗡',6.00,1,29,3,'方正科技','13382376111',NULL,'25:1','normal',NULL,'wx20171010122533e83503da630533352411',0,1,'2017-10-10 12:25:45','2017-10-10 04:25:29','2017-10-10 04:25:33'),(39,15.00,16.00,5,'55',6.00,1,29,23,'淡然','13862799403',NULL,'49:1','normal',NULL,'wx20171011152654db9da0a21d0296001223',0,1,'2017-10-11 15:27:07','2017-10-11 07:26:48','2017-10-11 07:26:54'),(40,20.00,26.00,0,'啊啊啊',6.00,1,3,3,'方正科技','13382376111',NULL,'49:2','normal',NULL,'wx201710111547072e69f0cb430743904245',0,0,NULL,'2017-10-11 07:47:03','2017-10-11 07:49:21'),(41,10.00,16.00,0,'嗷嗷',6.00,1,3,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx20171011155030a80ee86ea40431840450',0,0,NULL,'2017-10-11 07:50:25','2017-10-14 00:56:45'),(42,10.00,16.00,0,'红红火火',6.00,1,3,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx20171011162616ba3bf0280f0380578156',0,0,NULL,'2017-10-11 08:26:02','2017-10-14 00:56:46'),(43,70.00,76.00,0,'方正科技',6.00,1,3,3,'方正科技','13382376111',NULL,'28:1','normal',NULL,'wx201710111629592042fe08ee0465627907',0,0,NULL,'2017-10-11 08:29:54','2017-10-14 00:57:01'),(44,93.00,99.00,0,'最爱',6.00,1,1,3,'方正科技','13382376111',NULL,'29:1','normal',NULL,NULL,0,0,NULL,'2017-10-11 08:31:51',NULL),(45,10.00,16.00,0,'收拾收拾说',6.00,1,3,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx201710121002379581c74dbb0184937037',0,0,NULL,'2017-10-12 02:02:33','2017-10-14 00:56:48'),(46,10.00,16.00,0,'啊啊啊说',6.00,1,1,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx2017101214212561a77229970316331309',0,0,NULL,'2017-10-12 06:21:19','2017-10-12 06:21:25'),(47,10.00,16.00,0,'事实上',6.00,1,1,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx2017101215355627b18d8fb30115847036',0,0,NULL,'2017-10-12 07:35:53','2017-10-12 07:35:56'),(48,10.00,16.00,0,'嗡嗡嗡',6.00,1,1,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx2017101320021139024cba6a0500231017',0,0,NULL,'2017-10-13 12:02:08','2017-10-13 12:02:11'),(49,10.00,16.00,0,'试试',6.00,1,1,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx201710132022115667a9b34a0083269805',0,0,NULL,'2017-10-13 12:22:00','2017-10-13 12:22:11'),(50,12.80,0.80,18,'如东',6.00,1,3,10,'空气+','13052333613',NULL,'47:1','normal',NULL,'wx2017101408493157b571f40c0688428342',0,0,NULL,'2017-10-14 00:49:26','2017-10-14 00:56:50'),(51,10.00,16.00,0,'事实上',6.00,1,1,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,NULL,0,0,NULL,'2017-10-14 00:51:38',NULL),(52,10.00,16.00,0,'试试',6.00,1,1,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx201710140852238597a0b4540352811955',0,0,NULL,'2017-10-14 00:52:20','2017-10-14 00:52:23'),(53,10.00,16.00,0,'得到的',6.00,1,3,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,NULL,0,0,NULL,'2017-10-14 00:53:23','2017-10-14 01:25:35'),(54,10.00,16.00,0,'呃呃呃',6.00,1,3,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx20171014085444acf80e7a810640543850',0,0,NULL,'2017-10-14 00:54:35','2017-10-14 00:56:53'),(55,10.00,16.00,0,'对的',6.00,1,3,3,'方正科技','13382376111',NULL,'49:1','normal',NULL,'wx201710140856157ec4dbabe00356265268',0,0,NULL,'2017-10-14 00:56:12','2017-10-14 00:56:33'),(56,10.00,16.00,0,'得到的',6.00,1,1,22,'如果酒业????绿叶','13382376111',NULL,'49:1','normal',NULL,'wx2017101410091816d73dba870739881864',0,0,NULL,'2017-10-14 02:09:15','2017-10-14 02:09:18'),(57,15.00,16.00,5,'说啥',6.00,1,29,15,'A-俊（专业手机维修 爆屏修复）','13584601321',NULL,'49:1','normal',NULL,'wx20171014105729c71778fcf80587069293',0,1,'2017-10-14 11:01:00','2017-10-14 02:57:22','2017-10-14 02:57:29'),(58,289.00,294.00,0,'语言',5.00,1,1,3,'方正科技','13382376111',NULL,'18:1','normal',NULL,NULL,0,0,NULL,'2017-11-27 13:15:05',NULL),(59,11.80,11.80,5,'范堤改9卡:',5.00,1,29,40,'小忠','13057047609',NULL,'41:1','normal',NULL,'wx201712010846173a3ef85d8d0135202028',0,1,'2017-12-01 08:46:29','2017-12-01 00:46:12','2017-12-01 00:46:17'),(60,150.00,160.00,0,'打打',10.00,2,1,3,'方正科技','13382376111',NULL,'52:1','normal',NULL,'wx201712111115191bd912fb8b0287592181',0,0,NULL,'2017-12-11 03:15:15','2017-12-11 03:15:19'),(61,900.00,910.00,0,'电视上',10.00,2,1,3,'方正科技','13382376111',NULL,'19:2','normal',NULL,'wx201712120804168dae77101c0211767342',0,0,NULL,'2017-12-12 00:04:10','2017-12-12 00:04:16');
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
  `type` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '积分记录类型（+：加分、-：扣分）',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `order_id` int(10) unsigned DEFAULT NULL COMMENT '订单ID（返送积分缘由：购买商品）',
  `promotee_id` int(10) unsigned DEFAULT NULL COMMENT '介绍购买的用户ID（返送积分缘由：推荐会员）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remark` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '明细备注',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账户积分明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `point_detail`
--

LOCK TABLES `point_detail` WRITE;
/*!40000 ALTER TABLE `point_detail` DISABLE KEYS */;
INSERT INTO `point_detail` VALUES (6,100,'-',1,3,NULL,'2017-09-02 18:56:10',NULL,NULL),(7,400,'-',1,4,NULL,'2017-09-02 19:00:18',NULL,NULL),(8,100,'-',2,5,NULL,'2017-09-03 02:38:22',NULL,'2017-09-04 07:24:39'),(9,100,'-',1,6,NULL,'2017-09-03 03:01:19',NULL,NULL),(10,0,'-',1,7,NULL,'2017-09-03 03:05:39',NULL,NULL),(11,0,'-',2,8,NULL,'2017-09-03 04:00:17',NULL,'2017-09-04 07:24:20'),(12,0,'-',1,9,NULL,'2017-09-03 04:03:25',NULL,NULL),(13,0,'-',1,10,NULL,'2017-09-03 04:03:38',NULL,NULL),(14,1000,'-',2,13,NULL,'2017-09-10 11:19:15',NULL,NULL),(15,406,'-',2,16,NULL,'2017-09-10 16:54:20',NULL,NULL),(16,5,'+',5,NULL,NULL,'2017-09-28 21:10:59','会员注册奖励',NULL),(17,5294,'+',2,NULL,NULL,'2017-10-01 11:03:42','管理员加分',NULL),(18,5,'+',6,NULL,NULL,'2017-10-01 12:11:04','会员注册奖励',NULL),(19,5,'+',5,NULL,NULL,'2017-10-03 02:43:56','管理员加分',NULL),(20,5,'+',7,NULL,NULL,'2017-10-04 01:49:29','会员注册奖励',NULL),(21,5,'+',8,NULL,NULL,'2017-10-04 02:07:07','会员注册奖励',NULL),(22,5,'+',9,NULL,NULL,'2017-10-04 02:08:12','会员注册奖励',NULL),(23,5,'+',10,NULL,NULL,'2017-10-04 02:11:39','会员注册奖励',NULL),(24,5,'+',11,NULL,NULL,'2017-10-04 02:13:14','会员注册奖励',NULL),(25,5,'+',12,NULL,NULL,'2017-10-05 12:18:44','会员注册奖励',NULL),(26,5,'-',12,20,NULL,'2017-10-05 12:49:53','积分消费',NULL),(27,5,'+',13,NULL,NULL,'2017-10-07 02:19:01','会员注册奖励',NULL),(28,5,'+',14,NULL,NULL,'2017-10-07 05:13:57','会员注册奖励',NULL),(29,995,'+',10,NULL,NULL,'2017-10-09 15:03:13','管理员加分',NULL),(30,18,'-',10,23,NULL,'2017-10-09 17:28:54','积分消费',NULL),(31,18,'-',10,24,NULL,'2017-10-09 18:07:16','积分消费',NULL),(32,18,'-',10,25,NULL,'2017-10-09 18:07:46','积分消费',NULL),(33,18,'-',10,26,NULL,'2017-10-09 18:14:46','积分消费',NULL),(34,18,'-',10,27,NULL,'2017-10-09 18:32:49','积分消费',NULL),(35,18,'-',10,28,NULL,'2017-10-09 18:51:42','积分消费',NULL),(36,18,'-',10,29,NULL,'2017-10-09 18:54:41','积分消费',NULL),(37,18,'-',10,30,NULL,'2017-10-09 19:12:47','积分消费',NULL),(38,18,'-',10,31,NULL,'2017-10-09 19:16:46','积分消费',NULL),(39,18,'-',10,33,NULL,'2017-10-10 02:34:37','积分消费',NULL),(40,18,'-',10,34,NULL,'2017-10-10 02:35:03','积分消费',NULL),(41,100,'-',10,35,NULL,'2017-10-10 02:36:49','积分消费',NULL),(42,21,'-',10,36,NULL,'2017-10-10 03:09:00','积分消费',NULL),(43,21,'-',10,37,NULL,'2017-10-10 04:17:07','积分消费',NULL),(44,5,'+',15,NULL,NULL,'2017-10-10 04:43:18','会员注册奖励',NULL),(45,5,'+',16,NULL,NULL,'2017-10-10 04:44:26','会员注册奖励',NULL),(46,5,'+',17,NULL,NULL,'2017-10-10 07:36:07','会员注册奖励',NULL),(47,5,'+',18,NULL,NULL,'2017-10-10 07:37:06','会员注册奖励',NULL),(48,5,'+',19,NULL,NULL,'2017-10-10 07:37:29','会员注册奖励',NULL),(49,5,'+',20,NULL,NULL,'2017-10-10 07:38:32','会员注册奖励',NULL),(50,5,'+',21,NULL,NULL,'2017-10-11 02:54:45','会员注册奖励',NULL),(51,0,'-',21,NULL,NULL,'2017-10-11 02:56:30','管理员减分',NULL),(52,5,'+',22,NULL,NULL,'2017-10-11 06:47:06','会员注册奖励',NULL),(53,5,'-',22,NULL,NULL,'2017-10-11 06:48:11','管理员减分',NULL),(54,5,'+',23,NULL,NULL,'2017-10-11 07:24:22','会员注册奖励',NULL),(55,5,'-',23,39,NULL,'2017-10-11 07:26:48','积分消费',NULL),(56,7,'+',10,NULL,23,'2017-10-11 07:27:07','代理商提成奖励',NULL),(57,5,'+',24,NULL,NULL,'2017-10-11 09:31:16','会员注册奖励',NULL),(58,5,'+',25,NULL,NULL,'2017-10-11 14:19:10','会员注册奖励',NULL),(59,5,'+',26,NULL,NULL,'2017-10-11 14:24:58','会员注册奖励',NULL),(60,5,'+',27,NULL,NULL,'2017-10-11 14:30:46','会员注册奖励',NULL),(61,5,'-',27,NULL,NULL,'2017-10-11 14:33:25','管理员减分',NULL),(62,5,'+',28,NULL,NULL,'2017-10-11 14:33:59','会员注册奖励',NULL),(63,5,'+',29,NULL,NULL,'2017-10-11 14:35:55','会员注册奖励',NULL),(64,5,'+',30,NULL,NULL,'2017-10-11 14:37:25','会员注册奖励',NULL),(65,5,'+',31,NULL,NULL,'2017-10-11 14:37:28','会员注册奖励',NULL),(66,5,'+',32,NULL,NULL,'2017-10-11 14:37:51','会员注册奖励',NULL),(67,5,'+',33,NULL,NULL,'2017-10-11 14:39:27','会员注册奖励',NULL),(68,5,'-',28,NULL,NULL,'2017-10-11 14:39:39','管理员减分',NULL),(69,5,'+',34,NULL,NULL,'2017-10-11 15:25:54','会员注册奖励',NULL),(70,5,'+',35,NULL,NULL,'2017-10-13 12:25:57','会员注册奖励',NULL),(71,5,'-',35,NULL,NULL,'2017-10-13 12:27:25','管理员减分',NULL),(72,5,'+',36,NULL,NULL,'2017-10-13 13:31:00','会员注册奖励',NULL),(73,18,'-',10,50,NULL,'2017-10-14 00:49:26','积分消费',NULL),(74,5,'-',15,57,NULL,'2017-10-14 02:57:22','积分消费',NULL),(75,7,'+',3,NULL,15,'2017-10-14 03:01:00','代理商提成奖励',NULL),(76,5,'+',37,NULL,NULL,'2017-10-19 02:56:19','会员注册奖励',NULL),(77,5,'-',37,NULL,NULL,'2017-10-19 03:04:23','管理员减分',NULL),(78,5,'+',38,NULL,NULL,'2017-10-24 04:54:51','会员注册奖励',NULL),(79,5,'+',39,NULL,NULL,'2017-10-29 03:19:58','会员注册奖励',NULL),(80,5,'+',40,NULL,NULL,'2017-12-01 00:37:48','会员注册奖励',NULL),(81,5,'-',40,59,NULL,'2017-12-01 00:46:12','积分消费',NULL),(82,3,'+',3,59,40,'2017-12-01 00:46:30','代理商提成奖励',NULL),(83,5,'+',41,NULL,NULL,'2017-12-14 07:25:33','会员注册奖励',NULL),(84,5,'+',42,NULL,NULL,'2017-12-21 06:08:17','会员注册奖励',NULL);
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `icon` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品缩略图',
  `detail` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '商品详情描述',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT '目录ID',
  `normal_price` decimal(10,2) DEFAULT NULL COMMENT '普通价格',
  `vip_price` decimal(10,2) DEFAULT NULL COMMENT '会员价格',
  `back_points` int(10) unsigned DEFAULT NULL COMMENT '返送积分',
  `buyers` int(11) DEFAULT NULL COMMENT '参与人数',
  `counts` int(11) DEFAULT NULL COMMENT '抢购份数',
  `status` int(6) DEFAULT '2' COMMENT '商品状态（1：进行中、2：未开始、3：已结束）',
  `start_tiem` datetime DEFAULT NULL COMMENT '活动开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '活动结束时间',
  `images` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品图片（以，分隔）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='1元抢购商品信息表';
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
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名字',
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户手机',
  `type` int(10) DEFAULT '0' COMMENT '用户类型（0：会员、1：代理商）',
  `points` int(10) unsigned DEFAULT '0' COMMENT '用户积分',
  `open_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信open_id',
  `unionid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户昵称',
  `sex` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '常用地址',
  `city` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL COMMENT '推广人ID',
  `subscribe_time` datetime DEFAULT NULL,
  `qrcode_ticket` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推广二维码ticket',
  `qrcode_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推广二维码最终链接',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_OPEN_ID` (`open_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (3,'方正科技','13382376111',1,15,'ouJju0YA4QX91fvxykNWsAfWDW_E',NULL,'方正科技','1','zh_CN',NULL,'南通','江苏','中国',22,'1970-01-18 18:25:25','gQHa8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyNF84R0ZrVW9mS2gxMDAwMHcwMzkAAgTWtMhZAwQAAAAA','http://weixin.qq.com/q/024_8GFkUofKh10000w039','2017-09-25 07:48:31','2017-12-12 13:28:39'),(4,'跳跳鱼',NULL,1,5,'ouJju0dO_7HaMsU5U94HuNchgxu4',NULL,'跳跳鱼','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:27:56','gQEd8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyeU96NUVHVW9mS2gxMDAwMGcwM2YAAgQJzN1ZAwQAAAAA','http://weixin.qq.com/q/02yOz5EGUofKh10000g03f','2017-09-27 01:41:25','2017-12-12 13:28:53'),(7,'见成',NULL,0,5,'ouJju0b9V_2SL4F8vz2fOE3jn1H4',NULL,'见成','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:38:01','gQFc8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyZHE5eUZVVW9mS2gxMDAwMHcwM0wAAgSw_rRZAwQAAAAA','http://weixin.qq.com/q/02dq9yFUUofKh10000w03L','2017-10-04 01:49:29','2017-10-04 01:49:29'),(10,'空气+','13052333613',0,649,'ouJju0Qg-Ez2EAnFEGKtcsZ_6mts',NULL,'空气+','1','zh_CN',NULL,'浦东新区','上海','中国',NULL,'1970-01-18 18:38:03','gQGc8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyWVNKMUVxVW9mS2gxMDAwMDAwM1cAAgSIQ9RZAwQAAAAA','http://weixin.qq.com/q/02YSJ1EqUofKh10000003W','2017-10-04 02:11:39','2017-10-14 00:49:26'),(11,'Amy',NULL,0,5,'ouJju0dq7h1b7vNaj_VmQWzBJJKg',NULL,'Amy','2','zh_CN',NULL,'浦东新区','上海','中国',10,'1970-01-18 18:38:03',NULL,NULL,'2017-10-04 02:13:14','2017-10-04 02:13:14'),(12,'先锋科技','13073220456',0,0,'ouJju0VrJF-ZuU-uxQ4kEJ9Nr4Uc',NULL,'先锋科技','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:40:05','gQG68DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyWW9HTEZ4VW9mS2gxMDAwMDAwM0sAAgRYI9ZZAwQAAAAA','http://weixin.qq.com/q/02YoGLFxUofKh10000003K','2017-10-05 12:18:44','2017-10-05 12:49:53'),(13,'蝎子王',NULL,0,5,'ouJju0TBo4WPaY_4wF-5PpAAv-Qs',NULL,'蝎子王','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:42:22','gQH18DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyWmNJbkVxVW9mS2gxMDAwME0wM1UAAgTNOdhZAwQAAAAA','http://weixin.qq.com/q/02ZcInEqUofKh10000M03U','2017-10-07 02:19:01','2017-10-07 02:19:01'),(14,'黑暗Destroy',NULL,0,5,'ouJju0b1vwlr69MjdEBkboa1OCoY',NULL,'黑暗Destroy','1','zh_CN',NULL,'','','马达加斯加',3,'1970-01-18 18:42:33','gQES8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyUmlFQkZtVW9mS2gxMDAwMHcwM0wAAgSbYthZAwQAAAAA','http://weixin.qq.com/q/02RiEBFmUofKh10000w03L','2017-10-07 05:13:57','2017-10-07 05:13:57'),(15,'A-俊（专业手机维修 爆屏修复）','13584601321',0,0,'ouJju0YpjE_xW0LZk6a51g8i7Qwc',NULL,'A-俊（专业手机维修 爆屏修复）','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:46:50','gQGZ8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAybUJvN0VvVW9mS2gxMDAwMHcwM3MAAgToT9xZAwQAAAAA','http://weixin.qq.com/q/02mBo7EoUofKh10000w03s','2017-10-10 04:43:18','2017-10-14 02:57:22'),(16,'YWYA',NULL,0,5,'ouJju0T2YrZr80Gqm7A0unwBk8VQ',NULL,'YWYA','1','zh_CN',NULL,'','','伊拉克',3,'1970-01-18 18:46:50','gQGZ8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyZEliRUZsVW9mS2gxMDAwMDAwM3cAAgQtUNxZAwQAAAAA','http://weixin.qq.com/q/02dIbEFlUofKh10000003w','2017-10-10 04:44:26','2017-10-10 04:44:26'),(17,'♂楠℡',NULL,0,5,'ouJju0XVGpDdoCwhyBO8LAP_as4k',NULL,'♂楠℡','1','zh_CN',NULL,'南通','江苏','中国',13,'1970-01-18 18:47:00','gQHP7zwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyN3RNd0ZtVW9mS2gxMDAwMHcwM3kAAgRqeNxZAwQAAAAA','http://weixin.qq.com/q/027tMwFmUofKh10000w03y','2017-10-10 07:36:07','2017-10-10 07:36:07'),(18,'地势坤',NULL,0,5,'ouJju0beJFVqLeQPLXSeeTXvSksg',NULL,'地势坤','1','zh_CN',NULL,'南通','江苏','中国',13,'1970-01-18 18:47:01',NULL,NULL,'2017-10-10 07:37:06','2017-10-10 07:37:06'),(19,'有诗有梦有远方',NULL,0,5,'ouJju0S5TIcgJM9miru_dmrwtQgE',NULL,'有诗有梦有远方','1','zh_CN',NULL,'南通','江苏','中国',13,'1970-01-18 18:47:01',NULL,NULL,'2017-10-10 07:37:29','2017-10-10 07:37:29'),(20,'，',NULL,0,5,'ouJju0V3BCpMTyq5C2B91vZb5Mlg',NULL,'，','1','zh_CN',NULL,'南通','江苏','中国',13,'1970-01-18 18:47:01',NULL,NULL,'2017-10-10 07:38:32','2017-10-10 07:38:32'),(21,'微送鲜果18761766866',NULL,1,5,'ouJju0dBZuC1YP5IgPwQsQ58iMaM',NULL,'微送鲜果18761766866','0','zh_CN',NULL,'','','',3,'1970-01-18 18:48:10','gQEm8jwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyUzVGOEVNVW9mS2gxMDAwMDAwM1QAAgT5h91ZAwQAAAAA','http://weixin.qq.com/q/02S5F8EMUofKh10000003T','2017-10-11 02:54:45','2017-10-11 02:56:20'),(22,'如果酒业????绿叶','13382376111',1,0,'ouJju0eMiSLcisDAAicNsY0dZ2Dk',NULL,'如果酒业????绿叶','2','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:48:24','gQFC8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAydC1YOUU4VW9mS2gxMDAwME0wM1oAAgRsvt1ZAwQAAAAA','http://weixin.qq.com/q/02t-X9E8UofKh10000M03Z','2017-10-11 06:47:06','2017-10-11 06:48:11'),(23,'淡然','13862799403',0,0,'ouJju0ZoZz_gdlpCzd4upKyAX5Dk',NULL,'淡然','2','zh_CN',NULL,'南通','江苏','中国',10,'1970-01-18 18:48:26','gQEE8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAybzRkbEVXVW9mS2gxMDAwME0wM3EAAgQqx91ZAwQAAAAA','http://weixin.qq.com/q/02o4dlEWUofKh10000M03q','2017-10-11 07:24:22','2017-10-11 07:26:48'),(24,'石头剪子布',NULL,0,5,'ouJju0Z2LpSIO05i58rb7Q2K3200',NULL,'石头剪子布','1','zh_CN',NULL,'南通','江苏','中国',16,'1970-01-18 18:48:34','gQFm8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyb2R5SkVwVW9mS2gxMDAwME0wM1kAAgSG5d1ZAwQAAAAA','http://weixin.qq.com/q/02odyJEpUofKh10000M03Y','2017-10-11 09:31:16','2017-10-11 09:31:16'),(25,'陆健康',NULL,0,5,'ouJju0V52v17OQiIxAE66cxTCO14',NULL,'陆健康','1','zh_CN',NULL,'闵行','上海','中国',22,'1970-01-18 18:48:51','gQE28TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyUmFNbEZBVW9mS2gxMDAwME0wM1MAAgTQKN5ZAwQAAAAA','http://weixin.qq.com/q/02RaMlFAUofKh10000M03S','2017-10-11 14:19:10','2017-10-11 14:19:10'),(26,'David',NULL,0,5,'ouJju0ZjbILPVfelw-Q7zry9TIk4',NULL,'David','1','zh_CN',NULL,'','','圣马力诺',22,'1970-01-18 18:48:51','gQHI8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyYlp0VEVhVW9mS2gxMDAwME0wMzMAAgQkK95ZAwQAAAAA','http://weixin.qq.com/q/02bZtTEaUofKh10000M033','2017-10-11 14:24:58','2017-10-11 14:24:58'),(27,'髪耨、R',NULL,1,0,'ouJju0ejVVT4oPSGLNILicIMwz8E',NULL,'髪耨、R','1','zh_CN',NULL,'南通','江苏','中国',22,'1970-01-18 18:48:52','gQG98DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyTlZIN0ZQVW9mS2gxMDAwMHcwM04AAgRbK95ZAwQAAAAA','http://weixin.qq.com/q/02NVH7FPUofKh10000w03N','2017-10-11 14:30:46','2017-10-11 14:33:25'),(28,'老康',NULL,1,0,'ouJju0coq2NN6lpQcZwh27hjTAi0',NULL,'老康','0','zh_CN',NULL,'','','',22,'1970-01-18 18:48:52','gQEG8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyVGNfQUU5VW9mS2gxMDAwMHcwM2cAAgTdK95ZAwQAAAAA','http://weixin.qq.com/q/02Tc_AE9UofKh10000w03g','2017-10-11 14:33:59','2017-10-11 14:39:39'),(29,'七夜',NULL,0,5,'ouJju0VT9N_F4xTabkZtZE-Q2Ja4',NULL,'七夜','2','zh_CN',NULL,'南通','江苏','中国',22,'1970-01-18 18:48:52','gQED8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyQjhWZUYyVW9mS2gxMDAwME0wM0gAAgRQLN5ZAwQAAAAA','http://weixin.qq.com/q/02B8VeF2UofKh10000M03H','2017-10-11 14:35:55','2017-10-11 14:35:55'),(30,'虾米',NULL,0,5,'ouJju0SWSKtcceLqGxxXis6H1Ok8',NULL,'虾米','2','zh_CN',NULL,'','','安道尔',27,'1970-01-18 18:48:52',NULL,NULL,'2017-10-11 14:37:25','2017-10-11 14:37:25'),(31,'书*心羽',NULL,0,5,'ouJju0YRab6g26B5ZMnkVkNRctjY',NULL,'书*心羽','1','zh_CN',NULL,'南通','江苏','中国',NULL,NULL,NULL,NULL,'2017-10-11 14:37:28','2017-10-11 14:37:28'),(32,'alice',NULL,0,5,'ouJju0SpOPtA_4M513nLLY3gcZLw',NULL,'alice','2','zh_CN',NULL,'南通','江苏','中国',NULL,NULL,NULL,NULL,'2017-10-11 14:37:51','2017-10-11 14:37:51'),(33,'szkolia',NULL,0,5,'ouJju0Zbhb7bN5Rzgj0s7Y1x-BWc',NULL,'szkolia','1','zh_CN',NULL,'苏州','江苏','中国',NULL,NULL,NULL,NULL,'2017-10-11 14:39:27','2017-10-11 14:39:27'),(34,'蒹葭',NULL,0,5,'ouJju0ZmfwyPJjG5Y1tjoKrkY4SY',NULL,'蒹葭','2','zh_CN',NULL,'南通','江苏','中国',25,'1970-01-18 18:48:55',NULL,NULL,'2017-10-11 15:25:54','2017-10-11 15:25:54'),(35,'放飞天涯',NULL,1,0,'ouJju0QyEj4mvm8Jx3mRFDgx4WSM',NULL,'放飞天涯','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:51:37','gQGB8TwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyMVljbEY1VW9mS2gxMDAwMDAwM0UAAgREseBZAwQAAAAA','http://weixin.qq.com/q/021YclF5UofKh10000003E','2017-10-13 12:25:56','2017-10-13 12:27:25'),(36,'兰云',NULL,0,5,'ouJju0dVYsAyB_XOdrJCIspFlJcE',NULL,'兰云','2','zh_CN',NULL,'南通','江苏','中国',35,'1970-01-18 18:51:41',NULL,NULL,'2017-10-13 13:31:00','2017-10-13 13:31:00'),(37,'飞哥',NULL,1,0,'ouJju0aWFRdvJR9y1PWqGUqESBjM',NULL,'飞哥','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 18:59:41','gQEa8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyaHo1bEVSVW9mS2gxMDAwMHcwM3oAAgR8FuhZAwQAAAAA','http://weixin.qq.com/q/02hz5lERUofKh10000w03z','2017-10-19 02:56:19','2017-10-19 03:04:23'),(38,'东子',NULL,0,5,'ouJju0QkzAcFFEhPKdpHi6RvYK8M',NULL,'东子','1','zh_CN',NULL,'','克劳斯城','阿根廷',16,'1970-01-18 19:07:00',NULL,NULL,'2017-10-24 04:54:51','2017-10-24 04:54:51'),(39,'缘份天空',NULL,0,5,'ouJju0XeW3rRt8o4ue66uVmo9rbA',NULL,'缘份天空','1','zh_CN',NULL,'南通','江苏','中国',16,'1970-01-18 19:14:07',NULL,NULL,'2017-10-29 03:19:58','2017-10-29 03:19:58'),(40,'小忠','13057047609',0,0,'ouJju0VFPTbj_UXkcxCigTV0RJUw',NULL,'小忠','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 20:01:28','gQGw8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyamFGekZLVW9mS2gxMDAwME0wM0wAAgR1pCBaAwQAAAAA','http://weixin.qq.com/q/02jaFzFKUofKh10000M03L','2017-12-01 00:37:48','2017-12-01 00:46:12'),(41,'其实很简单',NULL,0,5,'ouJju0SbRlKm4EmxWd7-qyi1vav4',NULL,'其实很简单','1','zh_CN',NULL,'南通','江苏','中国',3,'1970-01-18 20:20:36','gQGF8DwAAAAAAAAAAS5odHRwOi8vd2VpeGluLnFxLmNvbS9xLzAyclpNOUVXVW9mS2gxMDAwMDAwMzAAAgRyJzJaAwQAAAAA','http://weixin.qq.com/q/02rZM9EWUofKh100000030','2017-12-14 07:25:33','2017-12-14 07:25:34'),(42,'手牵手',NULL,0,5,'ouJju0XSIk3so_tYTO9FXKWf32VI',NULL,'手牵手','1','zh_CN',NULL,'南通','江苏','中国',37,'1970-01-18 20:30:36',NULL,NULL,'2017-12-21 06:08:17','2017-12-21 06:08:17');
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
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `icon` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品缩略图',
  `detail` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '商品详情描述',
  `category_id` int(10) unsigned DEFAULT NULL COMMENT '目录ID',
  `normal_price` decimal(10,2) DEFAULT NULL COMMENT '普通价格',
  `vip_price` decimal(10,2) DEFAULT NULL COMMENT '会员价格',
  `back_points` int(10) unsigned DEFAULT NULL COMMENT '返送积分',
  `sales` int(11) DEFAULT NULL COMMENT '商品销量',
  `status` int(6) DEFAULT '2' COMMENT '商品状态（1：上架、2：下架、3：删除）',
  `title_imgs` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品预览图片（以，分隔）',
  `detail_imgs` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品详情图片（以，分隔）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='VIP商品信息表';
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

-- Dump completed on 2017-12-24 21:19:38
