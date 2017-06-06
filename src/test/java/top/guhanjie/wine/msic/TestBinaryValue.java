/** 
 * Project Name:		wine 
 * Package Name:	top.guhanjie.wine.msic 
 * File Name:			TestBinaryValue.java 
 * Create Date:		2017年6月6日 下午3:25:30 
 */  
package top.guhanjie.wine.msic;

/**
 * Class Name:      TestBinaryValue<br/>
 * Description:       [description]
 * c-time:              2017年6月6日 下午3:25:30
 * author:              guhanjie439
 * @version          1.0.0 
 * @since              JDK 1.6 
 */
public class TestBinaryValue {
	/**
	 * Method Name:     main<br/>
	 * Description:          [description]
	 * c-time:                 2017年6月6日 下午3:25:30
	 * author:                 guhanjie439
	 * @param args 
	 */
	public static void main(String[] args) {
		System.out.printf("%#016x\n", 127);
		System.out.println(0x01<<2 | 0x01<<1 | 0x01);
	}
}
