package com.caas.service.menu;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.caas.dao.CaasDao;
import com.caas.model.PageContainer;

/**
 * 
 * @author xupiao 2017年7月31日
 *
 */
@Service
public class MenuServiceImpl implements MenuService {

	private static final Logger logger = LogManager.getLogger(MenuServiceImpl.class);

	@Autowired
	private CaasDao dao;

	@Override
	public PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount) {
		return dao.getSearchPage(sqlData, sqlDataCount, map);
	}

	/*
	 * 角色管理(non-Javadoc)
	 * 
	 * @see com.caas.service.menu.MenuService#deleteRole(java.util.Map)
	 */
	@Override
	public void deleteRole(Map<String, Object> param) {
		dao.delete("menu.deleteRole", param);
	}

	@Override
	public void batchDeleteRole(Map<String, Object> param) {
		dao.delete("menu.batchDeleteRole", param);
	}

	@Override
	public Object saveAddRole(Map<String, Object> map) {
		try {
			dao.insert("menu.saveAddRole", map);
			return "true";
		} catch (Exception e) {
			logger.error("增加角色错误：", e);
			return "false";
		}
	}

	@Override
	public Map<String, Object> getRole(Map<String, Object> map) {
		return dao.getOneInfo("menu.getRole", map);
	}

	@Override
	public void saveEditRole(Map<String, Object> map) {
		dao.update("menu.saveEditRole", map);
	}

	@Override
	public void updateRoleStatus(Map<String, Object> map) {
		dao.update("menu.updateRoleStatus", map);
	}

	/*
	 * 菜单管理(non-Javadoc)
	 * 
	 * @see com.caas.service.menu.MenuService#deleteMenu(java.util.Map)
	 */
	@Override
	public void deleteMenu(Map<String, Object> param) {
		dao.delete("menu.deleteMenu", param);
	}

	@Override
	public void batchDeleteMenu(Map<String, Object> param) {
		dao.delete("menu.batchDeleteMenu", param);
	}

	@Override
	public Object saveAddMenu(Map<String, Object> map) {
		try {
			dao.insert("menu.saveAddMenu", map);
			return "true";
		} catch (Exception e) {
			logger.error("增加角色错误：", e);
			return "false";
		}
	}

	@Override
	public Map<String, Object> getMenu(Map<String, Object> map) {
		return dao.getOneInfo("menu.getMenu", map);
	}

	@Override
	public void saveEditMenu(Map<String, Object> map) {
		dao.update("menu.saveEditMenu", map);
	}

	@Override
	public void updateMenuStatus(Map<String, Object> map) {
		dao.update("menu.updateMenuStatus", map);
	}
}
