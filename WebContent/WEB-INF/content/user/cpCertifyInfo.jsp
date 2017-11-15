<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<title>控制台-企业开发者认证</title>
<%@include file="/resources/common/common.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/main/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/main/style.css">
<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/main/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/main/common.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/md5.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/form.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/auth/oauth.js">"></script>
<style type="text/css">
#kk {
	width: 550px;
	height: 550px;
}

#preview_wrapper {
	/*width: 643px;
			height: 318px;
			background-color: #CCC;*/
	overflow: hidden;
}

.preview_fake { /* 该对象用于在IE下显示预览图片 */
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);
	/*width: 643px;*/
	overflow: hidden;
}

.preview_size_fake { /* 该对象只用来在IE下获得图片的原始尺寸，无其它用途*/
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
	width: 50px;
	visibility: hidden;
	overflow: hidden;
}

.preview { /* 该对象用于在FF下显示预览图片*/
	/*width: 643px;
			height: 318px;*/
	overflow: hidden;
}

.spanerror {
	background: url("<%=path%>/images/error.png") no-repeat scroll left
		center rgba(0, 0, 0, 0);
	color: #E76200;
	display: inline-block;
	font-family: 黑体;
	font-size: 12px;
	height: 16px;
	padding-left: 25px;
}
</style>
</head>
<body>
	<div class="wrap container-fluid about-certify">
		<div id="main">
			<div class="content">
				<div class="box-fff clearfix">
					<div class="certify-edit">
						<h2 class="crumbs-menu">
							<span class="crumbs" onClick="history.back();"></span>企业开发者认证
						</h2>

						<!-- 组织 -->
						<div class="cert_items" id="cert_items_company">
							<form method="post" action="<%=path%>/user/oAuthCompany"
								enctype="multipart/form-data" name="companyForm"
								id="companyForm">
								<div class="group clearfix">
									<label for="appName">认证账号</label> <span>${user.email }</span>
								</div>
								<div class="group clearfix">
									<label>公司名称</label> <input type="text"
										value="${oauth.userName}" id="company_name"
										name="oauth.userName"
										onkeyup="if(this.value.length>60)this.value=this.value.subString(0,60)"
										onblur="oauth_frm_company.companyName();companyNameExist()" />
									<span class="tips tips1">认证成功后将默认作为发票开票抬头</span>
									<p class="error" style='display: none'
										id="companyNameSpanError">错误：请输入正确的公司名称</p>
								</div>
								<div class="group clearfix">
									<label>公司注册地址</label> <input type="text"
										value="${oauth.webSite }" id="company_address"
										onblur="oauth_frm_company.address()" name="oauth.webSite"
										class="cert_num"
										onkeyup="if(this.value.length>200)this.value=this.value.subString(0,60)" />
									<span class="tips tips1">公司地址必须与营业执照相同</span>
									<p class="error" style='display: none' id="addressSpanError">错误：请输入正确的公司地址</p>
								</div>

								<!-- 普通证件  -->
								<div class="add_items" id="add_items1">
									<div class="group clearfix">
										<label>营业执照号</label> <input type="text"
											value="${oauth.enterpriseMaterialId }" id="bs_num"
											name="oauth.enterpriseMaterialId"
											onblur="oauth_frm_company.bsNum();idNumExists(this.value,'BSNUM','${oauth.enterpriseMaterialId }')"
											maxlength="20" /> <span class="tips tips1">20位数字或字母以内</span>
										<p class="error" style='display: none' id="bsnumSpanError">错误：请输入正确的营业执照号</p>
									</div>
									<div class="group clearfix">
										<label>三证合一照</label>
										<div class="rz-img ft-l clearfix">
											<input type="file" class="file_1" name="bsnumFile"
												onchange="verifyPic(this,3)" id="bsnumFile" />
											<p class="error" style='display: none' id="bsnumFileError">错误：请选择正确的营业执照图片</p>
											<p class="clearfix">*证件照片上传必须是原件或加盖公章的复印件</p>
											<p>*文件仅支持2M以内的jpg，jpeg，png或gif。Mac苹果用户请使用firefox火狐浏览器进行上传</p>
										</div>
									</div>
								</div>
								<!-- 普通证件  -->
								<input type="hidden" id="existsBSNUM" /> <input type="hidden"
									id="cerType" name="userPic.cerType" value="1" /> <input
									type="hidden" id="existsCompanyName" value="0">

							</form>
						</div>

						<div class="div-btn cp-btn">
							<a href="javascript:void(0)" id="company_oauth_confirm_btn"
								class="sure btn-style4">提交审核</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>