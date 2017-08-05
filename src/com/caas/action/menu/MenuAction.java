package com.caas.action.menu;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.model.PageContainer;
import com.caas.model.PageModel;
import com.caas.service.menu.MenuService;
import com.caas.util.JsonUtil;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年7月31日
 *
 */
@Controller
@Results({ @Result(name = "menuList", location = "/WEB-INF/content/menu/listMenu.jsp"),
		@Result(name = "addMenu", location = "/WEB-INF/content/menu/addMenu.jsp"),
		@Result(name = "editMenu", location = "/WEB-INF/content/menu/editMenu.jsp"),
		@Result(name = "roleList", location = "/WEB-INF/content/menu/listRole.jsp"),
		@Result(name = "addRole", location = "/WEB-INF/content/menu/addRole.jsp"),
		@Result(name = "editRole", location = "/WEB-INF/content/menu/editRole.jsp") })
public class MenuAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5051185935625073083L;

	private static final Logger logger = LogManager.getLogger(MenuAction.class);

	@Autowired
	private MenuService service;

	/*
	 * 角色管理
	 */
	@Action("/menu/roleList")
	public String roleList() {
		return "roleList";
	}

	@Action("/menu/roleListData")
	public void roleListData() {
		deal("menu.roleListData", "menu.roleListDataCount");
	}

	@Action("/menu/deleteRole")
	public void deleteRole() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.deleteRole(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/menu/batchDeleteRole")
	public void batchDeleteRole() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.batchDeleteRole(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/menu/addRole")
	public String addRole() {
		return "addRole";
	}

	@Action("/menu/saveAddRole")
	public void saveAddRole() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Object obj = service.saveAddRole(map);
		StrutsUtils.renderJson(obj);
	}

	@Action("/menu/editRole")
	public String editRole() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getRole(map);
		String menu_priv = (String) returnMap.get("menu_priv");
		Map<String, Object> priv = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(menu_priv)) {
			String[] a = menu_priv.split(",");
			for (String aa : a) {
				priv.put(aa, 1);
			}
		}
		StrutsUtils.getRequest().setAttribute("priv", JsonUtil.toJsonStr(priv));
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editRole";
	}

	@Action("/menu/saveEditRole")
	public void saveEditRole() {
		Map<String, Object> map = StrutsUtils.getFormData();
		try {
			service.saveEditRole(map);
			Map<String, Object> returnMap = service.getRole(map);
			StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
			StrutsUtils.renderText("true");
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderText("false");
		}
	}

	/*
	 * 菜单管理
	 */
	@Action("/menu/menuList")
	public String menuList() {
		return "menuList";
	}

	@Action("/menu/menuListData")
	public void menuListData() {
		deal("menu.menuListData", "menu.menuListDataCount");
	}

	@Action("/menu/deleteMenu")
	public void deleteMenu() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.deleteMenu(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/menu/batchDeleteMenu")
	public void batchDeleteMenu() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.batchDeleteMenu(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/menu/addMenu")
	public String addMenu() {
		return "addMenu";
	}

	@Action("/menu/saveAddMenu")
	public void saveAddMenu() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Object obj = service.saveAddMenu(map);
		StrutsUtils.renderJson(obj);
	}

	@Action("/menu/editMenu")
	public String editMenu() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getMenu(map);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editMenu";
	}

	@Action("/menu/saveEditMenu")
	public void saveEditMenu() {
		Map<String, Object> map = StrutsUtils.getFormData();
		try {
			service.saveEditMenu(map);
			Map<String, Object> returnMap = service.getMenu(map);
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
