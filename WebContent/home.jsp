<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"  prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml"  prefix="x" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>VBOSSCloud平台</title>
	<!--给title添加一个小图标-->
    <link rel="Shortcut Icon" href="<%=path%>/resources/img/title.ico" type="/image/x-icon" />
	<link type="text/css" href="<%=path%>/resources/css/home.css" rel="stylesheet">
	<script src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
	<script src="<%=path%>/resources/js/login/home.js"></script>
</head>
<body>
	<!--头部信息开始-->
	<div class="header">
		<div class="logo width_980">
			<h1 class="title">VBOSSCloud平台</h1>
			<div class="header_nav">
				<ul>
					<li class="header_selected"><a href="/">概览</a></li>
					<li ><a href="<%=path%>/home/about">联系我们</a></li>
					<li><a href="<%=path%>/login">立即登录</a></li>
				</ul>	
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			$(".header_nav ul li").click(function(){
				$(this).siblings().removeClass("header_selected");
				$(this).addClass("header_selected");
				
			});
		})
	</script><script type="text/javascript" src="<%=path%>/resources/js/login/overview.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources//css/overview.css" />
<div class="floor_1 floor">
		<!-- banner开始 -->
		<div class="banner">
			<h1 class="banner_title" style="height:10px">
			</h1>
			<h2 class="banner_h2 width_980">
			平台致力于通讯服务行业，锻造业界领先的安全通讯运营管理能力，臻于完善。<br/>
			我们提供更效率、更稳定，更安全的电信级通信运营管理能力；<br/>
			致力成为一家受人尊敬的服务公众的互联网通讯企业。<br/>
			<div class="banner_cont">
				<img src="<%=path%>/resources/img/banner_cont.png"/>
			</div>
			<h2 class="banner_last">	
                 
				
			</h2>
		</div>
		<!-- banner结束 -->
		<!-- 产品信息开始 -->
		<div class="goods">
		<div class="sliderbox">
			<div id="btn-left" class="arrow-btn dasabled"></div>
			<div class="slider">
				<ul>
					<li class="goods_first_li">
						<a href="http://www.ucpaas.com/news/201703175.html" target="_bank"><img src="<%=path%>/resources/img/trading.png"/></a>
					</li>
					<li>
						<a href="http://www.ucpaas.com/news/201702173.html" target="_bank"><img src="<%=path%>/resources/img/interview.png"/></a>
					</li>
						<li><a href="http://www.ucpaas.com/news/201702170.html" target="_bank"><img src="<%=path%>/resources/img/csdn.png"/></a></li>
						<li><a href="http://soft.chinabyte.com/278/13062278.shtml" target="_blank"><img src="<%=path%>/resources/img/wort.png"/></a></li>
						<li><a href="http://sc.chinaz.com/" target="_blank"><img src=""/></a></li>
					
				</ul>
			</div>
			<div id="btn-right" class="arrow-btn"></div>
		</div>
		</div>
			
	<div class="footer">
		© 深圳市云之讯网络技术有限公司. All Rights Reserved<br/>
<!-- <a href="http://www.miitbeian.gov.cn" target="_bank">粤ICP备14046848号-10</a> -->
	</div>
</body>
</html>