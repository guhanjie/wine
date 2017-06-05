CREATE TABLE `wine`.`order` (
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`amount` decimal(10,2) NULL DEFAULT NULL COMMENT '订单金额',
`address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单地址',
`status` smallint(6) NULL DEFAULT 1 COMMENT '订单状态（位表示法，第1位：是否下单，第2位：是否取消订单，第3位：是否开始送货，第4位：是否送货完成，第5位：是否支付完成）',
`user_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '下单人ID',
`contactor` varchar(20) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '订单联系人',
`phone` varchar(11) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '联系电话',
`remark` varchar(200) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '订单备注',
`source` varchar(100) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '推广源',
`pay_id` varchar(64) CHARACTER SET utf8 NULL DEFAULT NULL COMMENT '微信统一下单的预支付ID',
`pay_type` smallint(6) NULL DEFAULT 0 COMMENT '支付类型（0：微信支付，1：现金）',
`pay_status` smallint(6) NULL DEFAULT 0 COMMENT '支付状态（0：未支付，1：支付成功，2：支付失败，3：转入退款，4：已关闭，5：已撤销（刷卡支付），6： 用户支付中）',
`pay_time` datetime NULL DEFAULT NULL COMMENT '支付完成时间',
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) ,
INDEX `IDX_USER_ID` (`user_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='订单表';

CREATE TABLE `wine`.`user` (
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`name` varchar(20) CHARACTER SET utf8 NULL DEFAULT NULL,
`phone` varchar(11) CHARACTER SET utf8 NULL DEFAULT NULL,
`type` smallint(6) NULL DEFAULT 1 COMMENT '用户类型（1：普通用户、2：会员）',
`points` int UNSIGNED NULL,
`open_id` varchar(50) CHARACTER SET utf8 NULL DEFAULT NULL,
`unionid` varchar(50) CHARACTER SET utf8 NULL DEFAULT NULL,
`nickname` varchar(50) CHARACTER SET utf8 NULL DEFAULT NULL,
`sex` char(1) CHARACTER SET utf8 NULL DEFAULT NULL,
`language` varchar(15) CHARACTER SET utf8 NULL DEFAULT NULL,
`address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '常用地址',
`city` varchar(15) CHARACTER SET utf8 NULL DEFAULT NULL,
`province` varchar(15) CHARACTER SET utf8 NULL DEFAULT NULL,
`country` varchar(15) CHARACTER SET utf8 NULL DEFAULT NULL,
`source_id` int UNSIGNED NULL DEFAULT NULL COMMENT '推广人ID',
`subscribe_time` datetime NULL DEFAULT NULL,
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) ,
UNIQUE INDEX `IDX_OPEN_ID` (`open_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='用户表';

CREATE TABLE `wine`.`item` (
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品ID',
`name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品名称',
`icon` varchar(200) NULL COMMENT '商品缩略图',
`detail` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '商品详情描述',
`category_id` int UNSIGNED NULL,
`normal_price` decimal(10,2) NOT NULL COMMENT '普通价格',
`vip_price` decimal(10,2) NULL COMMENT '会员价格',
`back_points` int UNSIGNED NULL COMMENT '返送积分',
`sales` int NULL COMMENT '商品销量',
`status` smallint(6) NULL DEFAULT 2 COMMENT '商品状态（1：上架、2：下架、3：删除）',
`img1` varchar(200) NULL COMMENT '商品图片1',
`img2` varchar(200) NULL,
`img3` varchar(200) NULL,
`img4` varchar(200) NULL,
`img5` varchar(200) NULL,
`img6` varchar(200) NULL,
`img7` varchar(200) NULL,
`img8` varchar(200) NULL,
`img9` varchar(200) NULL,
`img10` varchar(200) NULL,
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='商品信息表';

CREATE TABLE `wine`.`category` (
`id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '目录ID',
`name` varchar(20) NULL COMMENT '目录名称',
`level` smallint(6) NULL DEFAULT 1 COMMENT '目录层级',
`parent_id` int UNSIGNED NULL DEFAULT NULL COMMENT '父目录ID',
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='商品类目表';

CREATE TABLE `wine`.`bannar` (
`id` int NOT NULL COMMENT 'bannarID',
`index` smallint(6) NULL COMMENT 'bannar位置',
`item_id` int UNSIGNED NULL COMMENT '商品ID',
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='首屏bannar表';

CREATE TABLE `wine`.`point_detail` (
`id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '积分明细ID',
`points` int UNSIGNED NULL COMMENT '积分数额',
`type` char NULL COMMENT '积分记录类型（+：加分、-：扣分）',
`user_id` int UNSIGNED NULL COMMENT '用户ID',
`item_id` int UNSIGNED NULL DEFAULT NULL COMMENT '购买商品ID（返送积分缘由：购买商品）',
`promotee_id` int UNSIGNED NULL DEFAULT NULL COMMENT '介绍购买的用户ID（返送积分缘由：推荐会员）',
`create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`id`) ,
INDEX `IDX_USER_ID` (`user_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
COMMENT='账户积分明细表';

