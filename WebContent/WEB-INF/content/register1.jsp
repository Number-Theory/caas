<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@include file="/resources/common/common.jsp"%>

<!--[if lt IE 9]>
<meta http-equiv="refresh" content="0;ie.html" />
<![endif]-->

<script>
	if (window.top !== window.self) {
		window.top.location = window.location;
	}
</script>
<style>
.header .logo h1 {
	display: block;
	font-size: 2em;
	font-weight: bold;
	height: 60px;
	line-height: 60px;
}
</style>

<script type="text/javascript"
	src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>

<script src="<%=path%>/resources/js/login/login.js"></script>

<title>欢迎使用云掌互联</title>
<!--给title添加一个小图标-->
<link rel="Shortcut Icon" href="<%=path%>/resources/img/title.ico"
	type="/image/x-icon" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/home.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/reg.css" />
<script src="<%=path%>/resources/js/login/home.js"></script>
<script src="<%=path%>/resources/js/reg.js"></script>
</head>

<body>
	<!--头部信息开始-->
	<div class="header">
		<div class="logo width_980">
			<h1 class="title">云掌互联云平台</h1>
			<div class="header_nav">
				<ul>
<%-- 					<li><a href="<%=path%>/">概览</a></li> --%>
<%-- 					<li><a href="<%=path%>/home/about">联系我们</a></li> --%>
					<li class="header_selected"><a href="<%=path%>/login">立即登录</a></li>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$(".header_nav ul li").click(function() {
				$(this).siblings().removeClass("header_selected");
				$(this).addClass("header_selected");

			});
		})
	</script>
	<div class="content width_980" onkeydown="keyLogin()">
		<div>
			<h3>欢迎使用云掌互联</h3>
			<div class="reg-wrap">
				<div class="reg-con">
					<div class="reg-info">
						<h1></h1>
						<div class="reg-det">
							<h1 style="text-align: center; font-size: 2.2rem;">注册云掌互联账号</h1>
							<form action="<%=path%>/user/simpleReg" id="userInfoFrm"
								name="userInfoFrm" method="post">
								<div class="group">
									<input type="text" id="name" name="name" value="请输入用户名"
										onfocus="if(value=='请输入用户名') {value=''}"
										onblur="if (value=='') {value='请输入用户名'}"
										onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
										autocomplete="off" /> <span class="error" id="name_error"
										style="display: none">用户名已存在</span> <input type="hidden"
										id="name_error_flag" value="0" /> <i class="mark"></i> <i
										class="close"></i>
								</div>
								<div class="group close-d">
									<input type="password" name="password" id="password1"
										placeholder="密码为8-16位数字和字母组合"
										onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
										autocomplete="off" /> <span class="eye" id="showPassBtn"></span>
									<span id="password1_error" class="error" style="display: none">字符不符合规范</span>
									<input type="hidden" id="password1_error_flag" value="0" /> <i
										class="mark pas"></i> <i class="close"></i>
								</div>
								<div class="group">
									<input type="text" id="reg_email" name="vemail" value="请输入邮箱"
										onfocus="if(value=='请输入邮箱') {value=''}"
										onblur="if (value=='') {value='请输入邮箱'}"
										onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;"
										autocomplete="off" /> <span class="error" id="email_error"
										style="display: none">邮箱不符合规范</span> <input type="hidden"
										id="email_error_flag" value="0" /> <i class="mark"></i> <i
										class="close"></i>
								</div>
								<div class="group">
									<input type="text" name="user.mobile" id="phone" value="请输入手机号"
										onfocus="if(value=='请输入手机号') {value=''}"
										onblur="if (value=='') {value='请输入手机号'};" autocomplete="off" />
									<span class="error" id="phone_error" style="display: none"></span>
									<input type="hidden" id="phone_error_flag" value="0" /> <i
										class="mark num"></i> <i class="close"></i>
								</div>

								<div class="group item">
									<div class="txt">
										<input type="checkbox" id="reg_checked" name="is_agreement"
											value="1" onclick="validateButton()" />阅读并同意<a
											href="#" style="color: #2ea967;"
											target="_blank">《云掌互联云平台用户使用协议》</a>及相关服务条款
									</div>
									<span id="checked_error" class="error1" style="display: none;">请同意协议并勾选!</span>
									<input type="hidden" id="checked_error_flag" value="0" /> <a
										class="green-btn" id="infoSubt"
										onclick="ga('send', 'event', 'button', 'click', 'submitbutton');"
										style="background-color: #87cda9">立即注册</a>
								</div>
							</form>
						</div>
						<div class="go-login">
							已注册账号？<a href="<%=path%>/login">请登录</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 注册模块结束 -->
</body>
</html>
>>>>>>> branch 'master' of git@github.com:Number-Theory/caas.git
