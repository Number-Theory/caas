package com.caas.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 权限控制工具类
 * 
 * @author xiejiaan
 */
public class AuthorityUtils {

	/**
	 * 当前登录用户的sid、roleId保存在session中的key
	 */
	public static final String LOGIN_USER_ID = "LOGIN_USER_ID";
	public static final String LOGIN_USER_REALNAME = "user";
	public static final String LOGIN_ROLE_ID = "LOGIN_ROLE_ID";
	public static final String LOGIN_USER_ROLENAME = "role";
	public static final String LOGIN_USER_BRAND = "brand";
	public static final String LOGIN_USER_TYPE = "usertype";

	/**
	 * 保存当前登录用户的sid、roleId
	 * 
	 * @param sid
	 * @param roleId
	 */
	public static void setLoginUser(String userId, String userName, Integer roleId, String role, String brand,
			String usertype) {
		setLoginUser(StrutsUtils.getRequest(), userId, userName, roleId, role, brand, usertype);
	}

	/**
	 * 保存当前登录用户的sid、roleId
	 * 
	 * @param request
	 * @param sid
	 * @param roleId
	 */
	public static void setLoginUser(HttpServletRequest request, String userId, String userName, Integer roleId,
			String role, String brand, String usertype) {
		HttpSession session = request.getSession();
		session.setAttribute(LOGIN_USER_ID, userId);
		session.setAttribute(LOGIN_USER_REALNAME, userName);
		session.setAttribute(LOGIN_ROLE_ID, roleId);
		session.setAttribute(LOGIN_USER_ROLENAME, role);
		session.setAttribute(LOGIN_USER_BRAND, brand);
		session.setAttribute(LOGIN_USER_TYPE, usertype);
	}

	/**
	 * 获取当前登录用户的sid
	 * 
	 * @return
	 */
	public static String getLoginUserId() {
		return getLoginUserId(StrutsUtils.getRequest());
	}

	/**
	 * 获取当前登录用户的sid
	 * 
	 * @param request
	 * @return
	 */
	public static String getLoginUserId(HttpServletRequest request) {
		String id = null;
		Object obj = request.getSession().getAttribute(LOGIN_USER_ID);
		if (obj != null && !"null".equals(obj)) {
			id = obj.toString();
		}
		return id;
	}

	/**
	 * 获取当前登录用户的roleId
	 * 
	 * @return
	 */
	public static Integer getLoginRoleId() {
		return getLoginRoleId(StrutsUtils.getRequest());
	}
	
	/**
	 * 判断是否为超级管理员
	 * 
	 * @return
	 */
	public static boolean isSuperAdmin() {
		Integer roleId = getLoginRoleId(StrutsUtils.getRequest());
		return roleId <= 1 ? true : false;
	}

	/**
	 * 获取当前登录用户的roleId
	 * 
	 * @param request
	 * @return
	 */
	public static Integer getLoginRoleId(HttpServletRequest request) {
		Integer roleId = null;
		Object obj = request.getSession().getAttribute(LOGIN_ROLE_ID);
		if (obj != null) {
			roleId = Integer.parseInt(obj.toString());
		}
		return roleId;
	}

	/**
	 * 退出当前登录用户
	 * 
	 */
	public static void setLogoutUser() {
		setLogoutUser(StrutsUtils.getRequest());
	}

	/**
	 * 退出当前登录用户
	 * 
	 * @param request
	 */
	public static void setLogoutUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute(LOGIN_USER_ID);
		session.removeAttribute(LOGIN_ROLE_ID);
		session.removeAttribute(LOGIN_USER_REALNAME);
		session.removeAttribute("user");
	}

	/**
	 * 当前登录的用户名
	 * 
	 * @return
	 */
	public static final String getLoginRealName() {
		return (String) StrutsUtils.getRequest().getSession(true).getAttribute(LOGIN_USER_REALNAME);
	}

	public static final String getLoginUserName() {
		String jsonString = StrutsUtils.getSessionAttribute(LOGIN_USER_ID);
		Map<String, Object> user = JsonUtil.jsonStrToMap(jsonString);
		String name = (String) user.get("id");
		return name;
	}
	
	public static final String getLoginUserNameNew() {
		String jsonString = StrutsUtils.getSessionAttribute(LOGIN_USER_ID);
		Map<String, Object> user = JsonUtil.jsonStrToMap(jsonString);
		String name = (String) user.get("userName");
		return name;
	}
	
	public static final String getLoginUserIdNew() {
		String jsonString = StrutsUtils.getSessionAttribute(LOGIN_USER_ID);
		Map<String, Object> user = JsonUtil.jsonStrToMap(jsonString);

		String user_id = (String) user.get("userId");

		return user_id;
	}

	public static final Integer getLoginUserRole(){
		String jsonString = StrutsUtils.getSessionAttribute(LOGIN_USER_ROLENAME);
		Map<String, Object> user = JsonUtil.jsonStrToMap(jsonString);
		Integer role= (Integer) user.get("role");
		return role;
	}
	
	/**
	 * 判断当前是否已登录
	 * 
	 * @return
	 */
	public static boolean isLogin() {
		return isLogin(StrutsUtils.getRequest());
	}
	
	public static String getClientHost() {
		return StrutsUtils.getSessionAttribute("host");
	}

	/**
	 * 判断当前是否已登录
	 * 
	 * @param request
	 * @return
	 */
	public static boolean isLogin(HttpServletRequest request) {
		String sid = getLoginUserId(request);
		if (sid != null) {// 已经登录
			return true;
		}
		return false;
	}

}
