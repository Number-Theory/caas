<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
	<meta charset="UTF-8">
	<title>控制台-账号设置</title>
		<%@include file="/resources/common/common.jsp"%>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/main/bootstrap.min.css">	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/main/style.css">
	<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/main/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/main/common.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/md5.js"></script>
	<script type="text/javascript" src="<%=path %>/resources/js/form.js"></script>
</head>
<body>
	<div class="wrap container-fluid about-certify no-certify">
		<div id="main">
			<div class="content">
				<div class="order-list">
					<div class="box-fff">
						<div class="base-info">
							<h3>基本信息</h3>
							<div class="box clearfix">
								<div class="img ft-l"><img src="<%=path%>/resources/css/images/default_user.jpg" alt="开发者头像" /></div>
								<dl>
									<div class="clearfix">
										<dt>开发者账号</dt>
										<dd>${user.email }</dd>
									</div>
									<div class="clearfix">
										<dt>注册手机</dt>
										<dd>${user.mobile }
<!-- 											<a href="javascript:void(0)" class="green ft-r js-show-dialog" data-dialog="js-addnum_box">更换手机</a> -->
										</dd>
									</div>
									<div class="clearfix">
										<dt>登录密码</dt>
										<dd>******<!-- <a href="javascript:void(0)" class="green ft-r js-show-dialog" data-dialog="js-modify_secret">修改密码</a> --></dd>
									</div>
								</dl>
							</div>
						</div>
						<div id="certify_div"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--弹层（添加号码） bof-->
		<div class="dialog-bg"></div>
	    <div class="dialog-box">
	      <div class="addnum_box dialog" style="display: none;">
			<h6>更改手机</h6>
			<form action="/user/verifyMobileForToken" method="post" name="phoneForm" id="phone_form">
				<div class="group clearfix">
					<label>输入号码</label>
					 <input type="text" id="phone" name="user.mobile"/>
				     <span class="error" id="phone_error">格式错误</span>
				</div>
				<div class="group img-code clearfix">
					<label>图像验证码</label>
					<input type="text" name="imgCode" class="js-msg-code js-trigger-by-enter valid-code imgCode half-w"  onfocus="if(value=='图像验证码') {value=''}" onblur="if (value=='') {value='图像验证码'}" style="width: 140px;" />
					<img class="js-load-code" src="${pageContext.request.contextPath}/checkcode/picCheckCode?checkCodeId=${data.checkCodeId }"
						 data-target="load-imgCode" id="load-imgCode"/>
					<input type="hidden" value="${data.checkCodeId }" id="checkCodeId"/>
					<span class="error imgCode-error" data-msg-tip="imgCode"></span>
				</div>
				<div class="group clearfix">
					<label>验证方式</label>
					<input type="button" class="btn-style2" value="短信验证码" onclick="smsCode('smscodeinput','voicecodeinput','','${user.sid }')" id="smscodeinput"/> 
					<span style="padding:0 10px;">或</span> 
					<input type="button" class="btn-style2" value="语音验证码" onclick="voiceCode('voicecodeinput','smscodeinput','${user.sid }')" id="voicecodeinput"/>
				</div>
				<div class="group clearfix">
					<label>验证码</label>
					<input type="text" id="inputmovecode"/><input type="hidden" id="movecode"  />
					<span class="error imgCode-error" style="display:none" id="move_phone_code_error">正确</span>
				</div>
				<div class="div-btn">
					<input style="border: 0;" type="button" class="btn-style4 sure" value="确定" id="ph_confirm_btn"/>
					<a href="javascript:void(0)" class="btn-style5 cancel">取消</a>
				</div>
			</form>
		  </div>
		    <div class="modify_secret dialog" style="display:none;">
			    <h6>修改密码</h6>
			    <div class="float_ctn">
				      <div class="float_field clearfix">
				        <dl>
				          <dt>当前密码</dt>
				          <dd>
					          <input type="password" id="current_pwd"/><br/>
					          <span id="current_pwd_error" style="display:none;position: relative;left: 0;top: 0;" class="error">错误：密码错误</span>
				          </dd>
				        </dl>
				      </div>
				      <div class="float_field clearfix">
				        <dl>
				          <dt>新密码</dt>
				          <dd>
					          <input type="password" name="user.password" id="new_pwd"/><br/>
					          <span id="new_pwd_error" class="error" style="display:none;position: relative;left: 0;top: 0;">错误：密码不合法,8-16位数字字母组合</span>
				          </dd>	          
				          <dd><span class="tips">请尽量使用更为复杂的混合密码</span></dd>
				        </dl>
				      </div>
				      <div class="float_field clearfix">
				        <dl>
				          <dt>确认新密码</dt>
				          <dd>
				          <input type="password" id="confirm_pwd" data-trigger-target="#pwd_confirm_btn" class="js-trigger-by-enter"/><br/>
				          <span id="confirm_pwd_error" class="error" style="display:none">错误：密码不合法,8-16位数字字母组合</span>
				          </dd>	          
				        </dl>
				      </div>
				      <div class="float_btn">
				        <span id="pwd_msg" class="success" style="display:none;"></span>
				        <input type="submit" value="确定" class="confirm_btn" id="pwd_confirm_btn"/>
				        <input type="button" value="取消" class="cancel_btn cancel" />
				      </div>
			    </div>
		    </div>
	    	<i class="close-d"></i>
	    </div>
	
	<script type="text/javascript">

		$(function(){
			//绑定手机表单验证
			disabl('smscodeinput','voicecodeinput');
			$("#ph_confirm_btn").click(function(){
				if(frm.phone()&&frm.phoneCode()){
					var phone = $("#phone").val();
					$.ajax({
						url:"<%=path %>/user/updateMobile",
						type:"post",
						data:"user.mobile="+phone,
						dataType: "text",
						success: function (data) {
				        	location.href=location.href;
				        }
					});
				}
			});
			//修改密码
			$("#pwd_confirm_btn").click(function(){
				$("#pwd_confirm_btn").attr("disabled","disabled");
			 	  if(pwdFrm.currentPwd()){
					  var cpwd = $("#current_pwd").val();
					  cpwd = encodeURIComponent(cpwd);
					  $.ajax({
							url:"<%=path%>/user/thePwdIsRight",
							type:"post",
							data:"password="+cpwd,
							dataType: "text",
							success: function (data) {
					            if(data=="0"){
					          	  $("#current_pwd_error").show();
					    		  $("#current_pwd").focus();
					    		  $("#pwd_confirm_btn").removeAttr("disabled");
					    		  return;
					            }
					            
				          	    $("#current_pwd_error").hide();
				          	    if(pwdFrm.newPwd()&&pwdFrm.confirmPwd()){
				          			ajaxUpdatePwd(cpwd,$("#new_pwd").val());
					            }else{
					            	$("#pwd_confirm_btn").removeAttr("disabled");
					            }
					         }
					  });
			 	  }else{
			 		 $("#pwd_confirm_btn").removeAttr("disabled");
			 	  }
			});
			
			
			$("#current_pwd").blur(function(){
				 pwdFrm.currentPwd();
			 });
			 
			 $("#new_pwd").blur(function(){
				 pwdFrm.newPwd();
			 });
			 
			 $("#confirm_pwd").blur(function(){
				 pwdFrm.confirmPwd();
			 });
			
			 
			 //初始化认证信息
			 showCertifyInfo("<%=path%>/user/oAuthDispather");
		});
		
		 /** 修改密码  **/
		 var pwdFrm = {
				 currentPwd:function(){
					 var current_pwd = $("#current_pwd").val();
					 if(current_pwd==""){
						 $("#current_pwd_error").show();
	// 			         $("#current_pwd").focus();
				         return false;
					 }
					 $("#current_pwd_error").hide();
					 return true;
				 },
				 newPwd:function(){
					 var new_pwd =$("#new_pwd").val();
					 if(new_pwd==""){
						 $("#new_pwd_error").show();
	// 			         $("#new_pwd").focus();
				         return false;
					 }
					 if(new_pwd.length<8||new_pwd.length>16){
						 $("#new_pwd_error").show();
	// 			         $("#new_pwd").focus();
				         return false;
					 }
					 if(!vPwd(new_pwd)){
						 $("#new_pwd_error").show();
	// 			         $("#new_pwd").focus();
				         return false;
					 }
					 $("#new_pwd_error").hide();
					 return true;
				 },
				 confirmPwd:function(){
					 var confirm_pwd=$("#confirm_pwd").val();
					 var new_pwd =$("#new_pwd").val();
					 if(confirm_pwd==""){
						 $("#confirm_pwd_error").show();
	// 			         $("#confirm_pwd").focus();
				         return false;
					 }
					 if(confirm_pwd.length<8||confirm_pwd.length>16){
						 $("#confirm_pwd_error").show();
	// 			         $("#confirm_pwd").focus();
				         return false;
					 }
					 if(!vPwd(confirm_pwd)){
						 $("#confirm_pwd_error").show();
	// 			         $("#confirm_pwd").focus();
				         return false;
					 }
					 if(new_pwd!=confirm_pwd){
						 $("#confirm_pwd_error").show();
	// 			         $("#confirm_pwd").focus();
				         return false;
					 }
					 $("#confirm_pwd_error").hide();
					 return true;
				 }
		 };
		 
		 /** 修改密码 **/
		 var ajaxUpdatePwd = function(current_pwd,pwd){
			 $.ajax({
					url:"<%=path%>/user/correctPwd",
					type:"post",
					data:"current_pwd="+current_pwd+"&user.password="+pwd,
					dataType: "text",
					success: function (data) {
						$("#pwd_msg").text("密码修改成功").show();
						setTimeout(function(){
							location.href=location.href;
						},2000);
		          	}
				}); 
		 };
		 
		//初始化认证信息
		 function showCertifyInfo(url) {
			 $.ajax({
					url:url,
					type:"post",
					data:"",
					dataType: "text",
					success: function (data) {
						if (data.indexOf("certify-info") != -1) {
							$("#certify_div").html(data);
						}
		          	}
				}); 
		 }
		
		 $("body").delegate(".js-load-code", "click", function(){
				var targetId = $(this).attr("data-target");
				var targetImg = $("#" + targetId);
				var oldSrc = targetImg.attr("src");
				var str = "noCache=" +new Date().getTime();
				if(oldSrc.indexOf("?") === -1){
					var newSrc = oldSrc + "?"+str;
				}else{
					if(oldSrc.indexOf("&") === -1){
						var newSrc = oldSrc + "&" + str;
					}else{
						var newSrc = oldSrc.substring(0,oldSrc.indexOf("&")) + "&" + str;
					}
				}
				targetImg.attr("src", newSrc);
			});
		 
		//检查验证码是否正确
			var _checkCode = function(code, callback, error){
				var url = "/page/user/checkcode.jsp";
				var data = "checkCode=" + code +"&checkCodeId=" + $("#checkCodeId").val();
				var dataType = "text";
				var type = "post";
				Public.fetch(url, data, type, function(result){
					callback && callback(result);
				}, function(){
					error && error();
				}, dataType, false);
			};
	</script>
</body>
</html>