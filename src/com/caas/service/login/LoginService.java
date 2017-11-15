package com.caas.service.login;

import java.util.Map;

/**
 * 
 * @author xupiao 2017年7月31日
 *
 */
public interface LoginService {
	/**
	 * 根据用户名，密码查询用户是否存在
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> queryUser(Map<String, Object> paramMap);
	
	/**
	 * 根据用户查询目录权限
	 * @param paramMap
	 * @return
	 */
	public Map<String, Object> queryRoleMenuList(Integer roleId);
}
