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
			<li class="homeBtn"><a href="<%=path%>/homePage/register">注册</a></li>
			<li class="homeBtn"><a href="<%=path%>/index">登录</a></li>
		</ul>
	</div>
</div>
<div class="productDiv">
	<div class="ptitle"><h1>隐号通话</h1></div>
	<p class="picon"></p>
	<div class="pintro">隐号通话(AXB）业务员与客户之间通过临时生成的中间号码进行相互沟通，订单结束后，中间号码失效，可
以有效的保护双方隐私。可应用于出行，快递，VIP服务，订餐等行业、约车沟通、网络电话。</div>
	<div class="pic">
		<img src="<%=path%>/resources/img/homePage/pyhth.png">
	</div>
<!-- 	<div class="box1"> -->
<!-- 		<p class="pscene">应用场景</p> -->
<!-- 		<p class="pp">1、出行行业以订单作为绑定依据，按需生成隐私号码，司机及乘客双方通过该隐私号码进行互拨通话。订单完成，绑定关系解除。</p> -->
<!-- 		<p class="pp">2、物流行业快递派送即为快递员和买家分配一个隐私号码，派件期间通过该号码进行通话，物品派送成功，绑定关系随即解除。</p> -->
<!-- 		<p class="pp">3、中介行业经纪人在中介平台发布房源信息，留下电话生成虚拟号码，客户可通过中介平台查看并拨打经纪人的虚拟号码，双方号码不可见。</p> -->
<!-- 		<p class="pp">4、O2O行业二手车商家在O2O平台发布二手车信息，留下虚拟服务号码，客户拨打商家的虚拟号码，双方号码不可见，保护了O2O平台客户信息。</p> -->
<!-- 	</div> -->
</div>
<div class="productDiv">
	<div class="ptitle"><h1>回拨</h1></div>
	<p class="picon"></p>
	<div class="pintro">用户通过PC或者APP一键拨号，业务系统调用云掌互联API接口，平台发起两路呼叫，实现双方通话。</div>
	<div class="pic">
		<img src="<%=path%>/resources/img/homePage/phuibo.png">
	</div>
</div>
<div class="productDiv">
	<div class="ptitle"><h1>虚拟小号</h1></div>
	<p class="picon"></p>
	<div class="pintro">虚拟小号(AX），企业为每个业务员申请一个虚拟号码，客户拨打该号码可直接联系到相应的业务员，业务员
侧可显示客户的真实手机号码或者虚拟号码。可应用于房产中介，二手车，平台类互联网公司等行业。</div>
	<div class="pic">
		<img src="<%=path%>/resources/img/homePage/pxnxh.png">
	</div>
</div>
<div class="productDiv">
	<div class="ptitle"><h1>语音验证码</h1></div>
	<p class="picon"></p>
	<div class="pintro">语音验证码通过电话直呼到用户手机进行语音播报，可以避免各种原因导致的短信不及时、不安全等问题，
可有效增强或替代网站、app应用现有的短信通知/验证码。以电话语音的形式进行交互，使用户验证过程更为轻
松、高效，从而达到用户体验最优化的效果，为网站及软件带来用户，更给企业管理者带来更持久稳定的运营。</div>
	<div class="pic">
		<img src="<%=path%>/resources/img/homePage/pyyyzm.png">
	</div>
</div>
<div class="productDiv">
	<div class="ptitle"><h1>语音通知</h1></div>
	<p class="picon"></p>
	<div class="pintro">语音通知主要应用于需要向大量用户发送相似的通知的企业，例如快递行业在用户密集的高峰时段，快递
员使用语音通知业务，可一键向多个用户发起批量的快递送达通知，大大缩短等待时间，提高送件效率。</div>
	<div class="pic">
		<img src="<%=path%>/resources/img/homePage/pyytz.png">
	</div>
</div>
<br>
<br>
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