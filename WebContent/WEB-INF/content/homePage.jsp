<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<%-- <link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/jquery.fullPage.css" /> --%>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/homePage.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/component.css" />
	<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/reg.css" />
		<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/font-awesome.min93e3.css" />

<style type="text/css">
</style>
</head>
<body style="overflow: scroll;">
	<div id="fullPage">
		<div class="section">
			<!-- 导航条 -->
			<div class="container demo-1">
				<div class="content">
					<div id="large-header" class="large-header">
						<canvas id="demo-canvas"></canvas>
					</div>
				</div>
			</div>
			<div class="reg-wrap">
				<div class="reg-con">
					<div id="mydiv"></div>
					<div class="reg-info" style="margin-top: 30%">
						<div class="description">
							<h2 style="color: white;font-size: 64px;text-align: center;font-family:华文行楷">云掌互联</h2>
							<h2 style="color: white;font-size: 64px;text-align: center;font-family:华文行楷">让沟通无界</h2>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="section">
			<div class="homePageTop">
				<div class="homeLogo">
					<img src="<%=path%>/resources/img/homePage/logo.png" alt="云掌互联">
				</div>
				<div class="homeMenu">
					<ul class="homeUl">
						<li class="on"><a href="<%=path%>/homePage/portal">首页</a></li>
						<li><a href="<%=path%>/homePage/production">产品</a></li>
						<li><a href="<%=path%>/homePage/aboutUs">联系我们</a></li>
						<li class="homeBtn"><a href="<%=path%>/homePage/register">注册</a></li>
						<li class="homeBtn"><a href="<%=path%>/index">登录</a></li>
					</ul>
				</div>
			</div>
			<!-- 轮播区域 -->
			<div class="homePageLB">
				<div class="js-silder">
					<div class="silder-scroll">
						<div class="silder-main">
							<div class="silder-main-img">
								<img src="<%=path%>/resources/img/homePage/11.jpg" alt="">
							</div>
							<div class="silder-main-img">
								<img src="<%=path%>/resources/img/homePage/22.jpg" alt="">
							</div>
							<div class="silder-main-img">
								<img src="<%=path%>/resources/img/homePage/33.jpg" alt="">
							</div>
							<div class="silder-main-img">
								<img src="<%=path%>/resources/img/homePage/44.jpg" alt="">
							</div>
							<div class="silder-main-img">
								<img src="<%=path%>/resources/img/homePage/55.jpg" alt="">
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 产品内容 -->
			<div class="homePageContent">
				<table>
					<tr class="contentTitle">
						<td colspan="5">我们提供API接口，让企业轻松享受有以下通信能力</td>
					</tr>
					<tr class="productIcon">
						<td><img src="<%=path%>/resources/img/homePage/huibo.png"
							data-src="<%=path%>/resources/img/homePage/huibo.png"
							data-hover-src="<%=path%>/resources/img/homePage/huibo1.png"
							alt=""></td>
						<td><img src="<%=path%>/resources/img/homePage/yhth.png"
							data-src="<%=path%>/resources/img/homePage/yhth.png"
							data-hover-src="<%=path%>/resources/img/homePage/yhth1.png"
							alt=""></td>
						<td><img src="<%=path%>/resources/img/homePage/xnxh.png"
							data-src="<%=path%>/resources/img/homePage/xnxh.png"
							data-hover-src="<%=path%>/resources/img/homePage/xnxh1.png"
							alt=""></td>
						<td><img src="<%=path%>/resources/img/homePage/yyyzm.png"
							data-src="<%=path%>/resources/img/homePage/yyyzm.png"
							data-hover-src="<%=path%>/resources/img/homePage/yyyzm1.png"
							alt=""></td>
						<td><img src="<%=path%>/resources/img/homePage/yytz.png"
							data-src="<%=path%>/resources/img/homePage/yytz.png"
							data-hover-src="<%=path%>/resources/img/homePage/yytz1.png"
							alt=""></td>
					</tr>
					<tr class="productTitle">
						<td>回拨</td>
						<td>隐号通话</td>
						<td>虚拟小号</td>
						<td>语音验证码</td>
						<td>语音通知</td>
					</tr>
					<tr class="productContent">
						<td>用户通过PC或者APP一键拨号，业务系统调用云掌互联API接口，平台发起两路呼叫，实现双方通话。</td>
						<td>隐号通话(AXB）主要应用在出行，快递，VIP服务，订餐等行业，业务员与客户之间通过临时生成的中间号码进行相互沟通，订单结束后，中间号码失效，可以有效的保护双方隐私。</td>
						<td>虚拟小号(AX）主要应用房产中介，二手车，平台类互联网公司等行业，企业为每个业务员申请一个新的手机号码，即虚拟号码，该号码与业务员真实的手机号码进行一一绑定，企业在业务页面上展示虚拟号码，客户拨打该号码可直接联系到相应的业务员，业务员侧可显示客户的真实手机号码或者虚拟号码。</td>
						<td>语音验证码通过电话直呼到用户手机进行语音播报，可以避免各种原因导致的短信不及时、不安全等问题，可有效增强或替代网站、app应用现有的短信通知/验证码。以电话语音的形式进行交互，使用户验证过程更为轻松、高效，从而达到用户体验最优化的效果，为网站及软件带来用户，更给企业管理者带来更持久稳定的运营。</td>
						<td>语音通知主要应用于需要向大量用户发送相似的通知的企业，例如快递行业在用户密集的高峰时段，快递员使用语音通知业务，可一键向多个用户发起批量的快递送达通知，大大缩短等待时间，提高送件效率。</td>
					</tr>
				</table>
			</div>
			<!-- 地图 -->
			<div class="homePageMap"></div>
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
				<div>Copyright ©深圳市云掌互联科技有限公司.All Rights Reserved.云掌互联 版权所有
					深圳市市场监督管理局企业主体身份公示</div>
				<div>粤ICP备17131969号</div>
<!-- 				<div>粤公网安备44030502000949号</div> -->
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
	<script type="text/javascript"
		src="<%=path%>/resources/js/wySilder.min.js"></script>
	<script type="text/javascript"
		src="<%=path%>/resources/js/TweenLite.min.js"></script>
	<script type="text/javascript"
		src="<%=path%>/resources/js/EasePack.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/rAF.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/demo-1.js"></script>
	<script type="text/javascript"
		src="<%=path%>/resources/js/jquery.fullPage.min.js"></script>
	<script type="text/javascript"
		src="<%=path%>/resources/js/jquery.slimscroll.js"></script>
	<script>
		$(function() {
			$('#fullPage').fullpage({
				scrollOverflow : true,
			});

			$(".js-silder").silder({
				auto : true,//自动播放，传入任何可以转化为true的值都会自动轮播
				speed : 20,//轮播图运动速度
				sideCtrl : true,//是否需要侧边控制按钮
				bottomCtrl : true,//是否需要底部控制按钮
				defaultView : 0,//默认显示的索引
				interval : 3000,//自动轮播的时间，以毫秒为单位，默认3000毫秒
				activeClass : "active",//小的控制按钮激活的样式，不包括作用两边，默认active
			});
		});

		$(".productIcon img").mouseover(function() {
			$(this).attr("src", $(this).attr("data-hover-src"));
		}).mouseout(function() {
			$(this).attr("src", $(this).attr("data-src"));
		});
	</script>
</body>
>>>>>>> branch 'master' of git@github.com:Number-Theory/caas.git
</html>
