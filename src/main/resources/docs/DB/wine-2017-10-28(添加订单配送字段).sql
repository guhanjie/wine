use wine;

-- Table: user
ALTER TABLE `order` ADD COLUMN `ship_type` int(6) DEFAULT '1' COMMENT '派送方式：（1：快递，2：同城快速配送）' AFTER `ships`;