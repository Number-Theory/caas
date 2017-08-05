/*
 *  Copyright (c) 2013 The CCP project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a Beijing Speedtong Information Technology Co.,Ltd license
 *  that can be found in the LICENSE file in the root of the web site.
 *
 *   http://www.cloopen.com
 *
 *  An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */
package com.caas.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DateUtil {
	
    /**
     * 变量：日期格式化类型 - 格式:yyyy/MM/dd
     * 
     * @since 1.0
     */
    public static final int DEFAULT = 0;

    /**
     * 变量：日期格式化类型 - 格式:yyyy/MM
     * 
     * @since 1.0
     */
    public static final int YM = 1;

    /**
     * 变量：日期格式化类型 - 格式:yyyy-MM-dd
     * 
     * @since 1.0
     */
    public static final int YMR_SLASH = 11;

    /**
     * 变量：日期格式化类型 - 格式:yyyyMMdd
     * 
     * @since 1.0
     */
    public static final int NO_SLASH = 2;

    /**
     * 变量：日期格式化类型 - 格式:yyyyMM
     * 
     * @since 1.0
     */
    public static final int YM_NO_SLASH = 3;

    /**
     * 变量：日期格式化类型 - 格式:yyyy/MM/dd HH:mm:ss
     * 
     * @since 1.0
     */
    public static final int DATE_TIME = 4;

    /**
     * 变量：日期格式化类型 - 格式:yyyyMMddHHmmss
     * 
     * @since 1.0
     */
    public static final int DATE_TIME_NO_SLASH = 5;

    /**
     * 变量：日期格式化类型 - 格式:yyyy/MM/dd HH:mm
     * 
     * @since 1.0
     */
    public static final int DATE_HM = 6;

    /**
     * 变量：日期格式化类型 - 格式:HH:mm:ss
     * 
     * @since 1.0
     */
    public static final int TIME = 7;

    /**
     * 变量：日期格式化类型 - 格式:HH:mm
     * 
     * @since 1.0
     */
    public static final int HM = 8;
    
    /**
     * 变量：日期格式化类型 - 格式:HHmmss
     * 
     * @since 1.0
     */
    public static final int LONG_TIME = 9;
    /**
     * 变量：日期格式化类型 - 格式:HHmm
     * 
     * @since 1.0
     */
    
    public static final int SHORT_TIME = 10;

    /**
     * 变量：日期格式化类型 - 格式:yyyy-MM-dd HH:mm:ss
     * 
     * @since 1.0
     */
    public static final int DATE_TIME_LINE = 12;
    
    public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
    
    public static String dateToStr(Date date,String pattern) {
       if (date == null || date.equals(""))
    	 return null;
       SimpleDateFormat formatter = new SimpleDateFormat(pattern);
       return formatter.format(date);
    } 

    public static String dateToStr(Date date) {
        return dateToStr(date, "yyyy/MM/dd");
    }
    public static long getTime(String time) throws ParseException{
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	long times=sdf.parse(time).getTime();
    	return times;
    }
    /**
     * 字符串转时间
     * @param date	时间字符串
     * @param type	字符串时间格式
     * @return
     */
    public static Date strToDate(String date,int type){
		switch (type) {
            case DEFAULT:
                return getStrToDate(date,"yyyy/MM/dd");
            case YM:
                return getStrToDate(date, "yyyy/MM");
            case NO_SLASH:
                return getStrToDate(date, "yyyyMMdd");
            case YMR_SLASH:
            	return getStrToDate(date, "yyyy-MM-dd");
            case YM_NO_SLASH:
                return getStrToDate(date, "yyyyMM");
            case DATE_TIME:
                return getStrToDate(date, "yyyy/MM/dd HH:mm:ss");
            case DATE_TIME_NO_SLASH:
                return getStrToDate(date, "yyyyMMddHHmmss");
            case DATE_HM:
                return getStrToDate(date, "yyyy/MM/dd HH:mm");
            case TIME:
                return getStrToDate(date, "HH:mm:ss");
            case HM:
                return getStrToDate(date, "HH:mm");
            case LONG_TIME:
                return getStrToDate(date, "HHmmss");
            case SHORT_TIME:
                return getStrToDate(date, "HHmm");
            case DATE_TIME_LINE:
                return getStrToDate(date, "yyyy-MM-dd HH:mm:ss");
            default:
                throw new IllegalArgumentException("Type undefined : " + type);
        }
    }
    public static Date getStrToDate(String date, String pattern){
		try{
			if (date != null && !"".equals(date)) {
				SimpleDateFormat formatter = new SimpleDateFormat(pattern);
				return formatter.parse(date);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
    
    public static String dateToStr(Date date, int type) {
        switch (type) {
        case DEFAULT:
            return dateToStr(date);
        case YM:
            return dateToStr(date, "yyyy/MM");
        case NO_SLASH:
            return dateToStr(date, "yyyyMMdd");
        case YMR_SLASH:
        	return dateToStr(date, "yyyy-MM-dd");
        case YM_NO_SLASH:
            return dateToStr(date, "yyyyMM");
        case DATE_TIME:
            return dateToStr(date, "yyyy/MM/dd HH:mm:ss");
        case DATE_TIME_NO_SLASH:
            return dateToStr(date, "yyyyMMddHHmmss");
        case DATE_HM:
            return dateToStr(date, "yyyy/MM/dd HH:mm");
        case TIME:
            return dateToStr(date, "HH:mm:ss");
        case HM:
            return dateToStr(date, "HH:mm");
        case LONG_TIME:
            return dateToStr(date, "HHmmss");
        case SHORT_TIME:
            return dateToStr(date, "HHmm");
        case DATE_TIME_LINE:
            return dateToStr(date, "yyyy-MM-dd HH:mm:ss");
        default:
            throw new IllegalArgumentException("Type undefined : " + type);
        }
    }
    public static String getTimeStr(String dateFormat){
		SimpleDateFormat sdFormat = new SimpleDateFormat(dateFormat);
		return sdFormat.format(new Date());
	}
    
	/**
	 * 字符串转成时间
	 */
	public static Date strToDate(String str, String pattern) {
		try {
			if (str != null && !"".equals(str)) {
				SimpleDateFormat formatter = new SimpleDateFormat(pattern);
				return formatter.parse(str);
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 时间戳转换成日期格式字符串
	 * 
	 * @param seconds
	 * @param format
	 * @return
	 */
	public static String timeStamp2Date(String seconds, String format) {
		if (seconds == null || seconds.isEmpty() || seconds.equals("null")) {
			return "";
		}
		if (format == null || format.isEmpty()) {
			format = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(new Date(Long.valueOf(seconds)));
	}
	
	/**
	 * 计算两个时间的时间差(秒)
	 */
	public static int timeDifference(String startStr, String endStr) {
		if (startStr != null && !"".equals(startStr) && endStr != null && !"".equals(endStr)) {
			Date beginDate = DateUtil.strToDate(startStr, DateUtil.YYYY_MM_DD_HH_MM_SS);
			Date endDate = DateUtil.strToDate(endStr, DateUtil.YYYY_MM_DD_HH_MM_SS);
			long from = beginDate.getTime();
			long to = endDate.getTime();
			int minutes = (int) ((to - from) / (1000 * 60));
			return minutes;
		}
		return 0;
	}

	/**
	 * 将日期字符串装换成时间戳
	 */
	public static long dateStrToTimeStamp(String dateStr) {
		if (dateStr == null || "".equals(dateStr)) {
			return 0L;
		}
		Date beginDate = DateUtil.strToDate(dateStr, DateUtil.YYYY_MM_DD_HH_MM_SS);
		if (beginDate == null) {
			return 0L;
		}
		return beginDate.getTime();
	}
	
	/**
	 * 往后推移毫秒，输出时间戳
	 * @param dateStr 日期字符串
	 * @param millisecond 毫秒
	 * @return
	 */
	public static String goesTime(String dateStr,String pattern,int millisecond) {
		if(dateStr == null || "".equals(dateStr)){
			return "";
		}
		// 开始时间为空
		Date date = strToDate(dateStr,pattern);
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MILLISECOND, millisecond);
		Date result = cal.getTime();
		return String.valueOf(result.getTime());
	}
	
	public static String getDate(String date, int count) {
		Calendar c = Calendar.getInstance();
		try {
			Date d = new SimpleDateFormat("yyyy-MM-dd").parse(date);
			c.setTime(d);
			int day = c.get(Calendar.DATE);
			c.set(Calendar.DATE, day - count);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new SimpleDateFormat("yyyy-MM-dd").format(c.getTime());
	}
	
	public static String getDateByFormat(String date, int count, String format) {
		Calendar c = Calendar.getInstance();
		try {
			Date d = new SimpleDateFormat(format).parse(date);
			c.setTime(d);
			int day = c.get(Calendar.DATE);
			c.set(Calendar.DATE, day - count);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new SimpleDateFormat(format).format(c.getTime());
	}
	
	public static String getLaterTime(int second) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.SECOND, second); 
		Date date = calendar.getTime();
		SimpleDateFormat sdDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = sdDateFormat.format(date);
		
		return time;
	}
	
	public static List<String> timeListDay(String beginTime,String endTime){
		List<String> timeList = new ArrayList<String>();
		Date endDate = DateUtil.strToDate(endTime,"yyyy-MM-dd");
		int interval = 1;
		Date beginDate = DateUtil.strToDate(beginTime,"yyyy-MM-dd");
		Calendar cal = Calendar.getInstance(); //使用给定的 Date 设置此 Calendar 的时间 
		cal.setTime(beginDate);
		timeList.add(beginTime);
		while (true) { 
			//根据日历的规则，为给定的日历字段添加或减去指定的时间量 
			cal.add(Calendar.DAY_OF_MONTH, interval); 
			// 测试此日期是否在指定日期之后或者刚好相等
			if (endDate.after(cal.getTime()) || endTime.equals(DateUtil.dateToStr(cal.getTime(), DateUtil.YMR_SLASH))) { 
				String end = DateUtil.dateToStr(cal.getTime(), DateUtil.YMR_SLASH);
				timeList.add(end);
			} else { 
				break; 
			} 
		} 
		//timeList.add(endTime);//把结束时间加入集合
		return timeList;
	}
	
	public static List<String> timeListMinute(String beginTime,String endTime){
		List<String> timeList = new ArrayList<String>();
		Date endDate = DateUtil.strToDate(endTime,"yyyy-MM-dd HH:mm");
		int interval = 1;
		Date beginDate = DateUtil.strToDate(beginTime,"yyyy-MM-dd HH:mm");
		Calendar cal = Calendar.getInstance(); //使用给定的 Date 设置此 Calendar 的时间 
		cal.setTime(beginDate);
		timeList.add(beginTime);
		while (true) { 
			//根据日历的规则，为给定的日历字段添加或减去指定的时间量 
			cal.add(Calendar.MINUTE, interval); 
			// 测试此日期是否在指定日期之后或者刚好相等
			if (endDate.after(cal.getTime()) || endTime.equals(DateUtil.dateToStr(cal.getTime(), "yyyy-MM-dd HH:mm"))) { 
				String end = DateUtil.dateToStr(cal.getTime(), "yyyy-MM-dd HH:mm");
				timeList.add(end);
			} else { 
				break; 
			} 
		} 
		//timeList.add(endTime);//把结束时间加入集合
		return timeList;
	}
	
	public static List<String> timeListHour(String beginTime,String endTime,String format_in,String format_out){
		List<String> timeList = new ArrayList<String>();
		Date endDate = DateUtil.strToDate(endTime,format_in);
		int interval = 1;
		Date beginDate = DateUtil.strToDate(beginTime,format_in);
		Calendar cal = Calendar.getInstance(); //使用给定的 Date 设置此 Calendar 的时间 
		cal.setTime(beginDate);
		
		if (format_out == "yyyyMMddHH") {
			timeList.add(DateUtil.dateToStr(beginDate, DATE_TIME_NO_SLASH).substring(0, 10));
		} else {
			timeList.add(DateUtil.dateToStr(beginDate, DATE_TIME_LINE).substring(5, 10));
		}
		while (true) { 
			//根据日历的规则，为给定的日历字段添加或减去指定的时间量 
			cal.add(Calendar.HOUR, interval); 
			// 测试此日期是否在指定日期之后或者刚好相等
			if (endDate.after(cal.getTime()) || endTime.equals(DateUtil.dateToStr(cal.getTime(), format_out))) { 
				String end = DateUtil.dateToStr(cal.getTime(), format_out) + "h";
				
				if (end == "00h" || end == "24h") {
					end = DateUtil.dateToStr(cal.getTime(), "MM-dd");
				}
				
				timeList.add(end);
			} else { 
				break; 
			} 
		}
		if (format_out == "yyyyMMddHH") {
			timeList.add(DateUtil.dateToStr(endDate, DATE_TIME_NO_SLASH).substring(0, 10));
		} else {
			timeList.add(DateUtil.dateToStr(endDate, DATE_TIME_LINE).substring(5, 10));
		}
		//timeList.add(endTime);//把结束时间加入集合
		return timeList;
	}
}
