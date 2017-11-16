<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/login.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/homePage.css" />
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
		src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript"
	src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>

<script src="<%=path%>/resources/js/login/login.js"></script>

<title>欢迎使用云掌互联</title>
<!--给title添加一个小图标-->
<link rel="Shortcut Icon" href="<%=path%>/resources/img/title.ico"
	type="/image/x-icon" />
<script src="<%=path%>/resources/js/login/home.js"></script>
</head>

<body>
	<div class="homePageTop">
		<div class="homeLogo">
			<img src="<%=path%>/resources/img/homePage/logo.png" alt="云掌互联">
		</div>
		<div class="homeMenu">
			<ul class="homeUl">
				<li><a href="<%=path%>/homePage/portal">首页</a></li>
				<li><a href="<%=path%>/homePage/production">产品</a></li>
				<li><a href="<%=path%>/homePage/aboutUs">联系我们</a></li>
				<li class="homeBtn"><a href="<%=path%>/homePage/register">注册</a></li>
				<li class="homeBtn"><a href="<%=path%>/index">登录</a></li>
			</ul>
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
	<div class="content" onkeydown="keyLogin()">
			<div class="title">云掌互联登录</div>
			<form class="form-horizontal m-t" role="form" action="<%=path%>/index" method="post" id="form-login">
				<div class="mainContent">
					<ul>
						<li><img src="<%=path%>/resources/img/homePage/login_user.png"><input type="text" class="form-control" placeholder="用户名/邮箱/手机号码" id="name" name="name" required=""></li>
						<li><img src="<%=path%>/resources/img/homePage/login_pwd.png"><input type="password" class="form-control" placeholder="密码" id="userPwd" name="userPwd" required=""></li>
						<li><button type="button" onclick="loginSubmit()" id="subbtn" class="btn btn-success btn-block col-sm-10">登 录</button><input id="projectPath" value="<%=basePath%>" type="hidden"></li>
						<li> <div class="form-group"> <span style="color: red">${msg }</span></div></li>
					</ul>
				</div>
			</form>
		<!-- 登陆模块结束 -->
	</div>
</body>
</html>
