/** 
 * Project Name:		weixin-boot 
 * Package Name:	com.guhanjie.weixin 
 * File Name:			AccessTokenKit.java 
 * Create Date:		2016年8月28日 下午11:02:14 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.weixin.token;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;

import top.guhanjie.wine.weixin.WeixinConstants;
import top.guhanjie.wine.weixin.WeixinHttpUtil;
import top.guhanjie.wine.weixin.WeixinHttpUtil.WeixinHttpCallback;
import top.guhanjie.wine.weixin.model.AccessToken;

/**
 * Class Name:		AccessTokenKit<br/>
 * Description:		[description]
 * @time				2016年8月28日 下午11:02:14
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
@Component
public class AccessTokenKit {

    private static final Logger LOGGER = LoggerFactory.getLogger(AccessTokenKit.class);
    
    private static volatile String token;
    
    @Autowired
    private WeixinConstants weixinContants;
    
    public static String getToken() {
        return token;
    }

    /**
     * 定时刷新本微信公众号的access_token（access_token有效期是2小时，我们每1.5小时定时刷新）
     * access_token是公众号的全局唯一接口调用凭据，公众号调用各接口时都需使用access_token。
     */
    @Scheduled(fixedRate=6000000)
    public synchronized void refreshToken() {
        LOGGER.info("Starting to refresh access token...");
        try {
            String url = WeixinConstants.API_ACCESS_TOKEN;
            url = url.replaceAll("APPID", weixinContants.APPID);
            url = url.replaceAll("APPSECRET", weixinContants.APPSECRET);
            WeixinHttpUtil.sendGet(url, new WeixinHttpCallback() {
                @Override
                public void process(String json) {
                    AccessToken at = JSONObject.parseObject(json, AccessToken.class);
                    if(at!=null && at.getAccess_token() != null) {
                        token = at.getAccess_token();
                        LOGGER.info("Success to refresh access token:[{}].", token);
                    }
                    else {
                        LOGGER.error("Failed to refresh access token.");
                    }
                }
            });
        } catch (Exception e) {
            LOGGER.error("Failed to refresh access token.", e);
        }
    }
    
}
