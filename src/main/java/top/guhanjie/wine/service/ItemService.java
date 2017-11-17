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
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.mapper.ItemMapper;
import top.guhanjie.wine.model.Category;
import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.util.TTLCache;

@Service
public class ItemService {

    private static final Logger LOGGER = LoggerFactory.getLogger(ItemService.class);
    
    private static final Integer CATEGORY_WHITE = 5; //白酒
    private static final Integer CATEGORY_WINE = 6;	//红酒
    private static final Integer CATEGORY_BEER = 7; //啤酒
    
    private static final TTLCache<Integer, List<Item>> GROUPED_ITEMS_CACHE = 
                    new TTLCache<Integer, List<Item>>(10 * 60); //失效时间为10分钟，按进入时间超时逐出

    private static final TTLCache<Integer, Item> ITEM_CACHE = 
                    new TTLCache<Integer, Item>(10 * 60); //失效时间为10分钟，按进入时间超时逐出
    
    @Autowired
    private ItemMapper itemMapper;
    
    @Autowired
    private CategoryService categoryService;
    
    public void addItem(Item item) {
		LOGGER.info("Add a new item[{}]...", JSON.toJSONString(item, true));
		itemMapper.insertSelective(item);
		ITEM_CACHE.put(item.getId(), item);
//		//update cache for new item info
//		List<Item> items = GROUPED_ITEMS_CACHE.get(item.getCategoryId());
//		if(items == null) {
//			items = new ArrayList<Item>();
//			items.add(item);
//			GROUPED_ITEMS_CACHE.put(item.getCategoryId(), items);
//		}
//		else {
//			items.add(item);
//		}
		GROUPED_ITEMS_CACHE.clear();  //disable cache to update info 
	}

    public void updateItem(Item item) {
		LOGGER.info("Update item[{}]...", JSON.toJSONString(item, true));
		itemMapper.updateByPrimaryKeySelective(item);
		ITEM_CACHE.put(item.getId(), item);
		GROUPED_ITEMS_CACHE.clear();  //disable cache to update info
	}
    
    public void deleteItem(Item item) {
    	LOGGER.info("Delete item[{}]...", JSON.toJSONString(item, true));
    	//item.setStatus(3); //商品删除状态
    	itemMapper.deleteByPrimaryKey(item.getId());
    	ITEM_CACHE.remove(item.getId());
    	GROUPED_ITEMS_CACHE.clear();  //disable cache to update info
    }
    
    //前台首页显示
    public List<Item> listIndexItems(Integer categoryId) {
        List<Item> items = GROUPED_ITEMS_CACHE.get(categoryId);
        if(items == null) {
            LOGGER.info("items for category[{}] cache not hit, updating...", categoryId);
            items = itemMapper.selectByCategory(categoryId);
            GROUPED_ITEMS_CACHE.put(categoryId, items);
            LOGGER.info("items for category[{}] cache updated", categoryId);
        }
        return items;
//        List<Category> cateList = categoryService.listLeafCategory();
//        List<Item> items = null;
//        if(GROUPED_ITEMS_CACHE.size() == 0) {
//            for(Category c : cateList) {
//                items = itemMapper.selectByCategory(c.getId());
//                GROUPED_ITEMS_CACHE.put(c.getId(), items);
//            }
//        }
//        return (Map<Integer, List<Item>>)GROUPED_ITEMS_CACHE.maps();
    }

	//白酒
    public List<Item> listWhiteWine() {
        List<Item> items = GROUPED_ITEMS_CACHE.get(CATEGORY_WHITE);
        if(items == null) {
            LOGGER.info("white wine Item not hit cache, updating...");
            items = itemMapper.selectByCategory(CATEGORY_WHITE);
            GROUPED_ITEMS_CACHE.put(CATEGORY_WHITE, items);
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
    
    //后台管理用
    public List<Item> listAllItems() {
    	List<Item> items = itemMapper.selectAll();
        return items;
    }
    
    public Item getItem(Integer itemId) {
        Item item = ITEM_CACHE.get(itemId);
        if(item == null) {
            LOGGER.info("Item cache not hit, updating...");
            item = itemMapper.selectById(itemId);
            ITEM_CACHE.put(itemId, item);
        }
        return item;
    }
    
    public List<Item> getRelativeItems(Integer categoryId) {
    	LOGGER.debug("get relative items for category[{}]", categoryId);
    	List<Item> res = new ArrayList<Item>();
    	List<Category> categories = categoryService.listLeafCategory(categoryId);
    	for(Category c : categories) {
    	    List<Item> items = itemMapper.selectByCategory(c.getId());
    	    res.addAll(items);
    	}
    	return res;
    }
    
    @Transactional
    public void addSales(String items) {
    	LOGGER.debug("add sales for items:[{}]", items);
		String[] it = items.split(",");
		for(String str : it) {
			String[] iteminfo = str.split(":");
			Integer itemId = Integer.parseInt(iteminfo[0]);
			Integer count = Integer.parseInt(iteminfo[1]);
			if(0 == itemMapper.addSales(itemId, count)) {
				throw new RuntimeException("add sales for items["+items+"] failed, transaction rollback....");
			}
		}
    }
    
}
