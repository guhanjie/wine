use wine;

-- Table: rush_item
ALTER TABLE `rush_item` MODIFY COLUMN `buyers` int(10) DEFAULT '0' COMMENT '参与人数' AFTER `back_points`;
ALTER TABLE `rush_item` MODIFY COLUMN `counts` int(10) DEFAULT '0' COMMENT '抢购份数' AFTER `buyers`;