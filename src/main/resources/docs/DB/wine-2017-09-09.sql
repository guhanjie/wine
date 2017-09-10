use wine;
ALTER TABLE `user` ADD COLUMN `qrcode_ticket` varchar(200) NULL COMMENT '推广二维码ticket' AFTER `subscribe_time`;
ALTER TABLE `user` ADD COLUMN `qrcode_url` varchar(200) NULL COMMENT '推广二维码最终链接' AFTER `qrcode_ticket`;