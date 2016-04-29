package com.clz.core.extend;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5 {
	private static char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7',
			'8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };

	private static MessageDigest md = null;

	static {
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 将源字符串通过MD5加密不可逆算法生成密文,null失败
	 * 
	 * @param src
	 * @return
	 */
	public static String encrypt(String src) {
		if(null == src ) return null;
		try {
			byte[] bytes = src.getBytes();
			md.update(bytes);
			byte[] dstBytes = md.digest();
			int j = dstBytes.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = dstBytes[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
