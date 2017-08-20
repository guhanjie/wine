package top.guhanjie.wine.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.TreeMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.mapper.CategoryMapper;
import top.guhanjie.wine.model.Category;
import top.guhanjie.wine.util.TTLCache;

@Service
public class CategoryService {  

    private static final Logger LOGGER = LoggerFactory.getLogger(CategoryService.class);

    private static final TTLCache<Integer, Category> CACHE = new TTLCache<Integer, Category>(-1); //失效时间为20分钟，按进入时间超时逐出
    
    private volatile List<Category> categoryListCache; //缓存汇聚结果
    
    @Autowired
    private CategoryMapper categoryMapper;
    
    public synchronized void addCategory(Category category) {
        try {
            categoryMapper.insertSelective(category);
        } catch(DuplicateKeyException e) {
            LOGGER.error("当前位置的bannar已存在，无法添加", e);
        }
        CACHE.put(category.getId(), category);
        categoryListCache = null;  //disable listcached to update info
        LOGGER.debug("Added a new bannar[{}]...", JSON.toJSONString(category));
    }
    
    public synchronized void updateCategory(Category category) {
        categoryMapper.updateByPrimaryKeySelective(category);
        category = categoryMapper.selectByPrimaryKey(category.getId());
        CACHE.put(category.getId(), category);
        categoryListCache = null;  //disable listcached to update info
        LOGGER.debug("Updated bannar[{}]...", JSON.toJSONString(category));
    }
    
    public synchronized void deleteCategory(Category category) {
        categoryMapper.deleteByPrimaryKey(category.getId());
        CACHE.remove(category.getId());
        categoryListCache = null;  //disable listcached to update info
        LOGGER.debug("Deleted bannar[{}]...", JSON.toJSONString(category));
    }
    
    public List<Category> listCategory() {
        if(categoryListCache == null) {
            categoryListCache = constructList();
        }
        return categoryListCache;
    }
    
    private synchronized List<Category> constructList() {
        if(CACHE.size() == 0) {
            LOGGER.info("Category cache set up...");
            List<Category> list = categoryMapper.selectAll();
            for(Category c : list) {
                CACHE.put(c.getId(), c);
            }
        }
        //TreeMap<K,V> pattern: <parentid-idx, category>
        //Attention!!! this just support up to 0-9, such case will be error:  1-1, 11-1, 2-1, 3-1
        TreeMap<String, Category> categories = new TreeMap<String, Category>();
        for(Category c : CACHE.values()) {
            categories.put(c.getParentId()+"-"+c.getIdx(), c);
        }
        List<Category> items = new ArrayList<Category>();
        for(Category item : categories.values()) {
            item.getSubItems().clear();
            if(item.getParentId() == 0) {
                items.add(item);
            }
            else {
                Category parent = findParent(items, item);
                if(parent != null) {
                    parent.getSubItems().add(item);
                }
            }
        }
        return items;
    }
    
    public Category getCategory(int id) {
        Category c = CACHE.get(id);
        if(c == null) {
            LOGGER.info("Category not hit cache, updating...");
            c = categoryMapper.selectByPrimaryKey(id);
            if(c != null) {
                synchronized(this) {
                    CACHE.put(id, c);
                }
            }
        }
        return c;
    }
    
    //广度优先查找父目录
    private Category findParent(List<Category> items, Category c) {
        for(Category item : items) {
            if(item.getId() == c.getParentId()) {
                return item;
            }
        }
        for(Category item : items) {
            return findParent(item.getSubItems(), c);
        }
        LOGGER.error("can not find parent category for: [{}]", JSON.toJSONString(c));
        return null;
    }
    
}
