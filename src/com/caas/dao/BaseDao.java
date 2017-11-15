package com.caas.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.math.NumberUtils;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.caas.model.PageContainer;

/**
 * dao类的基类
 * 
 * @author xupiao 2017年2月5日
 *
 */
public abstract class BaseDao {
	private final Logger logger = LoggerFactory.getLogger(BaseDao.class);
	protected SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 设置SqlSessionTemplate
	 * 
	 * @param sqlSessionTemplate
	 */
	protected abstract void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate);

	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	/**
	 * 查询List
	 * 
	 * @param queryStr
	 * @param params
	 * @return
	 */
	public <T> List<T> selectList(String queryStr, Object params) {
		return sqlSessionTemplate.selectList(queryStr, params);
	}

	/**
	 * 查询List
	 * 
	 * @param queryStr
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> getSearchList(String queryStr, Object params) {
		List<Map<String, Object>> list = sqlSessionTemplate.selectList(queryStr, params);
		return list;
	}

	/**
	 * 返回List
	 * 
	 * @param queryStr
	 * @param params
	 * @return
	 */
	public List<String> getSearchReturnList(String queryStr, Object params) {
		List<String> list = sqlSessionTemplate.selectList(queryStr, params);
		return list;
	}

	/**
	 * 计算列表总数
	 * 
	 * @param countStr
	 * @param params
	 * @return
	 */
	public int getSearchSize(String countStr, Object params) {
		int totalCount = 0;
		List<Map<String, Object>> list = sqlSessionTemplate.selectList(countStr, params);
		if (list.size() > 0) {
			totalCount = Integer.parseInt(list.get(0).get("totalCount").toString());
		}
		return totalCount;
	}

	/**
	 * 分页查询
	 * 
	 * @param queryStr
	 * @param countStr
	 * @param params
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageContainer getSearchPage(String queryStr, String countStr, Map params) {
		PageContainer p = new PageContainer();
		if (params.containsKey("rows")) {
			Object pageRowCount = params.get("rows");
			if (pageRowCount != null && !pageRowCount.equals("")) {
				p.setPageRowCount(Integer.parseInt(pageRowCount.toString()));
			}
		}
		int totalCount = 0;
		try {
			totalCount = getSearchSize(countStr, params);
		} catch (Exception e) {
			logger.debug("【查询异常】" + e);
		}
		p.setTotalCount(totalCount);
		if (totalCount > 0) {
			String pageRowCountS = params.get("rows") != null ? params.get("rows").toString() : null;
			if (NumberUtils.isDigits(pageRowCountS)) {
				int pageRowCount = Integer.parseInt(pageRowCountS);
				if (pageRowCount > 0) {
					p.setPageRowCount(pageRowCount);
				}
			}
			int totalPage = totalCount / p.getPageRowCount() + (totalCount % p.getPageRowCount() == 0 ? 0 : 1);
			p.setTotalPage(totalPage);

			String currentPageS = params.get("page") != null ? params.get("page").toString() : null;
			if (NumberUtils.isDigits(currentPageS)) {
				int currentPage = Integer.parseInt(currentPageS);
				if (currentPage > 0 && currentPage <= totalPage) {
					p.setCurrentPage(currentPage);
				}
			}

			Object orderName = params.get("orderName");
			orderName = orderName == null ? "" : " order by " + orderName;
			String start = (String) (params.get("start") == null ? "0" : params.get("start"));
			String length = (String) (params.get("length") == null ? "10" : params.get("length"));
			String limit = " limit " + start + "," + Integer.parseInt(length);
			params.put("limit", limit);

			List<Map<String, Object>> list = getSearchList(queryStr, params);
			p.setList(list);
		}
		return p;
	}

	
	
	
	/**
	 * 插入SQL执行
	 * 
	 * @param insertStr
	 * @param params
	 * @return
	 */
	public int insert(String insertStr, Object params) {
		return sqlSessionTemplate.insert(insertStr, params);
	}

	/**
	 * 更新SQL执行
	 * 
	 * @param updateStr
	 * @param params
	 * @return
	 */
	public int update(String updateStr, Object params) {
		return sqlSessionTemplate.update(updateStr, params);
	}

	/**
	 * 删除SQL执行
	 * 
	 * @param updateStr
	 * @param params
	 * @return
	 */
	public int delete(String updateStr, Object params) {
		return sqlSessionTemplate.delete(updateStr, params);
	}

	/**
	 * 根据条件返回单个对象
	 * 
	 * @param queryStr
	 * @param params
	 * @return
	 */
	public <T> T getOneInfo(String queryStr, Object params) {
		return sqlSessionTemplate.selectOne(queryStr, params);
	}

}
