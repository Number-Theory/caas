package com.caas.action.login;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;

import javax.servlet.ServletException;

import org.apache.struts2.convention.annotation.Action;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.util.CheckCodeUtil;
import com.caas.util.StrutsUtils;

@Controller
@Scope("prototype")
public class CheckCodeAction extends BaseAction {
	
	private String phone;
	private String phone1;
	private String phone2;
	private Logger logger = LoggerFactory.getLogger(CheckCodeAction.class);
	private String type; 
	private String smsTempType;
	private String expType;
	private String content;
	private static Map<String, Object> urlMap = new HashMap<String, Object>();
	private final int baseCount = 10 ;
	private final String lockStr="lockStr";
	private String callId;
	private String confId;
	static{
		urlMap.put("smsurl", "/checkcode/smsCheckCode");
		urlMap.put("voiceurl", "/checkcode/voiceCheckCode");
	}

	/*---------------------------------------------打印验证码--------------------------------*/
	@Action("/checkcode/picCheckCode")
	public void checkCode(){
		String checkCodeId = StrutsUtils.getParameter("checkCodeId");
		try {
			CheckCodeUtil.makeCheckCode(StrutsUtils.getRequest(), StrutsUtils.getResponse(),checkCodeId);
		} catch (ServletException e) {
			e.printStackTrace();
			logger.error("-----------------获取图片验证码失败------------------");
			logger.error(e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("-----------------获取图片验证码失败------------------");
			logger.error(e.getMessage());
		}
	}
	
	
	
	/*---------------------------------------------get set--------------------------------*/
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getSmsTempType() {
		return smsTempType;
	}
	public void setSmsTempType(String smsTempType) {
		this.smsTempType = smsTempType;
	}
	public String getExpType() {
		return expType;
	}
	public void setExpType(String expType) {
		this.expType = expType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}

	public String getCallId() {
		return callId;
	}

	public void setCallId(String callId) {
		this.callId = callId;
	}

	public String getConfId() {
		return confId;
	}

	public void setConfId(String confId) {
		this.confId = confId;
	}
}
