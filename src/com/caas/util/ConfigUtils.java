package com.caas.util;

import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.net.URLDecoder;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * 系统配置工具类
 * 
 * @author xiejiaan
 */
@Component
public class ConfigUtils {
	private static final Logger logger = LoggerFactory.getLogger(ConfigUtils.class);

	/**
	 * 配置文件路径
	 */
	public static String config_file_path;
	
	public static String php_server;
	public static String scs_server;
	
	public static String mail_smtp_host;
	public static  String mail_host;
	public static String mail_username;
	public static String mail_password;
	
	public static String send_message_url;
	
	public static Integer request_infos_timeout;

	@PostConstruct
	public void init() {
		String path = ConfigUtils.class.getClassLoader().getResource("").getPath() + "config/";
		try {
			config_file_path = URLDecoder.decode(path, "UTF-8") + "config.properties";
		} catch (UnsupportedEncodingException e) {
		}

		logger.debug("\n\n-------------------------【vboss-platform，服务器启动】\n加载配置文件：\n{}\n", config_file_path);

		initValue();
	}

	/**
	 * 初始化配置项的值
	 */
	private void initValue() {
		Field[] fields = ConfigUtils.class.getFields();
		Object fieldValue = null;
		String name = null, value = null, tmp = null;
		Class<?> type = null;
		Pattern pattern = Pattern.compile("\\$\\{(.+?)\\}");
		Matcher matcher = null;
		try {
			Properties properties = new Properties();
			properties.load(new FileInputStream(config_file_path));

			for (Field field : fields) {
				name = field.getName();
				value = properties.getProperty(name);
				if (StringUtils.isNotBlank(value)) {
					matcher = pattern.matcher(value);
					while (matcher.find()) {
						tmp = properties.getProperty(matcher.group(1));
						if (StringUtils.isBlank(tmp)) {
							logger.error("配置{}存在其它配置{}，请检查您的配置文件", name, matcher.group(1));
						}
						value = value.replace(matcher.group(0), tmp);
					}

					type = field.getType();
					if (String.class.equals(type)) {
						fieldValue = value;
					} else if (Integer.class.equals(type)) {
						fieldValue = Integer.valueOf(value);
					} else if (Boolean.class.equals(type)) {
						fieldValue = Boolean.valueOf(value);
					} else {
						fieldValue = value;
					}
					field.set(this, fieldValue);
				}
				logger.debug("加载配置：{}={}", name, field.get(this));
			}
		} catch (Throwable e) {
			logger.error("初始化配置项的值失败：" + name + "=" + value, e);
		}
	}

}
