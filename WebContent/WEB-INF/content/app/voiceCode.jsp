<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<%@include file="/resources/common/common.jsp"%>
<meta charset="UTF-8">
<title>语音验证码应用</title>
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/main/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/main/style.css">
<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/main/bootstrap.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/main/common.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/md5.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/form.js"></script>
<%-- 	<script type="text/javascript" src="<%=path%>/front/v-1.0/js/base.js"></script> --%>
<style type="text/css">
h2 {
	line-height: 42px;
}

.crumbs-menu .crumbs {
	top: 0px;
	left: 0px;
}
</style>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content wrap container-fluid index">
		<div id="main">
			<div class="content">
				<div class="con-box1 row-fluid">
					<div class="info span12">
						<h2 class="crumbs-menu" style="padding-left: 40px">
							<span class="crumbs" onClick="history.back();"></span>语音验证码
						</h2>
						<div class="row"
							style="margin-left: -8px; margin-right: 16px; padding: 1px">
							<div class="col-sm-2">
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<h5>应用信息</h5>
									</div>
									<div class="ibox-content">
										<div>
											<small>应用名称：<span class="pull-right">${appMap.appName }</span></small>
										</div>
										<div>
											<small>应用状态： <c:if test="${appMap.status != 0 }">
													<span class="label label-danger pull-right">已停用</span>
												</c:if> <c:if test="${appMap.status == 0 }">
													<span class="label label-success pull-right">已启用</span>
												</c:if>
											</small>
										</div>
										<div>
											<small>创建时间：<span class="pull-right">${appMap.createDate }</span></small>
										</div>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<span class="label label-success pull-right">月</span>
										<h5>消耗</h5>
									</div>
									<div class="ibox-content">
										<h2 class="no-margins">${data.totalConsume }</h2>
										<div class="stat-percent font-bold text-success">
											98% <i class="fa fa-level-up"></i>
										</div>
										<small>当月消耗</small>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<span class="label label-success pull-right">月</span>
										<h5>请求</h5>
									</div>
									<div class="ibox-content">
										<h2 class="no-margins">${data.totalRequest }</h2>
										<div class="stat-percent font-bold text-success">
											98% <i class="fa fa-level-up"></i>
										</div>
										<small>当月总请求数</small>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<span class="label label-info pull-right">当前</span>
										<h5>号码</h5>
									</div>
									<div class="ibox-content">
										<h2 class="no-margins">${data.numberCount }</h2>
										<small>申请号码数</small>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<span class="label label-danger pull-right">今天</span>
										<h5>消耗</h5>
									</div>
									<div class="ibox-content">
										<h2 class="no-margins">${data.todayConsume }</h2>
										<div class="stat-percent font-bold text-navy">
											44% <i class="fa fa-level-up"></i>
										</div>
										<small>今日消耗</small>
									</div>
								</div>
							</div>
							<div class="col-sm-2">
								<div class="ibox float-e-margins">
									<div class="ibox-title">
										<span class="label label-danger pull-right">今天</span>
										<h5>请求</h5>
									</div>
									<div class="ibox-content">
										<h2 class="no-margins">${data.todayRequest }</h2>
										<div class="stat-percent font-bold text-success">
											98% <i class="fa fa-level-up"></i>
										</div>
										<small>今日总请求数</small>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="pro-box my-pro row-fluid">
					<div class="col-sm-12"
						style="padding-right: 20px; margin-left: -6px; margin-top: 20px;">
						<div class="tabs-container">
							<ul class="nav nav-tabs" style="margin-bottom: 0px;">
								<li class="active"><a data-toggle="tab" href="#tab-1"
									aria-expanded="true">产品介绍</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2"
									aria-expanded="false">应用管理</a></li>
								<li class=""><a data-toggle="tab" href="#tab-3"
									aria-expanded="false">号码管理</a></li>
								<li class=""><a data-toggle="tab" href="#tab-4"
									aria-expanded="false">消耗分析</a></li>
								<li class=""><a data-toggle="tab" href="#tab-5"
									aria-expanded="false">接口说明</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">
										<div class="col-sm-4">
											<img alt="" src="/resources/img/u3027.png"
												style="height: 400px;">
										</div>
										<div class="col-sm-8">
											<p>
												<span>&nbsp;Lorem ipsum dolor sit amet, consectetur
													adipiscing elit. Aenean euismod bibendum laoreet. Proin
													gravIDa dolor sit amet lacus accumsan et viverra justo
													commodo. Proin sodales pulvinar tempor. Cum sociis natoque
													penatibus et magnis dis parturient montes, nascetur
													rIDiculus mus. Nam fermentum, nulla luctus pharetra
													vulputate, felis tellus mollis orci, sed rhoncus sapien
													nunc eget.</span>
											</p>

											<div style="">
												<img alt="" src="/resources/img/u3031.png">
											</div>
										</div>
									</div>
								</div>
								<div id="tab-2" class="tab-pane">
									<div class="panel-body">
										<iframe width="100%" height="800px"
											src="<%=path%>/app/editAppInfo?productType=3" frameborder="0"
											seamless></iframe>
									</div>
								</div>
								<div id="tab-3" class="tab-pane">
									<div class="panel-body">
										<iframe width="100%" height="800px"
											src="<%=path%>/number/numberList?productType=3"
											frameborder="0" seamless></iframe>
									</div>
								</div>
								<div id="tab-4" class="tab-pane">
									<div class="panel-body">
										<strong>移动设备优先</strong>
										<p>在 Bootstrap 2 中，我们对框架中的某些关键部分增加了对移动设备友好的样式。而在 Bootstrap
											3
											中，我们重写了整个框架，使其一开始就是对移动设备友好的。这次不是简单的增加一些可选的针对移动设备的样式，而是直接融合进了框架的内核中。也就是说，Bootstrap
											是移动设备优先的。针对移动设备的样式融合进了框架的每个角落，而不是增加一个额外的文件。</p>
									</div>
								</div>
								<div id="tab-5" class="tab-pane">
									<div class="panel-body">
										<strong>移动设备优先</strong>
										<p>在 Bootstrap 2 中，我们对框架中的某些关键部分增加了对移动设备友好的样式。而在 Bootstrap
											3
											中，我们重写了整个框架，使其一开始就是对移动设备友好的。这次不是简单的增加一些可选的针对移动设备的样式，而是直接融合进了框架的内核中。也就是说，Bootstrap
											是移动设备优先的。针对移动设备的样式融合进了框架的每个角落，而不是增加一个额外的文件。</p>
									</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {

	})
</script>
<!-- IE8按钮统一高度-->
<!--[if IE 8]>
<script type="text/javascript">
	$(function() {
		var winW = $(window).width();
		if (winW >=1472) {
			$(".pro-box .txt p").css('height', '42px');
		} else{
			$(".pro-box .txt p").css('height', '63px');
			$(".index .pro-box .box-fff").css('height', '148px');
		}
	})
</script>

<![endif]-->
</html>