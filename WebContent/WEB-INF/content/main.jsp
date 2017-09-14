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
												class="js-show-dialog" data-dialog="js-mobile-valid"></i></a>
										</span>
									</div>
									<div class="standard">
										资费配置：<span class="green" onclick="returnFeeConfig()"
											style="cursor: pointer">标准档</span>
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
													<b>${yesterdayConsume.total == null ? '0.00' : yesterdayConsume.total}</b>元
												</p> <b class="line-v"></b></li>
											<s:set var="voiceNotify" value="0" />
											<li class="item item2 msg"><span><i></i></span>
												<p class="txt">语音通知</p>
												<p class="price">
													<b>${yesterdayConsume.voiceNotify == null ? '0.00' : yesterdayConsume.voiceNotify}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-valid"><span><i></i></span>
												<p class="txt">语音验证</p>
												<p class="price">
													<b>${yesterdayConsume.voiceCode == null ? '0.00' : yesterdayConsume.voiceCode}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-notice"><span><i></i></span>
												<p class="txt">隐号通话</p>
												<p class="price">
													<b>${yesterdayConsume.safetyCall == null ? '0.00' : yesterdayConsume.safetyCall}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">虚拟小号</p>
												<p class="price">
													<b>${yesterdayConsume.minNum == null ? '0.00' : yesterdayConsume.minNum}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">双向外呼</p>
												<p class="price">
													<b>${yesterdayConsume.callback == null ? '0.00' : yesterdayConsume.callback}</b>元
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
													<b>${monthConsume.total == null ? '0.0000' : monthConsume.total}</b>元
												</p> <b class="line-v"></b></li>
											<s:set var="voiceNotify" value="1" />
											<li class="item item2 msg"><span><i></i></span>
												<p class="txt">语音通知</p>
												<p class="price">
													<b>${monthConsume.voiceNotify == null ? '0.00' : monthConsume.voiceNotify}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-valid"><span><i></i></span>
												<p class="txt">语音验证</p>
												<p class="price">
													<b>${monthConsume.voiceCode == null ? '0.00' : monthConsume.voiceCode}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-notice"><span><i></i></span>
												<p class="txt">隐号通话</p>
												<p class="price">
													<b>${monthConsume.safetyCall == null ? '0.00' : monthConsume.safetyCall}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">虚拟小号</p>
												<p class="price">
													<b>${monthConsume.minNum == null ? '0.00' : monthConsume.minNum}</b>元
												</p> <b class="line-v"></b></li>
											<li class="item item3 voice-out"><span><i></i></span>
												<p class="txt">双向外呼</p>
												<p class="price">
													<b>${monthConsume.callback == null ? '0.00' : monthConsume.callback}</b>元
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
										钱包余额：<span> <s:property value="user.balance" />
										</span>元
									</div>
									<div class="rest">
										透支能力：<span> 未开启 </span>
									</div>

									<div class="btn-div" style="padding: 10px 0 0 0;">
										<a href="<%=path%>/pay/newOrder" class="btn-style1 recharge">充值</a>
										<a class="btn-style5 js-show-dialog" data-dialog="js-reminder"
											href="javascript:void(0)">余额提醒</a>
									</div>
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

	<div class="background_box" style="display: none"></div>
	<!--弹层(短信号码) eof-->
	<s:if test="data.view_token_auth">
		<!--弹层(开发者账号重置) bof-->
		<div class="float_box reset_box" id="reset_box"
			style="display: none; width: 600px;">
			<div class="float_tit">
				<h1>重置token</h1>
			</div>
			<div class="float_ctn">
				<s:form method="post" name="resetForm" namespace="/user"
					action="resetToken" theme="simple">
					<p>Auth
						token是主账户的唯一密码，进行重置token后，旧的token将不可用，故在重置前请慎重考虑是否进行此项动作。云之讯团队建议只有在发现您的账户存在被盗用的可能下才进行重置操作，并使用新的tokne进行更新。</p>
					<p>
						<span id="new_token"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="###"
							onclick="renewToken(2);">重新生成</a>
					</p>
					<p class="checkbox">
						<input type="checkbox" style="float: none;" />立即生效（旧token将不可再用）
					</p>
					<div class="float_btn">
						<input type="submit" value="确 定" disabled="disabled"
							class="confirm_btn" /> <input type="button" value="取 消"
							class="cancel_btn" />
					</div>
				</s:form>
			</div>
		</div>
	</s:if>

	<!-- 模态框 -->
	<div class="dialog-bg"></div>
	<div class="dialog-box">
		<div class="reminder dialog" style="display: none;">
			<h6>余额提醒</h6>
			<form action="<%=path%>/user/balanceRemind" method="post"
				id="remindForm">
				<div class="group clearfix">
					<label>当前绑定手机</label>
					<p style="font-size: 20px;">${data.finance.mobile}</p>
				</div>
				<div class="group clearfix">
					<label>当前账户余额低于</label>
					<div class="unit">
						<!-- 						<input type="text" name="restMoney" /> -->
						<input type="text" id="money" name="remind.money"
							value="${data.finance.remind_money}" maxlength="8"
							onblur="checkRemind(this.value)" /> <span>元</span>后提醒
						<p style="display: none; color: red;" id="error_money">输入余额必须为整数</p>
					</div>
				</div>
				<div class="group clearfix">
					<label>提醒方式</label>
					<p>短信提醒</p>
				</div>
				<div class="div-btn">
					<!-- 					<a href="javascript:void(0)" class="btn-style4 sure">确定</a> -->
					<input style="border: 0;" type="submit" class="btn-style4 sure"
						value="确定" /> <a href="javascript:void(0)"
						class="btn-style5 cancel">取消</a>
				</div>
				<input type="hidden" id="credit_balance"
					value="${data.finance.credit_balance}" /> <input type="hidden"
					id="isClear" name="isClear" value="0" />
			</form>
			<p class="p-blue" style="margin-left: 75px;">*金额为空时则无余额提醒</p>
		</div>
		<div class="mobile-valid dialog" style="display: none;">
			<h6>验证手机</h6>
			<form action="/user/verifyMobileForToken" method="post"
				name="phoneForm" id="phone_form">
				<div class="group clearfix">
					<label>手机号码</label> <span id="mobile"></span>
				</div>
				<div class="group img-code clearfix">
					<label>图片验证码</label> <input type="text" name="imgCode"
						class="js-msg-code js-trigger-by-enter valid-code imgCode"
						data-type="msg" placeholder="请输入图片验证码" /> <img
						class="js-load-code" data-target="expCode-msg" id="expCode-msg"
						src="${pageContext.request.contextPath}/checkcode/picCheckCode?checkCodeId=${data.checkCodeId }" />
					<span class="error imgCode-error" data-msg-tip="imgCode"></span> <input
						type="hidden" value="${data.checkCodeId }" id="checkCodeId" /> <input
						type="hidden" id="flag" />
				</div>
				<div class="group clearfix">
					<label>验证方式</label> <input type="button" class="btn-style2"
						value="短信验证码"
						onclick="codeAjax('sms','smscodeinput','voicecodeinput','短信验证码')"
						id="smscodeinput" /> <span style="padding: 0 10px;">或</span> <input
						type="button" class="btn-style2" value="语音验证码"
						onclick="codeAjax('voicecode','voicecodeinput','smscodeinput','语音验证码');"
						id="voicecodeinput" />
				</div>
				<div class="group clearfix">
					<label>验证码</label> <input type="text" placeholder="请输入验证码"
						id="inputmovecode" name="viewTokenCode" /> <span class="error"
						id="move_phone_code_error" style="display: none"></span>
				</div>
				<div class="div-btn">
					<input style="border: 0;" type="submit" class="btn-style4 sure"
						value="确定" id="submit_verifyMobileForToken" /> <a
						href="javascript:void(0)" class="btn-style5 cancel"
						onclick="refreshMsg()">取消</a>
				</div>
				<input type="hidden" id="vmovecode" /> <input type="hidden"
					id="movecode" />
			</form>
		</div>
		<i class="close-d"></i>
	</div>
</body>
<script type="text/javascript">
$(function(){
	
	var money = $("#money").val();
	if(money!=null || money!=""){
		var result = verfiyMoneySmall_(money);
		if(result == true){
			money = Math.ceil(money);
			$("#money").val(money);
		}
	}
	
	var token = '${user.token}';
	var token1 = token.substring(0,11);
    var token2 = token.substring(21,32);
    var token0 = token1+"**********"+token2;
    $(".token").text(token0);
    
    var mobile = '${user.mobile}';
    var mobile1 = mobile.substring(0,3);
    var mobile2 = mobile.substring(7,11);
    var mobile0 = mobile1+"****"+mobile2;
    $("#mobile").html(mobile0);
	
	  $(".chart_box .tit ul li").click(function(){
		var li_index = $(this).index();
		$(".chart_box .ctn").find("div").eq(li_index).show().siblings("div").hide();
		$(this).addClass("active").siblings("li").removeClass("active");
	  });
	  
	  $(".reset_box input[type='checkbox']").click(function(){
           if($(this).attr("checked")){
			     $(".float_btn .confirm_btn").removeAttr("disabled");
			     $(".float_btn .confirm_btn").css("cursor","pointer");
			     $(".float_btn .confirm_btn").removeClass("disabled_btn");
           }else{
               $(".float_btn .confirm_btn").attr("disabled","disabled");
               $(".float_btn .confirm_btn").css("cursor","default");
               $(".float_btn .confirm_btn").addClass("disabled_btn");
           }
		});

	  //引导页面
		$(".circle-btn li").click(function() {
			var num = $(this).attr("data-num");
			$(".guide-box .slides-list").css('marginLeft', (-(num * 100)) + '%');
			$(this).addClass('active').siblings().removeClass('active');
		});
		$(".step1").click(function() {
			$(".guide-box .slides-list").css('marginLeft', '-100%');
			$(".circle-btn li").eq(1).addClass('active').siblings().removeClass('active');
		});
		$(".step2").click(function() {
			$(".guide-box .slides-list").css('marginLeft', '-200%');
			$(".circle-btn li").eq(2).addClass('active').siblings().removeClass('active');
		});
		$(".step-last").click(function() {
			$(".guide-bg").hide();
			$(".guide-box").hide();
			addcookie("isReadHomePageGuide","1",24*30);
		});
		$(".close-img").click(function() {
			$(".guide-bg").hide();
			$(".guide-box").hide();
			addcookie("isReadHomePageGuide","1",24*30);
		});
});


  function returnFeeConfig(){
	  location.href="<%=path%>/user/feeConfig";
  }
  
  $("#view_link").click(function(){
	  $("#view_token_box").show();
	  $(".background_box").show();
  });
  
	 /*-----------重置弹层---------------*/
  $("#reset_link").click(function(){
	  renewToken(1);
	  $("#reset_box").show();
	  $(".background_box").show();
  });
	 
$(".float_link1").click(function(){
	$("#reset_box").show();
	$(".background_box").show();
});
	 
  $(".cancel_btn").click(function(){
	  $("#view_token_box").fadeOut();
	  $(".background_box").fadeOut();
	  $("#reset_box").fadeOut();
  });
  
  function codeAjax(type,id,id2,msg){
	  checkMessageCode();
	  var flag = $("#flag").val();
	  if(flag=='1'){
		  $("#voicecodeinput").attr("disabled", true);
	  	  $("#smscodeinput").attr("disabled", true);
	  	  $("#voicecodeinput").addClass("grey-btn");
		  $("#smscodeinput").addClass("grey-btn");
	      $.ajax({
	        url:"<%=path%>/checkcode/check4token",
	        type:"post",
	        dataType: "text",
	        data:{'expType':type},
	        success: function (data) {
	      	  	var code = data.substring(0,1);
	      	  	if("0" == code){
	      	  		$("#movecode").val(data.substring(1));
	      	  	    time1(id,id2,msg);
	      	  	}else{
	      	  		 $("#move_phone_code_error").text("发送失败");
	                   $("#move_phone_code_error").fadeIn();
	                   $("#vmovecode").val(2);
	      	  	}
	            },
	            error: function (msg) {
	               $("#movecode").val("");
	            }
	      });
	  }
    }
  
  //验证码时间
   var wait = 120;
	         var time1 = function(id,id1,cc) {
	             if (wait == 0) {
	             	$("#"+id).removeAttr("disabled");
	             	$("#"+id1).removeAttr("disabled");
	             	$("#"+id).removeClass("grey-btn");
	             	$("#"+id1).removeClass("grey-btn");
	             	$("#"+id).val(cc);
	                 wait = 120;
	                 $("#movecode").val("");
	             } else {
	                 $("#"+id).attr("cursor", "pointer");
	                 $("#"+id).val( wait + "秒");
	                 wait--;
	                 setTimeout(function () {
	                     time1(id,id1,cc);
	                 },
	                 1000);
	             }
	         };
	         
	 function renewToken(type){
		  $.ajax({
		      url:"<%=path%>/user/renewToken",
		      type:"post",
		      dataType: "text",
		      data:{'resetTokenType':type},
		      success: function (data) {
		      $("#new_token").html(data);
		           }
		     });
	 }
	 
	 function sendToNotice(){
		  window.location.href="<%=path%>/user/notice";
	  }
	 
	 
	 $("#phone_form").submit(function(){
        	if(!compareMoveCode($("#inputmovecode").val())){
        		 $("#move_phone_code_error").fadeIn();
                 $("#move_phone_code_error").html("验证码错误");
                 return false;
        	}
            $("#move_phone_code_error").hide();
            return true;
      });
	 
	 
	 function compareMoveCode(value){
         var movecode = $("#movecode").val();
         value = hex_md5('${user.sid}'+value);
         if(movecode!=value){
           $("#move_phone_code_error").text("验证码不合法");
           $("#move_phone_code_error").fadeIn();
           return false;
         }
         $("#vmovecode").val(1);
         return true;
       }
	 
	//余额提醒
		$("#remindForm").submit(function(){
			  var money = $("#money").val();
			  money = $.trim(money);
			  var flag = checkRemind(money);
			  if(flag==false){
				  return flag;
			  }
			  var boo = true;
			  var credit_balance = $("#credit_balance").val();
			  //金额为空，不提醒
			  if(money==null || money==""){
				  $("#isClear").val("1");
				  return true;
			  }else{
				  $("#isClear").val("0");
			  }
			  if(credit_balance>0){
				  boo = verfiyMoneyNegtiveInt(money);
			  }else{
				  boo = verfiyMoney(money);
			  }
			  if(!boo){
				  $("#error_money").text("输入的余额必须为整数");
				  $("#error_money").fadeIn();
				  return false;
			  }
			  if(money<-credit_balance){
				  $("#error_money").text("已超出信用额度");
				  $("#error_money").fadeIn();
				  return false;
			  }
			  $("#error_money").hide();
			  return true;
		});
	
	function showAllProduct(){
		$("#product_step1").hide();
		$("#product_step3").show();
	}
	
	function checkRemind(money){
		var credit_balance = $("#credit_balance").val();
		var boo = true;
		if(credit_balance>0){
			boo = verfiyMoneyNegtiveInt(money);
		}else{
			boo = verfiyMoney(money);
		}
		
		if(money==null || money==""){
			return true;
		}
		
		if(boo == false){
			$("#error_money").text("输入的余额必须为整数").show();
	    	return false;
		}
		if(money<-credit_balance){
			$("#error_money").text("已超出信用额度").show();
			return false;
		}
		$("#error_money").hide();
		return true;
	}
	
	//移除常用产品
    function removeUsualProduct(eventId){
		location.href = "<%=path%>/app/product/removeUsualProduct?eventId="+ eventId + "&status=0";
	}
	
	//添加常用产品
	function addUsualProduct(eventId){
		location.href = "<%=path%>/app/product/removeUsualProduct?eventId="+ eventId + "&status=1";
	}
	
	function backStatus(){
		$("#oauthType").text("立即接入");
		$("#oauthType").removeClass("red-border");
		$("#oauthType").attr('href','');
	}
	
	function checkOauthStatusAll(){
		var userType = '${user.userType}';
		var oauthStatus = '${user.oauthStatus}';
		if(userType==2&&oauthStatus==3){//企业开发者认证通过
			$("#oauthTypeAll").text("进入产品");
			$("#oauthTypeAll").removeClass("red-border");
			$("#oauthTypeAll").attr('href','<%=path%>/app/product/removeUsualProduct?eventId=15&status=1');
		}else{
			$("#oauthTypeAll").text("需先企业认证");
			$("#oauthTypeAll").addClass("btn-style-red");
			$("#oauthTypeAll").removeClass("btn-style2");
			$("#oauthTypeAll").attr('href','<%=path%>
	/user/userCenter');
		}
	}

	// 	function backStatusAll(){
	// 		$("#oauthTypeAll").text("进入产品");
	// 		$("#oauthTypeAll").removeClass("red-border");
	// 		$("#oauthTypeAll").attr('href','');
	// 	}

	function refreshMsg() {
		$(".js-load-code").click();
		$(".imgCode-error").text("").show();
		$(".js-msg-code").val("");
		$("#mobile").val("");
		$("#inputmovecode").val("");
	}

	$(".js-msg-code").blur(function() {
		var code = $(".js-msg-code").val();
		_checkCode(code, function(result) {
			result = $.trim(result);
			if (result != '2') {
				//验证码正确
				$(".imgCode-error").text("").hide();
				$("#flag").val("1");
				return true;
			} else {
				if (code == null || code == '') {
					$(".imgCode-error").text("验证码不能为空").show();
				} else {
					$(".imgCode-error").text("验证码错误").show();
				}
				$("#flag").val("2");
				return false;
			}
		}, function() {
		});
	});

	//检查验证码是否正确
	var _checkCode = function(code, callback, error) {
		var url = "/page/user/checkcode.jsp";
		var data = "checkCode=" + code + "&checkCodeId="
				+ $("#checkCodeId").val();
		var dataType = "text";
		var type = "post";
		fetch(url, data, type, function(result) {
			callback && callback(result);
		}, function() {
			error && error();
		}, dataType, false);
	};

	function checkMessageCode() {
		var code = $(".js-msg-code").val();
		var msgType = $(".js-msg-code").attr("data-type");
		_checkCode(code, function(result) {
			result = $.trim(result);
			if (result != '2') {
				//验证码正确
				$(".imgCode-error").text("").hide();
				$("#flag").val("1");
				return true;
			} else {
				if (code == null || code == '') {
					$(".imgCode-error").text("验证码不能为空").show();
				} else {
					$(".imgCode-error").text("验证码错误").show();
				}
				$("#flag").val("2");
				return false;
			}
		}, function() {
		});
	}

	$("body").delegate(
			".js-load-code",
			"click",
			function() {
				var targetId = $(this).attr("data-target");
				var targetImg = $("#" + targetId);
				var oldSrc = targetImg.attr("src");
				var str = "noCache=" + new Date().getTime();
				if (oldSrc.indexOf("?") === -1) {
					var newSrc = oldSrc + "?" + str;
				} else {
					if (oldSrc.indexOf("&") === -1) {
						var newSrc = oldSrc + "&" + str;
					} else {
						var newSrc = oldSrc.substring(0, oldSrc.indexOf("&"))
								+ "&" + str;
					}
				}
				targetImg.attr("src", newSrc);
			});

	var fetch = function(url, data, type, success, error, dataType, async) {
		type = type || "post";
		dataType = dataType || "json";
		if (typeof (async) === "undefined") {
			async = true;
		}
		$.ajax({
			type : type,
			url : url,
			async : async,
			dataType : dataType,
			data : data,
			success : function(ret) {
				success && success(ret);
			}
		});
	};
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