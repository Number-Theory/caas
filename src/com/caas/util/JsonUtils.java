package com.caas.util;

import com.google.gson.Gson;

/**
 * json字符串工具类
 * 
 * @author xiejiaan
 */
public class JsonUtils {
	private static final Gson gson = new Gson();

	/**
	 * 将对象转换成为json字符串
	 * 
	 * @param obj
	 * @return
	 */
	public static String toJson(Object obj) {
		if (obj == null) {
			return null;
		}
		return gson.toJson(obj);
	}

	/**
	 * 将json字符串转换成为对象
	 * 
	 * @param json
	 * @param classOfT
	 * @return
	 */
	public static <T> T toObject(String json, Class<T> classOfT) {
		return gson.fromJson(json, classOfT);
	}
}
