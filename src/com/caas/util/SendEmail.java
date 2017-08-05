package com.caas.util;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class SendEmail {
	protected final Logger logger = LogManager.getLogger(SendEmail.class);
	
	public static void mail(String mail_title, String mailContent, String mail_to) throws Exception {
		Properties props = new Properties(); // 可以加载一个配置文件
		// 使用smtp：简单邮件传输协议
		props.put("mail.smtp.host", StringUtils.defaultString(ConfigUtils.mail_smtp_host, "mail.ucpaas.com"));// 存储发送邮件服务器的信息
		props.put("mail.smtp.auth", "true");// 同时通过验证
		Session session = Session.getInstance(props);// 根据属性新建一个邮件会话
//		session.setDebug(true); //有他会打印一些调试信息。

		MimeMessage message = new MimeMessage(session);// 由邮件会话新建一个消息对象
		message.setFrom(new InternetAddress(ConfigUtils.mail_host));// 设置发件人的地址
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(mail_to));// 设置收件人,并设置其接收类型为TO
		message.setSubject(mail_title);// 设置标题
		// 设置信件内容
		message.setContent(mailContent, "text/html;charset=gbk"); // 发送HTML邮件，内容样式比较丰富
		message.setSentDate(new Date());// 设置发信时间
		message.saveChanges();// 存储邮件信息

		// 发送邮件
		// Transport transport = session.getTransport("smtp");
		Transport transport = session.getTransport();
		transport.connect(ConfigUtils.mail_username, ConfigUtils.mail_password);
		transport.sendMessage(message, message.getAllRecipients());// 发送邮件,其中第二个参数是所有已设好的收件人地址
		transport.close();
	}
	
	public static void main(String[] args) throws Exception {
		mail("测试", "发送测试邮件", "mengtao@ucpaas.com");
		mail("测试", "发送测试邮件", "xupiao@ucpaas.com");
		mail("测试", "发送测试邮件", "yuanzudong@ucpaas.com");
	}
}
