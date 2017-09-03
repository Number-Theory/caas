<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
	<meta charset="UTF-8">
	<title>控制台-个人开发者认证</title>
		<%@include file="/resources/common/common.jsp"%>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/main/bootstrap.min.css">	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/main/style.css">
	<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/main/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/main/common.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/md5.js"></script>
	<script type="text/javascript" src="<%=path %>/resources/js/form.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/auth/oauth.js"></script>
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
			filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale
				);
			/*width: 643px;*/
			overflow: hidden;
		}
		
		.preview_size_fake { /* 该对象只用来在IE下获得图片的原始尺寸，无其它用途*/
			filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image
				);
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
		    background: url("<%=path%>/images/error.png") no-repeat scroll left center rgba(0, 0, 0, 0);
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
					<div class="certify-edit certify-edit-person">
						<h2 class="crumbs-menu"><span class="crumbs" onClick="history.back();"></span>个人开发者认证</h2>
						<form action="<%=path %>/user/oAuthPersonal" method="post" name="personalForm" id="personalForm"  enctype="multipart/form-data">
							<div class="group clearfix">
								<label for="appName">认证账号</label>
								<span>${user.email }</span>
							</div>
							<div class="group clearfix">
								<label for="appType">真实姓名</label>
								<input type="text" value="${oauth.legalPerson }" id="real_name" name="oauth.legalPerson" onblur="oauth_frm_person.realName()" onkeyup="if(this.value.length>60)this.value=this.value.substring(0,60)"/>
								<span class="p-blue">认证成功后默认作为发票开票抬头</span>
								<span class="error"  id="nameSpanError">错误：不合法</span>
							</div>
							<div class="group clearfix">
								<label for="appType">证件号码</label>
								<input type="text" value="${oauth.legalPersonId }" id="id_num" name="oauth.legalPersonId" onblur="oauth_frm_person.idNum();idNumExists(this.value,'ID','${user.idNbr }')"/>
								<span class="error"  id="idNumSpanError">错误：请输入正确的证件号码</span>
							</div>
							<div class="group clearfix photo">
								<label for="appType">证件照片</label>
								<div class="rz-img ft-l clearfix" style="height: 340px;overflow: hidden;"> 
									<input type="file" value="" class="file_1" id="idCardFile" name="idCardFile" onchange="onUploadImgChange(this,1)"/>
									<span class="error"  >错误：请选择正确证件照片</span>
									<div id="preview_wrapper">
											<div id="preview_fake1" class="preview_fake">
												<div  class="img-div">
													<img id="preview1"
													<s:if test='oauth.legalPersonMeterial!=null'>src="<%=path%>/file/viewFast?remotePath=<u:des3 value='${oauth.legalPersonMeterial}'/>"</s:if>
													<s:else>src="<%=path%>/page/controlPage/images/cert-img.png"</s:else>
													onload="onPreviewLoad(this)"  alt="认证照片" />
												</div>
											</div>
										</div>
										<br />
										<img id="preview_size_fake1" class="preview_size_fake" />
									<p class="clearfix">*请上传手持真实有效的身份证及护照扫描件、照片的正面,确保证件内容和脸部清晰可见，文件仅支持2M以内的jpg，jpeg，png或gif。Mac苹果用户请使用firefox火狐浏览器进行上传</p>
								</div>
							</div>
							<br />
							<div class="div-btn">
								<a href="javascript:void(0)" class="sure btn-style4" style="z-index:999;" id="person_oauth_confirm_btn">提交审核</a>
							</div>
							
							<input type="hidden" id="pidType" value="1"/>
							<input type="hidden" id="existsID"/>
						</form>
					</div>					
				</div>
			</div>
		</div>
	</div>	
	
	<script type="text/javascript">
	$(function(){
	});
	</script>
</body>

</html>