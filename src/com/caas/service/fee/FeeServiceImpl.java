package com.caas.service.fee;

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
public class FeeServiceImpl implements FeeService {
	private static final Logger logger = LogManager.getLogger(FeeServiceImpl.class);
	@Autowired
	private CaasDao dao;

	@Override
	public PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount) {
		return dao.getSearchPage(sqlData, sqlDataCount, map);
	}

	/*
	 * 号码管理(non-Javadoc)
	 * 
	 * @see com.caas.service.fee.FeeService#deleteFee(java.util.Map)
	 */
	@Override
	public void deleteFee(Map<String, Object> param) {
		dao.delete("fee.deleteFee", param);
	}

	@Override
	public void batchDeleteFee(Map<String, Object> param) {
		dao.delete("fee.batchDeleteFee", param);
	}

	@Override
	public Object saveAddFee(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			dao.insert("fee.saveAddFee", map);
			result.put("result", "true");
		} catch (Exception e) {
			logger.error("增加费率错误：", e);
			result.put("result", "false");
			result.put("msg", "系统错误");
		}
		return result;
	}

	@Override
	public Map<String, Object> getFee(Map<String, Object> map) {
		return dao.getOneInfo("fee.getFee", map);
	}

	@Override
	public void saveEditFee(Map<String, Object> map) {
		dao.update("fee.saveEditFee", map);
	}

	@Override
	public void updateFeeStatus(Map<String, Object> map) {
		dao.update("fee.updateFeeStatus", map);
	}
}
