<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<title>VBOSS控制台 - 主页</title>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 全局css -->
<link rel="shortcut icon" href="favicon.ico">
<link href="<%=path%>/resources/css/bootstrap.min.css?v=3.3.6"
	rel="stylesheet">
<link href="<%=path%>/resources/css/bootstrap.min14ed.css?v=3.3.6"
	rel="stylesheet">
<link href="<%=path%>/resources/css/font-awesome.min93e3.css?v=4.4.0"
	rel="stylesheet">
<link href="<%=path%>/resources/css/animate.min.css" rel="stylesheet">
<link href="<%=path%>/resources/css/style.min.css?v=4.1.0"
	rel="stylesheet">

<link href="<%=path%>/resources/css/common.css" rel="stylesheet">
<!-- 全局js -->
<script src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path%>/resources/js/bootstrap.min.js?v=3.3.6"></script>
<script
	src="<%=path%>/resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script
	src="<%=path%>/resources/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=path%>/resources/js/plugins/layer/layer.min.js"></script>
<script
	src="<%=path%>/resources/js/plugins/beautifyhtml/beautifyhtml.js"></script>

<script src="<%=path%>/resources/js/content.min.js"></script>
<script src="<%=path%>/resources/js/jquery-ui-1.10.4.min.js"></script>
<!-- 自定义js -->
<script src="<%=path%>/resources/js/hplus.min.js?v=4.1.0"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/contabs.min.js"></script>
<!-- 第三方插件 -->
<script src="<%=path%>/resources/js/plugins/pace/pace.min.js"></script>
<title>VBOSS控制台 - 主页</title>

<script src="<%=path%>/resources/js/login/login.js"></script>
<style>
.droppable-active {
	background-color: #ffe !important
}

.tools a {
	cursor: pointer;
	font-size: 80%
}

.form-body .col-md-6, .form-body .col-md-12 {
	min-height: 400px
}

.draggable {
	cursor: move
}
</style>
</head>

<body class="fixed-sidebar full-height-layout gray-bg"
	style="overflow: hidden">
	<input id="projectPath" value="<%=path%>" type="hidden">
	<div id="wrapper">
		<!--左侧导航开始-->
		<nav class="navbar-default navbar-static-side" role="navigation">
			<div class="nav-close">
				<i class="fa fa-times-circle"></i>
			</div>
			<div class="sidebar-collapse">
				<ul class="nav" id="side-menu">
					<li class="nav-header">
						<div class="dropdown profile-element" style="margin-top: -20px;margin-bottom: -20px;">
							<span><img alt="image" class="img-circle"
								src="../../resources/img/default_user.jpg" /></span> 
						</div>
						<div class="logo-element">CAAS</div>
					</li>
					<!-- 加入逻辑start -->
					<c:forEach items="${sessionScope.rolemenu.first}" var="first">
						<li><a href="#"> <i class="fa fa-home"></i> <span
								class="nav-label">${first.name }</span> <span class="fa arrow"></span>
						</a>
							<ul class="nav nav-second-level">
								<c:forEach items="${sessionScope.rolemenu.second}" var="second">
									<c:if test="${second.super_id==first.id}">
										<li class="draggable"><a class="J_menuItem"
											name="${second.id}" href="${second.url}">${second.name}</a></li>
									</c:if>
								</c:forEach>
							</ul></li>
					</c:forEach>
				</ul>
			</div>
		</nav>
		<!--左侧导航结束-->
		<!--右侧部分开始-->
		<div id="page-wrapper" class="gray-bg dashbard-1">

			<div class="row content-tabs">
				<button class="roll-nav roll-left J_tabLeft">
					<i class="fa fa-backward"></i>
				</button>
				<nav class="page-tabs J_menuTabs">
					<div class="page-tabs-content">
						<a href="javascript:;" class="active J_menuTab defaultFix"
							data-id="index_main">首页</a>
					</div>

				</nav>
				<button class="roll-nav roll-right J_tabRight">
					<i class="fa fa-forward"></i>
				</button>
				<div class="btn-group roll-nav roll-right">
					<button class="dropdown J_tabClose" data-toggle="dropdown">
						关闭操作<span class="caret"></span>
					</button>
					<ul role="menu" class="dropdown-menu dropdown-menu-right">
						<li class="J_tabShowActive"><a>定位当前选项卡</a></li>
						<li class="divider"></li>
						<li class="J_tabCloseAll"><a>关闭全部选项卡</a></li>
						<li class="J_tabCloseOther"><a>关闭其他选项卡</a></li>
					</ul>
				</div>
				<a href="<%=path%>/logout" onclick="logout()"
					class="roll-nav roll-right J_tabExit"><i
					class="fa fa fa-sign-out"></i> 退出</a>
			</div>
			<div class="row J_mainContent" id="content-main">
				<iframe class="J_iframe" name="iframe0" width="100%" height="100%"
					src="<%=path%>/main" frameborder="0" data-id="index_main" seamless></iframe>
			</div>
		</div>
		<!--右侧部分结束-->
	</div>
</body>

</html>
