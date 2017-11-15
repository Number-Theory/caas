package com.caas.util;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.http.Consts;
import org.apache.http.NameValuePair;
import org.apache.http.client.fluent.Request;
import org.apache.http.entity.ContentType;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * http工具类
 * 
 * @author xiejiaan
 */
public class HttpUtils {
	private static final Logger logger = LoggerFactory.getLogger(HttpUtils.class);

	/**
	 * 发送get请求
	 * 
	 * @param url
	 * @return
	 */
	public static String get(String url) {
		return get(url, null);
	}

	/**
	 * 发送get请求
	 * 
	 * @param url
	 * @param data
	 * @return
	 */
	public static String get(String url, Map<String, Object> data) {
		StringBuilder sb = new StringBuilder();// 构造请求的url
		if (data != null) {
			for (Map.Entry<String, Object> v : data.entrySet()) {
				if (v.getValue() != null) {
					sb.append("&");
					sb.append(v.getKey());
					sb.append("=");
					sb.append(encodeUrl(v.getValue().toString()));
				}
			}
		}
		if (!url.contains("?") && sb.length() > 0) {
			sb.setCharAt(0, '?');
		}
		url = url + sb.toString();

		String result = null;
		try {
			result = Request.Get(url).execute().returnContent().asString();
			logger.debug("【发送get请求】成功：url=" + url + ", result=" + result);
		} catch (Throwable e) {
			logger.error("【发送get请求】失败：url=" + url + ", result=" + result, e);
		}
		return result;
	}

	/**
	 * url参数加密
	 * 
	 * @param str
	 * @return
	 */
	private static String encodeUrl(String str) {
		try {
			str = URLEncoder.encode(str, "utf-8");
		} catch (Throwable e) {
			logger.error("【url参数加密】失败：str=" + str, e);
		}
		return str;
	}

	/**
	 * 发送post请求（表单）
	 * 
	 * @param url
	 * @param data
	 * @return
	 */
	public static String postForm(String url, Map<String, Object> data) {
		String result = null;
		try {
			// 创建参数列表
			List<NameValuePair> formParams = new ArrayList<NameValuePair>();
			for (Map.Entry<String, Object> d : data.entrySet()) {
				if (d.getValue() != null) {
					formParams.add(new BasicNameValuePair(d.getKey(), d.getValue().toString()));
				}
			}
			Request request = Request.Post(url).bodyForm(formParams, Consts.UTF_8);

			result = request.execute().returnContent().asString();
			logger.debug("【发送post请求（表单）】成功：url=" + url + ", data=" + data + ", result=" + result);
		} catch (Throwable e) {
			logger.error("【发送post请求（表单）】失败：url=" + url + ", data=" + data + ", result=" + result, e);
		}
		return result;
	}

	/**
	 * 发送post请求JSON
	 * 
	 * @param url
	 * @param data
	 * @return
	 */
	public static String postJSON(String url, String data, String heads_host) {
		String result = null;
		try {
			Request request = Request.Post(url).setHeader("Accept", "application/json")
					.setHeader("Content-Type", "application/json;charset=utf-8").connectTimeout(3 * 1000)
					.socketTimeout(3 * 1000);
			if (StringUtils.isNotBlank(heads_host)) {
				request.setHeader("Host", heads_host);
			}
			request.bodyString(data, ContentType.APPLICATION_JSON);

			result = request.execute().returnContent().asString();
			logger.debug("【发送post请求JSON】成功：url=" + url + ", data=" + data + ", result=" + result);
		} catch (Throwable e) {
			logger.error("【发送post请求JSON】失败：url=" + url + ", data=" + data + ", result=" + result, e);
		}
		return result;
	}

	/**
	 * 发送post请求（xml字符串）
	 * 
	 * @param url
	 * @param data
	 * @return
	 */
	public static String postXml(String url, String data) {
		String result = null;
		Request request = Request.Post(url);
		request.setHeader("Accept", "application/xml");
		request.setHeader("Content-Type", "text/xml;charset=utf-8");
		request.bodyString(data, ContentType.create("text/xml", Consts.UTF_8));
		try {
			result = request.execute().returnContent().asString();
			logger.debug("【发送post请求（xml字符串）】成功：url=" + url + ", data=" + data + ", result=" + result);
		} catch (Throwable e) {
			logger.error("【发送post请求（xml字符串）】失败：url=" + url + ", data=" + data + ", result=" + result, e);
		}
		return result;
	}
}
