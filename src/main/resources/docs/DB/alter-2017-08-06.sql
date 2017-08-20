USE wine;

-- Table: bannar
ALTER TABLE `bannar`
ADD COLUMN `img`  varchar(200) NULL COMMENT 'banner图片' AFTER `id`,
ADD COLUMN `title`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '图片居中标题' AFTER `img`,
ADD COLUMN `description`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '图片居中详述' AFTER `title`,
CHANGE COLUMN `index` `idx`  smallint(6) UNSIGNED NULL DEFAULT NULL COMMENT 'bannar位置' AFTER `description`,
MODIFY COLUMN `idx`  int(6) UNSIGNED NULL DEFAULT NULL COMMENT 'bannar位置' AFTER `description`,
ADD UNIQUE INDEX `IDX_idx` (`idx`) USING BTREE ;

-- Table: category
ALTER TABLE `category`
MODIFY COLUMN `level`  int(6) NULL DEFAULT 1 COMMENT '目录层级' AFTER `name`,
ADD COLUMN `idx`  int NULL COMMENT '本层级内的排列位置' AFTEsR `level`,
ADD UNIQUE INDEX `IDX_parent_id_idx` (`parent_id`, `idx`) USING BTREE ;

-- Table: item
ALTER TABLE `item`
MODIFY COLUMN `status`  int(6) NULL DEFAULT 2 COMMENT '商品状态（1：上架、2：下架、3：删除）' AFTER `sales`,
DROP COLUMN `img2`,
DROP COLUMN `img3`,
DROP COLUMN `img4`,
DROP COLUMN `img5`,
DROP COLUMN `img6`,
DROP COLUMN `img7`,
DROP COLUMN `img8`,
DROP COLUMN `img9`,
DROP COLUMN `img10`,
CHANGE COLUMN `img1` `images`  varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片（以，分隔）' AFTER `status`,
CHANGE COLUMN `images` `detail_imgs`  varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品详情图片（以，分隔）' AFTER `status`,
ADD COLUMN `title_imgs`  varchar(1000) NULL COMMENT '商品预览图片（以，分隔）' AFTER `status`;

-- Table: rush_item
ALTER TABLE `rush_item`
DROP COLUMN `img2`,
DROP COLUMN `img3`,
DROP COLUMN `img4`,
DROP COLUMN `img5`,
DROP COLUMN `img6`,
DROP COLUMN `img7`,
DROP COLUMN `img8`,
DROP COLUMN `img9`,
DROP COLUMN `img10`,
CHANGE COLUMN `img1` `images`  varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品图片（以，分隔）' AFTER `end_time`;

-- Table: order
ALTER TABLE `order`
MODIFY COLUMN `status`  int(6) NULL DEFAULT 1 COMMENT '订单状态（位表示法，第1位：是否下单，第2位：是否取消订单，第3位：是否开始送货，第4位：是否送货完成，第5位：是否支付完成）' AFTER `address`,
MODIFY COLUMN `pay_type`  int(6) NULL DEFAULT 0 COMMENT '支付类型（0：微信支付，1：现金）' AFTER `pay_id`,
MODIFY COLUMN `pay_status`  int(6) NULL DEFAULT 0 COMMENT '支付状态（0：未支付，1：支付成功，2：支付失败，3：转入退款，4：已关闭，5：已撤销（刷卡支付），6： 用户支付中）' AFTER `pay_type`,
CHANGE COLUMN `source` `spm`  varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推广源跟踪（a.b.c.d）' AFTER `remark`,
ADD COLUMN `source_id`  int(10) NULL COMMENT '订单来源商品id' AFTER `remark`,
ADD COLUMN `source_type`  varchar(50) NULL COMMENT '订单来源类型（normal：普通商品，rush：1元购活动）' AFTER `item_id`;
