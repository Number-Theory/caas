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
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/register.css" />
<title>注册</title>

</head>
<body>
	<div class="content">
		<div class="title">云掌互联注册</div>
		<form action="<%=path%>/saveUser" method="post" id="register" onsubmit="return validate()">
			<div class="mainContent">
				<ul>
					<li><img src="<%=path%>/resources/img/homePage/login_user.png"><input type="text" class="form-control" required="" id="userName" name="userName" placeholder="请输入用户名"></li>
					<li><img src="<%=path%>/resources/img/homePage/login_pwd.png"><input type="password" class="form-control" required="" id="userPwd" name="userPwd" placeholder="请输入密码" onfocus="clearMsg()"></li>
					<li><img src="<%=path%>/resources/img/homePage/login_pwd.png"><input type="password" class="form-control" required="" id="reUserPwd" name="reUserPwd" placeholder="请再次输入密码" onfocus="clearMsg()"></li>
					<li><img src="<%=path%>/resources/img/homePage/tel.png"><input type="text" class="form-control" required="" id="mobile" name="mobile" placeholder="请输入手机号码" onfocus="clearMsg()"></li>
					<li><img src="<%=path%>/resources/img/homePage/email.png"><input type="email" class="form-control" required="" id="email" name="email" placeholder="请输入邮箱"></li>
					<li><input type="submit" id="subbtn" value="注册"></li>
					<li>
						<div class="form-group">
							<span id="msg" style="color: red">${resultMap.msg }</span>
						</div>
					</li>
				</ul>
			</div>
		</form>
	</div>
</body>
<script type="text/javascript"
		src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
<script type="text/javascript">
	function validate(){
		//验证两次密码是否一致
		var pwd = $("#userPwd").val();
		var repwd = $("#reUserPwd").val();
		if(pwd!=repwd){
			$("#msg").text("两次密码输入的不一致，请重新输入");
			$("#userPwd").val("");
			$("#reUserPwd").val("");
			return false;
		}
		//验证手机号码是否符合规范
		var phone = $("#mobile").val();
		if(!(/^1[34578]\d{9}$/.test(phone))){
			$("#msg").text("请输出正确的手机号码");
			return false;
		}
		return true;
	}
	//清空提示消息
	function clearMsg(){
		$("#msg").text("");
	}
</script>
>>>>>>> branch 'master' of git@github.com:Number-Theory/caas.git
</html>
