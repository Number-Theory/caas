package com.caas.action.user;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.dao.CaasDao;
import com.caas.model.PageContainer;
import com.caas.model.PageModel;
import com.caas.service.user.UserService;
import com.caas.util.AuthorityUtils;
import com.caas.util.MD5Util;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
@Controller
@Results({ @Result(name = "userList", location = "/WEB-INF/content/user/listUser.jsp"),
	@Result(name = "addUser", location = "/WEB-INF/content/user/addUser.jsp"),
	@Result(name = "editUser", location = "/WEB-INF/content/user/editUser.jsp") })
public class UserAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1383097107338406933L;

	private static final Logger logger = LogManager.getLogger(UserAction.class);

	@Autowired
	private UserService service;
	
	@Autowired
	private CaasDao dao;

	/*
	 * 用户管理
	 */
	@Action("/user/userList")
	public String userList() {
		return "userList";
	}

	@Action("/user/userListData")
	public void userListData() {
		deal("user.userListData", "user.userListDataCount");
	}

	@Action("/user/deleteUser")
	public void deleteUser() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.deleteUser(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/user/batchDeleteUser")
	public void batchDeleteUser() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.batchDeleteUser(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/user/addUser")
	public String addUser() {
		List<Map<String, Object>> roleMap = dao.selectList("menu.getAllRole", null);
		StrutsUtils.getRequest().setAttribute("roleMap", roleMap);
		return "addUser";
	}

	@Action("/user/saveAddUser")
	public void saveAddUser() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		map.put("sid", UUID.randomUUID().toString().replaceAll("-", ""));
		map.put("token", UUID.randomUUID().toString().replaceAll("-", ""));
		map.put("createType", "1");
		map.put("userPwd", MD5Util.string2MD5("123456").toUpperCase());
		map.put("creationUser", AuthorityUtils.getLoginUserNameNew());
		Object obj = service.saveAddUser(map);
		StrutsUtils.renderJson(obj);
	}

	@Action("/user/editUser")
	public String editUser() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getUser(map);
		List<Map<String, Object>> roleMap = dao.selectList("menu.getAllRole", null);
		StrutsUtils.getRequest().setAttribute("roleMap", roleMap);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editUser";
	}

	@Action("/user/saveEditUser")
	public void saveEditUser() {
		Map<String, Object> map = StrutsUtils.getFormData();
		try {
			service.saveEditUser(map);
			Map<String, Object> returnMap = service.getUser(map);
			StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
			StrutsUtils.renderText("true");
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderText("false");
		}
	}

	// 处理表格
	public void deal(String sqlData, String sqlDataCount) {
		Map<String, Object> map = StrutsUtils.getFormData();
		PageContainer page = service.csmData(map, sqlData, sqlDataCount);

		PageModel pageModel = new PageModel();
		pageModel.setTotal(page.getTotalCount());
		pageModel.setRows(page.getList());

		StrutsUtils.renderJson(pageModel);
	}
}
