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

import top.guhanjie.wine.model.Category;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:/context/db-mysql.xml", "classpath:/test-application-context.xml"})
public class TestCategoryService {

    @Autowired
    CategoryService categoryService;
    
    @Test
    public void testAddCategory() {
        Category category = new Category();
        category.setName("balabala~");
        category.setParentId(4);
        category.setIdx(7);
        categoryService.addCategory(category);
    }
    
    @Test
    public void testListBannar() {
        List<Category> list = categoryService.listCategory();
        for(Category b : list) {
            System.out.println(JSON.toJSONString(b, true));
        }
    }
}
