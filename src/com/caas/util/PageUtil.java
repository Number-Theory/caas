package com.caas.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.caas.model.PageContainer;

public class PageUtil {
	public Map<String, Object> getPageMap(Map<String, Object> turnParamsMap2, long total, List<Map<String, Object>> data) {
		Map<String, Object> map = new HashMap<String, Object>();
		//map.put("draw", Integer.parseInt(turnParamsMap2.get("draw").toString()));
		map.put("recordsTotal", total);
		map.put("recordsFiltered", total);
		map.put("data", data);
		return map;
	}
	/**
	 * 
	 * @author CD
	 * 2017-5-2		
	 * @param turnParamsMap2
	 * @param totalPage
	 * @param totalCount
	 * @param data
	 * @return
	 * 将返回的page对象转换为jqGrid接收的格式
	 */
	public static Map<String, Object> getpageGridMap(PageContainer page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page.getCurrentPage());
		map.put("total", page.getTotalPage());
		map.put("records", page.getTotalCount());
		map.put("rows", page.getList());
		return map;
	}
}
