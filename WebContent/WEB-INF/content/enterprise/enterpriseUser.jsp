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

<title>企业认证审核页面</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-15">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>企业认证审核</h5>
						<div class="ibox-tools">
							<a href="<%=path%>/enterprise">X</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm">
							<input id="id" name="id" value="${oauth.id }" type="hidden">
							<div class="form-group">
								<label class="col-sm-4 control-label">用户ID：</label>
								<div class="col-sm-3">
									<input id="userId" name="userId" value="${oauth.userId }"
										minlength="1" readonly="readonly" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">企业名称：</label>
								<div class="col-sm-3">
									<input id="userName" name="userName"
										value="${oauth.userName }" minlength="1"
										readonly="readonly" type="text" class="form-control"
										required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">企业地址：</label>
								<div class="col-sm-3">
									<input id="webSite" name="webSite"
										value="${oauth.webSite }" minlength="1"
										readonly="readonly" type="text" class="form-control"
										required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">营业执照ID：</label>
								<div class="col-sm-3">
									<input id="enterpriseMaterialId" name="enterpriseMaterialId"
										value="${oauth.enterpriseMaterialId }" minlength="1"
										readonly="readonly" type="text" class="form-control"
										required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">企业资料：</label>
								<div class="col-sm-8">
									<div class="input-group">
										<img alt="" src="/img/${oauth.enterpriseMaterial}" width="700px">
									</div>
								</div>
							</div>
							<c:if test="${oauth.status == 1 }">
								<div class="form-group">
									<div class="col-sm-4 col-sm-offset-3">
										<button class="btn btn-primary" type="button"
											onclick="paasEnterprise()">通过审核</button>
										<button class="btn btn-danger" type="button"
											onclick="notPaasEnterprise()">不通过审核</button>
										<p id="editText"></p>
									</div>
								</div>
							</c:if>
						</form>
					</div>
				</div>

			</div>

		</div>
	</div>

</body>
<script type="text/javascript">
	function paasEnterprise() {
		var id = $('#id').val();
		var p = document.getElementById("editText");

		var flag = notice_edit.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/enterprise/update",
			data : {
				id : id,
				status : '0'
			},
			dataType : "json",
			success : function(data) {
				if (data == true) {
					p.innerHTML = "更新成功";
					p.style.color = "red";
					setTimeout("codefans()", 3000);//3秒
				} else {
					p.innerHTML = "更新失败";
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
	
	function notPaasEnterprise() {
		var id = $('#id').val();
		var p = document.getElementById("editText");

		var flag = notice_edit.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/enterprise/update",
			data : {
				id : id,
				status : '2'
			},
			dataType : "json",
			success : function(data) {
				if (data == true) {
					p.innerHTML = "更新成功";
					p.style.color = "red";
					setTimeout("codefans()", 3000);//3秒
				} else {
					p.innerHTML = "更新失败";
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