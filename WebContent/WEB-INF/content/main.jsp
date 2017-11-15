<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
<meta charset="UTF-8">
<title>控制台-首页</title>
<%@include file="/resources/common/common.jsp"%>
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
</head>
<body class="isHomePage">
	<div class="wrap container-fluid index">
		<div id="main">
			<div class="content">
				<!--消息弹窗 eof-->
				<div class="con-box1 row-fluid">
					<div class="info span4">
						<h3>用户信息</h3>
						<div class="box-fff box1 clearfix">
							<div class="con-left clearfix">
								<div class="img">
									<img src="<%=path%>/resources/css/images/default_user.jpg"
										alt="用户头像" />
								</div>
								<div class="right">
									<div class="rest">Hi , ${user.email }</div>
									<div class="rest">
										认证状态：<span> <a href="<%=path%>/user/accountCertify"
											class="green"><small class="state"> <c:if
														test="${oauth != null && oauth.status == 0 }">已认证</c:if> <c:if
														test="${oauth != null && oauth.status == 1 }">审核中</c:if> <c:if
														test="${oauth != null && oauth.status == 2 }">审核失败</c:if>
													<c:if test="${oauth == null }">
											  未认证
										</c:if></small></a>
										</span>
									</div>
									<div class="rest">
										用户名称：<span> ${user.userName } </span>
									</div>

									<div class="small">
										UserID：<span> ${user.userId} </span>
									</div>
									<div class="small eye-div">
										Token：<span> <span id="span_token" class="token"></span><a
											href="#" id="" class="reset float_link"><i
												class="show-token"></i></a>
										</span>
									</div>
									<div class="standard">
										资费配置：<span class="green">标准档</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="data span5">
						<h3>消耗统计</h3>
						<div class="box-fff box2">
							<ul class="tab-ul clearfix">
								<li data-tab="yesterday" class="js-tab"><a class="active"
									href="javascript:;">昨天数据</a></li>
								<li data-tab="month" class="js-tab"><a href="javascript:;">当月数据</a></li>
							</ul>
							<div class="tablist">
								<div id="yesterday">
									<s:if test="userHasApp.size()!=0">
										<ul class="clearfix">
											<li class="item item1"><span><i></i></span>
												<p class="txt">总共花费</p>
												<p class="price">
													<b>${yesterdayConsume.total == null ? '0.00' : yesterdayConsume.total / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<s:set var="voiceNotify" value="0" />
											<li class="item item2 msg"><span><i></i></span>
												<p class="txt">语音通知</p>
												<p class="price">
													<b>${yesterdayConsume.voiceNotify == null ? '0.00' : yesterdayConsume.voiceNotify / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-valid"><span><i></i></span>
												<p class="txt">语音验证</p>
												<p class="price">
													<b>${yesterdayConsume.voiceCode == null ? '0.00' : yesterdayConsume.voiceCode / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-notice"><span><i></i></span>
												<p class="txt">隐号通话</p>
												<p class="price">
													<b>${yesterdayConsume.safetyCall == null ? '0.00' : yesterdayConsume.safetyCall / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">虚拟小号</p>
												<p class="price">
													<b>${yesterdayConsume.minNum == null ? '0.00' : yesterdayConsume.minNum / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">双向外呼</p>
												<p class="price">
													<b>${yesterdayConsume.callback == null ? '0.00' : yesterdayConsume.callback / 1000000}</b>元
												</p></li>
										</ul>
									</s:if>
									<s:else>
										<p style="text-align: center; padding-top: 80px;">
											您还没接入任何产品喔~~</p>
									</s:else>
								</div>
								<div id="month" style="display: none;">
									<s:if test="userHasApp.size()!=0">
										<ul class="clearfix">
											<li class="item item1"><span><i></i></span>
												<p class="txt">总共花费</p>
												<p class="price">
													<b>${monthConsume.total == null ? '0.0000' : monthConsume.total / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<s:set var="voiceNotify" value="1" />
											<li class="item item2 msg"><span><i></i></span>
												<p class="txt">语音通知</p>
												<p class="price">
													<b>${monthConsume.voiceNotify == null ? '0.00' : monthConsume.voiceNotify / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-valid"><span><i></i></span>
												<p class="txt">语音验证</p>
												<p class="price">
													<b>${monthConsume.voiceCode == null ? '0.00' : monthConsume.voiceCode / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-notice"><span><i></i></span>
												<p class="txt">隐号通话</p>
												<p class="price">
													<b>${monthConsume.safetyCall == null ? '0.00' : monthConsume.safetyCall / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">虚拟小号</p>
												<p class="price">
													<b>${monthConsume.minNum == null ? '0.00' : monthConsume.minNum / 1000000}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">双向外呼</p>
												<p class="price">
													<b>${monthConsume.callback == null ? '0.00' : monthConsume.callback / 1000000}</b>元
												</p></li>
										</ul>
									</s:if>
									<s:else>
										<p style="text-align: center; padding-top: 80px;">
											您还没接入任何产品喔~~</p>
									</s:else>
								</div>
							</div>
						</div>
					</div>

					<div class="data span3">
						<h3>账号状态</h3>
						<div class="box-fff box2 clearfix">
							<div class="con-left clearfix">
								<div class="right" style="margin-left: 10px; padding: 5px;">
									<div></div>
									<div class="rest">
										钱包余额：<span> ${user.balance / 1000000 }
										</span>元
									</div>
									<div class="rest">
										透支能力：<span> 未开启 </span>
									</div>

<!-- 									<div class="btn-div" style="padding: 10px 0 0 0;"> -->
<%-- 										<a href="<%=path%>/pay/newOrder" class="btn-style1 recharge">充值</a> --%>
<!-- 										<a class="btn-style5 js-show-dialog" data-dialog="js-reminder" -->
<!-- 											href="javascript:void(0)">余额提醒</a> -->
<!-- 									</div> -->
								</div>

								<ul class="tab-ul clearfix" style="margin: 10px 10px 10px 10px">

								</ul>

								<div class="tablist">
									<div id="yesterday">
										<ul class="clearfix">
											<c:forEach items="${lastFiveDayConsume }" var="item">
												<li class="item item4" style="font-size: 1px;">
													<p class="txt">${item.consumeDate }</p>
													<p class="price">
														<b>${item.total == null ? '0.00' : item.total}</b>元
													</p> <b class="line1-v"></b>
												</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="pro-box my-pro row-fluid">
					<h3>常用产品</h3>
					<div class="box4 span4">
						<div class="box-fff clearfix">
							<div class="pro-flag pro-flag2"></div>
							<div class="txt">
								<h4>语音验证码</h4>
								<p>注册客户0流失，100%验证到达,配合短信验证双保险</p>
								<s:if
									test="userHasAppFlag.app3 != null && userHasAppFlag.app3 == 0">
									<a class="btn-style2" href="<%=path%>/app/voiceCodeApp">进入产品</a>
								</s:if>
								<s:else>
									<a class="package-pay-btn" href="<%=path%>/app/voiceCodeApp">开通业务</a>
								</s:else>
							</div>
						</div>
					</div>
					<div class="box4 span4">
						<div class="box-fff clearfix">
							<div class="pro-flag pro-flag13"></div>
							<div class="txt">
								<h4>语音外呼</h4>
								<p>提供双向外呼、单向外呼能力</p>
								<s:if
									test="userHasAppFlag.app2 != null && userHasAppFlag.app2 == 0">
									<a class="btn-style2" href="<%=path%>/app/callbackApp">进入产品</a>
								</s:if>
								<s:else>
									<a class="package-pay-btn" href="<%=path%>/app/callbackApp">开通业务</a>
								</s:else>
							</div>
						</div>
					</div>
					<div class="box4 span4">
						<div class="box-fff clearfix">
							<div class="pro-flag pro-flag4"></div>
							<div class="txt">
								<h4>语音通知</h4>
								<p>集体通知，自动拨打用户电话号码播报语音通知，一分钟通知600人以上</p>
								<s:if
									test="userHasAppFlag.app4 != null && userHasAppFlag.app4 == 0">
									<a class="btn-style2" href="<%=path%>/app/voiceNotifyApp">进入产品</a>
								</s:if>
								<s:else>
									<a class="package-pay-btn" href="<%=path%>/app/voiceNotifyApp">开通业务</a>
								</s:else>
							</div>
						</div>
					</div>
					<div class="box4 span4">
						<div class="box-fff clearfix">
							<div class="pro-flag pro-flag5"></div>
							<div class="txt">
								<h4>隐号通话</h4>
								<p>为主被叫双方分别分配临时虚拟号码,解决交易平台等用户隐私泄露问题</p>
								<s:if
									test="userHasAppFlag.app0 != null && userHasAppFlag.app0 == 0">
									<a class="btn-style2" href="<%=path%>/app/safetyCallApp">进入产品</a>
								</s:if>
								<s:else>
									<a class="package-pay-btn" href="<%=path%>/app/safetyCallApp">开通业务</a>
								</s:else>
							</div>
						</div>
					</div>
					<div class="box4 span4">
						<div class="box-fff clearfix">
							<div class="pro-flag pro-flag6"></div>
							<div class="txt">
								<h4>虚拟小号</h4>
								<p>为主被叫双方分别分配临时虚拟号码,解决交易平台等用户隐私泄露问题</p>
								<s:if
									test="userHasAppFlag.app1 != null && userHasAppFlag.app1 == 0">
									<a class="btn-style2" href="<%=path%>/app/minNumApp">进入产品</a>
								</s:if>
								<s:else>
									<a class="package-pay-btn" href="<%=path%>/app/minNumApp">开通业务</a>
								</s:else>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(function(){
	debugger;
	var token = '${user.token}';
	var token1 = token.substring(0,11);
    var token2 = token.substring(21,32);
    var token0 = token1+"**********"+token2;
    var tmp = true;
    $(".token").text(token0);
	$('.show-token').click(function(){
		if(tmp == true) {
			$(".token").text(token);
			tmp = false;
		} else {
			$(".token").text(token0);
			tmp = true;
		}
	})
});

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