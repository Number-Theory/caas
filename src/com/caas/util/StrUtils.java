package com.caas.util;

import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串工具类
 * 
 * @author xiejiaan
 */
public class StrUtils {

	/**
	 * 替换字符串中的占位符，占位符的正则为\[@\w+@\]
	 * 
	 * @param data
	 *            处理的字符串
	 * @param params
	 *            替换的参数
	 * @return
	 */
	public static String replacePlaceholder(String data, Map<String, Object> params) {
		Pattern p = Pattern.compile("\\[@\\w+@\\]");
		Matcher m = p.matcher(data);
		String key;
		Object value;
		while (m.find()) {
			key = m.group();
			value = params.get(key.substring(2, key.length() - 2));
			if (value != null) {
				data = data.replace(key, value.toString());
			}
		}
		return data;
	}
	//UUID生成
	public static String getUUID(){
		String id = UUID.randomUUID().toString();
		return id.replaceAll("-", "");
	}

	// 效验
	public static boolean sqlValidate(String str) {
		str = str.toLowerCase();// 统一转为小写
		String badStr = "'|and|exec|execute|insert|select|delete|update|count|drop|*|%|chr|mid|master|truncate|"
				+ "char|declare|sitename|net user|xp_cmdshell|;|or|-|+|,|like'|and|exec|execute|insert|create|drop|"
				+ "table|from|grant|use|group_concat|column_name|"
				+ "information_schema.columns|table_schema|union|where|select|delete|update|order|by|count|*|"
				+ "chr|mid|master|truncate|char|declare|or|;|-|--|+|,|like|//|/|%|#";// 过滤掉的sql关键字，可以手动添加
		String[] badStrs = badStr.split("\\|");
		for (int i = 0; i < badStrs.length; i++) {
			if (str.indexOf(badStrs[i]) >= 0) {
				return true;
			}
		}
		return false;
	}

	public static String toUTF8(String param) {
		if (param == null) {
			return null;
		}
		try {
			return new String(param.getBytes("utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * @author CD
	 * 2017-4-27		
	 * @param object
	 * @param defaultStr
	 * @return
	 * 对象转str
	 */
	public static String ObjToStr(Object object,String defaultStr){
		String str="";
		if (object!=null) {
			str=String.valueOf(object);
		}else {
			str=defaultStr;
		}
		return str;
	}
}
