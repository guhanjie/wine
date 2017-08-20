/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.msic 
 * File Name:				TestTreeMap.java 
 * Create Date:			2017年8月6日 下午5:10:38 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.msic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.TreeMap;

import org.junit.Test;

import top.guhanjie.wine.model.Category;

public class TestTreeMap {
    @Test
    public void test() {
        //test case 1
        TreeMap<Integer, String> map = new TreeMap<Integer, String>();
        map.put(2, "2");
        map.put(4, "4");
        map.put(1, "1");
        map.put(3, "3");
        map.put(5, "5");
        for(String str : map.values()) {
            System.out.println(str);
        }

        //test case 2
        TreeMap<String, String> map2 = new TreeMap<String, String>();
        map2.put("1-1", "1-1");
        map2.put("1-2", "1-2");
        map2.put("2-0", "2-3");
        map2.put("3-1", "2-3");
        map2.put("11-1", "11-1");
        map2.put("24-1", "24-1");
        for(String key : map2.keySet()) {
            System.out.println(key+":"+map2.get(key));
        }
        
//        TreeMap<Integer, Category> map3 = new TreeMap<Integer, Category>();
//        Category m = new Category();
//        m.setId(1);
//        m.setIdx(1);
//        m.setParentId(0);
//        map3.put(1, m);
//        List<Category> items = new ArrayList<Category>();
//        for(Integer id : map3.keySet()) {
//            Category c = map3.get(id);
//            c.getSubItems().clear();
//            items.add(c);
//        }
//        Collections.sort(items, new Comparator<Category>() {
//
//            @Override
//            public int compare(Category o1, Category o2) {
//                if(o1.getParentId() < o2.getParentId())
//                    return -1;
//                else if(o1.getParentId() == o2.getParentId())
//                    return o1.getIdx() - o2.getIdx();
//                return 1;
//            }
//
//        });
    }
}
