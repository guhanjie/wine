/** 
 * Project Name:		weixin-boot 
 * Package Name:	com.guhanjie.weixin 
 * File Name:			AccessTokenKit.java 
 * Create Date:		2016年8月28日 下午11:02:14 
 * Copyright (c) 2008-2016, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.task;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.HttpClientUtils;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import top.guhanjie.wine.mapper.LotteryInfoMapper;
import top.guhanjie.wine.model.LotteryInfo;

/**
 * Class Name:		AccessTokenKit<br/>
 * Description:		[description]
 * @time				2016年8月28日 下午11:02:14
 * @author			guhanjie
 * @version			1.0.0 
 * @since 			JDK 1.6 
 */
@Component
public class LotteryScrapKit {

    private static final Logger LOGGER = LoggerFactory.getLogger(LotteryScrapKit.class);
    
    @Autowired
    LotteryInfoMapper looteryInfoMapper;

    /**
     * 定时刷新福彩3D中奖号码，并落库。
     */
    @Scheduled(cron="0 30 21-23 * * ?")
    public synchronized void refreshToken() {
    	Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(now);
        if(looteryInfoMapper.selectByRound(date) != null) {
        	LOGGER.warn("lottery code for date[{}] has existed.", date);
        	return;
        }
        LOGGER.info("Starting to refresh lottery, date[{}]...", date);
		HttpGet get = null;
        CloseableHttpClient client = null;        
        CloseableHttpResponse resp = null;
        try {
            client = HttpClients.createDefault();
            get = new HttpGet("http://www.zhcw.com/kaijiang/kjData/2012/zhcw_3d_index_last30.js");
            resp = client.execute(get);
            String txt = EntityUtils.toString(resp.getEntity());
            //System.out.println("get response: [{}]"+txt);
            Pattern p = Pattern.compile(date+".*?kjZNum\":\"(.*?)\"", Pattern.DOTALL);
            System.out.println(p.pattern());
            Matcher m = p.matcher(txt);
            if (m.find( )) {
            	//System.out.println(m.group());
            	String znum = m.group(1);
            	znum = znum.replaceAll("\\s", "");
            	LOGGER.info("found lottery code[{}] for date[{}]", znum, date);
            	LotteryInfo li = new LotteryInfo();
            	li.setLotteryCode(znum);
            	li.setRound(date);
            	looteryInfoMapper.insertSelective(li);
            }
        } catch (Exception e) {
            LOGGER.error("Failed to refresh lottery.", e);
        } finally {
            HttpClientUtils.closeQuietly(resp);
            HttpClientUtils.closeQuietly(client);
        }
    }
    
}
