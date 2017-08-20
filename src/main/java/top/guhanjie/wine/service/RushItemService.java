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
import java.util.Set;
import java.util.TreeSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import top.guhanjie.wine.mapper.RushItemMapper;
import top.guhanjie.wine.model.Bannar;
import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.model.RushItem;
import top.guhanjie.wine.util.TTLCache;

@Service
public class RushItemService {

    private static final Logger LOGGER = LoggerFactory.getLogger(RushItemService.class);
    
    private static final TTLCache<Integer, RushItem> CACHE = new TTLCache<Integer, RushItem>(60 * 20); //失效时间为20分钟，按进入时间超时逐出
    
    @Autowired
    private RushItemMapper itemMapper;
    
    //获取当前正在进行的活动商品列表
    public List<RushItem> listRushItems() {
        if(CACHE.size() == 0) {
            LOGGER.info("RushItem cache set up...");
            List<RushItem> items = itemMapper.selectByStatus(RushItem.StatusEnum.PROCESSING.code());
            for(RushItem e : items) {
                CACHE.put(e.getId(), e);
            }
        }
        Set<Integer> keys = new TreeSet<Integer>(CACHE.keySet());
        List<RushItem> items = new ArrayList<RushItem>();
        for(Integer key : keys) {
            items.add(CACHE.get(key));
        }
        return items;
    }
    
    //获取某个活动商品
    public RushItem getRushItem(Integer id) {
        RushItem item = CACHE.get(id);
        if(item == null) {
            LOGGER.info("RushItem not hit cache, updating...");
            item = itemMapper.selectByPrimaryKey(id);
            if(item != null) {
                CACHE.put(id, item);
            }
        }
        return item;
    }
    
}
