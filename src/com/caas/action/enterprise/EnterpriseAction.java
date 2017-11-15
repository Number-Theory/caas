package com.caas.action.enterprise;

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
import com.caas.service.enterprise.EnterpriseService;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author hexinqi 2017-09-11 企业信息列表
 */
@Controller
@Results({ @Result(name = "enterpriseList", location = "/WEB-INF/content/enterprise/listEnterprise.jsp"),
		@Result(name = "enterpriseUser", location = "/WEB-INF/content/enterprise/enterpriseUser.jsp") })
public class EnterpriseAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private static final Logger logger = LogManager.getLogger(EnterpriseAction.class);

	@Autowired
	private EnterpriseService service;

	@Autowired
	private CaasDao dao;

	/*
	 * 待认证企业页面
	 */
	@Action("/enterprise")
	public String enterpriseList() {
		return "enterpriseList";
	}

	/**
	 * 待认证企业列表
	 */
	@Action("/enterprise/list")
	public void enterpriseListData() {
		deal("enterprise.enterpriseListData", "enterprise.enterpriseListDataCount");
	}

	@Action("/enterprise/auth")
	public String authAnterprise() {
		data = StrutsUtils.getFormData();
		Map<String, Object> oauth = dao.getOneInfo("user.getUserAuthenticationById", data);
		StrutsUtils.setAttribute("oauth", oauth);
		return "enterpriseUser";
	}

	@Action("/enterprise/update")
	public void updateAnterprise() {
		data = StrutsUtils.getFormData();
		try {
			service.updateEnterpriseStatus(data);
			StrutsUtils.renderJson("true");
		} catch (Exception e) {
			logger.error("审核失败：", e);
			StrutsUtils.renderJson("false");
		}
	}

	// 处理表格
	public void deal(String sqlData, String sqlDataCount) {
		logger.info("list enterprise by SQL: " + sqlData + " and " + sqlDataCount);
		Map<String, Object> map = StrutsUtils.getFormData();
		PageContainer page = service.csmData(map, sqlData, sqlDataCount);

		PageModel pageModel = new PageModel();
		pageModel.setTotal(page.getTotalCount());
		pageModel.setRows(page.getList());

		StrutsUtils.renderJson(pageModel);
	}
}
