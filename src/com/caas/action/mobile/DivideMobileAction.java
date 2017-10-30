package com.caas.action.mobile;

import java.util.HashMap;
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
 * @author xupiao 2017年9月26日
 *
 */
@Controller
@Results({ @Result(name = "devideMobile", location = "/WEB-INF/content/mobile/devideMobile.jsp") })
public class DivideMobileAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1383097107338406933L;

	private static final Logger logger = LogManager.getLogger(DivideMobileAction.class);

	@Autowired
	private MobileService service;

	@Autowired
	private CaasDao dao;

	private Map<String, Object> applyMap = new HashMap<String, Object>();

	@Action("/devide/devideMobile")
	public String devideMobile() {
		data = StrutsUtils.getFormData();
		applyMap = dao.getOneInfo("number.getOneApplyInfo", data);

		return "devideMobile";
	}

	@Action("/devide/saveDevideMobile")
	public void saveDevideMobile() {
		try {
			data = StrutsUtils.getFormData();

			String str = (String) data.get("str");
			String[] mobileIds = str.split(",");

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", data.get("id"));
			map.put("applyCount", mobileIds.length);
			dao.update("number.updateDevideStatus", map);

			applyMap = dao.getOneInfo("number.getDevideRateAndUserInfo", data);
			for (String mobileId : mobileIds) {
				applyMap.put("mobileId", mobileId);
				dao.update("number.devideMobileToUser", applyMap);
			}
			StrutsUtils.renderJson(true);
		} catch (Exception e) {
			logger.error("分配号码失败: ", e);
			StrutsUtils.renderJson(false);
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

	public Map<String, Object> getApplyMap() {
		return applyMap;
	}

	public void setApplyMap(Map<String, Object> applyMap) {
		this.applyMap = applyMap;
	}

}
