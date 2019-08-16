/*
 * @(#)DateUtility.java $Date: 2013/03/09 02:30:47 $
 */
package com.perssoft.common.tool;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期操作类
 * 
 * @author Administrator
 */
public class DateUtility {

	/** 日期格式 yyyy-MM-dd */
	 
	
	public static final String DateFormat1 = "yyyy-MM-dd";
	public static final String DateFormat2 = "yyyy-MM-dd HH:mm";
	public static final String DateFormat3 = "yyyy-MM-dd HH:mm:ss";
	public static final String DateFormat4 = "yyyyMMddHHmmss";
	public static final String DateFormat5 = "yyyy-MM";
	public static final String DateFormat6 = "yyyyMMdd";
	public static final String DateFormat7 = "HH:mm";
	public static final String DateFormat8 = "yyyy";
	public static final String DateFormat9 = "MM-dd";
	public static final String DateFormat10 = "MM-dd HH:mm";
	public static final String DateFormat11 = "dd";
	public static String convertDate(String datestr, String format1, String format2) {

		return getFormatDate(getDateFromStr(datestr, format1), format2);
	}
	
	/**
	 * 返回日期
	 * 
	 */
	public static Date getToday(String format) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
    	String todaystr=dateFormat.format(new Date());
	
		Date result = null;
		try {
			result=dateFormat.parse(todaystr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	//得到   2016-05-17
	public static String  getStringToday() {
		SimpleDateFormat dateFormat = new SimpleDateFormat(DateFormat1);
    	String todaystr=dateFormat.format(new Date());
		return todaystr;
	}

	/**
	 * 根据日期字符返回日期对象
	 * 
	 * @param datestr
	 *            比如：2006-02-03
	 * @param format
	 *            比如yyyy-MM-dd
	 * @return 日期对象
	 */
	public static Date getDateFromStr(String datestr, String format) {
		if (datestr == null || "".equalsIgnoreCase(datestr)) {
			return null;
		}

		SimpleDateFormat dateformat = new SimpleDateFormat(format);
		Date result = null;
		try {
			result = dateformat.parse(datestr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 格式化日期
	 * 
	 * @param indate
	 *            日期对象
	 * @param format
	 *            比如yyyy-MM-dd
	 * @return 比如：2006-02-03
	 */
	public static String getFormatDate(Date indate, String format) {
		if (indate == null) {
			return "";
		}

		SimpleDateFormat dateformat = new SimpleDateFormat(format);

		return dateformat.format(indate);
	}
	
	

	/**
	 * 得到当前时间
	 * 
	 * @return 当前时间
	 */
	public static Date getCurrentTime() {
		return new Date();
	}

	/**
	 * 日期加减年数
	 * 
	 * @param inDate
	 *            初始日期
	 * @param addYear
	 *            要加的年数(负值代表减)
	 * @return 结果日期
	 */
	public static Date addYearS(final Date inDate, final int addYear) {

		return addDateS(inDate, addYear, Calendar.YEAR);
	}

	/**
	 * 日期加减月数
	 * 
	 * @param inDate
	 *            初始日期
	 * @param addMonth
	 *            要加的月数(负值代表减)
	 * @return 结果日期
	 */
	public static Date addMonthS(final Date inDate, final int addMonth) {

		return addDateS(inDate, addMonth, Calendar.MONTH);
	}

	/**
	 * 日期加减天数
	 * 
	 * @param inDate
	 *            初始日期
	 * @param addDay
	 *            要加的天数(负值代表减)
	 * @return 结果日期
	 */
	public static Date addDayS(final Date inDate, final int addDay) {

		return addDateS(inDate, addDay, Calendar.DAY_OF_MONTH);
	}

	/**
	 * 日期加减小时数
	 * 
	 * @param inDate
	 *            初始日期
	 * @param addDay
	 *            要加的小时数(负值代表减)
	 * @return 结果日期
	 */
	public static Date addHourS(final Date inDate, final int addDay) {

		return addDateS(inDate, addDay, Calendar.HOUR_OF_DAY);
	}

	/**
	 * 日期加减分钟数
	 * 
	 * @param inDate
	 *            初始日期
	 * @param addDay
	 *            要加的小时数(负值代表减)
	 * @return 结果日期
	 */
	public static Date addMinuteS(final Date inDate, final int addMinute) {

		return addDateS(inDate, addMinute, Calendar.MINUTE);
	}

	/**
	 * 日期加减秒数
	 * 
	 * @param inDate
	 *            初始日期
	 * @param addSecond
	 *            要加的秒数(负值代表减)
	 * @return 结果日期
	 */
	public static Date addSecondS(final Date inDate, final int addSecond) {

		return addDateS(inDate, addSecond, Calendar.SECOND);
	}

	/**
	 * 计算日期加减
	 * 
	 * @param inDate
	 *            初始日期
	 * @param addDate
	 *            要加的日期
	 * @param field
	 *            要加的域
	 * @return 结果日期
	 */
	public static Date addDateS(final Date inDate, final int addDate,
			final int field) {

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(inDate);

		calendar.add(field, addDate);

		return calendar.getTime();
	}

	/**
	 * 计算两个日期之间的天数
	 * 
	 * @param fromDate
	 *            开始日
	 * @param toDate
	 *            结束日
	 * @param blnAbs
	 *            是否取绝对值
	 * @return 天数
	 */
	public static int calcDays(Date fromDate, Date toDate, boolean blnAbs) {

		long miliSeconds1 = fromDate.getTime();
		long miliSeconds2 = toDate.getTime();

		if (fromDate.compareTo(toDate) > 0 && blnAbs == false) {
			// 不足2天算1天
			return (int) ((miliSeconds2 - miliSeconds1) / 86400000);
		}

		// 超过1天算2天
		return (int) (Math.abs(miliSeconds2 - miliSeconds1 - 1) / 86400000) + 1;
	}

	/**
	 * 计算两个日期之间的天数 （过一个0点算一天）
	 * 
	 * @param fromDate
	 *            开始日期
	 * @param toDate
	 *            结束日期
	 * @return 天数
	 */
	public static int calcDays(Date fromDate, Date toDate) {
		long miliSeconds1 = DateUtility.getFirstTimeOfDay(fromDate).getTime();
		long miliSeconds2 = DateUtility.getFirstTimeOfDay(toDate).getTime();

		return (int) ((miliSeconds2 - miliSeconds1) / 86400000);

	}

	/**
	 * 计算两个日期之间的分钟 （过一个0点算一天）
	 * 
	 * @param fromDate
	 *            开始日期
	 * @param toDate
	 *            结束日期
	 * @return 天数
	 */
	public static int calMinute(Date fromDate, Date toDate) {
		long miliSeconds1 =fromDate.getTime();
		long miliSeconds2 =toDate.getTime();
		return (int) ((miliSeconds2 - miliSeconds1) / (1000 * 60 ) );

	}
	
 
	/**
	 * 计算两个日期之间的年数
	 * 
	 * @param fromDate
	 *            开始日期
	 * @param toDate
	 *            结束日期
	 * @return 年数
	 */
	public static int calcYears(Date fromDate, Date toDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(fromDate);
		int years = 0;
		Date temp = null;
		if (fromDate.before(toDate)) {
			temp = DateUtility.addYearS(fromDate, 1);
			while (!temp.after(toDate)) {
				temp = DateUtility.addYearS(temp, 1);
				years++;
			}
		} else {
			temp = DateUtility.addYearS(fromDate, -1);
			while (!temp.before(toDate)) {
				temp = DateUtility.addYearS(temp, -1);
				years--;
			}
		}

		return years;

	}

	/**
	 * 得到本年的开始时间
	 * 
	 * @param date
	 *            日期对象
	 * @return 本年开始时间
	 */
	public static Date getFirstDayOfYear(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);
		calendar.set(Calendar.MONTH, 0);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);

		return calendar.getTime();
	}

	/**
	 * 得到本月的开始时间
	 * 
	 * @param date
	 *            日期对象
	 * @return 本月开始时间
	 */
	public static Date getFirstDayOfMonth(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);

		return calendar.getTime();
	}
	public static Date getLastDayOfMonth(Date date) {

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_MONTH, calendar
				.getActualMaximum(Calendar.DAY_OF_MONTH));
		calendar.set(Calendar.HOUR_OF_DAY, calendar
				.getActualMaximum(Calendar.HOUR_OF_DAY));
		calendar.set(Calendar.MINUTE, calendar
				.getActualMaximum(Calendar.MINUTE));
		calendar.set(Calendar.SECOND, calendar
				.getActualMaximum(Calendar.SECOND));
		calendar.set(Calendar.MILLISECOND, calendar
				.getActualMaximum(Calendar.MILLISECOND));
		return calendar.getTime();
	}
	/**
	 * 得到本天的开始时间
	 * 
	 * @param date
	 *            日期对象
	 * @return 本天的开始时间
	 */
	public static Date getFirstTimeOfDay(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);

		return calendar.getTime();
	}

	/**
	 * 得到日期的年份
	 * 
	 * @param date
	 *            日期对象
	 * @return 日期的年份
	 */
	public static int getYear(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.YEAR);
	}

	/**
	 * 得到日期的月份 (1-12)
	 * 
	 * @param date
	 *            日期对象
	 * @return 日期的月份
	 */
	public static int getMonthOfYear(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.MONTH) + 1;
	}

	/**
	 * 得到日期是年中的第几周
	 * 
	 * @param date
	 *            日期对象
	 * @return 年中的第几周
	 */
	public static int getWeekOfYear(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.WEEK_OF_YEAR);
	}

	/**
	 * 得到日期是一年中的第几天 (1-366)
	 * 
	 * @param date
	 *            日期对象
	 * @return 年中的第几天
	 */
	public static int getDayOfYear(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.DAY_OF_YEAR);
	}

	/**
	 * 得到日期是一月中的第几天 (1-31)
	 * 
	 * @param date
	 *            日期对象
	 * @return 月中的第几天
	 */
	public static int getDayOfMonth(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 得到日期是一周中的第几天(星期日开始，是1)
	 * 
	 * @param date
	 *            日期对象
	 * @return 周中的第几天
	 */
	public static int getDayOfWeek(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 得到时间是一天中的哪个小时
	 * 
	 * @param date
	 *            日期对象
	 * @return 天中的哪个小时
	 */
	public static int getHourOfDay(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.HOUR_OF_DAY);
	}

	/**
	 * 得到时间是多少分钟
	 * 
	 * @param date
	 *            日期对象
	 * @return 天中的哪个小时
	 */
	public static int getMinuteOfHour(Date date) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		return calendar.get(Calendar.MINUTE);
	}

	/**
	 * 设置小时
	 * 
	 * @param date
	 *            日期对象
	 * @return 天中的哪个小时
	 */
	public static Date setHourOfDay(Date date, int hour) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		calendar.set(Calendar.HOUR_OF_DAY, hour);

		return calendar.getTime();
	}

	/**
	 * 设置分钟
	 * 
	 * @param date
	 *            日期对象
	 * @return 天中的哪个小时
	 */
	public static Date setMinuteOfHour(Date date, int minute) {
		Calendar calendar = Calendar.getInstance();

		calendar.setTime(date);

		calendar.set(Calendar.MINUTE, minute);

		return calendar.getTime();
	}

	/**
	 * 根据输入的毫秒数，得到 "星期几",如“星期二”
	 * 
	 * @param date
	 *            日期对象
	 * @return 周中的第几天
	 */
	public static String getWeekDay(Date date) {
		SimpleDateFormat weekFormatter = new SimpleDateFormat("E");

		return weekFormatter.format(date);
	}

	/**
	 * 根据数字得到对应的星期名字
	 * 
	 * @param i
	 *            数字
	 * @return 对应的星期名字
	 */
	public static String getWeekName(int i) {
		switch (i) {
		case 1:
			return "星期日";
		case 2:
			return "星期一";
		case 3:
			return "星期二";
		case 4:
			return "星期三";
		case 5:
			return "星期四";
		case 6:
			return "星期五";
		case 7:
			return "星期六";

		default:
			return "无效数字";
		}
	}

	/**
	 * 根据数字得到对应的时间段名字
	 * 
	 * @param i
	 *            数字
	 * @return 对应的时间段名字
	 */
	public static String getHourInterzone(int i) {
		switch (i) {
		case 0:
			return "00:00-01:00";
		case 1:
			return "01:00-02:00";
		case 2:
			return "02:00-03:00";
		case 3:
			return "03:00-04:00";
		case 4:
			return "04:00-05:00";
		case 5:
			return "05:00-06:00";
		case 6:
			return "06:00-07:00";
		case 7:
			return "07:00-08:00";
		case 8:
			return "08:00-09:00";
		case 9:
			return "09:00-10:00";
		case 10:
			return "10:00-11:00";
		case 11:
			return "11:00-12:00";
		case 12:
			return "12:00-13:00";
		case 13:
			return "13:00-14:00";
		case 14:
			return "14:00-15:00";
		case 15:
			return "15:00-16:00";
		case 16:
			return "16:00-17:00";
		case 17:
			return "17:00-18:00";
		case 18:
			return "18:00-19:00";
		case 19:
			return "19:00-20:00";
		case 20:
			return "20:00-21:00";
		case 21:
			return "21:00-22:00";
		case 22:
			return "22:00-23:00";
		case 23:
			return "23:00-24:00";

		default:
			return "无效数字";
		}
	}
	
	/**
	 * 计算两时间相差多少分钟
	 * @param dateA
	 * @param dateB
	 * @return
	 */
	public static int getBetweenMinuteNumber(Date dateA, Date dateB) {
		long dayNumber = 0;
		//1小时=60分钟=3600秒=3600000
		long mins = 60L * 1000L;
		//long day= 24L * 60L * 60L * 1000L;计算天数之差
	
		try {
		    
		   dayNumber = (dateB.getTime() - dateA.getTime()) / mins;
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return (int) dayNumber;
		}
	
	/**
	 * 计算两时间相差多少天
	 * @param dateA
	 * @param dateB
	 * @return
	 */
	public static int getBetweenDayNumber(Date dateA, Date dateB) {
		long dayNumber = 0;
		//1小时=60分钟=3600秒=3600000
		//long mins = 60L * 1000L;
		 long day= 24L * 60L * 60L * 1000L; 
		try {
		    
		   dayNumber = (dateB.getTime() - dateA.getTime()) / day;
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return (int) dayNumber;
		}
	
	/**
	 * 计算两时间相差多少小时
	 * @param dateA
	 * @param dateB
	 * @return
	 */
	public static int getBetweenHourNumber(Date dateA, Date dateB) {
		long hourNumber = 0;
		//1小时=60分钟=3600秒=3600000
		//long mins = 60L * 1000L;
		 long day=  60L * 60L * 1000L; 
		try {
		    
			hourNumber = (dateB.getTime() - dateA.getTime()) / day;
		} catch (Exception e) {
		   e.printStackTrace();
		}
		return (int) hourNumber;
		}
	/**
	 * 日期加天数
	 * @param n
	 * @return
	 */
    public  static String   nDaysAftertoday(int   n)   {  
        SimpleDateFormat   df   =   new   SimpleDateFormat("yyyy-MM-dd");  
        Calendar   rightNow   =   Calendar.getInstance();  
        //rightNow.add(Calendar.DAY_OF_MONTH,-1);  
        rightNow.add(Calendar.DAY_OF_MONTH,+n);  
        return   df.format(rightNow.getTime());  
    } 
    
    public static void main(String[] args) {
    	//System.out.println(getLastDayOfMonth(new Date()));
    	System.out.println(getMonthDiff("2014-11", "2015-04"));
	}
    
    /** 
     * 判断当前日期是星期几 
     *  
     * @param pTime 修要判断的时间 
     * @return dayForWeek 判断结果 
     * @Exception 发生异常 
     */ 
 public static String dayForWeek(Date pTime) {
	   String[] weekDays = {"日", "一", "二", "三", "四", "五", "六"}; 
		Calendar c = Calendar.getInstance();
		c.setTime(pTime);
		int dayForWeek = 0;
		if (c.get(Calendar.DAY_OF_WEEK) == 1) {
			dayForWeek = 7;
		} else {
			dayForWeek = c.get(Calendar.DAY_OF_WEEK) - 1;
		}
        if (dayForWeek < 0) 
        	dayForWeek = 0; 
        return weekDays[dayForWeek]; 
	}  

 public static int getDaysOfMonth(Date date){
	   Calendar cal =Calendar.getInstance();
	   cal.setTime(date);
	   return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	   
 }
 
 /**     
	 * * 得到两日期相差几个月     *     *
	 *  @param String  
	 @return     */
	public static long getMonthDiff(String startDate, String endDate)
			{
		long monthday = 0;
		try {

			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM");
			Date startDate1;
			startDate1 = fmt.parse(startDate);
			Calendar starCal = Calendar.getInstance();
			starCal.setTime(startDate1);
			int sYear = starCal.get(Calendar.YEAR);
			int sMonth = starCal.get(Calendar.MONTH);

			Date endDate1 = fmt.parse(endDate);
			Calendar endCal = Calendar.getInstance();
			endCal.setTime(endDate1);
			int eYear = endCal.get(Calendar.YEAR);
			int eMonth = endCal.get(Calendar.MONTH);
			monthday = ((eYear - sYear) * 12 + (eMonth - sMonth));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return monthday;
	}

	 
		
		

}
