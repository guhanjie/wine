/** 
 * Project Name:			weixin-boot 
 * Package Name:		com.guhanjie.misc 
 * File Name:				TestConcurrentModificationException.java 
 * Create Date:			2017年8月20日 下午8:24:11 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.msic;

import java.util.Random;
import java.util.Set;
import java.util.TreeSet;

import top.guhanjie.wine.util.TTLCache;

public class TestConcurrentModificationException {
    public static TTLCache<Integer, String> cache = new TTLCache<Integer, String>(-1);
    
    public static void main(String[] args) {
        for(int i=0; i<100; i++) {
            cache.put(i, "test");
        }
        Thread t1 = new Thread() {
            public void run() {
                while(true) {
                    Set<Integer> keys = new TreeSet<Integer>(cache.keySet());
                    for(Integer key : keys) {
                        System.out.println(key);
                    }
                }
            }
        };
        Thread t2 = new Thread() {
            public void run() {
                while(true) {
                    Random r = new Random();
                    cache.put(r.nextInt(1000), "test");
                }
            }
        };
        t1.start();
        t2.start();
    }
}
