package com.perssoft.common.tool;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * 
 * @author ����
 */
public class EncryptUtil {

	public final static String MD5 = "MD5";

	public static String encrypt(String inStr) {
		MessageDigest md = null;
		String out = null;

		if (null == inStr || inStr.equals("")) {
			return "";
		}
		try {
			md = MessageDigest.getInstance(MD5);
			// sha = MessageDigest.getInstance("SHA-1");
			// md.update(inStr.getBytes());
			byte[] digest = md.digest(inStr.getBytes());
			out = byte2hex(digest);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return out;
	}

	private static String byte2hex(byte[] b) {
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1) {
				hs = hs + "0" + stmp;
			} else {
				hs = hs + stmp;
			}
		}
		return hs.toUpperCase();
	}
}
