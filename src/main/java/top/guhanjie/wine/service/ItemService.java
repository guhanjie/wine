/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.service 
 * File Name:				ItemService.java 
 * Create Date:			2017年8月13日 下午4:53:02 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.service;

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
    
    private static final Integer CATEGORY_WRITE = 5;
    private static final Integer CATEGORY_WINE = 6;
    private static final Integer CATEGORY_BEER = 7;
    
    private static final TTLCache<Integer, List<Item>> GROUPED_ITEMS_CACHE = 
                    new TTLCache<Integer, List<Item>>(10 * 60); //失效时间为10分钟，按进入时间超时逐出

    private static final TTLCache<Integer, Item> ITEM_CACHE = 
                    new TTLCache<Integer, Item>(10 * 60); //失效时间为10分钟，按进入时间超时逐出
    
    @Autowired
    private ItemMapper itemMapper;
    
    //白酒
    public List<Item> listWhiteWine() {
        List<Item> items = GROUPED_ITEMS_CACHE.get(CATEGORY_WRITE);
        if(items == null) {
            LOGGER.info("white wine Item not hit cache, updating...");
            items = itemMapper.selectByCategory(CATEGORY_WRITE);
            GROUPED_ITEMS_CACHE.put(CATEGORY_WRITE, items);
        }
        return items;
    }
    
    //红酒
    public List<Item> listWine() {
        List<Item> items = GROUPED_ITEMS_CACHE.get(CATEGORY_WINE);
        if(items == null) {
            LOGGER.info("wine Item not hit cache, updating...");
            items = itemMapper.selectByCategory(CATEGORY_WINE);
            GROUPED_ITEMS_CACHE.put(CATEGORY_WINE, items);
        }
        return items;
    }

    //啤酒
    public List<Item> listBeer() {
        List<Item> items = GROUPED_ITEMS_CACHE.get(CATEGORY_BEER);
        if(items == null) {
            LOGGER.info("beer Item not hit cache, updating...");
            items = itemMapper.selectByCategory(CATEGORY_BEER);
            GROUPED_ITEMS_CACHE.put(CATEGORY_BEER, items);
        }
        return items;
    }
    
    public Item getItem(Integer itemId) {
        Item item = ITEM_CACHE.get(itemId);
        if(item == null) {
            LOGGER.info("Item not hit cache, updating...");
            item = itemMapper.selectById(itemId);
            ITEM_CACHE.put(itemId, item);
        }
        return item;
    }
}
