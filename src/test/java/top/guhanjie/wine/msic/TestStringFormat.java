/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.msic 
 * File Name:				TestPrint.java 
 * Create Date:			2017年7月9日 下午12:08:56 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.msic;

import static org.junit.Assert.*;

import java.util.Random;

import org.junit.Test;

public class TestStringFormat {
    @Test
    public void testBinaryPrint() {
        System.out.printf("%#016x\n", 127);
        System.out.println(String.format("%16s", Integer.toBinaryString(7)));
        System.out.println(0x01<<2 | 0x01<<1 | 0x01);
    	Integer i = null;
    	if(0 != i) {
    		System.out.println(i);
    	}
    	
    	String total_fee = "1185";
    	System.out.println(Double.valueOf(total_fee)/100);
    }
    
    @Test
    public void TestRandCodeFormat() {
    	int rcode = 151;
    	String randcode = String.format("%03d", rcode);
    	System.out.println(randcode);
    }
}
