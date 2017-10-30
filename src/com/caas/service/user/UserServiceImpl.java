package com.caas.service.user;

import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.caas.dao.CaasDao;
import com.caas.model.PageContainer;

/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
@Service
public class UserServiceImpl implements UserService {
	private static final Logger logger = LogManager.getLogger(UserServiceImpl.class);
	@Autowired
	private CaasDao dao;

	@Override
	public PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount) {
		return dao.getSearchPage(sqlData, sqlDataCount, map);
	}

	/*
	 * 用户管理(non-Javadoc)
	 * 
	 * @see com.caas.service.user.UserService#deleteUser(java.util.Map)
	 */
	@Override
	public void deleteUser(Map<String, Object> param) {
		dao.delete("user.deleteUser", param);
	}

	@Override
	public void batchDeleteUser(Map<String, Object> param) {
		dao.delete("user.batchDeleteUser", param);
	}

	@Override
	public Object saveAddUser(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, Object> user = dao.getOneInfo("user.getUserByUserName", map);
			;
			if (user != null && !user.isEmpty()) {
				result.put("result", "false");
				result.put("msg", ",用户名已存在");
				return result;
			}
			user = dao.getOneInfo("user.getUserByMobile", map);
			if (user != null && !user.isEmpty()) {
				result.put("result", "false");
				result.put("msg", ",号码已被注册");
				return result;
			}

			user = dao.getOneInfo("user.getUserByEmail", map);
			if (user != null && !user.isEmpty()) {
				result.put("result", "false");
				result.put("msg", ",邮箱已被注册");
				return result;
			}

			dao.insert("user.saveAddUser", map);

			dao.insert("user.saveAddUserBalance", map);

			result.put("result", "true");
		} catch (Exception e) {
			logger.error("增加角色错误：", e);
			result.put("result", "false");
			result.put("msg", "系统错误");
		}
		return result;
	}

	@Override
	public Map<String, Object> getUser(Map<String, Object> map) {
		return dao.getOneInfo("user.getUser", map);
	}

	@Override
	public void saveEditUser(Map<String, Object> map) {
		dao.update("user.saveEditUser", map);
	}

	@Override
	public void updateUserStatus(Map<String, Object> map) {
		dao.update("user.updateUserStatus", map);
	}
}
