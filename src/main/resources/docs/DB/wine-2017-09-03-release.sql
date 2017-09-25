/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50627
Source Host           : localhost:3306
Source Database       : wine

Target Server Type    : MYSQL
Target Server Version : 50627
File Encoding         : 65001

Date: 2017-09-03 13:43:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bannar
-- ----------------------------
DROP TABLE IF EXISTS `bannar`;
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

-- ----------------------------
-- Records of bannar
-- ----------------------------
INSERT INTO `bannar` VALUES ('1', 'images/banner-1.jpg', '经典洋河好酒', '酒体饱满丰润，珍藏版佳酿！', '1', '1', '2017-08-06 15:45:28', null);
INSERT INTO `bannar` VALUES ('2', 'images/banner-2.jpg', '长城 干红葡萄酒', '细选葡萄原料，用心酿制而成！', '2', '2', '2017-08-06 15:45:28', null);
INSERT INTO `bannar` VALUES ('3', 'images/banner-3.jpg', '茅台 15年贵州茅台酒', '天贵人和，厚德致远！', '3', '3', '2017-08-06 15:45:28', null);
INSERT INTO `bannar` VALUES ('4', 'images/banner-4.jpg', '郎酒 红花郎酒', '自然美景，良好水源，天宝洞藏！', '4', '4', '2017-08-06 15:45:28', null);
INSERT INTO `bannar` VALUES ('5', 'images/banner-5.jpg', '小糊涂仙 浓香型', '选用高粱，秉承传统工艺酿造而成！', '5', '5', '2017-08-06 15:45:28', null);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
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

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '酒水', '1', '1', '0', '2017-08-13 16:22:50', '2017-08-19 15:21:15');
INSERT INTO `category` VALUES ('2', '茶叶', '1', '2', '0', '2017-08-13 16:22:50', '2017-08-19 15:21:21');
INSERT INTO `category` VALUES ('3', '礼品', '1', '3', '0', '2017-08-13 16:22:50', '2017-08-19 15:21:28');
INSERT INTO `category` VALUES ('4', '集市', '1', '4', '0', '2017-08-13 16:22:50', '2017-08-19 15:21:31');
INSERT INTO `category` VALUES ('5', '白酒', '2', '1', '1', '2017-08-13 16:22:50', '2017-08-19 15:21:34');
INSERT INTO `category` VALUES ('6', '红酒', '2', '2', '1', '2017-08-13 16:22:51', '2017-08-19 15:21:35');
INSERT INTO `category` VALUES ('7', '啤酒', '2', '3', '1', '2017-08-13 16:22:51', '2017-08-19 15:21:36');
INSERT INTO `category` VALUES ('8', '碧螺春', '2', '1', '2', '2017-08-13 16:22:51', '2017-08-19 15:21:38');
INSERT INTO `category` VALUES ('9', '龙井', '2', '2', '2', '2017-08-13 16:22:51', '2017-08-19 15:21:39');
INSERT INTO `category` VALUES ('10', '海鲜', '2', '1', '3', '2017-08-13 16:22:51', '2017-08-19 15:21:41');
INSERT INTO `category` VALUES ('11', '肉', '2', '2', '3', '2017-08-13 16:22:51', '2017-08-19 15:21:44');
INSERT INTO `category` VALUES ('12', '鱼', '2', '3', '3', '2017-08-13 16:22:51', '2017-08-19 15:21:49');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES ('1', '洋河蓝色经典', 'images/product-1.jpg', '洋河蓝色经典 天之蓝 46度 480ml 绵柔浓香型', '5', '1200.00', '800.00', '1000', '18', '1', 'images/p1-1.jpg,images/p1-2.jpg,images/p1-3.jpg,images/p1-6.jpg,images/p1-4.jpg,images/p1-5.jpg', 'images/p1-img1.jpg,images/p1-img2.jpg,images/p1-img3.jpg,images/p1-img4.jpg,images/p1-img5.jpg,images/p1-img6.jpg,images/p1-img7.jpg,images/p1-img8.jpg,images/p1-img9.jpg,images/p1-img10.jpg,images/p1-img11.jpg,images/p1-img12.jpg,images/p1-img13.jpg,images/p1-img14.jpg', '2017-08-13 16:28:14', '2017-09-03 00:53:04');
INSERT INTO `item` VALUES ('2', '小糊涂仙 浓香型', 'images/product-2.jpg', '小糊涂仙 浓香型白酒 52度 100ml 精致小酒版', '5', '1200.00', '800.00', '1000', '18', '1', 'images/p2-1.jpg,images/p2-2.jpg,images/p2-3.jpg,images/p2-4.jpg', 'images/p2-img1.jpg,images/p2-img2.jpg,images/p2-img3.jpg,images/p2-img4.jpg,images/p2-img5.jpg,images/p2-img6.jpg,images/p2-img7.jpg,images/p2-img8.jpg,images/p2-img9.jpg,images/p2-img10.jpg,images/p2-img11.jpg,images/p2-img12.jpg', '2017-08-13 16:28:14', '2017-09-03 00:56:45');
INSERT INTO `item` VALUES ('3', '郎酒 红花郎酒', 'images/product-3.jpg', '茅台 王子 53度 单瓶装白酒 500ml 口感酱香型', '5', '1200.00', '800.00', '1000', '18', '1', 'images/p3-1.jpg,images/p3-2.jpg,images/p3-3.jpg,images/p3-4.jpg', 'images/p3-img1.jpg,images/p3-img2.jpg,images/p3-img3.jpg,images/p3-img4.jpg,images/p3-img5.jpg,images/p3-img6.jpg,images/p3-img7.jpg,images/p3-img8.jpg', '2017-08-13 16:28:14', '2017-09-03 00:52:44');
INSERT INTO `item` VALUES ('4', '茅台 15年贵州茅台酒', 'images/product-4.jpg', '酱香型！ 贵州茅台，国货匠心， 收藏精品，越品越有味！“风味隔壁三家醉，雨后开瓶十里芳”！', '5', '1200.00', '800.00', '1000', '18', '1', 'images/p4-1.jpg,images/p4-2.jpg,images/p4-3.jpg', 'images/p4-img1.jpg,images/p4-img2.jpg,images/p4-img3.jpg', '2017-08-13 16:28:14', '2017-09-03 00:49:12');
INSERT INTO `item` VALUES ('5', '巴黎之花 PerrierJouet特级干型香槟', 'images/product-5.jpg', '巴黎之花 香槟 Perrier Jouet 法国香槟 干型香槟750ml', '6', '1200.00', '800.00', '1000', '18', '1', 'images/p5-1.jpg,images/p5-2.jpg,images/p5-3.jpg,images/p5-4.jpg', 'images/p5-img1.jpg,images/p5-img2.jpg,images/p5-img3.jpg', '2017-08-13 16:28:14', '2017-09-03 00:45:31');
INSERT INTO `item` VALUES ('6', '长城 干红葡萄酒', 'images/product-6.jpg', '长城（GreatWall）红酒 华夏葡园九二珍藏级干红葡萄酒', '6', '1200.00', '800.00', '1000', '18', '1', 'images/p6-1.jpg,images/p6-2.jpg,images/p6-3.jpg,images/p6-4.jpg', 'images/p6-img1.jpg,images/p6-img2.jpg,images/p6-img3.jpg,images/p6-img4.jpg,images/p6-img5.jpg,images/p6-img6.jpg,images/p6-img7.jpg,images/p6-img8.jpg,images/p6-img9.jpg,images/p6-img10.jpg', '2017-08-13 16:28:14', '2017-09-03 00:41:42');
INSERT INTO `item` VALUES ('7', '1664白啤酒', 'images/product-7.jpg', '1664 白啤酒 330ml 用心酿造舌尖上的浪漫~', '7', '1200.00', '800.00', '1000', '18', '1', 'images/p7-1.jpg,images/p7-2.jpg,images/p7-3.jpg,images/p7-4.jpg', 'images/p7-img1.jpg,images/p7-img2.jpg,images/p7-img3.jpg,images/p7-img4.jpg,images/p7-img5.jpg,images/p7-img6.jpg', '2017-08-13 16:28:14', '2017-09-03 00:34:35');
INSERT INTO `item` VALUES ('8', 'Baileys/百利甜酒 爱尔兰甜酒', 'images/product-8.jpg', '洋酒Baileys百利甜酒750ml爱尔兰奶油利口酒', '7', '1200.00', '800.00', '1000', '18', '1', 'images/p8-1.jpg,images/p8-2.jpg,images/p8-3.jpg,images/p8-4.jpg', 'images/p8-img1.jpg,images/p8-img2.jpg,images/p8-img3.jpg,images/p8-img4.jpg,images/p8-img5.jpg,images/p8-img6.jpg,images/p8-img7.jpg', '2017-08-13 16:28:14', '2017-09-03 00:17:51');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '订单金额',
  `coupons` int(10) DEFAULT NULL COMMENT '使用积分',
  `address` varchar(200) DEFAULT NULL COMMENT '订单地址',
  `ships` decimal(10,2) DEFAULT NULL COMMENT '运费',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for point_detail
-- ----------------------------
DROP TABLE IF EXISTS `point_detail`;
CREATE TABLE `point_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '积分明细ID',
  `points` int(10) unsigned DEFAULT NULL COMMENT '积分数额',
  `type` char(1) DEFAULT NULL COMMENT '积分记录类型（+：加分、-：扣分）',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '用户ID',
  `order_id` int(10) unsigned DEFAULT NULL COMMENT '订单ID（返送积分缘由：购买商品）',
  `promotee_id` int(10) unsigned DEFAULT NULL COMMENT '介绍购买的用户ID（返送积分缘由：推荐会员）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_USER_ID` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='账户积分明细表';

-- ----------------------------
-- Records of point_detail
-- ----------------------------

-- ----------------------------
-- Table structure for rush_item
-- ----------------------------
DROP TABLE IF EXISTS `rush_item`;
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

-- ----------------------------
-- Records of rush_item
-- ----------------------------
INSERT INTO `rush_item` VALUES ('1', '经典海之蓝', 'images/offer-1 (2).jpg', '', '5', '1200.00', '800.00', '1000', '98', '198', '1', null, null, null, '2017-08-13 17:27:33', '2017-08-20 10:46:28');
INSERT INTO `rush_item` VALUES ('2', '法国精品葡萄酒', 'images/offer-8.jpg', '', '5', '1200.00', '800.00', '1000', '78', '198', '1', null, null, null, '2017-08-13 17:28:55', '2017-08-20 10:46:44');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `name` varchar(20) DEFAULT NULL COMMENT '用户名字',
  `phone` varchar(11) DEFAULT NULL COMMENT '用户手机',
  `type` smallint(6) DEFAULT '0' COMMENT '用户类型（0：普通用户、1：会员）',
  `points` int(10) unsigned DEFAULT NULL COMMENT '用户积分',
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
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_OPEN_ID` (`open_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '顾汉杰', '13052333613', '1', '3000', null, null, null, null, null, null, null, null, null, null, null, '2017-08-27 09:56:23', '2017-09-02 15:49:20');
INSERT INTO `user` VALUES ('2', '印霞', '13052333613', '1', '5000', null, null, null, null, null, null, null, null, null, '1', null, '2017-08-27 10:14:41', '2017-08-27 10:15:26');
