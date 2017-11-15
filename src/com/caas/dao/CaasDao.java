package com.caas.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

/**
 * 平台库的dao类
 * 
 * @author xupiao 2017年2月5日
 *
 */
@Repository
public class CaasDao extends BaseDao {

	@Override
	@Resource(name = "caas_sqlSessionTemplate")
	protected void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

}
