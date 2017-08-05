package com.caas.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 分页查询容器
 * 
 * @author xupiao
 */
public class PageContainer implements Serializable {
	private static final long serialVersionUID = 8976331697912229579L;

	private List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();// 查询结果
	private Integer currentPage = 1; // 当前页号
	private Integer totalPage = 1; // 总页数
	private Integer totalCount = 0;// 总行数
	private Integer pageRowCount = 10; // 每页显示行数
	
	//新增的字段用于返回给bootstrap table组件
	private Integer totlal = 0; // 总个数
	private List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();// 查询结果

	public List<Map<String, Object>> getList() {
		return list;
	}

	public void setList(List<Map<String, Object>> list) {
		this.list = list;
	}

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public Integer getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(Integer totalCount) {
		this.totalCount = totalCount;
	}

	public Integer getPageRowCount() {
		return pageRowCount;
	}

	public void setPageRowCount(Integer pageRowCount) {
		this.pageRowCount = pageRowCount;
	}

	public Integer getTotlal() {
		return totlal;
	}

	public void setTotlal(Integer totlal) {
		this.totlal = totlal;
	}

	public List<Map<String, Object>> getRows() {
		return rows;
	}

	public void setRows(List<Map<String, Object>> rows) {
		this.rows = rows;
	}

}
