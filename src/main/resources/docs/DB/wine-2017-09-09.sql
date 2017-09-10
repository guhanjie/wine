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