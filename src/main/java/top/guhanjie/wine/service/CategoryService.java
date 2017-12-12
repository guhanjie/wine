package top.guhanjie.wine.service;

import java.util.ArrayList;
import java.util.Collections;
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

    private static final Logger LOGGER = LoggerFactory
            .getLogger(CategoryService.class);

    private static final TTLCache<Integer, Category> CACHE = new TTLCache<Integer, Category>(
            20 * 60); // 失效时间为20分钟，按进入时间超时逐出

    private volatile List<Category> categoryListCache; // 缓存汇聚结果（所有分类条目组成的树状结构）

    @Autowired
    private CategoryMapper categoryMapper;

    public synchronized void addCategory(Category category) {
        LOGGER.info("Add a new category[{}]...", JSON.toJSONString(category));
        try {
            categoryMapper.insertSelective(category);
        } catch (DuplicateKeyException e) {
            LOGGER.error("当前位置的category已存在，无法添加", e);
        }
        CACHE.put(category.getId(), category);
        categoryListCache = null; // disable list cache to update info
    }

    public synchronized void updateCategory(Category category) {
        LOGGER.info("Update category[{}]...", JSON.toJSONString(category));
        categoryMapper.updateByPrimaryKeySelective(category);
        category = categoryMapper.selectByPrimaryKey(category.getId());
        CACHE.put(category.getId(), category);
        categoryListCache = null; // disable list cache to update info
    }

    public synchronized void deleteCategory(Category category) {
        LOGGER.info("Delete category[{}]...", JSON.toJSONString(category));
        categoryMapper.deleteByPrimaryKey(category.getId());
        CACHE.remove(category.getId());
        categoryListCache = null; // disable list cache to update info
    }

    public Category getCategory(int id) {
        Category c = CACHE.get(id);
        if (c == null) {
            LOGGER.info("Category cache not hit, updating...");
            c = categoryMapper.selectByPrimaryKey(id);
            if (c != null) {
                synchronized (this) {
                    CACHE.put(id, c);
                }
            }
        }
        return c;
    }

    /**
     * 根据具体某个category获取其序列（从根到叶子节点的序列）
     */
    public List<Category> getCategorySequence(int id) {
        List<Category> cSeq = new ArrayList<Category>();
        Category c = getCategory(id);
        cSeq.add(c);
        while (c != null && c.getParentId() != 0) {
            c = getCategory(c.getParentId());
            cSeq.add(c);
        }
        Collections.reverse(cSeq);
        return cSeq;
    }

    public List<Category> listCategory() {
        if (categoryListCache == null) {
            categoryListCache = constructList();
        }
        return categoryListCache;
    }

    /**
     * 获取所有叶子节点的的分类条目列表
     */
    public List<Category> listLeafCategory() {
        List<Category> leafCategories = new ArrayList<Category>();
        List<Category> allCategories = listCategory();
        addLeafCategory(allCategories, leafCategories);
        return leafCategories;
    }
    
    /**
     * 获取指定category下面的叶子节点列表
     */
    public List<Category> listLeafCategory(int pid) {
        List<Category> leafCategories = new ArrayList<Category>();
        List<Category> allCategories = listCategory();
        Category c = findCategory(allCategories, pid);
        if (c.getSubItems() != null && !c.getSubItems().isEmpty()) {
            addLeafCategory(c.getSubItems(), leafCategories);
        }
        else {
            leafCategories.add(c);
        }
        return leafCategories;
    }

    private void addLeafCategory(List<Category> list, List<Category> leafList) {
        for (Category c : list) {
            if (c.getSubItems() != null && !c.getSubItems().isEmpty()) {
                addLeafCategory(c.getSubItems(), leafList);
            } else {
                leafList.add(c);
            }
        }
    }

    private synchronized List<Category> constructList() {
        if (CACHE.size() == 0) {
            LOGGER.info("Category cache set up...");
            List<Category> list = categoryMapper.selectAll();
            for (Category c : list) {
                CACHE.put(c.getId(), c);
            }
        }
        // Double check in lock
        if (categoryListCache != null) {
            return categoryListCache;
        }
        // TreeMap<K,V> pattern: <parentid-idx, category>
        // Attention!!! this just support up to 0-9, such case will be error:
        // 1-1, 11-1, 2-1, 3-1
        TreeMap<String, Category> orderedMap = new TreeMap<String, Category>();
        for (Category c : CACHE.values()) {
            orderedMap.put(c.getParentId() + "-" + c.getIdx(), c);
        }
        List<Category> items = new ArrayList<Category>();
        for (Category item : orderedMap.values()) {
            item.getSubItems().clear();
            if (item.getParentId() == 0) {
                items.add(item);
            } else {
                Category parent = findParent(items, item);
                if (parent != null) {
                    parent.getSubItems().add(item);
                }
            }
        }
        return items;
    }

    /**
     * 广度优先查找父目录
     */
    private Category findParent(List<Category> categories, Category c) {
        for (Category i : categories) {
            if (i.getId() == c.getParentId()) {
                return i;
            }
        }
        for (Category i : categories) {
            return findParent(i.getSubItems(), c);
        }
        LOGGER.error("can not find parent category for: [{}]",
                JSON.toJSONString(c));
        return null;
    }
    
    /**
     * 广度优先查找指定category
     */
    private Category findCategory(List<Category> categories, int cid) {
        if(categories != null) {
            for (Category i : categories) {
                if (i.getId() == cid) {
                    return i;
                }
            }
            for (Category i : categories) {
                if(i.getSubItems() != null) {
                    return findCategory(i.getSubItems(), cid);
                }
            }
        }
        return null;
    }
    
//   
//    /**
//     * 根据cid获取其所有的叶子节点
//     * 如果本身是叶子目录，则直接返回
//     */
//    public void getChildCategories(int pid, List<Category> ) {
//        List<Category> res = new ArrayList<Category>();
//        List<Category> list = categoryMapper.selectByParentId(pid);
//        //本身是叶子目录
//        if(list.size()==0) {
//            Category c = categoryMapper.selectByPrimaryKey(pid);
//            if(c != null) {
//                res.add(c);
//            }
//        }
//        else {
//            for(Category i : list) {
//                List<Category> list = getChildCategories(i.getId());
//            }
//        }
//    }

}
