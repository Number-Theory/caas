package com.caas.action.login;

import java.util.Map;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.service.login.LoginService;
import com.caas.service.user.UserService;
import com.caas.util.AuthorityUtils;
import com.caas.util.CheckCodeUtil;
import com.caas.util.JsonUtil;
import com.caas.util.MD5Util;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年1月19日
 *
 */
@Controller
@Scope("prototype")
@Results({ @Result(name = "login", location = "/WEB-INF/content/login.jsp"),
		@Result(name = "index", location = "/WEB-INF/content/index.jsp"),
		@Result(name = "main", location = "/WEB-INF/content/main.jsp"),
		@Result(name = "register", location = "/WEB-INF/content/register.jsp"),
		@Result(name = "home", location = "/WEB-INF/content/home_about.jsp") })
public class LoginAction extends BaseAction {
	private static final long serialVersionUID = 3830209747022145354L;
	private static final Logger logger = LogManager.getLogger(LoginAction.class);

	@Autowired
	private LoginService loginService;
	
	@Autowired
	private UserService userService;

	@Action("/checkCode")
	public void checkCode() {
		try {
			CheckCodeUtil.makeCheckCode(StrutsUtils.getRequest(), StrutsUtils.getResponse());
		} catch (Throwable e) {
			logger.error(e.getMessage(), e);
		}
	}

	@Action("/checkCodeValid")
	// 验证验证码是否正确
	public void checkCodeValid() {
		String code = StrutsUtils.getRequest().getParameter("code");
		String randCheckCode = (String) StrutsUtils.getSession().getAttribute("randCheckCode");
		if (code.toLowerCase().equals(randCheckCode.toLowerCase())) {
			StrutsUtils.renderJson(true);
		} else {
			StrutsUtils.renderJson(false);
		}
	}
	
	@Action("/login") 
	public String login(){
		if (AuthorityUtils.isLogin()) {
			return "index";
		} else {
			return "login";
		}
	}

	@Action("/index")
	public String index() {
		if (AuthorityUtils.isLogin()) {
			return "index";
		} else {
			Map<String, Object> param = StrutsUtils.getFormData();
			if(param.containsKey("name") && param.containsKey("userPwd")) {
				logger.info("[获取的参数为]param={}" + param);
				Map<String, Object> userMap = loginService.queryUser(param);

				if (userMap != null && userMap.size() > 0) {
					StrutsUtils.setSessionAttribute(AuthorityUtils.LOGIN_USER_ID, JsonUtil.toJsonStr(userMap));

					Map<String, Object> roleMenu = loginService.queryRoleMenuList((Integer) userMap.get("roleId"));
					StrutsUtils.setSessionAttribute("rolemenu", roleMenu);
					StrutsUtils.setAttribute("user", userMap);
					StrutsUtils.setSessionAttribute("sid", (String) userMap.get("sid"));
				} else {
					StrutsUtils.setAttribute("msg", "用户名或密码错误");
					return "login";
				}
			} else {
				return "login";
			}
		}
		return "index";
	}
	
	@Action("/home")
	public String home() {
		return "home";
	}
	
	@Action("register")
	public String register() {
		return "register";
	}

	@Action("/logout")
	public String logout() {
		AuthorityUtils.setLogoutUser();
		return "login";
	}
	
	@Action("/saveUser")
	public String saveUser(){
		Map<String, Object> param = StrutsUtils.getFormData();
		param.put("userId", UUID.randomUUID().toString().replaceAll("-", ""));
		param.put("token", UUID.randomUUID().toString().replaceAll("-", ""));
		param.put("createType", "1");
		param.put("roleId", "4");
		param.put("userType", "0");
		param.put("status", "0");
		param.put("userPwd", MD5Util.string2MD5(param.get("userPwd").toString()).toUpperCase());
		param.put("creationUser", param.get("userName").toString());
		Map<String, Object> resultMap = (Map<String, Object>) userService.saveAddUser(param);
		StrutsUtils.setAttribute("resultMap", resultMap);
		if(resultMap.get("result").toString().equals("true")){
			return "login";
		}else {
			return "register";
		}
	}

}
=======
package com.caas.action.login;

import java.util.Map;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.service.login.LoginService;
import com.caas.service.user.UserService;
import com.caas.util.AuthorityUtils;
import com.caas.util.CheckCodeUtil;
import com.caas.util.JsonUtil;
import com.caas.util.MD5Util;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年1月19日
 *
 */
@Controller
@Scope("prototype")
@Results({ @Result(name = "login", location = "/WEB-INF/content/login.jsp"),
		@Result(name = "index", location = "/WEB-INF/content/index.jsp"),
		@Result(name = "main", location = "/WEB-INF/content/main.jsp"),
		@Result(name = "register", location = "/WEB-INF/content/register.jsp"),
		@Result(name = "home", location = "/WEB-INF/content/home_about.jsp") })
public class LoginAction extends BaseAction {
	private static final long serialVersionUID = 3830209747022145354L;
	private static final Logger logger = LogManager.getLogger(LoginAction.class);

	@Autowired
	private LoginService loginService;
	
	@Autowired
	private UserService userService;

	@Action("/checkCode")
	public void checkCode() {
		try {
			CheckCodeUtil.makeCheckCode(StrutsUtils.getRequest(), StrutsUtils.getResponse());
		} catch (Throwable e) {
			logger.error(e.getMessage(), e);
		}
	}

	@Action("/checkCodeValid")
	// 验证验证码是否正确
	public void checkCodeValid() {
		String code = StrutsUtils.getRequest().getParameter("code");
		String randCheckCode = (String) StrutsUtils.getSession().getAttribute("randCheckCode");
		if (code.toLowerCase().equals(randCheckCode.toLowerCase())) {
			StrutsUtils.renderJson(true);
		} else {
			StrutsUtils.renderJson(false);
		}
	}
	
	@Action("/login") 
	public String login(){
		if (AuthorityUtils.isLogin()) {
			return "index";
		} else {
			return "login";
		}
	}

	@Action("/index")
	public String index() {
		if (AuthorityUtils.isLogin()) {
			return "index";
		} else {
			Map<String, Object> param = StrutsUtils.getFormData();
			if(param.containsKey("name") && param.containsKey("userPwd")) {
				logger.info("[获取的参数为]param={}" + param);
				Map<String, Object> userMap = loginService.queryUser(param);

				if (userMap != null && userMap.size() > 0) {
					StrutsUtils.setSessionAttribute(AuthorityUtils.LOGIN_USER_ID, JsonUtil.toJsonStr(userMap));

					Map<String, Object> roleMenu = loginService.queryRoleMenuList((Integer) userMap.get("roleId"));
					StrutsUtils.setSessionAttribute("rolemenu", roleMenu);
					StrutsUtils.setAttribute("user", userMap);
					StrutsUtils.setSessionAttribute("sid", (String) userMap.get("sid"));
				} else {
					StrutsUtils.setAttribute("msg", "用户名或密码错误");
					return "login";
				}
			} else {
				return "login";
			}
		}
		return "index";
	}
	
	@Action("/home")
	public String home() {
		return "home";
	}
	
	@Action("register")
	public String register() {
		return "register";
	}

	@Action("/logout")
	public String logout() {
		AuthorityUtils.setLogoutUser();
		return "login";
	}
	
	@Action("/saveUser")
	public String saveUser(){
		Map<String, Object> param = StrutsUtils.getFormData();
		param.put("userId", UUID.randomUUID().toString().replaceAll("-", ""));
		param.put("token", UUID.randomUUID().toString().replaceAll("-", ""));
		param.put("createType", "1");
		param.put("roleId", "4");
		param.put("userType", "0");
		param.put("status", "0");
		param.put("userPwd", MD5Util.string2MD5(param.get("userPwd").toString()).toUpperCase());
		param.put("creationUser", param.get("userName").toString());
		Map<String, Object> resultMap = (Map<String, Object>) userService.saveAddUser(param);
		StrutsUtils.setAttribute("resultMap", resultMap);
		if(resultMap.get("result").toString().equals("true")){
			return "login";
		}else {
			return "register";
		}
	}

}
