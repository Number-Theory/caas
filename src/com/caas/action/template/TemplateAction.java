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
import com.caas.service.template.TemplateService;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author hl 2017年9月9日
 *
 */
@Controller
@Results({ @Result(name = "templateList", location = "/WEB-INF/content/template/listTemplate.jsp"),
		@Result(name = "addTemplate", location = "/WEB-INF/content/template/addTemplate.jsp"),
		@Result(name = "editTemplate", location = "/WEB-INF/content/template/editTemplate.jsp") })
public class TemplateAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4538828482364493087L;

	private static final Logger logger = LogManager.getLogger(TemplateAction.class);

	@Autowired
	private TemplateService service;

	/*
	 * 模板管理
	 */
	@Action("/template/templateList")
	public String templateList() {
		return "templateList";
	}

	@Action("/template/templateListData")
	public void templateListData() {
		deal("template.templateListData", "template.templateListDataCount");
	}

	@Action("/template/deleteTemplate")
	public void deleteTemplate() {
		data = StrutsUtils.getFormData();
		try {
			service.deleteTemplate(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/template/batchDeleteTemplate")
	public void batchDeleteTemplate() {
		data = StrutsUtils.getFormData();
		try {
			service.batchDeleteTemplate(data);
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("{}", e);
			StrutsUtils.renderJson(false);
		}
	}

	@Action("/template/addTemplate")
	public String addTemplate() {
		return "addTemplate";
	}

	@Action("/template/saveAddTemplate")
	public void saveAddTemplate() {
		data = StrutsUtils.getFormDataObj();
		String obj = service.saveAddTemplate(data);
		StrutsUtils.renderJson(obj);
	}

	@Action("/template/editTemplate")
	public String editTemplate() {
		data = StrutsUtils.getFormDataObj();
		Map<String, Object> returnMap = service.getTemplate(data);
		StrutsUtils.getRequest().setAttribute("returnMap", returnMap);
		return "editTemplate";
	}

	@Action("/template/saveEditTemplate")
	public void saveEditTemplate() {
		data = StrutsUtils.getFormData();
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
		PageContainer page = service.csmData(data, sqlData, sqlDataCount);

		PageModel pageModel = new PageModel();
		pageModel.setTotal(page.getTotalCount());
		pageModel.setRows(page.getList());

		StrutsUtils.renderJson(pageModel);
	}
}
