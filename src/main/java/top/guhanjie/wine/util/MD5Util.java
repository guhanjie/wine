package top.guhanjie.wine.util;

import java.security.MessageDigest;


public class MD5Util {	 
	public static String md5(String str) {
		byte[] byteArray = null;
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("MD5");
			messageDigest.reset();
			messageDigest.update(str.getBytes("UTF-8"));
			byteArray = messageDigest.digest();
		} catch (Exception e) {
			e.printStackTrace();
		}

		StringBuffer md5StrBuff = new StringBuffer();

		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1) {
				md5StrBuff.append("0");
			}
			md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
		}
		return md5StrBuff.toString();
	}
	
	public static void main(String[] args) {
		System.out.println(MD5Util.md5("guhanjie"));
	}
}
