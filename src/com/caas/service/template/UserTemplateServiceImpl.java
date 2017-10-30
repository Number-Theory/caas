package com.caas.service.template;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.caas.dao.CaasDao;
import com.caas.model.PageContainer;

/**
 * 
 * @author hl 2017年9月9日
 *
 */
@Service
public class UserTemplateServiceImpl implements UserTemplateService {

	private static final Logger logger = LogManager.getLogger(UserTemplateServiceImpl.class);

	@Autowired
	private CaasDao dao;

	@Override
	public PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount) {
		return dao.getSearchPage(sqlData, sqlDataCount, map);
	}

	/*
	 * 模板管理(non-Javadoc)
	 * 
	 * @see com.caas.service.template.TemplateService#deleteTemplate(java.util.Map)
	 */
	@Override
	public void deleteTemplate(Map<String, Object> param) {
		dao.delete("userTemplate.deleteTemplate", param);
	}

	@Override
	public void batchDeleteTemplate(Map<String, Object> param) {
		dao.delete("userTemplate.batchDeleteTemplate", param);
	}

	@Override
	public String saveAddTemplate(Map<String, Object> map) {
		try {
			dao.insert("userTemplate.saveAddTemplate", map);
			return "true";
		} catch (Exception e) {
			logger.error("增加模板错误：", e);
			return "false";
		}
	}

	@Override
	public Map<String, Object> getTemplate(Map<String, Object> map) {
		return dao.getOneInfo("userTemplate.getTemplate", map);
	}

	@Override
	public void saveEditTemplate(Map<String, Object> map) {
		dao.update("userTemplate.saveEditTemplate", map);
	}

	@Override
	public void updateTemplateStatus(Map<String, Object> map) {
		dao.update("userTemplate.updateTemplateStatus", map);
	}
}
