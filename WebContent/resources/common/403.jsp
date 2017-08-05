<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:set var="ctx"><%=request.getContextPath()%></s:set>

<!DOCTYPE html>
<html>
<head>
	<title>403页面</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/a_style.css" />
</head>

<body>
	<!--主体部分content bof-->
	<div class="content">
		<div class="content_wrapper">
			<div class="content_box1">
				<div class="error_page">
					<ul>
						<li class="num">403</li>
						<li class="txt">
							<h2>权限不足，禁止访问</h2>
							<p>请先登录</p>
							<p>
								<a href="${ctx}/logout">返回首页</a>
							</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>