package com.caas.action.number;

import java.util.ArrayList;
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
import com.caas.service.number.NumberService;
import com.caas.util.AuthorityUtils;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年7月31日
 *
 */
@Controller
@Results({ @Result(name = "numberList", location = "/WEB-INF/content/number/listNumber.jsp"),
		@Result(name = "applyNumberList", location = "/WEB-INF/content/number/listApplyNumber.jsp"),
		@Result(name = "addNumber", location = "/WEB-INF/content/number/addNumber.jsp"),
		@Result(name = "editNumber", location = "/WEB-INF/content/number/editNumber.jsp"),
		@Result(name = "roleList", location = "/WEB-INF/content/number/listRole.jsp"),
		@Result(name = "addRole", location = "/WEB-INF/content/number/addRole.jsp"),
		@Result(name = "editRole", location = "/WEB-INF/content/number/editRole.jsp"),
		@Result(name = "numberRate", location = "/WEB-INF/content/number/numberRate.jsp"),
		@Result(name = "applyNumber", location = "/WEB-INF/content/number/applyNumber.jsp")

})
public class NumberAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5051185935625073083L;

	private static final Logger logger = LogManager.getLogger(NumberAction.class);

	@Autowired
	private NumberService service;

	@Autowired
	private CaasDao dao;

	private List<Map<String, Object>> feeMap = new ArrayList<Map<String, Object>>();

	private List<Map<String, Object>> cityMap = new ArrayList<Map<String, Object>>();

	/*
	 * 菜单管理
	 */
	@Action("/number/numberList")
	public String numberList() {
		data = StrutsUtils.getFormData();
		if (!data.containsKey("userId")) {
			data.put("userId", AuthorityUtils.getLoginUserIdNew());
		}
		String authStatus = dao.getOneInfo("number.getUserAuthStatus", data) ;
		data.put("authStatus", authStatus);
		return "numberList";
	}

	@Action("/number/numberListData")
	public void numberListData() {
		deal("number.numberListData", "number.numberListDataCount");
	}

	@Action("/number/deleteNumber")
	public void deleteNumber() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.deleteNumber(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/number/batchDeleteNumber")
	public void batchDeleteNumber() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.batchDeleteNumber(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/number/addNumber")
	public String addNumber() {
		return "addNumber";
	}

	@Action("/number/saveAddNumber")
	public void saveAddNumber() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Object obj = service.saveAddNumber(map);
		StrutsUtils.renderJson(obj);
	}

	@Action("/number/editNumber")
	public String editNumber() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getNumber(map);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editNumber";
	}

	@Action("/number/saveEditNumber")
	public void saveEditNumber() {
		Map<String, Object> map = StrutsUtils.getFormData();
		try {
			service.saveEditNumber(map);
			Map<String, Object> returnMap = service.getNumber(map);
			StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
			StrutsUtils.renderText("true");
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderText("false");
		}
	}

	@Action("/number/numberRate")
	public String numberRate() {
		data = StrutsUtils.getFormData();
		Map<String, Object> rateMap = dao.getOneInfo("number.getNumberRate", data);
		StrutsUtils.getRequest().setAttribute("rateMap", rateMap);
		return "numberRate";
	}

	@Action("/number/applyNumber")
	public String applyNumber() {
		data = StrutsUtils.getFormData();
		feeMap = dao.selectList("number.getFeeMap", data);
		cityMap = dao.selectList("number.getAllCity", null);
		return "applyNumber";
	}

	@Action("/number/addApplyNumber")
	public String addApplyNumber() {
		data = StrutsUtils.getFormData();
		try {
			System.out.println(data);
			data.put("userId", AuthorityUtils.getLoginUserIdNew());
			service.applyNumber(data);
			feeMap = dao.selectList("number.getFeeMap", data);
			cityMap = dao.selectList("number.getAllCity", null);
			data.put("msg", "申请成功");
		} catch (Exception e) {
			data.put("msg", "申请失败");
		}
		return "applyNumber";
	}

	@Action("/number/applyNumberListData")
	public void applyNumberListData() {
		deal("number.applyNumberListData", "number.applyNumberListDataCount");
	}

	@Action("/number/applyNumberList")
	public String applyNumberList() {
		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		return "applyNumberList";
	}
	// 处理表格
	public void deal(String sqlData, String sqlDataCount) {
		Map<String, Object> map = StrutsUtils.getFormData();
//		if (!map.containsKey("userId")) {
//			map.put("userId", AuthorityUtils.getLoginUserIdNew());
//		}
		PageContainer page = service.csmData(map, sqlData, sqlDataCount);

		PageModel pageModel = new PageModel();
		pageModel.setTotal(page.getTotalCount());
		pageModel.setRows(page.getList());

		StrutsUtils.renderJson(pageModel);
	}

	public List<Map<String, Object>> getFeeMap() {
		return feeMap;
	}

	public void setFeeMap(List<Map<String, Object>> feeMap) {
		this.feeMap = feeMap;
	}

	public List<Map<String, Object>> getCityMap() {
		return cityMap;
	}

	public void setCityMap(List<Map<String, Object>> cityMap) {
		this.cityMap = cityMap;
	}

}
