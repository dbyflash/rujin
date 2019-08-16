package com.perssoft.common.tool;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.lang.StringUtils;

/**
 * 通用操作类
 * 
 * @author bugerno1
 */
public class CommonUtility {

	/**
	 * 根据完整url得到struts.config中的path
	 * 
	 * @param url
	 *            完整url如localhost:8080/xxx/xxx.do
	 * @param levnum
	 *            path有几个'/'(项目分模块时用到)
	 * @return xxx.do
	 */
	public static String getPathByUrl(String url, int levnum) {
		int doindex = url.lastIndexOf("/");

		while (levnum > 1) {
			doindex = url.lastIndexOf("/", doindex - 1);
			levnum--;
		}
		String path = url.substring(doindex);
		return path;
	}

	/**
	 * 产生length位随机码(数字)
	 * 
	 * @param length
	 *            随机码长度
	 * @return 生成的数字(字符串形式，可以0打头)
	 */
	public static String getRandomCode(int length) {
		int num = new Double(Math.random() * Math.pow(10, length)).intValue();

		return StringUtils.leftPad(String.valueOf(num), length, "0");
	}

	/**
	 * 产生length位随机码(0~9 a~z)
	 * 
	 * @param length
	 *            随机码长度
	 * @return 生成的随机码
	 */
	public static String getRandomPwCode(int length) {
		String sRand = "";
		Random random = new Random();
		char[] randchar = new char[] { '1', '2', '3', '4', '5', '6', '7', '8',
				'9', '0', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
				'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
				'W', 'X', 'Y', 'Z' };

		char temp;
		for (int i = 0; i < length; i++) {
			temp = randchar[random.nextInt(randchar.length)];

			sRand += temp;
		}

		return sRand;
	}

	/**
	 * 抽奖
	 * 
	 * @param rate
	 *            中奖率
	 * @return 是否中奖
	 */
	public static boolean checkRandomPrise(double rate) {
		if (Math.random() < rate) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 判断对象obj是否有和objs中的对象相同
	 * 
	 * @param objs objs
	 * @param obj obj
	 * @return result
	 */
	public static boolean isContains(Object[] objs, Object obj) {
		if (null == objs) {
			return false;
		}

		for (int i = 0; i < objs.length; i++) {
			if ((null == objs[i] && null == obj)
					|| (null != objs[i] && objs[i].equals(obj))) {
				return true;
			}
		}

		return false;
	}

	/**
	 * 判断对象objs2中对象是否有和objs1中的对象相同
	 * 
	 * @param objs1 objs1
	 * @param objs2 objs2
	 * @return result
	 */
	public static boolean isContains(Object[] objs1, Object[] objs2) {
		if (null == objs1 || null == objs2) {
			return false;
		}

		for (int i = 0; i < objs2.length; i++) {
			for (int j = 0; j < objs1.length; j++) {
				if ((null == objs1[j] && null == objs2[i])
						|| (null != objs1[j] && objs1[j].equals(objs2[i]))) {
					return true;
				}
			}
		}

		return false;
	}

	/**
	 * 判断对象是否为空，或者空字符串
	 * 
	 * @param obj
	 * @return
	 */
	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		} else if (obj instanceof String) {
			return StringUtils.isEmpty(obj.toString());
		}
		
		return false;
	}
	
	public static boolean isBlank(Object obj) {
		if (obj == null) {
			return true;
		} else if (obj instanceof String) {
			return StringUtils.isBlank(obj.toString());
		}
		
		return false;
	}
	
	/**
	 * 将List<Object[]> 根据alias转变成List<Map>
	 * 
	 * @param org
	 * @param alias
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<Map> arraylistToMapList(List org, String[] alias) {
		List<Map> result = new ArrayList<Map>();
		Object[] objarray = null;
		for (Object object : org) {
			objarray = (Object[]) object;

			Map mapbean = new HashMap();
			
			for (int i = 0; i < objarray.length; i ++) {

				if (alias == null) {
					mapbean.put("obj" + i, objarray[i]);
				} else {
					mapbean.put(alias[i], objarray[i]);
				}
			}
			result.add(mapbean);
		}
		
		return result;
	}
	
	/**
	 * 从一个对象里获取一个字符串
	 * 
	 * @param obj
	 * @return
	 */
	public static String getStringFromObject(Object obj) {
		if (!CommonUtility.isEmpty(obj)) {
			if (obj instanceof String) {
				return obj.toString();
			} else if (obj instanceof Object[]) {
				return ((Object[])obj)[0].toString();
			}
		}
		
		return null;
	}
	
	/**
	 * request.getParameterMap中取得String值
	 * 
	 * @param map
	 * @param key
	 * @return
	 */
	public static String getValueFromRequestMap(Map map, String key) {
		
    	Object value = map.get(key);
        
        if (!CommonUtility.isEmpty(value)) {
            
			if (value instanceof String) {
				return value.toString();
			} else if (value instanceof Object[]) {
				value = ((Object[])value)[0];
				
				return value.toString();
			}
			
        }
        
        return "";
	}
   
	
	public static String getString(Object o){
		if(o==null){
			return "";
		}else {
			return o.toString();
		}
		
		
	}
	
	public static Double getDoublefromObject(Object o){
		if(o==null || isEmpty(o)){
			return 0.0;
		}else {
			return Double.parseDouble(o.toString());
		}
	}
	
	public static Integer getIntegerfromObject(Object o){
		if(o==null || isEmpty(o)){
			return 0;
		}else {
			return Integer.parseInt(o.toString());
		}
	}
	
}
