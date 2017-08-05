package com.caas.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Struts2工具类.
 * 
 * 实现获取Request/Response/Session与绕过jsp/freemaker直接输出文本的简化函数.
 * 
 * @author calvinXu
 */
public class StrutsUtils {

	private static final Logger LOGGER = LoggerFactory.getLogger(StrutsUtils.class);

	// -- header 常量定义 --//
	private static final String HEADER_ENCODING = "encoding";
	private static final String HEADER_NOCACHE = "no-cache";
	private static final String DEFAULT_ENCODING = "UTF-8";
	private static final boolean DEFAULT_NOCACHE = true;
	private static final long EXPIRES_SECONDS = 3600L;// 缓存时间(单位为秒)

	// -- 取得Request/Response/Session的简化函数 --//
	/**
	 * 取得HttpSession的简化函数.
	 */
	public static HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	/**
	 * 取得HttpSession的简化函数.
	 */
	public static HttpSession getSession(boolean isNew) {
		return ServletActionContext.getRequest().getSession(isNew);
	}

	/**
	 * 设置HttpSession中Attribute的简化函数.
	 */
	public static void setSessionAttribute(String name, Object value) {
		HttpSession session = getSession(false);
		session.setAttribute(name, value);
	}

	/**
	 * 取得HttpSession中Attribute的简化函数.
	 */
	public static String getSessionAttribute(String name) {
		HttpSession session = getSession(false);
		String result = (String) (session != null ? session.getAttribute(name) : "");
		return result;
	}

	/**
	 * 删除HttpSession中Attribute的简化函数.
	 */
	public static void removeSessionAttribute(String name) {
		HttpSession session = getSession(false);
		session.removeAttribute(name);
	}

	/**
	 * 取得HttpRequest的简化函数.
	 */
	public static HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * 取得HttpRequest中Parameter的简化方法.
	 */
	public static String getParameter(String name) {
		return getRequest().getParameter(name);
	}

	/**
	 * 取得HttpRequest中Parameter的简化方法.
	 */
	public static String getParameterTrim(String name) {
		return StringUtils.trim(getParameter(name));
	}

	/**
	 * 取得HttpResponse的简化函数.
	 */
	public static HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	/**
	 * 设置HttpRequest中Parameter的简化方法.
	 * 
	 * @param name
	 * @param value
	 */
	public static void setAttribute(String name, Object value) {
		getRequest().setAttribute(name, value);
	}

	/**
	 * 获取提交的表单数据，多个值用,分割
	 * 
	 * @return
	 */
	public static Map<String, Object> getFormDataExcel() {
		Map<String, Object> formData = new HashMap<String, Object>();
		String value;
		for (Map.Entry<String, String[]> map : getRequest().getParameterMap().entrySet()) {
			value = StringUtils.join(map.getValue(), ",").trim();
			try {
				value = new String(value.getBytes("iso8859-1"), "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			if (StringUtils.isNotBlank(value)) {
				if (map.getKey().equals("beginDate") || map.getKey().equals("endDate")
						|| map.getKey().equals("begin_time") || map.getKey().equals("end_time")) {
					if (value.contains("-")) {
						value = value.replace("-", "");
					}
				}
				formData.put(map.getKey(), value);
			}
		}
		LOGGER.debug("\n\nformData-------------------------" + formData + "\n");
		return formData;
	}

	public static Map<String, Object> getFormData() {
		Map<String, Object> formData = new HashMap<String, Object>();
		String value;
		for (Map.Entry<String, String[]> map : getRequest().getParameterMap().entrySet()) {
			value = StringUtils.join(map.getValue(), ",").trim();
			if (StringUtils.isNotBlank(value)) {
				formData.put(map.getKey(), value);
			}
		}
		LOGGER.debug("\n\nformData-------------------------" + formData + "\n");
		return formData;
	}

	public static Map<String, Object> getFormDataObj() {
		Map<String, Object> formData = new HashMap<String, Object>();
		String value;
		for (Map.Entry<String, String[]> map : getRequest().getParameterMap().entrySet()) {
			value = StringUtils.join(map.getValue(), ",").trim();
			if (StringUtils.isNotBlank(value)) {
				if (map.getKey().equals("beginDate") || map.getKey().equals("endDate")
						|| map.getKey().equals("beginTime") || map.getKey().equals("endTime")) {
					if (value.contains("-")) {
						value = value.replace("-", "");
					}
				}
				formData.put(map.getKey(), value);
			}
		}

		LOGGER.debug("\n\nformData-------------------------" + formData + "\n");
		return formData;
	}

	/**
	 * 获取请求的源页面url
	 * 
	 * @return
	 */
	public static String getReferer() {
		return getRequest().getHeader("referer");
	}

	/**
	 * 获取当前Web应用路径
	 * 
	 * @return
	 */
	public static String getContextPath() {
		return getRequest().getContextPath();
	}

	/**
	 * 获取请求的url
	 * 
	 * @return
	 */
	public static String getRequestURI() {
		return getRequest().getRequestURI();
	}

	/**
	 * 获取访问者的IP地址
	 * 
	 * @return
	 */
	public static String getClientIP() {
		HttpServletRequest request = getRequest();

		String ip = request.getHeader("X-Real-IP");
		if (ip == null || ip.equals("")) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	// -- 绕过jsp/freemaker直接输出文本的函数 --//
	/**
	 * 直接输出内容的简便函数.
	 * 
	 * eg. render("text/plain", "hello", "encoding:GBK"); render("text/plain",
	 * "hello", "no-cache:false"); render("text/plain", "hello", "encoding:GBK",
	 * "no-cache:false");
	 * 
	 * @param headers
	 *            可变的header数组，目前接受的值为"encoding:"或"no-cache:",默认值分别为UTF-8和true.
	 */
	public static void render(final String contentType, final String content, final String... headers) {
		HttpServletResponse response = initResponseHeader(contentType, headers);
		try {
			response.getWriter().write(content);
			response.getWriter().flush();
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
	}

	/**
	 * 直接输出文本.
	 * 
	 * @see #render(String, String, String...)
	 */
	public static void renderText(final String text, final String... headers) {
		render(ServletUtils.TEXT_TYPE, text, headers);
	}

	/**
	 * 直接输出HTML.
	 * 
	 * @see #render(String, String, String...)
	 */
	public static void renderHtml(final String html, final String... headers) {
		render(ServletUtils.HTML_TYPE, html, headers);
	}
	
	/**
	 * 直接输出JS
	 * 
	 * @see #render(String, String, String...)
	 */
	public static void renderJS(final String js, final String... headers) {
		render(ServletUtils.JS_TYPE, js, headers);
	}

	/**
	 * 直接输出XML.
	 * 
	 * @see #render(String, String, String...)
	 */
	public static void renderXml(final String xml, final String... headers) {
		render(ServletUtils.XML_TYPE, xml, headers);
	}

	/**
	 * 直接输出JSON.
	 * 
	 * @param jsonString
	 *            json字符串.
	 * @see #render(String, String, String...)
	 */
	public static void renderJson(final String jsonString, final String... headers) {
		render(ServletUtils.JSON_TYPE, jsonString, headers);
	}

	/**
	 * 直接输出JSON,使用Jackson转换Java对象.
	 * 
	 * @param data
	 *            可以是List<POJO>, POJO[], POJO, 也可以Map名值对.
	 * @see #render(String, String, String...)
	 */
	public static void renderJson(final Object data, final String... headers) {
		String jsonString = JsonUtils.toJson(data);
		LOGGER.debug("{json获取成功}" + jsonString);
		renderJson(jsonString, headers);
	}

	/**
	 * 直接输出支持跨域Mashup的JSONP.
	 * 
	 * @param callbackName
	 *            callback函数名.
	 * @param object
	 *            Java对象,可以是List<POJO>, POJO[], POJO ,也可以Map名值对, 将被转化为json字符串.
	 */
	public static void renderJsonp(final String callbackName, final Object object, final String... headers) {
		String jsonString = JsonUtils.toJson(object);

		String data = new StringBuilder().append(callbackName).append("(").append(jsonString).append(");").toString();

		// 渲染Content-Type为javascript的返回内容,输出结果为javascript语句,
		// 如callback197("{html:'Hello World!!!'}");
		render(ServletUtils.JS_TYPE, data, headers);
	}

	/**
	 * 分析并设置contentType与headers.
	 */
	public static HttpServletResponse initResponseHeader(final String contentType, final String... headers) {
		// 分析headers参数
		String encoding = DEFAULT_ENCODING;
		boolean noCache = DEFAULT_NOCACHE;
		long expiresSeconds = EXPIRES_SECONDS;
		for (String header : headers) {
			String headerName = StringUtils.substringBefore(header, ":");
			String headerValue = StringUtils.substringAfter(header, ":");

			if (StringUtils.equalsIgnoreCase(headerName, HEADER_ENCODING)) {
				encoding = headerValue;
			} else if (StringUtils.equalsIgnoreCase(headerName, HEADER_NOCACHE)) {
				noCache = Boolean.parseBoolean(headerValue);
			} else if (StringUtils.equalsIgnoreCase(headerName, "expiresSeconds")) {
				expiresSeconds = Long.parseLong(headerValue);
			} else {
				throw new IllegalArgumentException(headerName + "不是一个合法的header类型");
			}
		}

		HttpServletResponse response = ServletActionContext.getResponse();

		// 设置headers参数
		String fullContentType = contentType + ";charset=" + encoding;
		response.setContentType(fullContentType);
		if (noCache) {
			ServletUtils.setDisableCacheHeader(response);
		} else {
			ServletUtils.setExpiresHeader(response, expiresSeconds);
		}

		return response;
	}

}
