package com.caas.action.mobile;

import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.caas.util.MD5Util;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年8月2日
 *
 */
@Controller
@Results({ @Result(name = "mobileList", location = "/WEB-INF/content/mobile/listMobile.jsp"),
	@Result(name = "addMobile", location = "/WEB-INF/content/mobile/addMobile.jsp"),
	@Result(name = "editMobile", location = "/WEB-INF/content/mobile/editMobile.jsp") })
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
		return "mobileList";
	}

	@Action("/mobile/mobileListData")
	public void mobileListData() {
		deal("mobile.mobileListData", "mobile.mobileListDataCount");
	}

	@Action("/mobile/deleteMobile")
	public void deleteMobile() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.deleteMobile(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/mobile/batchDeleteMobile")
	public void batchDeleteMobile() {
		Map<String, Object> param = StrutsUtils.getFormData();
		try {
			service.batchDeleteMobile(param);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/mobile/addMobile")
	public String addMobile() {
		List<Map<String, Object>> roleMap = dao.selectList("menu.getAllRole", null);
		StrutsUtils.getRequest().setAttribute("roleMap", roleMap);
		return "addMobile";
	}

	@Action("/mobile/saveAddMobile")
	public void saveAddMobile() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		map.put("sid", UUID.randomUUID().toString().replaceAll("-", ""));
		map.put("token", UUID.randomUUID().toString().replaceAll("-", ""));
		map.put("createType", "1");
		map.put("mobilePwd", MD5Util.string2MD5("123456").toUpperCase());
		Object obj = service.saveAddMobile(map);
		StrutsUtils.renderJson(obj);
	}

	@Action("/mobile/editMobile")
	public String editMobile() {
		Map<String, Object> map = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getMobile(map);
		List<Map<String, Object>> roleMap = dao.selectList("menu.getAllRole", null);
		StrutsUtils.getRequest().setAttribute("roleMap", roleMap);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editMobile";
	}

	@Action("/mobile/saveEditMobile")
	public void saveEditMobile() {
		Map<String, Object> map = StrutsUtils.getFormData();
		try {
			service.saveEditMobile(map);
			Map<String, Object> returnMap = service.getMobile(map);
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
