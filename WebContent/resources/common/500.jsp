<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:set var="ctx"><%=request.getContextPath()%></s:set>

<!DOCTYPE html>
<html>
<head>
	<title>500页面</title>
	<style type="text/css">
		.div_debug td{
			text-align:left;
			line-height:normal;
		}
	</style>
</head>

<body>
	<div class="error_page">
		<ul>
			<li class="num">500</li>
			<li class="txt">
				<h2>抱歉，服务器内部错误</h2>
				<p>我们正在努力修复，请稍后重试</p>
				<p>
					<a href="${ctx}">返回首页</a>
				</p>
			</li>
		</ul>
	</div>
	<div class="div_debug" style="display:none;">
		<s:debug></s:debug>
	</div>
</body>
</html>
