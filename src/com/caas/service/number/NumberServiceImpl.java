package com.caas.service.number;

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
public class NumberServiceImpl implements NumberService {

	private static final Logger logger = LogManager.getLogger(NumberServiceImpl.class);

	@Autowired
	private CaasDao dao;

	@Override
	public PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount) {
		return dao.getSearchPage(sqlData, sqlDataCount, map);
	}

	/*
	 * 菜单管理(non-Javadoc)
	 * 
	 * @see com.caas.service.number.NumberService#deleteNumber(java.util.Map)
	 */
	@Override
	public void deleteNumber(Map<String, Object> param) {
		dao.delete("number.deleteNumber", param);
	}

	@Override
	public void batchDeleteNumber(Map<String, Object> param) {
		dao.delete("number.batchDeleteNumber", param);
	}

	@Override
	public Object saveAddNumber(Map<String, Object> map) {
		try {
			dao.insert("number.saveAddNumber", map);
			return "true";
		} catch (Exception e) {
			logger.error("增加角色错误：", e);
			return "false";
		}
	}

	@Override
	public Map<String, Object> getNumber(Map<String, Object> map) {
		return dao.getOneInfo("number.getNumber", map);
	}

	@Override
	public void saveEditNumber(Map<String, Object> map) {
		dao.update("number.saveEditNumber", map);
	}

	@Override
	public void updateNumberStatus(Map<String, Object> map) {
		dao.update("number.updateNumberStatus", map);
	}

	@Override
	public void applyNumber(Map<String, Object> data) {
		dao.insert("number.applyNumber", data);
	}
}
