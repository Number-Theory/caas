package com.caas.action.template;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.model.PageContainer;
import com.caas.model.PageModel;
import com.caas.service.template.UserTemplateService;
import com.caas.util.AuthorityUtils;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author hl 2017年9月9日
 *
 */
@Controller
@Results({ @Result(name = "templateList", location = "/WEB-INF/content/template/listUserTemplate.jsp"),
		@Result(name = "addTemplate", location = "/WEB-INF/content/template/addUserTemplate.jsp"),
		@Result(name = "editTemplate", location = "/WEB-INF/content/template/editUserTemplate.jsp") })
public class UserTemplateAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4538828482364493087L;

	private static final Logger logger = LogManager.getLogger(UserTemplateAction.class);

	@Autowired
	private UserTemplateService service;

	/*
	 * 模板管理
	 */
	@Action("/userTemplate/templateList")
	public String templateList() {
		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		return "templateList";
	}

	@Action("/userTemplate/templateListData")
	public void templateListData() {
		deal("userTemplate.templateListData", "userTemplate.templateListDataCount");
	}

	@Action("/userTemplate/deleteTemplate")
	public void deleteTemplate() {
		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		try {
			service.deleteTemplate(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/userTemplate/batchDeleteTemplate")
	public void batchDeleteTemplate() {
		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		try {
			service.batchDeleteTemplate(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/userTemplate/addTemplate")
	public String addTemplate() {
		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		return "addTemplate";
	}

	@Action("/userTemplate/saveAddTemplate")
	public void saveAddTemplate() {
		data = StrutsUtils.getFormDataObj();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		String obj = service.saveAddTemplate(data);
		StrutsUtils.renderJson(obj);
	}

	@Action("/userTemplate/editTemplate")
	public String editTemplate() {
		data = StrutsUtils.getFormDataObj();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		Map<String, Object> returnMap = service.getTemplate(data);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editTemplate";
	}

	@Action("/userTemplate/saveEditTemplate")
	public void saveEditTemplate() {
		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		try {
			service.saveEditTemplate(data);
			Map<String, Object> returnMap = service.getTemplate(data);
			StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
			StrutsUtils.renderText("true");
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderText("false");
		}
	}

	// 处理表格
	public void deal(String sqlData, String sqlDataCount) {
		data = StrutsUtils.getFormData();
		data.put("userId", AuthorityUtils.getLoginUserIdNew());
		PageContainer page = service.csmData(data, sqlData, sqlDataCount);

		PageModel pageModel = new PageModel();
		pageModel.setTotal(page.getTotalCount());
		pageModel.setRows(page.getList());

		StrutsUtils.renderJson(pageModel);
	}
}
