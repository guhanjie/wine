/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.service 
 * File Name:				ItemService.java 
 * Create Date:			2017年8月13日 下午4:53:02 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import top.guhanjie.wine.mapper.ItemMapper;
import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.util.TTLCache;

@Service
public class ItemService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ItemService.class);
    
    private static final TTLCache<Integer, Item> CACHE = new TTLCache<Integer, Item>(60 * 20); //失效时间为20分钟，按进入时间超时逐出
    
    @Autowired
    private ItemMapper itemMapper;
    
    //白酒
    public List<Item> getItemsByBaijiu() {
        return itemMapper.selectByCategory(5);
    }
    
    //洋酒
    public List<Item> getItemsByYangjiu() {
        List<Item> items1 = itemMapper.selectByCategory(6);
        List<Item> items2 = itemMapper.selectByCategory(6);
        List<Item> items = new ArrayList<Item>();
        items.addAll(items1);
        items.addAll(items2);
        return items;
    }
    
}
