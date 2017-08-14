/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.msic 
 * File Name:				TestTreeMap.java 
 * Create Date:			2017年8月6日 下午5:10:38 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.msic;

import java.util.TreeMap;

import org.junit.Test;

public class TestTreeMap {
    @Test
    public void test() {
        TreeMap<Integer, String> map = new TreeMap<Integer, String>();
        map.put(2, "2");
        map.put(4, "4");
        map.put(1, "1");
        map.put(3, "3");
        map.put(5, "5");
        for(String str : map.values()) {
            System.out.println(str);
        }
    }
}
