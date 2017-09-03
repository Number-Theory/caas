package com.caas.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.caas.model.PageContainer;
import com.caas.util.Des3Utils;
import com.caas.util.JsonUtil;
import com.caas.util.StrutsUtils;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 
 * @author xupiao 2017年1月19日
 *
 */
public class BaseAction extends ActionSupport {
	private static final Logger logger = LogManager.getLogger(BaseAction.class);
	
	private static final long serialVersionUID = -6024322463400978622L;

	/**
	 * 分页信息
	 */
	protected PageContainer pagecontainer;

	/**
	 * 返回数据
	 */
	protected Map<String, Object> data;

	/**
	 * 返回数据
	 */
	protected List<Map<String, Object>> dataList;

	/**
	 * 请求页面，用于返回刷新
	 */
	private String referer;

	/**
	 * 导出Excel的sql
	 */
	protected String excelSqlParams;
	/**
	 * jqGrid参数
	 */
	private Integer rows = 0;  
    private Integer page = 0;  
	  

	public PageContainer getPageContainer() {
		return pagecontainer;
	}

	public void setPageContainer(PageContainer page) {
		this.pagecontainer = page;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	public String getReferer() {
		referer = StrutsUtils.getReferer();
		return referer;
	}

	public void setReferer(String referer) {
		this.referer = referer;
	}

	public List<Map<String, Object>> getDataList() {
		return dataList;
	}

	public void setDataList(List<Map<String, Object>> dataList) {
		this.dataList = dataList;
	}

	public String getExcelSqlParams() {
		return excelSqlParams;
	}

	public void setExcelSqlParams(String excelSqlParams) {
		this.excelSqlParams = excelSqlParams;
	}
	
	//打印后台输出编码
	protected void printMsg(String code){
		try {
			StrutsUtils.getResponse().setContentType("text/html; charset=utf-8");
			PrintWriter pw = StrutsUtils.getResponse().getWriter();
			pw.write(code);
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
			logger.error("--------------------------打印后台输出编码错误----------------------------",e);
			logger.error(e.getMessage());
		}
	}

	public String buildSql(Map<String, Object> map) {
		if (map == null) {
			return null;
		}
		String str = JsonUtil.toJsonStr(map);
		return Des3Utils.encodeDes3(str);
	}

	public String buildSqlObj(Map<String, Object> map) {
		if (map == null) {
			return null;
		}
		String str = JsonUtil.toJsonStr(map);
		return Des3Utils.encodeDes3(str);
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Integer getPage(){
		return page;
	}
	
	public void setPage(Integer page) {
		this.page = page;
	}
	
	
}
