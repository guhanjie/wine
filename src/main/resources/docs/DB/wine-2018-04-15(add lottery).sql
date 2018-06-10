DROP TABLE IF EXISTS `rush_lottery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rush_lottery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(10) unsigned DEFAULT NULL COMMENT '订单ID',
  `user_id` int(10) unsigned DEFAULT NULL COMMENT '下单用户ID',
  `rush_item_id` int(10) unsigned DEFAULT NULL COMMENT '1元秒杀活动ID',
  `lottery_code` varchar(10) DEFAULT NULL COMMENT '彩票号码',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_user_item_code` (`user_id`,`rush_item_id`,`lottery_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='1元抢购用户活动表';
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `lottery_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lottery_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lottery_code` varchar(10) DEFAULT NULL COMMENT '开奖号码',
  `round` varchar(20) DEFAULT NULL COMMENT '第x期',
  `type` int(6) DEFAULT '1' COMMENT '彩票类型：（1：福彩3D，2：试机号）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 COMMENT='彩票中奖信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `rush_item`
DROP COLUMN `images`,
ADD COLUMN `status` int(6) DEFAULT '2' COMMENT '商品状态（1：进行中、2：未开始、3：已结束、4：已删除）' AFTER `count`;
ADD COLUMN `lottery_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开奖号码' AFTER `status`,
ADD COLUMN `round` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第x期' AFTER `lottery_code`,
ADD COLUMN `title_imgs` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品预览图片（以，分隔）' AFTER `end_time`,
ADD COLUMN `detail_imgs` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品详情图片（以，分隔）' AFTER `title_imgs`;