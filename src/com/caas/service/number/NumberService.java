package com.caas.service.number;

import java.util.Map;

import com.caas.model.PageContainer;
/**
 * 
 * @author xupiao 2017年7月31日
 *
 */
public interface NumberService {
	
	PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount);

	/*
	 * 号码管理
	 */
	void deleteNumber(Map<String, Object> param);

	void batchDeleteNumber(Map<String, Object> param);

	Object saveAddNumber(Map<String, Object> map);

	Map<String, Object> getNumber(Map<String, Object> map);

	void saveEditNumber(Map<String, Object> map);

	void updateNumberStatus(Map<String, Object> map);

	void applyNumber(Map<String, Object> data);
}
