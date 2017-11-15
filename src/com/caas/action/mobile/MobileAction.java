package com.caas.action.mobile;

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
import com.caas.service.mobile.MobileService;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
@Controller
@Results({ @Result(name = "mobileList", location = "/WEB-INF/content/mobile/listMobile.jsp"),
	@Result(name = "addMobile", location = "/WEB-INF/content/mobile/addMobile.jsp"),
	@Result(name = "editMobile", location = "/WEB-INF/content/mobile/editMobile.jsp"),
	@Result(name = "mobileExamine", location = "/WEB-INF/content/mobile/mobileExamine.jsp") })
public class MobileAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1383097107338406933L;

	private static final Logger logger = LogManager.getLogger(MobileAction.class);

	@Autowired
	private MobileService service;
	
	@Autowired
	private CaasDao dao;

	/*
	 * 号码管理
	 */
	@Action("/mobile/mobileList")
	public String mobileList() {
		data = StrutsUtils.getFormData();
		return "mobileList";
	}

	@Action("/mobile/mobileListData")
	public void mobileListData() {
		deal("mobile.mobileListData", "mobile.mobileListDataCount");
	}

	@Action("/mobile/deleteMobile")
	public void deleteMobile() {
		data = StrutsUtils.getFormData();
		try {
			service.deleteMobile(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}
	
	@Action("/mobile/recoverMobile")
	public void recoverMobile() {
		data = StrutsUtils.getFormData();
		try {
			service.recoverMobile(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/mobile/batchDeleteMobile")
	public void batchDeleteMobile() {
		data = StrutsUtils.getFormData();
		try {
			service.batchDeleteMobile(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/mobile/addMobile")
	public String addMobile() {
		List<Map<String, Object>> cityMap = dao.selectList("number.getAllCity", null);
		StrutsUtils.getRequest().setAttribute("cityMap", cityMap);
		
		List<Map<String, Object>> apiMap = dao.selectList("number.getAllApi", null);
		StrutsUtils.getRequest().setAttribute("apiMap", apiMap);
		
		List<Map<String, Object>> rateMap = dao.selectList("mobile.getAllRate", null);
		StrutsUtils.getRequest().setAttribute("rateMap", rateMap);
		return "addMobile";
	}

	@Action("/mobile/saveAddMobile")
	public void saveAddMobile() {
		data = StrutsUtils.getFormDataObj();
		Object obj = service.saveAddMobile(data);
		StrutsUtils.renderJson(obj);
	}

	@Action("/mobile/editMobile")
	public String editMobile() {
		data = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getMobile(data);
		List<Map<String, Object>> rateMap = dao.selectList("mobile.getAllRate", null);
		StrutsUtils.getRequest().setAttribute("rateMap", rateMap);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editMobile";
	}

	@Action("/mobile/saveEditMobile")
	public void saveEditMobile() {
		data = StrutsUtils.getFormData();
		try {
			service.saveEditMobile(data);
			Map<String, Object> returnMap = service.getMobile(data);
			StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
			StrutsUtils.renderText("true");
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderText("false");
		}
	}
	
	@Action("/mobile/mobileExamine")
	public String mobileExamine() {
		data = StrutsUtils.getFormData();
		return "mobileExamine";
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
