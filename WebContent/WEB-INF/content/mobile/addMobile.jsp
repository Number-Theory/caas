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

<title>号码添加</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-15">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>添加号码</h5>
						<div class="ibox-tools">
							<a href="<%=path%>/mobile/mobileList">X</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm"
							action="<%=path%>/mobile/addMobile" method="post">
							<div class="form-group">
								<label class="col-sm-4 control-label">号码：</label>
								<div class="col-sm-3">
									<input id="phoneNumber" name="phoneNumber"
										value="${returnMap.phoneNumber }" minlength="1" type="text"
										class="form-control" required="true" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">号码归属：</label>
								<div class="col-sm-3">
									<select id="cityCode" name="cityCode" data-placeholder="城市ID"
										class="chosen-select" tabindex="2">
										<option value="" cityName="" hassubinfo="true">请选择城市</option>
										<c:forEach items="${cityMap}" var="city">
											<option value="${city.cityId }" cityName="${city.cityName }"
												hassubinfo="true">${city.cityId }-${city.cityName }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-sm-2">
									<input id="city" name="city" value="${returnMap.city }"
										minlength="1" type="hidden" class="form-control" required=""
										aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">业务类型：</label>
								<div class="col-md-3">
									<select id="serverProduct" name="serverProduct"
										data-placeholder="业务类型" class="chosen-select"
										style="width: 330px;" tabindex="2">
										<option value="0" hassubinfo="true"
											<c:if test="${returnMap.serverProduct == 0}">selected="selected"</c:if>>隐号业务</option>
										<option value="1" hassubinfo="true"
											<c:if test="${returnMap.serverProduct == 1}">selected="selected"</c:if>>小号业务</option>
										<option value="2" hassubinfo="true"
											<c:if test="${returnMap.serverProduct == 2}">selected="selected"</c:if>>回拨业务</option>
										<option value="3" hassubinfo="true"
											<c:if test="${returnMap.serverProduct == 3}">selected="selected"</c:if>>语音验证码</option>
										<option value="4" hassubinfo="true"
											<c:if test="${returnMap.serverProduct == 4}">selected="selected"</c:if>>语音通知</option>
									</select>
								</div>
							</div>
							<div class="form-group select_api" id="select_api_0">
								<label class="col-sm-4 control-label">所属API资源：</label>
								<div class="col-sm-3">
									<select id="apiId_0" name="apiId" data-placeholder="所属API资源" style="width: 330px;"
										class="chosen-select" tabindex="2">
										<c:forEach items="${apiMap}" var="api">
											<c:if test="${api.productType == 0 }">
												<option value="${api.id }" cityName="${api.apiName }"
													hassubinfo="true">${api.apiName }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group select_api" id="select_api_1">
								<label class="col-sm-4 control-label">所属API资源：</label>
								<div class="col-sm-3">
									<select id="apiId_1" name="apiId" data-placeholder="所属API资源" style="width: 330px;"
										class="chosen-select" tabindex="2">
										<c:forEach items="${apiMap}" var="api">
											<c:if test="${api.productType == 1 }">
												<option value="${api.id }" cityName="${api.apiName }"
													hassubinfo="true">${api.apiName }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group select_api" id="select_api_2">
								<label class="col-sm-4 control-label">所属API资源：</label>
								<div class="col-sm-3">
									<select id="apiId_2" name="apiId" data-placeholder="所属API资源" style="width: 330px;"
										class="chosen-select" tabindex="2">
										<c:forEach items="${apiMap}" var="api">
											<c:if test="${api.productType == 2 }">
												<option value="${api.id }" cityName="${api.apiName }"
													hassubinfo="true">${api.apiName }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group select_api" id="select_api_3">
								<label class="col-sm-4 control-label">所属API资源：</label>
								<div class="col-sm-3">
									<select id="apiId_3" name="apiId" data-placeholder="所属API资源" style="width: 330px;"
										class="chosen-select" tabindex="2">
										<c:forEach items="${apiMap}" var="api">
											<c:if test="${api.productType == 3 }">
												<option value="${api.id }" cityName="${api.apiName }"
													hassubinfo="true">${api.apiName }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group select_api" id="select_api_4">
								<label class="col-sm-4 control-label">所属API资源：</label>
								<div class="col-sm-3">
									<select id="apiId_4" name="apiId" data-placeholder="所属API资源" style="width: 330px;"
										class="chosen-select" tabindex="2">
										<c:forEach items="${apiMap}" var="api">
											<c:if test="${api.productType == 4 }">
												<option value="${api.id }" cityName="${api.apiName }"
													hassubinfo="true">${api.apiName }</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label">运营商：</label>
								<div class="col-sm-3">
									<input id="operator" name="operator"
										value="${returnMap.operator }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">号码属性：</label>
								<div class="col-sm-3">
									<div class="input-group">
										<select id="attribute" name="attribute"
											data-placeholder="号码属性" class="chosen-select"
											style="width: 330px;" tabindex="2">
											<option value="0" hassubinfo="true"
												<c:if test="${returnMap.numberType == 0}">selected="selected"</c:if>>正式号码</option>
											<option value="1" hassubinfo="true"
												<c:if test="${returnMap.numberType == 1}">selected="selected"</c:if>>测试号码</option>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">号码类型：</label>
								<div class="col-sm-3">
									<div class="input-group">
										<select id="numberType" name="numberType"
											data-placeholder="号码类型" class="chosen-select"
											style="width: 330px;" tabindex="2">
											<option value="0" hassubinfo="true"
												<c:if test="${returnMap.numberType == 0}">selected="selected"</c:if>>API资源</option>
											<option value="1" hassubinfo="true"
												<c:if test="${returnMap.numberType == 1}">selected="selected"</c:if>>线路资源</option>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">号码状态：</label>
								<div class="col-sm-3">
									<div class="input-group">
										<select id="status" name="status" data-placeholder="号码状态"
											class="chosen-select" style="width: 330px;" tabindex="2">
											<option value="0" hassubinfo="true"
												<c:if test="${returnMap.status == 0}">selected="selected"</c:if>>启用</option>
											<option value="1" hassubinfo="true"
												<c:if test="${returnMap.status == 1}">selected="selected"</c:if>>停用</option>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">备注：</label>
								<div class="col-sm-3">
									<input id="remark" name="remark" value="${returnMap.remark }"
										minlength="1" type="text" class="form-control" required=""
										aria-required="true">
								</div>
							</div>
						</form>
					</div>


					<div class="form-group">
						<div class="col-sm-6 col-sm-offset-5">
							<button class="btn btn-primary" type="button" onclick="addUser()">提交添加</button>
							<p id="addText"></p>
						</div>
					</div>
				</div>
			</div>

		</div>

	</div>
</body>
<script type="text/javascript">
	$(function() {
		$("#cityCode").change(function() {
			$("#city").val($(this).find("option:selected").attr("cityName"));
		})

		$("#city").val($("#cityCode").find("option:selected").attr("cityName"));

		$("#serverProduct").change(
				function() {
					debugger;
					$("#select_api_" + $("#serverProduct").val()).siblings(
							".select_api").css("display", "none");
					$("#select_api_" + $("#serverProduct").val()).css(
							"display", "block");
				});
		$("#select_api_" + $("#serverProduct").val()).siblings(".select_api")
				.css("display", "none");
	})
	function addUser() {
		var phoneNumber = $('#phoneNumber').val();
		var city = $('#city').val();
		var cityCode = $('#cityCode').val();
		var operator = $('#operator').val();
		var numberType = $('#numberType').val();
		var serverProduct = $('#serverProduct').val();
		var apiId = $('#apiId_' + serverProduct).val();
		var attribute = $('#attribute').val();
		var status = $('#status').val();
		var remark = $('#remark').val();
		var p = document.getElementById("addText");

		var flag = notice_add.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/mobile/saveAddMobile",
			data : {
				phoneNumber : phoneNumber,
				city : city,
				apiId : apiId,
				cityCode : cityCode,
				operator : operator,
				numberType : numberType,
				attribute : attribute,
				status : status,
				remark : remark,
				serverProduct : serverProduct
			},
			dataType : "json",
			success : function(data) {
				debugger;
				if (data.result == 'true') {
					p.innerHTML = "添加成功";
					p.style.color = "red";
				} else {
					p.innerHTML = "添加失败" + data.msg;
					p.style.color = "red";
				}
			},
			error : function(data) {
				p.innerHTML = "请求失败";
				p.style.color = "red";
			}
		});
	}
	//正则判断
	var notice_add = {
		validateData : function() {

			// 			var notice_title = $('#notice_title').val();
			// 			if (notice_title == null || notice_title == '') {
			// 				alert('请输入公告标题');
			// 				return false;
			// 			}
			// 			var notice_endtime = $('#notice_endtime').val();
			// 			if (notice_endtime == null || notice_endtime == '' ) {
			// 				alert('请输入过期时间');
			// 				return false;
			// 			} 
			// 			var notice_content = $('#notice_content').val();
			// 			if (notice_content == null || notice_content == '') {
			// 				alert('请输入公告内容');
			// 				return false;
			// 			}

			return true;
		}
	}
</script>

</html>