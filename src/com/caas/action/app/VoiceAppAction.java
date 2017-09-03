package com.caas.action.app;

import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.dao.CaasDao;
import com.caas.util.AuthorityUtils;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年8月22日
 *
 */
@Controller
@Scope("prototype")
@Results({ @Result(name = "voiceCodeApp", location = "/WEB-INF/content/app/voiceCode.jsp"),
		@Result(name = "voiceNotifyApp", location = "/WEB-INF/content/app/voiceNotify.jsp"),
		@Result(name = "safetyCallApp", location = "/WEB-INF/content/app/safetyCall.jsp"),
		@Result(name = "minNumApp", location = "/WEB-INF/content/app/minNum.jsp"),
		@Result(name = "callbackApp", location = "/WEB-INF/content/app/callback.jsp"),
		@Result(name = "editAppInfo", location = "/WEB-INF/content/app/editAppInfo.jsp") })
public class VoiceAppAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2367556583057400927L;

	@Autowired
	private CaasDao dao;

	private Map<String, Object> appMap;

	@Action("/app/voiceCodeApp")
	public String voiceCodeApp() {
		data = StrutsUtils.getFormData();
		getApp("3");
		getAppConsume("3");
		return "voiceCodeApp";
	}

	@Action("/app/voiceNotifyApp")
	public String voiceNotifyApp() {
		data = StrutsUtils.getFormData();
		getApp("4");
		getAppConsume("4");
		return "voiceNotifyApp";
	}

	@Action("/app/safetyCallApp")
	public String safetyCallApp() {
		data = StrutsUtils.getFormData();
		getApp("0");
		getAppConsume("0");
		return "safetyCallApp";
	}

	@Action("/app/minNumApp")
	public String minNumApp() {
		data = StrutsUtils.getFormData();
		getApp("1");
		getAppConsume("1");
		return "minNumApp";
	}

	@Action("/app/callbackApp")
	public String callbackApp() {
		data = StrutsUtils.getFormData();
		getApp("2");
		getAppConsume("2");
		return "callbackApp";
	}

	@Action("/app/editAppInfo")
	public String editAppInfo() {
		data = StrutsUtils.getFormData();
		getApp((String) data.get("productType"));
		return "editAppInfo";
	}

	@Action("/app/saveEditAppInfo")
	public void saveEditAppInfo() {
		data = StrutsUtils.getFormData();
		dao.update("app.updateAppInfo", data);
		StrutsUtils.renderJson(true);
	}

	private void getAppConsume(String productType) {
		Long totalRequest = 18543L; // TODO
		Long todayRequest = 3578L;
		Long totalConsume = 87521L;
		Long todayConsume = 2654L;
		int numberCount = dao.getOneInfo("app.getAppNumberCount", data);
		data.put("totalRequest", totalRequest);
		data.put("todayRequest", todayRequest);
		data.put("totalConsume", totalConsume);
		data.put("todayConsume", todayConsume);
		data.put("numberCount", numberCount);
	}

	private void getApp(String productType) {
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		data.put("productType", productType);
		appMap = dao.getOneInfo("getUserAppByProductType", data);
	}

	public Map<String, Object> getAppMap() {
		return appMap;
	}

	public void setAppMap(Map<String, Object> appMap) {
		this.appMap = appMap;
	}

}
