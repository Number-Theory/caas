package com.caas.action.fee;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.dao.CaasDao;
import com.caas.model.PageContainer;
import com.caas.model.PageModel;
import com.caas.service.fee.FeeService;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
@Controller
@Results({ @Result(name = "feeList", location = "/WEB-INF/content/fee/listFee.jsp"),
	@Result(name = "addFee", location = "/WEB-INF/content/fee/addFee.jsp"),
	@Result(name = "editFee", location = "/WEB-INF/content/fee/editFee.jsp") })
public class FeeAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1383097107338406933L;

	private static final Logger logger = LogManager.getLogger(FeeAction.class);

	@Autowired
	private FeeService service;
	
	@Autowired
	private CaasDao dao;

	/*
	 * 号码管理
	 */
	@Action("/fee/feeList")
	public String feeList() {
		data = StrutsUtils.getFormData();
		return "feeList";
	}

	@Action("/fee/feeListData")
	public void feeListData() {
		deal("fee.feeListData", "fee.feeListDataCount");
	}

	@Action("/fee/deleteFee")
	public void deleteFee() {
		data = StrutsUtils.getFormData();
		try {
			service.deleteFee(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/fee/batchDeleteFee")
	public void batchDeleteFee() {
		data = StrutsUtils.getFormData();
		try {
			service.batchDeleteFee(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/fee/addFee")
	public String addFee() {
		List<Map<String, Object>> cityMap = dao.selectList("number.getAllCity", null);
		StrutsUtils.getRequest().setAttribute("cityMap", cityMap);
		return "addFee";
	}

	@Action("/fee/saveAddFee")
	public void saveAddFee() {
		data = StrutsUtils.getFormDataObj();
		Object obj = service.saveAddFee(data);
		StrutsUtils.renderJson(obj);
	}

	@Action("/fee/editFee")
	public String editFee() {
		data = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getFee(data);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editFee";
	}

	@Action("/fee/saveEditFee")
	public void saveEditFee() {
		data = StrutsUtils.getFormData();
		try {
			service.saveEditFee(data);
			Map<String, Object> returnMap = service.getFee(data);
			StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
			StrutsUtils.renderText("true");
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderText("false");
		}
	}

	// 处理表格
	public void deal(String sqlData, String sqlDataCount) {
		Map<String, Object> map = StrutsUtils.getFormData();
		PageContainer page = service.csmData(map, sqlData, sqlDataCount);

		PageModel pageModel = new PageModel();
		pageModel.setTotal(page.getTotalCount());
		pageModel.setRows(page.getList());

		StrutsUtils.renderJson(pageModel);
	}
}
