<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />  
<title>产品</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/homePage.css" />
<style type="text/css">
/* .BMap_Marker img{ */
/* 	height: 30px; */
/* 	width: 30px; */
/* 	max-width: inherit; */
/* } */
</style>
</head>
<body>
<!-- 导航条 -->
<div class="homePageTop">
	<div class="homeLogo"><img src="<%=path%>/resources/img/homePage/logo.png" alt="云掌互联"></div>
	<div class="homeMenu">
		<ul class="homeUl">
			<li><a href="<%=path%>/homePage/portal">首页</a></li>
			<li class="on"><a href="<%=path%>/homePage/production">产品</a></li>
			<li><a href="<%=path%>/homePage/aboutUs">联系我们</a></li>
			<li class="homeBtn"><a>注册</a></li>
			<li class="homeBtn"><a>登录</a></li>
		</ul>
	</div>
</div>
<div class="productDiv">
	<div class="ptitle"><h1>隐私通话</h1></div>
	<p class="picon"></p>
	<div class="pintro">以电话语音的方式发送验证码，通过手机接收语音验证码，接通后自动语音播报，挂机后可选择短信验证码同步发送手机号，实现双保险确保万无一失。</div>
	<div class="box1">
		<p class="pscene">应用场景</p>
		<p class="pp">1、出行行业以订单作为绑定依据，按需生成隐私号码，司机及乘客双方通过该隐私号码进行互拨通话。订单完成，绑定关系解除。</p>
		<p class="pp">2、物流行业快递派送即为快递员和买家分配一个隐私号码，派件期间通过该号码进行通话，物品派送成功，绑定关系随即解除。</p>
		<p class="pp">3、中介行业经纪人在中介平台发布房源信息，留下电话生成虚拟号码，客户可通过中介平台查看并拨打经纪人的虚拟号码，双方号码不可见。</p>
		<p class="pp">4、O2O行业二手车商家在O2O平台发布二手车信息，留下虚拟服务号码，客户拨打商家的虚拟号码，双方号码不可见，保护了O2O平台客户信息。</p>
	</div>
</div>
<div class="productDiv">
<!-- 	<div>点击呼叫(回拨)</div> -->
<!-- 	<div>点击拨号是同时将主叫号码和被叫号码通过IP网络发送给服务器，由服务器呼叫主叫和被叫，使主叫和被叫能够互相通话。</div> -->
<!-- 	<div></div> -->
<!-- 	<p></p> -->
</div>
<div class="productDiv">
	
</div>
<div class="productDiv">
	
</div>
<!-- footerList -->
<div class="footerList">
	<table>
		<tr>
			<th>产品</th>
			<th>解决方案</th>
			<th colspan="2">开发者中心</th>
			<th>联系</th>
		</tr>
		<tr>
			<td>专线语音</td>
			<td>金融行业</td>
			<td>新手指引</td>
			<td>AS回调通知接口</td>
			<td>联系客服</td>
		</tr>
		<tr>
			<td>智能云调度</td>
			<td>物流行业</td>
			<td>平台政策规范</td>
			<td>全局错误码</td>
			<td>联系我们</td>
		</tr>
		<tr>
			<td>专号通</td>
			<td>地产行业</td>
			<td>Rest API</td>
			<td>常见问题</td>
			<td>关于我们</td>
		</tr>
		<tr>
			<td>虚拟小号</td>
			<td>O2O行业</td>
			<td></td>
			<td></td>
			<td>公司新闻</td>
		</tr>	
	</table>
</div>
<!-- 底部 -->
<div class="homePageFoot">
	<div>Copyright ©深圳市云掌互联科技有限公司.All Rights Reserved.云掌互联 版权所有 深圳市市场监督管理局企业主体身份公示</div>
	<div>粤ICP备17131969号</div>
 	<div>粤公网安备44030502000949号</div>
</div>
<script type="text/javascript" src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
</body>
</html>