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

--------------------------
-- initialize data
--------------------------

-- Table: bannar
INSERT INTO `bannar` (`id`, `img`, `title`, `description`, `idx`, `item_id`) VALUES ('1', 'images/banner-1.jpg', '经典洋河好酒', '酒体饱满丰润，珍藏版佳酿！', '1', '1');
INSERT INTO `bannar` (`id`, `img`, `title`, `description`, `idx`, `item_id`) VALUES ('2', 'images/banner-2.jpg', '长城 干红葡萄酒', '细选葡萄原料，用心酿制而成！', '2', '2');
INSERT INTO `bannar` (`id`, `img`, `title`, `description`, `idx`, `item_id`) VALUES ('3', 'images/banner-3.jpg', '茅台 15年贵州茅台酒', '天贵人和，厚德致远！', '3', '3');
INSERT INTO `bannar` (`id`, `img`, `title`, `description`, `idx`, `item_id`) VALUES ('4', 'images/banner-4.jpg', '郎酒 红花郎酒', '自然美景，良好水源，天宝洞藏！', '4', '4');
INSERT INTO `bannar` (`id`, `img`, `title`, `description`, `idx`, `item_id`) VALUES ('5', 'images/banner-5.jpg', '小糊涂仙 浓香型', '选用高粱，秉承传统工艺酿造而成！', '5', '5');

-- Table: category
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('1', '酒水', '1', '0');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('2', '茶叶', '1', '0');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('3', '礼品', '1', '0');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('4', '集市', '1', '0');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('5', '白酒', '2', '1');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('6', '红酒', '2', '1');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('7', '啤酒', '2', '1');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('8', '碧螺春', '2', '2');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('9', '龙井', '2', '2');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('10', '海鲜', '2', '3');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('11', '肉', '2', '3');
INSERT INTO `category` (`id`, `name`, `level`, `parent_id`) VALUES ('12', '鱼', '2', '3');

-- Table: item
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('1', '泸州老窖 国窖 1573', 'images/product-1.jpg', '', '5', '1200', '800', '1000', '18', '1');
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('2', '小糊涂仙 浓香型', 'images/product-2.jpg', '', '5', '1200', '800', '1000', '18', '1');
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('3', '郎酒 红花郎酒', 'images/product-3.jpg', '', '5', '1200', '800', '1000', '18', '1');
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('4', '茅台 15年贵州茅台酒', 'images/product-4.jpg', '', '5', '1200', '800', '1000', '18', '1');
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('5', '巴黎之花 PerrierJouet特级干型香槟', 'images/product-5.jpg', '', '6', '1200', '800', '1000', '18', '1');
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('6', '长城 干红葡萄酒', 'images/product-6.jpg', '', '6', '1200', '800', '1000', '18', '1');
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('7', '1664白啤酒', 'images/product-7.jpg', '', '7', '1200', '800', '1000', '18', '1');
INSERT INTO `item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `sales`, `status`) 
VALUES ('8', 'Baileys/百利甜酒 爱尔兰甜酒', 'images/product-8.jpg', '', '7', '1200', '800', '1000', '18', '1');

-- Table: rush_item
INSERT INTO `rush_item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `buyers`, `counts`, `status`) 
VALUES ('1', '经典海之蓝', 'images/offer-1 (2).jpg', '', '5', '1200', '800', '1000', 198, 98, 1);
INSERT INTO `rush_item` (`id`, `name`, `icon`, `detail`, `category_id`, `normal_price`, `vip_price`, `back_points`, `buyers`, `counts`, `status`) 
VALUES ('2', '法国精品葡萄酒', 'images/offer-8.jpg', '', '5', '1200', '800', '1000', 198, 98, 1);