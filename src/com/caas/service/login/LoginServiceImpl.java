package com.caas.service.login;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.caas.dao.CaasDao;
import com.caas.util.MD5Util;

/**
 * 
 * @author xupiao 2017年7月31日
 *
 */
@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	private CaasDao caasDao;

	@Override
	public Map<String, Object> queryUser(Map<String, Object> paramMap) {
		String password = (String) paramMap.get("userPwd");
		if (StringUtils.isNotBlank(password)) {
			paramMap.put("userPwd", MD5Util.string2MD5(password).toUpperCase());
		}
		Map<String, Object> userMap = caasDao.getOneInfo("login.queryLoginUser", paramMap);
		return userMap;
	}

	@Override
	public Map<String, Object> queryRoleMenuList(Integer roleId) {
		List<Map<String, Object>> firstMenus = new ArrayList<Map<String, Object>>(); // 第一级别
		List<Map<String, Object>> secondMenus = new ArrayList<Map<String, Object>>();// 第二级别
		if (roleId == 1) {
			firstMenus = caasDao.selectList("menu.getAllFirstMenu", null);
			secondMenus = caasDao.selectList("menu.getAllSecondMenu", null);
		} else {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("roleId", roleId);
			Map<String, Object> roleMenuMap = caasDao.getOneInfo("login.queryLoginUserRoleMenu", params);
			if (null == roleMenuMap || roleMenuMap.size() <= 0) {
				return null;
			} else {
				String roleMenuStr = roleMenuMap.get("menu").toString();
				String[] roleMenuArray = roleMenuStr.split(",");
				for (String roleMenu : roleMenuArray) {
					// 依次遍历查找一,二,三级菜单
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("id", roleMenu);
					Map<String, Object> menuMap = caasDao.getOneInfo("login.queryMenuRate", map);
					if (null == menuMap || menuMap.size() <= 0) {
						continue;
					} else {
						if (menuMap.get("super_id").toString().equals("0")) {
							firstMenus.add(menuMap);
						} else {
							secondMenus.add(menuMap);
						}
					}
				}

			}
		}
		Map<String, Object> menuListMap = new HashMap<String, Object>();
		Comparator<Map<String, Object>> c = new Comparator<Map<String, Object>>() {
			@Override
			public int compare(Map<String, Object> o1, Map<String, Object> o2) {
				return ((Integer) o1.get("sort")) - ((Integer) o2.get("sort"));
			}
		};
		java.util.Collections.sort(firstMenus, c);
		java.util.Collections.sort(secondMenus, c);
		menuListMap.put("first", firstMenus);
		menuListMap.put("second", secondMenus);
		return menuListMap;
	}

}
