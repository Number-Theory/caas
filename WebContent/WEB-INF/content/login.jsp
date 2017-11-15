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
<script src="<%=path%>/resources/js/login/home.js"></script>
</head>

<body style="background-color: #e9ecf0;">
	<!--头部信息开始-->
	<div class="header">
		<div class="logo width_980">
			<h1 class="title">云掌互联云平台</h1>
			<div class="header_nav">
				<ul>
					<%-- 					<li><a href="<%=path%>/">概览</a></li> --%>
					<%-- 					<li><a href="<%=path%>/home/about">联系我们</a></li> --%>
<%-- 					<li class="header_selected"><a href="<%=path%>/login">立即登录</a></li> --%>
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
		<div class="middle-box text-center loginscreen animated fadeInDown"
			style="width: 500px;">
			<div
				style="background-color: white; border-radius: 5px; padding: 35px;">
				<h3>欢迎使用云掌互联</h3>

				<form class="form-horizontal m-t" role="form"
					action="<%=path%>/index" method="post" id="form-login">

					<div class="form-group">
						<div class="col-sm-12">
							<input type="text" class="form-control" placeholder="用户名/邮箱/手机号码"
								id="name" name="name" required="">
						</div>
					</div>

					<div class="form-group"></div>

					<div class="form-group">
						<div class="col-sm-12">
							<input type="password" class="form-control" placeholder="密码"
								id="userPwd" name="userPwd" required="">
						</div>
					</div>

					<%-- 					<div class="form-group">
						<div class="col-sm-12">
							<input type="text" class="form-control" placeholder="验证码"
								id="checkCode" name="checkCode" required="">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<img src="<%=path%>/checkCode" id="randCheckCode_img"
								onclick="$(this).attr('src','<%=path%>/checkCode?' + Math.random())">
						</div>
					</div> --%>

					<div class="form-group"></div>

					<div class="form-group">
						<span style="color: red">${msg }</span>
					</div>
					<button type="button" onclick="loginSubmit()"
						class="btn btn-success btn-block col-sm-10">登 录</button>
					<input id="projectPath" value="<%=basePath%>" type="hidden">

					<div class="form-group"></div>
					<div class="form-group"></div>
					<p class="text-muted text-center">
<%-- 						<a href="<%=path%>/welcome"><small>忘记密码了？</small></a> | <a --%>
<%-- 							href="<%=path%>/register">注册一个新账号</a> --%>
					</p>

				</form>
			</div>
		</div>
		<!-- 登陆模块结束 -->
	</div>

</body>
</html>
