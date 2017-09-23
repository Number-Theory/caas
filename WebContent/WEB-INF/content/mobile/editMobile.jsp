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

<title>号码编辑页面</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-15">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>号码详情</h5>
						<div class="ibox-tools">
							<a href="<%=path%>/mobile/mobileList">X</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm">
							<input id="id" name="id" value="${returnMap.id }" type="hidden">
							<div class="form-group">
								<label class="col-sm-4 control-label">号码：</label>
								<div class="col-sm-3">
									<input id="phoneNumber" name="phoneNumber"
										value="${returnMap.phoneNumber }" minlength="1"
										readonly="readonly" type="text" class="form-control"
										required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">城市名称：</label>
								<div class="col-sm-3">
									<input id="city" name="city" value="${returnMap.city }"
										minlength="1" readonly="readonly" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">城市ID：</label>
								<div class="col-sm-3">
									<input id="cityCode" name="cityCode"
										value="${returnMap.cityCode }" minlength="1"
										readonly="readonly" type="text" class="form-control"
										required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">运营商：</label>
								<div class="col-sm-3">
									<input id="operator" name="operator"
										value="${returnMap.operator }" minlength="1"
										readonly="readonly" type="text" class="form-control"
										required="" aria-required="true">
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
								<label class="col-sm-4 control-label">业务类型：</label>
								<div class="col-md-3">
									<select id="serverProduct" name="serverProduct"
										data-placeholder="业务类型" class="chosen-select"
										style="width: 330px;" tabindex="2" disabled="disabled">
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
							<c:if test="${returnMap.allotStatus == 1 }">
								<div class="form-group">
									<label class="col-sm-4 control-label">套餐：</label>
									<div class="col-sm-3">
										<div class="input-group">
											<select id="rateId" name="rateId" data-placeholder="套餐"
												class="chosen-select" style="width: 330px;" tabindex="2">
												<option value="" hassubinfo="true">请选择套餐</option>
												<c:forEach items="${rateMap}" var="rate">
													<option value="${rate.id }"
														<c:if test="${returnMap.rateId == rate.id}">selected="selected"</c:if>
														hassubinfo="true">${rate.Id }-${rate.rateName }</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
							</c:if>
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="button"
										onclick="editMobile()">提交编辑</button>
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
	function editMobile() {
		var id = $('#id').val();
		var numberType = $('#numberType').val();
		var status = $('#status').val();
		var rateId = $('#rateId').val();
		var attribute = $('#attribute').val();
		var remark = $('#remark').val();
		var p = document.getElementById("editText");

		var flag = notice_edit.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/mobile/saveEditMobile",
			data : {
				id : id,
				numberType : numberType,
				status : status,
				attribute : attribute,
				status : status,
				remark : remark,
				rateId : rateId
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