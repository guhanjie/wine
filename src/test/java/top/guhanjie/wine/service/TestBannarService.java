/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.service 
 * File Name:				TestBannarService.java 
 * Create Date:			2017年8月6日 下午4:25:41 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.model.Bannar;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestBannarService {

    @Autowired
    BannarService bannarService;
    
    @Test
    public void testAddBannar() {
        Bannar bannar = new Bannar();
        bannar.setIdx(7);
        bannar.setTitle("xoxox~");
        bannarService.addBannar(bannar);
    }
    
    @Test
    public void testListBannar() {
        List<Bannar> list = bannarService.listBannar();
        for(Bannar b : list) {
            System.out.println(JSON.toJSONString(b, true));
        }
    }
}
