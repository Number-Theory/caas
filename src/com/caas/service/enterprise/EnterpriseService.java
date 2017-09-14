package com.caas.service.enterprise;

import java.util.Map;

import com.caas.model.PageContainer;

/**
 * @author hexinqi 2017-09-11
 *
 */
public interface EnterpriseService {
	PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount);

	Object saveAddEnterprise(Map<String, Object> map);

	Map<String, Object> getEnterprise(Map<String, Object> map);

	void updateEnterpriseStatus(Map<String, Object> map);
}
