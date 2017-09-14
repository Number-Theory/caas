package com.caas.action.auth;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.caas.action.BaseAction;
import com.caas.dao.CaasDao;
import com.caas.service.user.UserService;
import com.caas.util.AuthorityUtils;
import com.caas.util.ConfigUtils;
import com.caas.util.FileUtil;
import com.caas.util.StrUtil;
import com.caas.util.StrutsUtils;

/**
 * 
 * @author xupiao 2017年8月22日
 *
 */
@Controller
@Scope("prototype")
@Results({ @Result(name = "dispComSuc", type = "redirectAction", location = "oAuthCompanyInfo"),
		@Result(name = "dispPersSuc", type = "redirectAction", location = "oAuthPersonalInfo"),
		@Result(name = "updatePersonPage", location = "/WEB-INF/content/user/psCertifyInfo.jsp"),
		@Result(name = "updateCompanyPage", location = "/WEB-INF/content/user/cpCertifyInfo.jsp"),
		@Result(name = "accountCertify", location = "/WEB-INF/content/user/accountCertify.jsp"),
		@Result(name = "toOauthSuc", location = "/WEB-INF/content/user/accountCertifyInfo.jsp"),
		@Result(name = "personalInfoSuc", location = "/WEB-INF/content/user/accountCertifyInfo.jsp"),
		@Result(name = "companyInfoSuc", location = "/WEB-INF/content/user/accountCertifyInfo.jsp") })
public class AuthAction extends BaseAction {

	@Autowired
	private UserService userService;

	private Map<String, Object> user;

	private Map<String, Object> oauth;

	private File idCardFile = null;
	private String idCardFileFileName;

	// 营业执照证件
	private File bsnumFile = null;
	private String bsnumFileFileName = null;

	@Autowired
	private CaasDao dao;

	/**
	 * 
	 */
	private static final long serialVersionUID = 6509092526741810595L;

	@Action("/user/accountCertify")
	public String accountCertify() {
		// 获取用户数据
		getUserInfo();

		return "accountCertify";
	}

	@Action("/user/oAuthDispather")
	public String oAuthDispather() {
		// 获取用户数据
		getAuthenticationInfo();

		if (oauth != null && !oauth.isEmpty()) {
			if ("1".equals(oauth.get("authenticationType"))) { // 个人
				return "dispPersSuc";
			} else if ("2".equals(oauth.get("authenticationType"))) {// 企业
				return "dispComSuc";
			}
		} else {
			return "toOauthSuc";
		}

		return "toOauthSuc";
	}

	/*------------------------------------------------查看个人信息--------------------------------------*/
	@Action("/user/oAuthPersonalInfo")
	public String oAuthPersonalInfo() {
		getUserInfo();
		getAuthenticationInfo();
		return "personalInfoSuc";
	}

	/*------------------------------------------------查看企业详情--------------------------------------*/
	@Action("/user/oAuthCompanyInfo")
	public String oAuthCompanyInfo() {
		getUserInfo();
		getAuthenticationInfo();
		return "companyInfoSuc";
	}

	/*------------------------------------------------跳转到更新个人信息页--------------------------------------*/
	@Action("/user/updatePerson")
	public String updatePsPage() {
		getUserInfo();
		getAuthenticationInfo();
		return "updatePersonPage";
	}

	/*------------------------------------------------跳转到更新企业信息页--------------------------------------*/
	@Action("/user/updateCompany")
	public String updateCpPage() {
		getUserInfo();
		getAuthenticationInfo();
		return "updateCompanyPage";
	}

	private boolean checkComp(Map<String, Object> oauth) {
		boolean boo = true;
		String name = (String) oauth.get("userName");
		String bsnumId = (String) oauth.get("enterpriseMaterialId");
		String address = (String) oauth.get("webSite");
		if (StrUtil.isEmpty(name) || StrUtil.isEmpty(address)) {
			boo = false;
		}
		if (StrUtil.constainsSymbol(name) || StrUtil.constainsSymbol(bsnumId) || StrUtil.constainsSymbol(address)
				|| StrUtil.checkJsForStr(name) || StrUtil.checkJsForStr(bsnumId) || StrUtil.checkJsForStr(address)) {
			boo = false;
		}
		return boo;
	}

	private boolean checkPer(Map<String, Object> user) {
		boolean boo = true;
		String name = (String) user.get("legalPerson");
		String idType = (String) user.get("idType");
		String idNbr = (String) user.get("legalPersonId");
		if (StrUtil.checkJsForStr(name) || StrUtil.checkJsForStr(idType) || StrUtil.checkJsForStr(idNbr)
				|| StrUtil.constainsSymbol(name) || StrUtil.constainsSymbol(idType) || StrUtil.constainsSymbol(idNbr)) {
			boo = false;
		}
		return boo;
	}

	/*------------------------------------------------个人认证--------------------------------------*/
	@Action("/user/oAuthPersonal")
	public String oAuthPersonal() {
		getUserInfo();
		if (!checkPer(oauth)) {
			StrUtil.writeMsg(StrutsUtils.getResponse(), "请输入合法的信息", null);
			return null;
		}
		String name = (String) user.get("legalPerson");
		boolean boo = StrUtil.constainsSymbol(name);
		if (boo) {
			StrUtil.writeMsg(StrutsUtils.getResponse(), "请输入合法的用户名", null);
			return null;
		}

		return "accountCertify";
	}

	@Action("/user/checkCompanyName")
	public void checkCompanyName() {
		data = StrutsUtils.getFormData();
		int count = dao.getOneInfo("user.checkCompanyName", data);
		StrutsUtils.renderJson(count);
	}

	@Action("/user/ckIDNumEnable")
	public void ckIDNumEnable() {
		data = StrutsUtils.getFormData();
		int count = dao.getOneInfo("user.ckIDNumEnable", data);
		StrutsUtils.renderJson(count);
	}

	/*------------------------------------------------企业认证--------------------------------------*/
	@Action("/user/oAuthCompany")
	public String oAuthCompany() {
		getUserInfo();
		oauth = StrutsUtils.getFormData(oauth);
		boolean boo = checkComp(oauth);
		if (!boo) {
			StrUtil.writeMsg(StrutsUtils.getResponse(), "认证信息不合法，请检查后重试.", null);
			return null;
		}
		String result = null;

		// 普通企业认证
		result = authComNormal();
		if (result == null) {
			StrUtil.writeMsg(StrutsUtils.getResponse(), "认证信息不合法，请检查后重试", null);
			return null;
		}
		if (!result.equals("success")) {
			StrUtil.writeMsg(StrutsUtils.getResponse(), result, null);
			return null;
		}

		return "accountCertify";
	}

	/*---------------------------------企业普通认证------------------------------*/
	public String authComNormal() {
		if(bsnumFile==null){
			return "认证证件图片不能为空" ;
		}
		
		if(checkPic(bsnumFile)==null){
			return null;
		}
		String suffix = bsnumFileFileName.substring(bsnumFileFileName.lastIndexOf(".")+1);
		String userId = AuthorityUtils.getLoginUserIdNew();
		Map<String, Object> temp = dao.getOneInfo("user.getUserAuthenticationByUserId", userId);
		if(temp != null && temp.containsKey("enterpriseMaterial")) {
			FileUtil.deleteFile((String)temp.get("enterpriseMaterial"));
			dao.delete("user.deleteUserAuthentication", userId);
		}
		String fileName = FileUtil.upload(bsnumFile, userId, ConfigUtils.auth_pic, suffix);
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.putAll(oauth);
		params.put("userId", userId);
		params.put("authenticationType", "2");
		params.put("enterpriseMaterial", fileName);
		params.put("status", "1");
		
		
		dao.insert("user.oAuthCompany", params);
		
		return "success";
	}
	
	private String checkPic(File file){
		//验证图片大小
		String result = FileUtil.checkFile(file,FileUtil.SYS_PIC_MAXSIZE);
		if(result!=null){
			return result;
		}
		//验证图片格式
		boolean imgType = FileUtil.checkImgType(file);
		if(!imgType){
			return "图片格式不正确";
		}
		if(!FileUtil.isImageByWidthHeight(file)){
			return "无法获取图片宽度高度";
		}
		return "success";
	}

	private void getUserInfo() {
		Map<String, Object> userParams = new HashMap<String, Object>();
		userParams.put("userId", AuthorityUtils.getLoginUserIdNew());
		user = dao.getOneInfo("user.getUserByUserId", userParams);
	}

	private void getAuthenticationInfo() {
		Map<String, Object> userParams = new HashMap<String, Object>();
		userParams.put("userId", AuthorityUtils.getLoginUserIdNew());
		oauth = dao.getOneInfo("user.getUserAuthenticationByUserId", userParams);
	}

	public Map<String, Object> getUser() {
		return user;
	}

	public void setUser(Map<String, Object> user) {
		this.user = user;
	}

	public Map<String, Object> getOauth() {
		return oauth;
	}

	public void setOauth(Map<String, Object> oauth) {
		this.oauth = oauth;
	}

	public File getIdCardFile() {
		return idCardFile;
	}

	public void setIdCardFile(File idCardFile) {
		this.idCardFile = idCardFile;
	}

	public String getIdCardFileFileName() {
		return idCardFileFileName;
	}

	public void setIdCardFileFileName(String idCardFileFileName) {
		this.idCardFileFileName = idCardFileFileName;
	}

	public File getBsnumFile() {
		return bsnumFile;
	}

	public void setBsnumFile(File bsnumFile) {
		this.bsnumFile = bsnumFile;
	}

	public String getBsnumFileFileName() {
		return bsnumFileFileName;
	}

	public void setBsnumFileFileName(String bsnumFileFileName) {
		this.bsnumFileFileName = bsnumFileFileName;
	}

}
