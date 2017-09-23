package com.caas.service.fee;

import java.util.Map;

import com.caas.model.PageContainer;
/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
public interface FeeService {
	PageContainer csmData(Map<String, Object> map, String sqlData, String sqlDataCount);

	/*
	 * 用户管理
	 */
	void deleteFee(Map<String, Object> param);

	void batchDeleteFee(Map<String, Object> param);

	Object saveAddFee(Map<String, Object> map);

	Map<String, Object> getFee(Map<String, Object> map);

	void saveEditFee(Map<String, Object> map);

	void updateFeeStatus(Map<String, Object> map);
}
