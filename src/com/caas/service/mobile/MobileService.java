package com.caas.service.mobile;

import java.util.Map;

import com.caas.model.PageContainer;
/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
public interface MobileService {
	PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount);

	/*
	 * 用户管理
	 */
	void deleteMobile(Map<String, Object> param);

	void batchDeleteMobile(Map<String, Object> param);

	Object saveAddMobile(Map<String, Object> map);

	Map<String, Object> getMobile(Map<String, Object> map);

	void saveEditMobile(Map<String, Object> map);

	void updateMobileStatus(Map<String, Object> map);
}
