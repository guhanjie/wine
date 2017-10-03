use wine;

-- Table: user
ALTER TABLE `user` MODIFY COLUMN `points` int(10) unsigned DEFAULT '0' COMMENT '用户积分' AFTER `type`;
ALTER TABLE `user` MODIFY COLUMN `type` int(10) DEFAULT '0' COMMENT '用户类型（0：会员、1：代理商）' AFTER `phone`;