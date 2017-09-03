package com.caas.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.caas.dao.CaasDao;
import com.caas.util.AuthorityUtils;

@Controller
@Scope("prototype")
@Results({ @Result(name = "main", location = "/WEB-INF/content/main.jsp") })
public class MainAction extends BaseAction {

	private Map<String, Object> user = new HashMap<String, Object>();
	private Map<String, Object> oauth;

	private List<Map<String, Object>> userHasApp = new ArrayList<>();
	private List<Map<String, Object>> userNotApp = new ArrayList<>();
	private List<Map<String, Object>> paramsList = new ArrayList<>();

	private Map<String, Object> userHasAppFlag = new HashMap<String, Object>();

	private Map<String, Object> app = new HashMap<String, Object>();
	private Map<String, Object> monthConsume = new HashMap<String, Object>();

	private Map<String, Object> yesterdayConsume = new HashMap<String, Object>();

	@Autowired
	private CaasDao dao;

	/**
	 * 
	 */
	private static final long serialVersionUID = -2994868047362364750L;

	@Action("main")
	public String main() {
		getUserInfo();
		getAuthenticationInfo();
		Long banalce = dao.getOneInfo("user.getUserBalance", user);
		if (banalce != null) {
			user.put("balance", banalce);
		} else {
			user.put("balance", 0);
		}

		userHasApp = dao.selectList("getUserApp", user);

		for (Map<String, Object> app : userHasApp) {
			userHasAppFlag.put("app" + (String) app.get("productType"), app.get("status"));
		}

		// TODO
		yesterdayConsume.put("smsCount", 50000.10);
		yesterdayConsume.put("total", 50000.10);
		yesterdayConsume.put("verify_fee", 50000.10);
		yesterdayConsume.put("notice_fee", 50000.10);
		yesterdayConsume.put("waihu_fee", 50000.10);
		yesterdayConsume.put("center_fee", 50000.10);

		return "main";
	}

	private void getUserInfo() {
		Map<String, Object> userParams = new HashMap<String, Object>();
		userParams.put("userId", AuthorityUtils.getLoginUserIdNew());
		user = dao.getOneInfo("user.getUserByUserId", userParams);
	}

	private void getAuthenticationInfo() {
		Map<String, Object> userParams = new HashMap<String, Object>();
		userParams.put("userId", AuthorityUtils.getLoginUserIdNew());
		oauth = dao.getOneInfo("user.getUserAuthenticationByUserId", userParams);
	}

	public Map<String, Object> getUserHasAppFlag() {
		return userHasAppFlag;
	}

	public void setUserHasAppFlag(Map<String, Object> userHasAppFlag) {
		this.userHasAppFlag = userHasAppFlag;
	}

	public Map<String, Object> getOauth() {
		return oauth;
	}

	public void setOauth(Map<String, Object> oauth) {
		this.oauth = oauth;
	}

	public Map<String, Object> getUser() {
		return user;
	}

	public void setUser(Map<String, Object> user) {
		this.user = user;
	}

	public List<Map<String, Object>> getUserHasApp() {
		return userHasApp;
	}

	public void setUserHasApp(List<Map<String, Object>> userHasApp) {
		this.userHasApp = userHasApp;
	}

	public List<Map<String, Object>> getUserNotApp() {
		return userNotApp;
	}

	public void setUserNotApp(List<Map<String, Object>> userNotApp) {
		this.userNotApp = userNotApp;
	}

	public List<Map<String, Object>> getParamsList() {
		return paramsList;
	}

	public void setParamsList(List<Map<String, Object>> paramsList) {
		this.paramsList = paramsList;
	}

	public Map<String, Object> getApp() {
		return app;
	}

	public void setApp(Map<String, Object> app) {
		this.app = app;
	}

	public Map<String, Object> getMonthConsume() {
		return monthConsume;
	}

	public void setMonthConsume(Map<String, Object> monthConsume) {
		this.monthConsume = monthConsume;
	}

	public Map<String, Object> getYesterdayConsume() {
		return yesterdayConsume;
	}

	public void setYesterdayConsume(Map<String, Object> yesterdayConsume) {
		this.yesterdayConsume = yesterdayConsume;
	}

}
