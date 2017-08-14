package com.caas.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller
@Scope("prototype")
@Results({ @Result(name = "main", location = "/WEB-INF/content/main.jsp") })
public class MainAction extends BaseAction {

	private Map<String, Object> user;

	private List<Map<String, Object>> userHasApp = new ArrayList<>();
	private List<Map<String, Object>> userNotApp = new ArrayList<>();
	private List<Map<String, Object>> paramsList = new ArrayList<>();

	private Map<String, Object> app;
	private Map<String, Object> monthConsume;

	/**
	 * 
	 */
	private static final long serialVersionUID = -2994868047362364750L;

	@Action("main")
	public String main() {
		user = new HashMap<>();
		user.put("balance", 100);
		user.put("sid", UUID.randomUUID().toString().replaceAll("-", ""));
		user.put("token", UUID.randomUUID().toString().replaceAll("-", ""));
		return "main";
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

}
