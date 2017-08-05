package com.caas.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * des3加密、解密工具类，请使用EncryptUtils.encodeDes3("")、EncryptUtils.decodeDes3("")方法
 * 
 */
public class Des3Utils {
	private static final Logger logger = LoggerFactory.getLogger(Des3Utils.class);
	/**
	 * 加密秘钥，必须大于23位
	 */
	private static final String encode_key = "0?W)<&{o}8QjO@XU]S>reEs>#0'^ay";

	private static Cipher encode_cipher;
	private static Cipher decode_cipher;

	static {
		try {
			KeySpec keySpec = new DESedeKeySpec(stringToByteArray(encode_key));
			SecretKeyFactory secretKeyFactory = SecretKeyFactory.getInstance("DESede");
			SecretKey secretKey = secretKeyFactory.generateSecret(keySpec);

			encode_cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
			decode_cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");

			encode_cipher.init(Cipher.ENCRYPT_MODE, secretKey);
			decode_cipher.init(Cipher.DECRYPT_MODE, secretKey);
		} catch (Throwable e) {
			logger.error("des3加密、解密初始化失败", e);
		}
	}

	/**
	 * des3加密
	 * 
	 * @param str
	 * @return
	 */
	public synchronized static String encodeDes3(String str) {
		try {
			byte[] cipherStr = encode_cipher.doFinal(stringToByteArray(str));
			String temp = new BASE64Encoder().encode(cipherStr);
			return URLEncoder.encode(temp, "utf-8");
		} catch (Throwable e) {
			logger.error("des3加密失败：str=" + str, e);
		}
		return null;
	}

	/**
	 * des3解密
	 * 
	 * @param str
	 * @return
	 */
	public synchronized static String decodeDes3(String str) {
		String temp = str.replace("+", "%2B");
		temp = temp.replace("=", "%3D");
		temp = temp.replace("%25", "%");
		try {
			temp = URLDecoder.decode(temp, "utf-8");
			byte[] cipherStr = decode_cipher.doFinal(new BASE64Decoder().decodeBuffer(temp));
			return byteArrayToString(cipherStr);
		} catch (Throwable e) {
			logger.error("des3解密失败：str=" + str, e);
		}
		return null;
	}

	private static byte[] stringToByteArray(String input) {
		try {
			return input.getBytes("utf-8");
		} catch (UnsupportedEncodingException e) {
			return input.getBytes();
		}
	}

	private static String byteArrayToString(byte[] byteArray) {
		try {
			return new String(byteArray, "utf-8");
		} catch (UnsupportedEncodingException e) {
			return new String(byteArray);
		}
	}

	public static void main(String[] argv) {
		String str = RandomStringUtils.randomAscii(30);

		System.out.println("str：" + str);
		System.out.println("encode_key：" + encode_key);
		str = encodeDes3(str);
		System.out.println("encodeDes3：" + str);
		str = decodeDes3(str);
		System.out.println("decodeDes3：" + str);
	}
}
