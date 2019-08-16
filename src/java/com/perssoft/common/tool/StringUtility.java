package com.perssoft.common.tool;

import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;

import org.apache.commons.lang.StringUtils;

public class StringUtility {

	/**
	 * 用分割符分割字符串为数组
	 * 
	 * @param org
	 * @param splitstr
	 * @return
	 */
	public static String[] getArrayBySplitString(String org, String splitstr) {
		if (org == null) {
			return null;
		}
		StringTokenizer token = new StringTokenizer(org, splitstr);
		String[] result = new String[token.countTokens()];
		int i = 0;
		while (token.hasMoreTokens()) {
			result[i] = token.nextToken();
			i++;
		}

		return result;
	}

	/**
	 * �ַ�תint
	 * 
	 * @param value
	 * @return
	 */
	public static int transformStringToInt(String value) {
		int result = 0;
		try {
			result = Integer.parseInt(value);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	/**
	 * Integerת�ַ�
	 * 
	 * @param value
	 * @return
	 */
	public static String transformIntToString(Integer value) {
		if (value == null) {
			return null;
		}

		return value.toString();
	}

	/**
	 * �ַ�����תint����
	 * 
	 * @param value
	 * @return
	 */
	public static int[] transformStringToInt(String[] values) {
		int[] result = new int[values.length];
		for (int i = 0; i < values.length; i++) {
			result[i] = transformStringToInt(values[i]);
		}

		return result;
	}

	/**
	 * �ַ�תdouble
	 * 
	 * @param value
	 * @return
	 */
	public static double transformStringToDouble(String value) {
		double result = 0;
		try {
			result = Double.parseDouble(value);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	/**
	 * �����滻�ַ��е�?
	 * 
	 * @param str
	 * @param vector
	 * @return
	 */
	public static String formatStr(String str, Vector params) {
		String s1 = "";
		int i = 0;
		int j;
		int k = 0;
		j = str.indexOf('?', i);
		while (j != -1) {
			if (params.size() <= k) {
				break;
			}
			s1 = s1.concat(str.substring(i, j));
			s1 = s1.concat((params.elementAt(k) == null ? "null" : params
					.elementAt(k).toString()));
			i = j + 1;
			k++;
			j = str.indexOf('?', i);
		}

		s1 = s1.concat(str.substring(i));
		return s1;
	}

	/**
	 * ��HTML���б���ת��
	 */
	public static String htmlEncode(String str) {
		String sTemp;
		sTemp = str;
		if (sTemp.equals("")) {
			return "";
		}
		sTemp = sTemp.replaceAll("&", "&amp;");
		sTemp = sTemp.replaceAll("<", "&lt;");
		sTemp = sTemp.replaceAll(">", "&gt;");
		sTemp = sTemp.replaceAll("\"", "&quot;");
		return sTemp;
	}

	/**
	 * ��HTML���н���ת��
	 */
	public static String htmlDecode(String str) {
		String sTemp;
		sTemp = str;
		if (sTemp.equals("")) {
			return "";
		}
		sTemp = sTemp.replaceAll("&amp;", "&");
		sTemp = sTemp.replaceAll("&lt;", "<");
		sTemp = sTemp.replaceAll("&gt;", ">");
		sTemp = sTemp.replaceAll("&quot;", "\"");
		return sTemp;
	}

	/**
	 * aa bb cc dd => aa|bb|cc|dd|
	 * 
	 * @param array
	 * @param split
	 * @return
	 */
	public static String arrayToString(String[] array, String split) {
		if (array == null || split == null) {
			return "";
		}

		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < array.length; i++) {
			if (null != array[i]) {
				sb.append(array[i]);
				sb.append(split);
			}
		}

		return sb.toString();
	}

	/**
	 * ��Object�������string
	 * 
	 * @param array
	 * @param split
	 * @return 2006-7-31
	 */
	public static String arrayToString(Object[] array, String split) {
		if (array == null || split == null) {
			return "";
		}

		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < array.length; i++) {
			if (null != array[i]) {
				sb.append(array[i].toString());
				if (i != array.length - 1) {
					sb.append(split);
				}
			}
		}

		return sb.toString();
	}

	/**
	 * 
	 * @param list
	 * @param split
	 * @return
	 */
	public static String listToString(List list, String split) {
		if (list == null || split == null) {
			return "";
		}

		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < list.size(); i++) {
			if (null != list.get(i)) {
				sb.append(list.get(i).toString());
				if (i != list.size() - 1) {
					sb.append(split);
				}
			}
		}

		return sb.toString();
	}

	public static String[] listToArray(List list) {

		String[] str = new String[list.size()];

		for (int i = 0; i < list.size(); i++) {

			str[i] = list.get(i).toString();
		}

		return str;
	}

	/**
	 * 隐藏前pre和后last位
	 * 
	 * @param org
	 * @param pre
	 * @param last
	 * @return
	 */
	public static String hiddenContent(String org, int pre, int last) {

		String result = "";
		if (org == null) {
			result = "";
		} else {
			if (pre + last >= org.length()) {
				result = org;
			} else {
				result = org.substring(0, pre)
						+ StringUtils.leftPad("", org.length() - pre - last,
								"*")
						+ org.substring(org.length() - last, org.length());
			}
		}

		return result;
	}

	/**
	 * 格式化字符串长度，超出部分显示省略号,区分汉字跟字母。汉字2个字节，字母数字一个字节
	 * 
	 * @param str
	 * @param n
	 * @return
	 */
	public static String format(String str, int n) {
		String temp = "";

		if (str.getBytes().length <= n)// 如果长度比需要的长度n小,返回原字符串
		{
			return str;
		} else {
			int t = 0;
			char[] q = str.toCharArray();
			for (int i = 0; i < q.length && t < n; i++) {
				if (q[i] >= 0x4E00 && q[i] <= 0x9FA5)// 是否汉字
				{
					temp += q[i];
					t += 2;
				} else {
					temp += q[i];
					t++;
				}
			}
			return (temp + "...");
		}
	}

}
