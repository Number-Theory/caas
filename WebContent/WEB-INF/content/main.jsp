<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s"  uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-cmn-Hans">
<head>
	<meta charset="UTF-8">
	<title>云之讯开发者控制台-首页</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/main/bootstrap.min.css">	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/main/style.css">
	<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/main/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/js/main/common.js"></script>
	<script type="text/javascript" src="<%=path%>/js/md5.js"></script>
	<script type="text/javascript" src="<%=path %>/js/form.js"></script>
<%-- 	<script type="text/javascript" src="<%=path%>/front/v-1.0/js/base.js"></script> --%>
</head>
<body class="isHomePage">
    <s:if test="#request.tm1_disp>0">
    <div class="note_mark" id="note_mark" style="background:#fdff5a; color:#f00; font-size:14px; 
    text-align: center; padding:5px 0px;">
    <marquee style="width:1180px; margin:0 auto;">
    	公告：尊敬的开发者（客户），由于近期大量终端手机用户向运营商投诉短信骚扰，导致我公司短信通道被运营商大面积关停，
    	严重影响公司短信业务正常运营及广大开发者的使用。经查，主要是由于超频发送导致用户投诉短信骚扰，目前运营商已在网关做了超频发送限制（1分钟只发1条，24小时只发3条）。
    	如违反发送规则，运营商对短信发送请求不予处理，但会正常扣费。为了大家能正常使用，请遵守运营商发送规则！
    </marquee></div></s:if>
	<div class="wrap container-fluid index">
		<div id="main">
			<div class="content">
				<!--消息弹窗 bof-->
                <div class="new_msg_box" id="new_msg_box" style='display:none;cursor:pointer;'>
    	           <p id="countMsgValue" value="${sessionScope.user.countMsg}" onclick="sendToNotice()">
    		         <span id="overOneMsg">亲爱的开发者，您有<a>${sessionScope.user.countMsg}</a>条未读消息，点击进入消息页面查看</span>
    		         <span id="oneMsg"></span>
    	           </p>
    	           <span class="close"></span>
                   <input id="count" value="${sessionScope.count}" type="hidden"/>
               </div>
	           <!--消息弹窗 eof-->
				<div class="con-box1 row-fluid">
					<div class="info span7">
						<h3>个人信息</h3>
						<div class="box-fff box1 clearfix">
							<div class="con-left clearfix">
								<div class="img"><img src="<%=path%>/page/controlPage/images/portrait.png" alt="用户头像" /></div>
								<div class="right">
									<div class="name">Hi , ${user.email }</div>
									<div class="identify">
<%-- 									    <s:if test="user.oauthStatus=='2'.toString() || user.oauthStatus== null"> --%>
									       <div class="no">
											  <span></span>
											  <a href="<%=path%>/user/userCenter"><small class="state">未认证</small></a>
										   </div>
<%-- 									    </s:if> --%>
									    <s:elseif test="user.oauthStatus=='3'.toString()">
									        <s:if test="user.userType=='1'.toString()">
									             <div class="yes">
											        <span></span>
											        <small class="state">个人开发者</small>
										         </div>
									        </s:if>
									        <s:elseif test="user.userType=='2'.toString()">
									             <div class="yes">
											        <span></span>
											        <s:if test="security.status == 4">
														<small class="state">协议认证开发者</small>
													</s:if>
													<s:else>
														<small class="state">企业开发者</small>
													</s:else>
										         </div>
									        </s:elseif>
									    </s:elseif>
									    <s:elseif test="user.oauthStatus=='4'.toString()">
									       <div class="no">
											  <span></span>
											  <small class="state">认证不通过</small>			
										   </div>
									    </s:elseif>
									</div>
									<div class="rest">账户余额：<span class="big-bold"> <s:property value="user.balance"/> </span>元</div>
									<div class="btn-div">
										<a href="<%=path %>/pay/newOrder" class="btn-style1 recharge">充值</a>
										<a class="btn-style5 js-show-dialog" data-dialog="js-reminder" href="javascript:void(0)">余额提醒</a>
									</div>
									<div class="standard">资费配置：<span class="green" onclick="returnFeeConfig()" style="cursor:pointer">${pck.packageName }</span></div>
								</div>
							</div>
							<div class="con-right">
								<div class="right-in">
									<p>接入参数</p>
									<dl>
										<dt>Account Sid</dt>
										<dd>${user.sid}</dd>
										<dt>Auth Token</dt>
										<dd class="eye-div">
<%-- 										    <s:if test="data.view_token_auth"> --%>
<%-- 								              <span id="span_token">${user.token}</span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="reset float_link1" style="color: green;">重置</a> --%>
<%-- 								            </s:if> --%>
<%-- 								            <s:else> --%>
								           	  <span id="span_token" class="token"></span><a href="#" id="" class="reset float_link" ><i class="js-show-dialog" data-dialog="js-mobile-valid"></i></a>
<%-- 								            </s:else> --%>
										</dd>
										<dt>API URL</dt>
										<dd>
										   <span>
										     <s:iterator value="paramsList" var="p">
							                   <s:if test="#p.paramKey==1">
							              	    ${p.paramValue}
							                   </s:if>
							                 </s:iterator>
							               </span>
										</dd>			
									</dl>
								</div>
							</div>
							<b class="line-v"></b>
						</div>
					</div>
					<div class="data span5">
						<h3>数据统计</h3>
						<div class="box-fff box2">
							<ul class="tab-ul clearfix">
								<li data-tab="yesterday" class="js-tab"><a class="active" href="javascript:;">昨天数据</a></li>
								<li data-tab="month" class="js-tab"><a href="javascript:;">当月数据</a></li>
							</ul>
							<div class="tablist">
								<div id="yesterday">
<%-- 									<s:if test="userHasApp.size()!=0"> --%>
										<ul class="clearfix">
											<li class="item item1">
												<span><i></i></span>
												<p class="txt">总共花费</p>
												<p class="price"><b><u:removeZero value="${yesterdayConsume.total == null ? '0.0000' : yesterdayConsume.total}" /></b>元</p>
												<b class="line-v"></b>
											</li>
											<s:set var="smsCount" value="0" />
											<s:iterator value="userHasApp" var="app">
						      					<s:if test="(#app.event_id==1 || #app.event_id==15) && #smsCount == 0">
						      						<s:set var="smsCount" value="1" />
													<li class="item item2 msg">
														<span><i></i></span>
														<p class="txt">发送短信</p>
														<p class="price"><b><u:removeZero value="${yesterdayConsume.smsCount == null ? '0' : yesterdayConsume.smsCount}" /></b>条</p>
														<b class="line-v"></b>	
													</li>
												</s:if>
												<s:elseif test="#app.event_id==2">
													<li class="item item3 voice-valid">
														<span><i></i></span>
														<p class="txt">语音验证</p>
														<p class="price"><b><u:removeZero value="${yesterdayConsume.verify_fee == null ? '0.0000' : yesterdayConsume.verify_fee}" /></b>元</p>
														<b class="line-v"></b>	
													</li>
												</s:elseif>
												<s:elseif test="#app.event_id==4">
													<li class="item item3 voice-notice">
														<span><i></i></span>
														<p class="txt">语音通知</p>
														<p class="price"><b><u:removeZero value="${yesterdayConsume.notice_fee == null ? '0.0000' : yesterdayConsume.notice_fee}" /></b>元</p>
														<b class="line-v"></b>	
													</li>
												</s:elseif>
												<s:elseif test="#app.event_id==13">
													<li class="item item3 voice-out">
														<span><i></i></span>
														<p class="txt">语音外呼 </p>
														<p class="price"><b><u:removeZero value="${yesterdayConsume.waihu_fee == null ? '0.0000' : yesterdayConsume.waihu_fee}" /></b>元</p>
														<b class="line-v"></b>	
													</li>
												</s:elseif>
												<s:elseif test="#app.event_id==6">
													<li class="item item3 cloud-api">
														<span><i></i></span>
														<p class="txt">云呼叫中心</p>
														<p class="price"><b><u:removeZero value="${yesterdayConsume.center_fee == null ? '0.0000' : yesterdayConsume.center_fee}" /></b>元</p>
													</li>
												</s:elseif>
											</s:iterator>
										</ul>
<%-- 									</s:if> --%>
<%-- 									<s:else> --%>
<!-- 										<p style="text-align: center;padding-top: 80px;"> 您还没接入任何产品喔~~</p> -->
<%-- 									</s:else> --%>
								</div>
								<div id="month" style="display: none;">
									<s:if test="userHasApp.size()!=0">
										<ul class="clearfix">
											<li class="item item1">
												<span><i></i></span>
												<p class="txt">总共花费</p>
												<p class="price"><b><u:removeZero value="${monthConsume.total == null ? '0.0000' : monthConsume.total}" /></b>元</p>
												<b class="line-v"></b>
											</li>
											<s:set var="smsCount" value="0" />
											<s:iterator value="userHasApp" var="app">
						      					<s:if test="(#app.event_id==1 || #app.event_id==15) && #smsCount == 0">
						      						<s:set var="smsCount" value="1" />
													<li class="item item2 msg">
														<span><i></i></span>
														<p class="txt">发送短信</p>
														<p class="price"><b><u:removeZero value="${monthConsume.smsCount == null ? '0' : monthConsume.smsCount}" /></b>条</p>
														<b class="line-v"></b>	
													</li>
												</s:if>
												<s:elseif test="#app.event_id==2">
													<li class="item item3 voice-valid">
														<span><i></i></span>
														<p class="txt">语音验证</p>
														<p class="price"><b><u:removeZero value="${monthConsume.verify_fee == null ? '0.0000' : monthConsume.verify_fee}" /></b>元</p>
														<b class="line-v"></b>	
													</li>
												</s:elseif>
												<s:elseif test="#app.event_id==4">
													<li class="item item3 voice-notice">
														<span><i></i></span>
														<p class="txt">语音通知</p>
														<p class="price"><b><u:removeZero value="${monthConsume.notice_fee == null ? '0.0000' : monthConsume.notice_fee}" /></b>元</p>
														<b class="line-v"></b>	
													</li>
												</s:elseif>
												<s:elseif test="#app.event_id==13">
													<li class="item item3 voice-out">
														<span><i></i></span>
														<p class="txt">语音外呼 </p>
														<p class="price"><b><u:removeZero value="${monthConsume.waihu_fee == null ? '0.0000' : monthConsume.waihu_fee}" /></b>元</p>
														<b class="line-v"></b>	
													</li>
												</s:elseif>
												<s:elseif test="#app.event_id==6">
													<li class="item item3 cloud-api">
														<span><i></i></span>
														<p class="txt">云呼叫中心</p>
														<p class="price"><b><u:removeZero value="${monthConsume.center_fee == null ? '0.0000' : monthConsume.center_fee}" /></b>元</p>
													</li>
												</s:elseif>
											</s:iterator>
										</ul>
									</s:if>
									<s:else>
										<p style="text-align: center;padding-top: 80px;"> 您还没接入任何产品喔~~</p>
									</s:else>
								</div>
							</div>
						</div>			
					</div>
				</div>

                   <div class="pro-box my-pro row-fluid">
					<h3>常用产品</h3>
<%-- 					   <s:iterator value="userHasApp" var="app"> --%>
					          <div class="box3 span4">
						          <div class="box-fff clearfix">
							      <div class="pro-flag pro-flag1"></div>
							      <div class="txt">
								    <h4>验证码短信</h4>
                                    <p>高达99%到达率 ，三网合一，API一键接入即享短信验证、短信通知极速达。</p>
                                    <div class="pro-btn clearfix">
									    <a class="btn-style4 ft-l" href="<%=path%>/app/product/message">进入产品</a>
									    <a href="<%=path%>/package/userDefindPackage?eventId=<u:des3 value='1005'/>&paramId=<u:des3 value='1'/>" class="package-pay-btn ft-l">特惠套餐包</a>
								    </div>
							      </div>
							      <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						          </div>
					          </div>
<%-- 					      </s:if> --%>
<%-- 					      <s:elseif test="#app.event_id==2"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag2"></div>
							         <div class="txt">
								       <h4>语音验证</h4>
								       <p>注册客户0流失，100%验证到达,配合短信验证双保险</p>
<%-- 								       <p>当月消费：<span class="big-bold">${monthConsume.verify_fee == null ? "0.0000" : monthConsume.verify_fee}</span>元</p> --%>
								       <a class="btn-style4" href="<%=path %>/app/product/voiceVerify">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==15"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag15"></div>
							         <div class="txt">
								        <h4>通知服务短信</h4>
								        <p>提供安全、稳定的通讯通道，到达率高达99%，满足多种服务短信需求</p>
<%-- 								       <p>当月消费：<span class="big-bold">${monthConsume.verify_fee == null ? "0.0000" : monthConsume.verify_fee}</span>元</p> --%>
                                        <div class="pro-btn clearfix">
									       <a class="btn-style4 ft-l" href="<%=path %>/app/product/smsMarket">进入产品</a>
									       <a href="<%=path%>/package/userDefindPackage?eventId=<u:des3 value='1046'/>&paramId=<u:des3 value='15'/>" class="package-pay-btn ft-l">特惠套餐包</a>
								        </div>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==14"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag14"></div>
							         <div class="txt">
								       <h4>电话会议</h4>
								       <p>基于电话网络的一对一或多方通话产品，对外提供丰富的SDK和API接口</p>
<%-- 								       <p>当月消费：<span class="green big-bold">${monthConsume.huiyi_fee == null ? "0.0000" : monthConsume.huiyi_fee}</span>元</p> --%>
								       <a class="btn-style4" href="<%=path %>/app/product/teleconference">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==13"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag13"></div>
							         <div class="txt">
								       <h4>语音外呼</h4>
								       <p>提供双向外呼、单向外呼能力</p>
<%-- 								       <p>当月消费：<span class="big-bold">${monthConsume.waihu_fee == null ? "0.0000" : monthConsume.waihu_fee}</span>元</p> --%>
								       <a class="btn-style4" href="<%=path %>/app/product/outBandCall">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==4"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag4"></div>
							         <div class="txt">
								       <h4>语音通知</h4>
								       <p>集体通知，自动拨打用户电话号码播报语音通知，一分钟通知600人以上</p>
<%-- 								       <p>当月消费：<span class="big-bold">${monthConsume.notice_fee == null ? "0.0000" : monthConsume.notice_fee}</span>元</p> --%>
								       <a class="btn-style4" href="<%=path %>/app/product/voiceNotice">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==5"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag5"></div>
							         <div class="txt">
								       <h4>隐号通话</h4>
								       <p>为主被叫双方分别分配临时虚拟号码,解决交易平台等用户隐私泄露问题</p>
								       <a class="btn-style4" href="<%=path %>/app/product/hiddenCall">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==6"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag6"></div>
							         <div class="txt">
								       <h4>云呼叫中心</h4>
								       <p>在提供云呼叫中心能力服务基础上，集成互联网语音通话、语音视频能力服务</p>
<%-- 								       <p>当月消费：<span class="big-bold">${monthConsume.center_fee == null ? "0.0000" : monthConsume.center_fee}</span>元</p> --%>
								       <a class="btn-style4" href="<%=path %>/app/product/cloudService">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==7"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag7"></div>
							         <div class="txt">
								       <h4>即时通讯</h4>
								       <p>稳定高冗余，支持单/群聊，讨论组，推送，支持自定义可扩展的语义消息媒体接口</p>
								       <a class="btn-style4"  href="<%=path%>/app/product/im">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==9"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag9"></div>
							         <div class="txt">
								       <h4>互联网音视频通话</h4>
								       <p>有网络即可享受语音、视频通话，可应用物联网、在线客服、在线教育等场景</p>
<%-- 								       <p>当月消费：<span class="big-bold">${monthConsume.video_fee == null ? "0.0000" : monthConsume.video_fee}</span>元</p> --%>
								       <a class="btn-style4" href="<%=path%>/app/product/voiceVideoCall">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					      <s:elseif test="#app.event_id==11"> --%>
					          <div class="box4 span4">
						          <div class="box-fff clearfix">
							         <div class="pro-flag pro-flag11"></div>
							         <div class="txt">
								       <h4>充流量</h4>
								       <p>页面流量直充，支持移动，联通，电信全国号码，支持批量手机号充流量，2/3/4G可使用</p>
<%-- 								       <p>当月消费：<span class="big-bold">${monthConsume.video_fee == null ? "0.0000" : monthConsume.video_fee}</span>元</p> --%>
								       <a class="btn-style4" href="<%=path%>/app/product/flow">进入产品</a>
							         </div>
							         <div class="delete-icon flag-tip" onclick="removeUsualProduct('${app.event_id }')"><i class="for-tips">从常用移除</i></div>
						           </div>						
					         </div>
<%-- 					      </s:elseif> --%>
<%-- 					   </s:iterator> --%>
				</div>
			</div>
		</div>
	</div>
	
	<div class="background_box" style="display: none"></div>
	<!--弹层(短信号码) eof--> 
    <s:if test="data.view_token_auth">
	    <!--弹层(开发者账号重置) bof-->
	    <div class="float_box reset_box" id="reset_box" style="display:none;width: 600px;">
	      <div class="float_tit">
	        <h1>重置token</h1>
	      </div>
	      <div class="float_ctn">
	        <s:form method="post" name="resetForm" namespace="/user" action="resetToken" theme="simple">
	          <p>Auth token是主账户的唯一密码，进行重置token后，旧的token将不可用，故在重置前请慎重考虑是否进行此项动作。云之讯团队建议只有在发现您的账户存在被盗用的可能下才进行重置操作，并使用新的tokne进行更新。</p>
	          <p>
	          	<span id="new_token"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a href="###" onclick="renewToken(2);">重新生成</a>
	          </p>
	          <p class="checkbox"><input type="checkbox" style="float:none;"/>立即生效（旧token将不可再用）</p>
	          <div class="float_btn">
	            <input type="submit" value="确 定" disabled="disabled" class="confirm_btn"/>
	            <input type="button" value="取 消" class="cancel_btn" />
	          </div>
	        </s:form>
	      </div>
	    </div>
    </s:if>

    <!-- 引导页面 -->
	<div class="guide-bg"></div>
	<div class="guide-box index">
        <div class="slider-box old-user hide">
            <ul class="slides-list clearfix">
                <li class="item1">
	                <div class="abs-img">
	                	<img src="<%=path%>/page/controlPage/images/idx-guide-img1.png" />
	                </div>
					<div class="con">
						<div class="img">
							<img src="<%=path%>/page/controlPage/images/idx-guide-bg1.png" />
						</div>
						<h3>点击进入产品管理页</h3>
						<p>完成对产品语音文件、模板、号码管理等管理操作</p>
						<a href="javascript:;" class="btn-style4 step1">继续了解</a>
					</div>
                </li>
                <li class="item2">
	                <div class="abs-img">
	                	<img src="<%=path%>/page/controlPage/images/idx-guide-img2.png" />
	                </div>
					<div class="con">
						<div class="img">
							<img src="<%=path%>/page/controlPage/images/idx-guide-bg2.png" />
						</div>
						<h3>API接入调试时，身份鉴权需用到</h3>
						<a href="javascript:;" class="btn-style4 step-last">知道了</a>
					</div>
                </li>
            </ul>
            <ol class="circle-btn">
            	<li class="item1 active" data-num="0"></li>
            	<li class="item2" data-num="1"></li>
            </ol>
        </div>
        <div class="slider-box new-user hide">
            <ul class="slides-list clearfix">
                <li class="item1">
	                <div class="abs-img">
	                	<img src="<%=path%>/page/controlPage/images/idx-guide-img1-1.png" />
	                </div>
					<div class="con">
						<div class="img">
							<img src="<%=path%>/page/controlPage/images/idx-guide-bg1.png" />
						</div>
						<h3>点击进入产品管理页，指南助您快速接入</h3>
						<a href="javascript:;" class="btn-style4 step1">继续了解</a>
					</div>
                </li>
                <li class="item2">
	                <div class="abs-img">
	                	<img src="<%=path%>/page/controlPage/images/idx-guide-img2.png" />
	                </div>
					<div class="con">
						<div class="img">
							<img src="<%=path%>/page/controlPage/images/idx-guide-bg2.png" />
						</div>
						<h3>API接入调试时，身份鉴权需用到</h3>
						<a href="javascript:;" class="btn-style4 step-last">知道了</a>
					</div>
                </li>
            </ul>
            <ol class="circle-btn">
            	<li class="item1 active" data-num="0"></li>
            	<li class="item2" data-num="1"></li>
            </ol>
        </div>
        <div class="close-img"><img src="<%=path%>/page/controlPage/images/guide-close-icon.png" alt="关闭" /></div>
	</div>
	
	<!-- 模态框 -->
	<div class="dialog-bg"></div>
	<div class="dialog-box">
		<div class="reminder dialog" style="display: none;">
			<h6>余额提醒</h6>
			<form action="<%=path%>/user/balanceRemind" method="post" id="remindForm" >
				<div class="group clearfix">
					<label>当前绑定手机</label>
					<p style="font-size: 20px;">${data.finance.mobile}</p>
				</div>
				<div class="group clearfix">
					<label>当前账户余额低于</label>
					<div class="unit">
<!-- 						<input type="text" name="restMoney" /> -->
						<input type="text" id="money" name="remind.money" value="${data.finance.remind_money}" maxlength="8" onblur="checkRemind(this.value)"/>
						<span>元</span>后提醒
						<p style="display:none; color:red;" id="error_money" >输入余额必须为整数</p>
					</div>
				</div>
				<div class="group clearfix">
					<label>提醒方式</label>
					<p>短信提醒</p>
				</div>
				<div class="div-btn">
<!-- 					<a href="javascript:void(0)" class="btn-style4 sure">确定</a> -->
					<input style="border: 0;" type="submit" class="btn-style4 sure" value="确定"/>
					<a href="javascript:void(0)" class="btn-style5 cancel">取消</a>
				</div>
				<input type="hidden" id="credit_balance" value="${data.finance.credit_balance}"/>
				<input type="hidden" id="isClear" name="isClear" value="0"/>
			</form>
			<p class="p-blue" style="margin-left: 75px;">*金额为空时则无余额提醒</p>
		</div>
		<div class="mobile-valid dialog" style="display: none;">
			<h6>验证手机</h6>
			<form action="/user/verifyMobileForToken" method="post" name="phoneForm" id="phone_form">
				<div class="group clearfix">
					<label>手机号码</label>
					<span id="mobile"></span>
				</div>
				<div class="group img-code clearfix">
					<label>图片验证码</label>
					<input type="text" name="imgCode" class="js-msg-code js-trigger-by-enter valid-code imgCode" data-type="msg" placeholder="请输入图片验证码"/>
                    <img class="js-load-code"  data-target="expCode-msg" id="expCode-msg" src="${pageContext.request.contextPath}/checkcode/picCheckCode?checkCodeId=${data.checkCodeId }" />
                    <span class="error imgCode-error" data-msg-tip="imgCode"></span>
                    <input type="hidden" value="${data.checkCodeId }" id="checkCodeId"/>
                    <input type="hidden" id="flag"/>
				</div>
				<div class="group clearfix">
					<label>验证方式</label>
					<input type="button" class="btn-style2" value="短信验证码" onclick="codeAjax('sms','smscodeinput','voicecodeinput','短信验证码')" id="smscodeinput"/> 
					<span style="padding:0 10px;">或</span> 
					<input type="button" class="btn-style2" value="语音验证码" onclick="codeAjax('voicecode','voicecodeinput','smscodeinput','语音验证码');" id="voicecodeinput"/>
				</div>
				<div class="group clearfix">
					<label>验证码</label>
					<input type="text" placeholder="请输入验证码" id="inputmovecode" name="viewTokenCode"/>
					<span class="error" id="move_phone_code_error" style="display:none"></span>
				</div>
				<div class="div-btn">
					<input style="border: 0;" type="submit" class="btn-style4 sure" value="确定" id="submit_verifyMobileForToken"/>
					<a href="javascript:void(0)" class="btn-style5 cancel" onclick="refreshMsg()">取消</a>
				</div>
				<input type="hidden" id="vmovecode"  />
             	<input type="hidden" id="movecode"  />
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
	
	debugger;
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
	 //整点刷新
	  self.setInterval("fresh()",1000);
	  //今日消费
// 	  getTodayConsumeInfo("voice");
	  
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
		
		var guide = '${user.guide }';
		var userCreateTime = '${user.createDate.getTime()}';
		var timeLine = "1482595200000"; // 上线时间
		
		var isReadHomePageGuide = getcookie("isReadHomePageGuide");
		
		if (guide == 0 && isReadHomePageGuide == null) {
			if (userCreateTime > timeLine) {
				$(".new-user").show();
				$(".old-user").hide();
			} else {
				$(".new-user").hide();
				$(".old-user").show();
			}
			$(".guide-bg").show();
			$(".guide-box").show();
		}
});

//获取今天的消费信息，指定格式数据
 function getTodayConsumeInfo(type){
	   var title = "";
	   var url = "" ;
	   var typeTitile = "";
	   if(type=="voice"){
		   url = "todayVoiceCs"; 
		   title="今天的语音消费" ;
		   typeTitile = "元" ;
	   }else if(type=="sms"){
		   url = "todaySmsCs"; 
		   title="今天的SMS消息发送" ;
		   typeTitile = "条" ;
	   }else if(type=="im"){
		   url = "todayImCs"; 
		   title="今天的IM消息发送" ;
		   typeTitile = "条" ;
	   }else if(type=="voicecheckcode"){
		   url = "todayVoicecheckcodeCs"; 
		   title="今天的语音验证码发送" ;
		   typeTitile = "条" ;
	   }else if(type=="client"){
		   url = "todayClientCs";
		   title="今天的client活跃" ;
		   typeTitile = "个" ;
	   }else if(type=="yunsms"){
		   url = "todayCloudCs";
		   title="今天的智能验证消费" ;
		   typeTitile = "元" ;
	   }else if(type="voicenotify"){
		   url = "todayVoicenotifyCs";
		   title="今天的语音通知消费";
		   typeTitile = "元";
	   }
	   $.ajax({
			url:"<%=path%>/user/"+url,
			type:"post",
			dataType: "text",
			success: function (data) {
					data = eval("("+data+")");
				drawTodayConsumeInfo(data,title,typeTitile);
	        }
		});
	   
 }
 
function drawTodayConsumeInfo(data,text,typeTitile){
		chart = new Highcharts.Chart({
			chart: {
	            renderTo: 'drawDiv',
	            defaultSeriesType: 'spline',
	            events: {
	                //load: requestData
	            }
	        },
         title: {
             text: text,
             x: -20 //center
         },
         subtitle: {
             text: '',
             x: -20
         },
         xAxis: {
             categories: ['0', '1', '2', '3', '4',
                          '5','6','7',
                          '8', '9', '10', '11', '12', '13',
                          '14', '15', '16', '17', '18', '19',
                          '20', '21', '22', '23'
                          ],
             gridLineWidth: 1, //设置网格宽度为1 
             lineWidth: 1,  //基线宽度 
             labels:{y:20}  //x轴标签位置：距X轴下方26像素
	            
         },
         yAxis: {
             title: {
                 text: '' //左侧边栏
             },
             min:0,
             lineWidth: 1, //基线宽度 
             plotLines: [{
                 value: 0,
                 width: 1,
                 color: '#808080'
             }]
         },
    		//去掉线上的点
	        plotOptions:{ 
	            series:{
	                marker:{
	                    enabled:false
	                }
	            }
	        },
         tooltip: {
             valueSuffix: typeTitile
         },
         //设置图例
         legend: {
         	enabled:false //去掉图例
         },
    		//右下角不显示LOGO 
	        credits: { 
	            enabled: false   
	        },
         series:data
     });
 }
 
 
 function fresh(){
	  var myDate = new Date();
	  var min = myDate.getMinutes();     //获取当前分钟数(0-59)
	  var sec = myDate.getSeconds();     //获取当前秒数(0-59)
	  if(min==0 && sec==30){
		  //今日消费
// 			  getTodayConsumeInfo("voice");
	  }
 }



  function ringVoice(){
	  location.href="<%=path %>/app/ring/queryVoice";
  }
  
  function returnFeeConfig(){
	  location.href="<%=path %>/user/feeConfig";
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
		  window.location.href="<%=path %>/user/notice";
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
			$("#oauthTypeAll").attr('href','<%=path %>/user/userCenter');
		}
	}
	
// 	function backStatusAll(){
// 		$("#oauthTypeAll").text("进入产品");
// 		$("#oauthTypeAll").removeClass("red-border");
// 		$("#oauthTypeAll").attr('href','');
// 	}
	
	function refreshMsg(){
		$(".js-load-code").click();
		$(".imgCode-error").text("").show();
		$(".js-msg-code").val("");
		$("#mobile").val("");
		$("#inputmovecode").val("");
	}
	
	$(".js-msg-code").blur(function(){
		var code = $(".js-msg-code").val();
		_checkCode(code, function(result){
			result = $.trim(result);
			if(result!='2'){
				//验证码正确
				$(".imgCode-error").text("").hide();
				$("#flag").val("1");
				return true;
			}else{
				if(code==null||code==''){
					$(".imgCode-error").text("验证码不能为空").show();
				}else{
					$(".imgCode-error").text("验证码错误").show();
				}
				$("#flag").val("2");
				return false;
			}
		}, function(){
		});
	});
	
	//检查验证码是否正确
	var _checkCode = function(code, callback, error){
		var url = "/page/user/checkcode.jsp";
		var data = "checkCode=" + code +"&checkCodeId=" + $("#checkCodeId").val();
		var dataType = "text";
		var type = "post";
		fetch(url, data, type, function(result){
			callback && callback(result);
		}, function(){
			error && error();
		}, dataType, false);
	};
	
	function checkMessageCode(){
		var code = $(".js-msg-code").val();
		var msgType = $(".js-msg-code").attr("data-type");
		_checkCode(code, function(result){
			result = $.trim(result);
			if(result!='2'){
				//验证码正确
				$(".imgCode-error").text("").hide();
				$("#flag").val("1");
				return true;
			}else{
				if(code==null||code==''){
					$(".imgCode-error").text("验证码不能为空").show();
				}else{
					$(".imgCode-error").text("验证码错误").show();
				}
				$("#flag").val("2");
				return false;
			}
		}, function(){
		});
	}
	
	$("body").delegate(".js-load-code", "click", function(){
		var targetId = $(this).attr("data-target");
		var targetImg = $("#" + targetId);
		var oldSrc = targetImg.attr("src");
		var str = "noCache=" +new Date().getTime();
		if(oldSrc.indexOf("?") === -1){
			var newSrc = oldSrc + "?"+str;
		}else{
			if(oldSrc.indexOf("&") === -1){
				var newSrc = oldSrc + "&" + str;
			}else{
				var newSrc = oldSrc.substring(0,oldSrc.indexOf("&")) + "&" + str;
			}
		}
		targetImg.attr("src", newSrc);
	});
	
	
	var fetch = function(url, data, type, success, error, dataType, async){
		type = type || "post";
		dataType = dataType || "json";
		if(typeof(async) === "undefined"){
			async = true;
		}
		$.ajax({
			type:type,
			url: url,
			async:async,
			dataType: dataType,
			data: data,
			success: function(ret){
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