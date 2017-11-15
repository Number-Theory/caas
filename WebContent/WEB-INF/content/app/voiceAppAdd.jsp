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
<title>开通应用</title>

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

input {
	height: 34px !important;
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
			<div class="content col-sm-15">
				<div class="con-box1 row-fluid">
					<h2 class="crumbs-menu" style="padding-left: 40px">
						<span class="crumbs" onClick="history.back();"></span>开通应用
					</h2>

					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm"
							action="<%=path%>/app/saveAddAppInfo" method="post">
							<input id="productType" name="productType"
								value="${data.productType }" type="hidden">

							<div class="form-group">
								<label class="col-sm-4 control-label">应用名称：</label>
								<div class="col-sm-3">
									<input id="" appName"" name="appName"
										value="${appMap.appName }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label">服务器白名单：</label>
								<div class="col-sm-3">
									<input id="ipWhiteList" name="ipWhiteList"
										value="${appMap.ipWhiteList }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
								<label class="col-sm-4 control-label" style="text-align: left;">多个用分号(;)隔开</label>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">状态回调地址：</label>
								<div class="col-sm-3">
									<input id="statusUrl" name="statusUrl"
										value="${appMap.statusUrl }" minlength="1" type="text"
										class="form-control" required="" aria-required="">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">挂机回调地址：</label>
								<div class="col-sm-3">
									<input id="hangupUrl" name="hangupUrl"
										value="${appMap.hangupUrl }" minlength="1" type="text"
										class="form-control" required="" aria-required="">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">录音回调地址：</label>
								<div class="col-sm-3">
									<input id="recordUrl" name="recordUrl"
										value="${appMap.recordUrl }" minlength="1" type="text"
										class="form-control" required="" aria-required="">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="submit">开通应用</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	
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