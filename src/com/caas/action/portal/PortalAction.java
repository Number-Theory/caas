package com.caas.action.portal;


import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;

/** 
 * @author 鄢俊
 * @version 创建时间：2017-10-28 下午10:19:36 
 * 类说明 
 */
@Controller
@Results({ 
	@Result(name = "portal", location = "/WEB-INF/content/homePage.jsp"),
	@Result(name = "aboutUs", location = "/WEB-INF/content/aboutUs.jsp"),
	@Result(name = "production", location = "/WEB-INF/content/production.jsp")
})
public class PortalAction extends BaseAction{

	@Action("/homePage/portal")
	public String portal(){
		return "portal";
	}
	
	@Action("/homePage/aboutUs")
	public String aboutUs(){
		return "aboutUs";
	}
	
	@Action("/homePage/production")
	public String production(){
		return "production";
	}
}
