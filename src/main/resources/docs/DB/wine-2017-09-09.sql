use wine;

-- Table: user
ALTER TABLE `user` ADD COLUMN `qrcode_ticket` varchar(200) NULL COMMENT '推广二维码ticket' AFTER `subscribe_time`;
ALTER TABLE `user` ADD COLUMN `qrcode_url` varchar(200) NULL COMMENT '推广二维码最终链接' AFTER `qrcode_ticket`;

-- Table: point_detail
ALTER TABLE `point_detail` ADD COLUMN `remark` varchar(200) NULL COMMENT '明细备注' AFTER `create_time`;

-- Table: order
ALTER TABLE `order` 
CHANGE COLUMN `amount` `total_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总额' AFTER `id`,
ADD COLUMN `pay_amount` decimal(10,2) DEFAULT NULL COMMENT '支付金额' AFTER `total_amount`;

-- Table: vip_item
DROP TABLE IF EXISTS `vip_item`;
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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='VIP商品信息表'