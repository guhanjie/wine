package top.guhanjie.wine.msic;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.alibaba.fastjson.JSON;

/**
 * Created by guhanjie on 2017-09-09.
 */
public class TestJSONDeserialize {

	public static void main(String[] args) throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		// TODO Auto-generated method stub
		String str = "{\"ticket\":\"gQH47joAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL2taZ2Z3TVRtNzJXV1Brb3ZhYmJJAAIEZ23sUwMEmm\n" + 
				"3sUw==\",\"expire_seconds\":60,\"url\":\"http:\\/\\/weixin.qq.com\\/q\\/kZgfwMTm72WWPkovabbI\"}";
		Object r = JSON.parseObject(str);
		System.out.println(BeanUtils.getProperty(r, "ticket"));
	}

	
	private static class QrcodeCreateResponse {
    	private String ticket;
    	private String expire_seconds;
    	private String url;
    	
    	public void setTicket(String ticket) {
    		this.ticket = ticket;
    	}
    }
}
