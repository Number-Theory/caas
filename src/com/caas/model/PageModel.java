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
public class PageModel implements Serializable {
	private static final long serialVersionUID = 8976331697912229579L;
	
	//新增的字段用于返回给bootstrap table组件
	private Integer total = 0; // 总个数
	private List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();// 查询结果

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<Map<String, Object>> getRows() {
		return rows;
	}

	public void setRows(List<Map<String, Object>> rows) {
		this.rows = rows;
	}

}
