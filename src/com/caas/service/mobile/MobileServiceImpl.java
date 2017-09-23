package com.caas.service.mobile;

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
public class MobileServiceImpl implements MobileService {
	private static final Logger logger = LogManager.getLogger(MobileServiceImpl.class);
	@Autowired
	private CaasDao dao;

	@Override
	public PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount) {
		return dao.getSearchPage(sqlData, sqlDataCount, map);
	}

	/*
	 * 号码管理(non-Javadoc)
	 * 
	 * @see com.caas.service.mobile.MobileService#deleteMobile(java.util.Map)
	 */
	@Override
	public void deleteMobile(Map<String, Object> param) {
		dao.delete("mobile.deleteMobile", param);
	}

	@Override
	public void batchDeleteMobile(Map<String, Object> param) {
		dao.delete("mobile.batchDeleteMobile", param);
	}

	@Override
	public Object saveAddMobile(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Map<String, Object> mobile = dao.getOneInfo("mobile.getMobileByMobile", map);
			if(mobile != null && !mobile.isEmpty()) {
				result.put("result", "false");
				result.put("msg", ",号码已存在");
				return result;
			}
			
			dao.insert("mobile.saveAddMobile", map);
			result.put("result", "true");
		} catch (Exception e) {
			logger.error("增加号码错误：", e);
			result.put("result", "false");
			result.put("msg", "系统错误");
		}
		return result;
	}

	@Override
	public Map<String, Object> getMobile(Map<String, Object> map) {
		return dao.getOneInfo("mobile.getMobile", map);
	}

	@Override
	public void saveEditMobile(Map<String, Object> map) {
		dao.update("mobile.saveEditMobile", map);
	}

	@Override
	public void updateMobileStatus(Map<String, Object> map) {
		dao.update("mobile.updateMobileStatus", map);
	}
}
