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

import org.junit.Test;

public class TestPrint {
    @Test
    public void testBinaryPrint() {
        System.out.printf("%#016x\n", 127);
        System.out.println(String.format("%16s", Integer.toBinaryString(7)));
        System.out.println(0x01<<2 | 0x01<<1 | 0x01);
    }
}
