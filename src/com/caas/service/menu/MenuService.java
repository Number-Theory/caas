package com.caas.service.menu;

import java.util.Map;

import com.caas.model.PageContainer;
/**
 * 
 * @author xupiao 2017年7月31日
 *
 */
public interface MenuService {
	
	PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount);

	/*
	 * 角色管理
	 */
	void deleteRole(Map<String, Object> param);

	void batchDeleteRole(Map<String, Object> param);

	Object saveAddRole(Map<String, Object> map);

	Map<String, Object> getRole(Map<String, Object> map);

	void saveEditRole(Map<String, Object> map);

	void updateRoleStatus(Map<String, Object> map);
	
	/*
	 * 菜单管理
	 */
	void deleteMenu(Map<String, Object> param);

	void batchDeleteMenu(Map<String, Object> param);

	Object saveAddMenu(Map<String, Object> map);

	Map<String, Object> getMenu(Map<String, Object> map);

	void saveEditMenu(Map<String, Object> map);

	void updateMenuStatus(Map<String, Object> map);
}
