<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div class="certify-info">
	<h3>认证信息</h3>

	<!--oauthStatus  2:待认证 ,3:证件已认证(正常) 4：认证不通过 -->
	<s:if test="oauth==null">
		<div class="not-cert">
			<dl class="clearfix">
				<div class="group group1 clearfix">
					<dt>当前认证状态</dt>
					<dd>
						<a class="fail btn-style4" href="javascript:void(0)">未认证</a>
					</dd>
				</div>
				<div class="group clearfix">
					<ul class="clearfix">
<%-- 						<li class="item1"><span class="icon"></span> --%>
<!-- 							<h6>个人开发者</h6> -->
<!-- 							<div> -->
<%-- 								<a class="btn-style4" href="<%=path%>/user/updatePerson">申请个人认证</a> --%>
<!-- 							</div> -->
<!-- 							<p>* 可申请应用上线，正式商用产品</p></li> -->
						<li class="item2"><span class="icon"></span>
							<h6>企业开发者</h6>
							<div>
								<a class="btn-style4" href="<%=path%>/user/updateCompany">申请企业认证</a>
							</div>
							<p>* 可申请应用上线，且之后的应用上线可享秒上线服务</p>
							<p>* 可开启语音外呼服务</p>
							<p>* 号码管理等其他功能服务</p>
							<p>* 可申请协议认证（支持部分业务免审服务）</p>
							<p>* 可开启营销短信服务</p></li>
					</ul>
				</div>
		</div>
	</s:if>
	<!-- 个人开发者 -->
<%-- 	<s:if test="oauth!=null && oauth.authenticationType==1"> --%>
<!-- 		<div class="person-cert"> -->
<!-- 			<dl class="clearfix"> -->
<!-- 				<div class="btn-r"> -->
<%-- 					<s:if test="oauth.status==0"> --%>
<%-- 						<a class="btn-style4" href="<%=path%>/user/updateCompany">企业开发者认证</a> --%>
<%-- 					</s:if> --%>
<%-- 					<s:elseif test="oauth.status==1"> --%>
<%-- 						<a class="btn-style4" href="<%=path%>/user/updatePerson">重新个人认证</a> --%>
<%-- 						<a class="btn-style4" href="<%=path%>/user/updateCompany">企业开发者认证</a> --%>
<%-- 					</s:elseif> --%>
<%-- 					<s:if test="oauth.status==2"> --%>
<%-- 						<a class="btn-style4" href="<%=path%>/user/updatePerson">重新个人认证</a> --%>
<%-- 						<a class="btn-style4" href="<%=path%>/user/updateCompany">企业开发者认证</a> --%>
<%-- 					</s:if> --%>
<!-- 				</div> -->
<!-- 				<div class="group group1 clearfix"> -->
<!-- 					<dt>认证类型</dt> -->
<!-- 					<dd> -->
<%-- 						<span class="pass-icon"></span>个人开发者 --%>
<%-- 						<s:elseif test="oauth.status==1"> --%>
<!-- 							<a class="fail btn-style4" href="javascript:void(0)">待审核</a> -->
<%-- 						</s:elseif> --%>
<%-- 						<s:elseif test="oauth.status==0"> --%>
<!-- 							<a class="btn-style4" href="javascript:void(0)">认证成功</a> -->
<%-- 						</s:elseif> --%>
<%-- 						<s:elseif test="oauth.status==2"> --%>
<!-- 							<a class="fail btn-style4" href="javascript:void(0)">审核未通过</a> -->
<%-- 						</s:elseif> --%>
<!-- 					</dd> -->
<!-- 				</div> -->
<!-- 				<div class="group clearfix"> -->
<!-- 					<dt>真实姓名</dt> -->
<%-- 					<dd>${oauth.legalPerson }</dd> --%>
<!-- 				</div> -->
<!-- 				<div class="group clearfix"> -->
<!-- 					<dt>证件类型</dt> -->
<!-- 					<dd>身份证</dd> -->
<!-- 				</div> -->
<!-- 				<div class="group clearfix"> -->
<!-- 					<dt>证件号码</dt> -->
<!-- 					<dd> -->
<%-- 						<span class="txt">${oauth.legalPersonId}</span> --%>
<!-- 					</dd> -->
<!-- 				</div> -->
<!-- 				<div class="group clearfix"> -->
<!-- 					<dt>证件照片</dt> -->
<!-- 					<dd> -->
<!-- 						<img -->
<%-- 							src="<%=path%>/file/viewFast?remotePath=<u:des3 value='${oauth.legalPersonMeterial}'/>" --%>
<!-- 							alt="证件照片" /> -->
<!-- 					</dd> -->
<!-- 				</div> -->
<!-- 			</dl> -->
<!-- 		</div> -->
<%-- 	</s:if> --%>
	<!-- 企业开发者 -->
	<s:if test="oauth!=null && oauth.authenticationType==2">
		<div class="company-cert">
			<dl class="clearfix">
				<div class="btn-r">
					<s:if test="oauth.status==0">
					</s:if>
					<s:if test="oauth.status==1">
						<a class="btn-style4" href="<%=path%>/user/updateCompany">重新企业认证</a>
					</s:if>
					<s:if test="oauth.status==2">
						<a class="btn-style4" href="<%=path%>/user/updateCompany">重新企业认证</a>
					</s:if>
				</div>
				<div class="group group1 clearfix">
					<dt>认证类型</dt>
					<dd>
						<span class="pass-icon"></span> 企业开发者
						<s:elseif test="oauth.status==1">
							<a class="fail btn-style4" href="javascript:void(0)">待审核</a>
						</s:elseif>
						<s:elseif test="oauth.status==0">
							<a class="btn-style4" href="javascript:void(0)">认证成功</a>
						</s:elseif>
						<s:elseif test="oauth.status==2">
							<a class="fail btn-style4" href="javascript:void(0)">审核未通过</a>
						</s:elseif>
					</dd>
				</div>
				<div class="group clearfix">
					<dt>公司名称</dt>
					<dd>${oauth.userName}</dd>
				</div>
				<div class="group clearfix">
					<dt>公司注册地址</dt>
					<dd>${oauth.webSite }</dd>
				</div>
				<div class="group clearfix">
					<dt>证件类型</dt>
					<dd>三证合一</dd>
				</div>
				<div class="group clearfix">
					<dt>营业执照号</dt>
					<dd>
						<span class="txt">${oauth.enterpriseMaterialId }</span>
					</dd>
				</div>
				<div class="group clearfix">
					<dt>三证合一照</dt>
				</div>
				<div class="group clearfix">
					<dd>
						<img
							src="/img/${oauth.enterpriseMaterial}" />
					</dd>
				</div>
				<!-- 普通证件  -->
			</dl>
		</div>
	</s:if>

</div>
