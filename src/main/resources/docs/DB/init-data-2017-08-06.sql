USE wine;

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