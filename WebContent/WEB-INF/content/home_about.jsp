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
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/home.css" />
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
					<li ><a href="<%=path%>/">概览</a></li>
					<li class="header_selected"><a href="<%=path%>/home/about">联系我们</a></li>
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
	</script><link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/contact_us.css"/>
	<!--右侧悬浮回顶端开始-->
	<div class="back_top">
		回顶端
	</div>
	<!--右侧悬浮回顶端结束-->
	<div class="content width_980">
		<h1 class="title_one">联系我们</h1>
		<!-- 销售联系方式开始 -->
		<div class="sales_phone kind">
			
		<!-- 销售联系方式结束 -->
		<!-- 技术与支持开始 -->
		<div class="technology">
			<h1 class="title_phone">技术与支持</h1>
			<div class="technology_cont">
				<h2>技术专线</h2>
				<p><span>企业QQ：</span></p>
				<p><span>400热线：</span>400-7776698</p>
			</div>
			<div class="technology_cont">
				<h2>电子邮件</h2>
				<p><span>产品运营：</span>bcs@ucpaas.com</p>
				<p><span>技术支持：</span>ocs@ucpass.com</p>
			</div>
			
			<h1 class="title_phone"></h1>
			<div class="sales_cont">
				<h2 class="sales_title"></h2>
				<p class="cont"></p>
				<p class="cont"></p>
			</div>
			<div class="technology_cont" style="padding-bottom:20px;">
				<h2>公司地址</h2>
				<p>深圳市南山区科技园高新南四道8号创维半导体设计大厦东座19楼</p>
			</div>
			<img src="<%=path%>/resources/img/url.png"/>
		</div>
		<!-- 技术与支持结束 -->
	</div>
		<!-- 团队构成开始 -->
		<div class="team  kind">
			<h1 class="title_phone">团队构成</h1>
			<div class="technology_cont">
				<h2>核心成员</h2>
				<p>来自传统电信、互联网行业、知名IT企业。平均从业经验10年以上，形成了成熟的核心团队及超强的战术执行力。</p>
			</div>
			<div class="technology_cont">
				<h2>产品技术团队</h2>
				<p>公司60%以上成员为产品技术研发人员，90%拥有本科及以上学历。研发团队不断突破，获多项计算机软件著作权证书。</p>
			</div>
			<div class="technology_cont">
				<h2>支持团队</h2>
				<p>此外，云之讯还拥有一支高素质专业运营支持团队，快速响应客户需求。</p>
			</div>
		</div>
		<!-- 团队构成结束 -->
		<!-- 公司信息开始 -->
		<div class="company_information  kind">
			<h1 class="title_phone">公司信息</h1>
			<div class="company_cont">
				<h2>公司简介</h2>
				<p>
					深圳市云之讯网络技术有限公司[1]  （以下简称云之讯），是一家融合通讯云平台服务提供商。云之讯部署了一张融合电信和互联网通信能力的网络，并且把融合通信的网络
					能力（音视频通话，会议、IM、短信/语音验证码、短信/语音通知）打包成非常友好的API和SDK的方式提供给开发者，让开发者可以不用自己研发通讯技术和部署通讯网络，而是
					可以通过添加几行代码，迅速为自己的业务增加通讯的能力。当前云之讯的能力广泛应用于免费电话，在线客服，社交沟通，企业通讯，国际漫游，安全通讯等领域，
					截止2015年2月底，已经有2万多名开发者/企业，包括腾讯，京东，YY，阿里巴巴，小米，用友，天润融通，有信等公司，使用了云之讯的能力，服务于超过2亿的最终用户。
			</p>
			</div>
			
			
		</div>
		<!-- 公司信息结束 -->
	</div>
	<div class="clear"></div>
	<div class="footer">
		© 深圳市云之讯网络技术有限公司. All Rights Reserved<br/>
<!-- <a href="http://www.miitbeian.gov.cn" target="_bank">粤ICP备14046848号-10</a> -->
	</div>
</body>
</html>