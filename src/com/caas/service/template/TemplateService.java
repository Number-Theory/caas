package com.caas.service.template;

import java.util.Map;

import com.caas.model.PageContainer;
/**
 * 
 * @author hl 2017年9月9日
 *
 */
public interface TemplateService {
	
	PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount);
	
	/*
	 * 模板管理
	 */
	void deleteTemplate(Map<String, Object> param);

	void batchDeleteTemplate(Map<String, Object> param);

	String saveAddTemplate(Map<String, Object> map);

	Map<String, Object> getTemplate(Map<String, Object> map);

	void saveEditTemplate(Map<String, Object> map);

	void updateTemplateStatus(Map<String, Object> map);
}
