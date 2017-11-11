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
<title>关于我们</title>
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
			<li><a href="<%=path%>/homePage/production">产品</a></li>
			<li class="on"><a href="<%=path%>/homePage/aboutUs">联系我们</a></li>
			<li class="homeBtn"><a>注册</a></li>
			<li class="homeBtn"><a>登录</a></li>
		</ul>
	</div>
</div>
<div class="adoutUsPic">
	<img src="<%=path%>/resources/img/homePage/company.png" alt="">
</div>
<!-- 地图定位 -->
<div id="ourMap">
	<div id="container"></div> 
</div>
<!-- 联系我们的具体信息 -->
<div class="contact">
	<h2>
		<span>联系我们</span>
	</h2>
	<p>公司名称：深圳市云掌互联科技有限公司</p>
	<p>公司地址：</p>
	<p>联系人：江先生</p>
	<p>联系方式：18926050663</p>
	<p></p>
</div>
<!-- 底部 -->
<div class="homePageFoot">
	<div>Copyright ©深圳市云掌互联科技有限公司.All Rights Reserved.云掌互联 版权所有 深圳市市场监督管理局企业主体身份公示</div>
	<div>粤ICP备17131969号</div>
 	<div>粤公网安备44030502000949号</div>
</div>
<script type="text/javascript" src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=9f203065d6bfef95503b9519831eda1b"></script>
<script>
	var map = new BMap.Map("container"); 
	var point = new BMap.Point(114.025973657,22.5460535462); 
	map.centerAndZoom(point, 15);  
	map.addControl(new BMap.NavigationControl());
	map.enableScrollWheelZoom(true);  
	
	var marker = new BMap.Marker(point);  // 创建标注    
	map.addOverlay(marker);   
	marker.setAnimation(BMAP_ANIMATION_BOUNCE); //可以动
</script>

</body>
</html>