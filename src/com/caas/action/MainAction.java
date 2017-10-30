package com.caas.action;

import java.util.ArrayList;
import java.util.Date;
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
import com.caas.util.DateUtil;
import com.caas.util.StrutsUtils;

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
	
	private List<Map<String, Object>> lastFiveDayConsume = new ArrayList<Map<String,Object>>();

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

		userHasApp = dao.selectList("user.getUserApp", user);

		for (Map<String, Object> app : userHasApp) {
			userHasAppFlag.put("app" + (String) app.get("productType"), app.get("status"));
		}

		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		data.put("startDate", DateUtil.strToDate(DateUtil.getDate(DateUtil.dateToStr(new Date(), "yyyy-MM-dd"), 1) + " 00:00:00", "yyyy-MM-dd HH:mm:ss"));
		data.put("endDate", DateUtil.strToDate(DateUtil.getDate(DateUtil.dateToStr(new Date(), "yyyy-MM-dd"), 1) + " 23:59:59", "yyyy-MM-dd HH:mm:ss"));
		yesterdayConsume.put("total", dao.getOneInfo("user.getUserDaySumConsume", data));
		data.put("productType", "4");
		yesterdayConsume.put("voiceNotify", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "3");
		yesterdayConsume.put("voiceCode", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "2");
		yesterdayConsume.put("callback", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "0");
		yesterdayConsume.put("safetyCall", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "1");
		yesterdayConsume.put("minNum", dao.getOneInfo("user.getUserDayConsume", data));
		
		data.clear();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		data.put("startDate", DateUtil.strToDate(DateUtil.dateToStr(new Date(), "yyyy-MM") + "-01 00:00:00", "yyyy-MM-dd HH:mm:ss"));
//		data.put("endDate", DateUtil.strToDate(DateUtil.getDate(DateUtil.dateToStr(new Date(), "yyyy-MM-dd"), 30) + "23:59:59", "yyyy-MM-dd HH:mm:ss"));
		monthConsume.put("total", dao.getOneInfo("user.getUserDaySumConsume", data));
		data.put("productType", "4");
		monthConsume.put("voiceNotify", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "3");
		monthConsume.put("voiceCode", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "2");
		monthConsume.put("callback", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "0");
		monthConsume.put("safetyCall", dao.getOneInfo("user.getUserDayConsume", data));
		data.put("productType", "1");
		monthConsume.put("minNum", dao.getOneInfo("user.getUserDayConsume", data));
		
		data.clear();
		for(int i = 0 ; i < 5 ; i ++) {
			Map<String, Object> map = new HashMap<String, Object>();
			data = StrutsUtils.getFormData();
			data.put("startDate", DateUtil.strToDate(DateUtil.getDate(DateUtil.dateToStr(new Date(), "yyyy-MM-dd"), i) + " 00:00:00", "yyyy-MM-dd HH:mm:ss"));
			data.put("endDate", DateUtil.strToDate(DateUtil.getDate(DateUtil.dateToStr(new Date(), "yyyy-MM-dd"), i) + " 23:59:59", "yyyy-MM-dd HH:mm:ss"));
			data.put("userId", AuthorityUtils.getLoginUserIdNew());
			map.put("total", dao.getOneInfo("user.getUserDaySumConsume", data));
			map.put("consumeDate", DateUtil.getDate(DateUtil.dateToStr(new Date(), "yyyy-MM-dd"), i));
			lastFiveDayConsume.add(map);
		}

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

	public List<Map<String, Object>> getLastFiveDayConsume() {
		return lastFiveDayConsume;
	}

	public void setLastFiveDayConsume(List<Map<String, Object>> lastFiveDayConsume) {
		this.lastFiveDayConsume = lastFiveDayConsume;
	}
	

}
