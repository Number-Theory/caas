<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/resources/common/common.jsp"%>

<title>用户充值页面</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-15">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>用户详情</h5>
						<div class="ibox-tools">
							<a href="<%=path%>/user/userList">X</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm">
							<input id="id" name="id" value="${returnMap.id }" type="hidden">
							<div class="form-group">
								<label class="col-sm-4 control-label">用户名：</label>
								<div class="col-sm-3">
									<input id="userName" name="userName"
										value="${returnMap.userName }" minlength="1"
										readonly="readonly" type="text" class="form-control"
										required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">userId：</label>
								<div class="col-sm-3">
									<input id="userId" name="userId" value="${returnMap.userId }"
										minlength="1" readonly="readonly" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label">充值金额：</label>
								<div class="col-sm-3">
									<input id="payMoney" name="payMoney"
										value="${returnMap.payMoney }" minlength="0" type="text"
										class="form-control" required="" aria-required="true">
								</div>
								<label class="col-sm-2 control-label"> 单位元</label>
							</div>

							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="button"
										onclick="chargeUser()">充值</button>
									<p id="editText"></p>
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
	function chargeUser() {
		var id = $('#id').val();
		var userId = $('#userId').val();
		var payMoney = $('#payMoney').val();
		var p = document.getElementById("editText");

		var flag = notice_edit.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/user/saveChargeUser",
			data : {
				id : id,
				userId : userId,
				payMoney : payMoney
			},
			dataType : "json",
			success : function(data) {
				if (data == true) {
					p.innerHTML = "充值成功";
					p.style.color = "red";
					setTimeout("codefans()", 3000);//3秒
				} else {
					p.innerHTML = "充值失败";
					p.style.color = "red";
					setTimeout("codefans()", 3000);//3秒
				}
			},
			error : function(data) {
				p.innerHTML = "请求失败";
				p.style.color = "red";
				setTimeout("codefans()", 3000);//3秒
			}
		});
	}
	//设置显示的过期时间
	function codefans() {
		var p = document.getElementById("editText");
		p.innerHTML = "";
	}
	//正则判断
	var notice_edit = {
		validateData : function() {

			return true;
		}
	}
</script>
</html>