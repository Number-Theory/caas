package com.caas.service.enterprise;

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
public class EnterpriseServiceImpl implements EnterpriseService {
	
	private static final Logger logger = LogManager.getLogger(EnterpriseServiceImpl.class);
	@Autowired
	private CaasDao dao;

	@Override
	public PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount) {
		return dao.getSearchPage(sqlData, sqlDataCount, map);
	}

	@Override
	public Object saveAddEnterprise(Map<String, Object> map) {
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
			result.put("result", "true");
		} catch (Exception e) {
			logger.error("增加角色错误：", e);
			result.put("result", "false");
			result.put("msg", "系统错误");
		}
		return result;
	}

	@Override
	public Map<String, Object> getEnterprise(Map<String, Object> map) {
		return dao.getOneInfo("user.getUser", map);
	}

	@Override
	public void updateEnterpriseStatus(Map<String, Object> map) {
		dao.update("enterprise.updateEnterpriseStatus", map);
	}
}
