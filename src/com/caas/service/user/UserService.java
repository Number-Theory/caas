package com.caas.service.user;

import java.util.Map;

import com.caas.model.PageContainer;
/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
public interface UserService {
	PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount);

	/*
	 * 用户管理
	 */
	void deleteUser(Map<String, Object> param);

	void batchDeleteUser(Map<String, Object> param);

	Object saveAddUser(Map<String, Object> map);

	Map<String, Object> getUser(Map<String, Object> map);

	void saveEditUser(Map<String, Object> map);
	
	void saveChargeUser(Map<String, Object> map);
	
	void saveRepasswdUser(Map<String, Object> map);

	void updateUserStatus(Map<String, Object> map);
}
