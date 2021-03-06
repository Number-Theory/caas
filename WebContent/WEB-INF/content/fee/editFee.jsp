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

<title>套餐编辑页面</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-15">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>套餐详情</h5>
						<div class="ibox-tools">
							<a href="<%=path%>/fee/feeList">X</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm">
							<input id="id" name="id" value="${returnMap.id }" type="hidden">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐名称：</label>
								<div class="col-sm-3">
									<input id="rateName" name="rateName"
										value="${returnMap.rateName }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">业务类型：</label>
								<div class="col-md-3">
									<select id="productType" name="productType"
										data-placeholder="业务类型" class="chosen-select"
										style="width: 330px;" tabindex="2">
										<option value="0" hassubinfo="true"
											<c:if test="${returnMap.productType == 0}">selected="selected"</c:if>>隐号业务</option>
										<option value="1" hassubinfo="true"
											<c:if test="${returnMap.productType == 1}">selected="selected"</c:if>>小号业务</option>
										<option value="2" hassubinfo="true"
											<c:if test="${returnMap.productType == 2}">selected="selected"</c:if>>回拨业务</option>
										<option value="3" hassubinfo="true"
											<c:if test="${returnMap.productType == 3}">selected="selected"</c:if>>语音验证码</option>
										<option value="4" hassubinfo="true"
											<c:if test="${returnMap.productType == 4}">selected="selected"</c:if>>语音通知</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">业务类型：</label>
								<div class="col-md-3">
									<select id="rateType" name="rateType" data-placeholder="业务类型"
										class="chosen-select" style="width: 330px;" tabindex="2">
										<option value="0" hassubinfo="true"
											<c:if test="${returnMap.rateType == 0}">selected="selected"</c:if>>公共套餐</option>
										<option value="1" hassubinfo="true"
											<c:if test="${returnMap.rateType == 1}">selected="selected"</c:if>>独立套餐</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">月租：</label>
								<div class="col-sm-3">
									<input id="monthlyRent" name="monthlyRent"
										value="${returnMap.monthlyRent / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">低消：</label>
								<div class="col-sm-3">
									<input id="mininumCharge" name="mininumCharge"
										value="${returnMap.mininumCharge / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">计费方式：</label>
								<div class="col-md-3">
									<select id="billingType" name="billingType"
										data-placeholder="计费方式" class="chosen-select"
										style="width: 330px;" tabindex="2">
										<option value="0" hassubinfo="true"
											<c:if test="${returnMap.billingType == 0}">selected="selected"</c:if>>A路开始计费</option>
										<option value="1" hassubinfo="true"
											<c:if test="${returnMap.billingType == 1}">selected="selected"</c:if>>B路开始计费</option>
										<option value="2" hassubinfo="true"
											<c:if test="${returnMap.billingType == 2}">selected="selected"</c:if>>单路呼出计费</option>
										<option value="3" hassubinfo="true"
											<c:if test="${returnMap.billingType == 3}">selected="selected"</c:if>>条/次计费</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">计费周期：</label>
								<div class="col-sm-3">
									<input id="billingUnit" name="billingUnit"
										value="${returnMap.billingUnit }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">免费计费单元：</label>
								<div class="col-sm-3">
									<input id="gratisUnit" name="gratisUnit"
										value="${returnMap.gratisUnit }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">A路市话价格：</label>
								<div class="col-sm-3">
									<input id="localPrice" name="localPrice"
										value="${returnMap.localPrice / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">A路长途价：</label>
								<div class="col-sm-3">
									<input id="dddPrice" name="dddPrice"
										value="${returnMap.dddPrice / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">A路国际价格：</label>
								<div class="col-sm-3">
									<input id="iddPrice" name="iddPrice"
										value="${returnMap.localPrice / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">B路市话价格：</label>
								<div class="col-sm-3">
									<input id="localPriceB" name="localPriceB"
										value="${returnMap.localPriceB / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">B路长途价：</label>
								<div class="col-sm-3">
									<input id="dddPriceB" name="dddPriceB"
										value="${returnMap.dddPriceB / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">B路国际价格：</label>
								<div class="col-sm-3">
									<input id="iddPriceB" name="iddPriceB"
										value="${returnMap.localPriceB / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">录音价格：</label>
								<div class="col-sm-3">
									<input id="recordPrice" name="recordPrice"
										value="${returnMap.recordPrice / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">条/次价格：</label>
								<div class="col-sm-3">
									<input id="oncePrice" name="oncePrice"
										value="${returnMap.oncePrice / 1000000 }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐状态：</label>
								<div class="col-sm-3">
									<select id="status" name="status" data-placeholder="号码状态"
										class="chosen-select" style="width: 330px;" tabindex="2">
										<option value="0" hassubinfo="true"
											<c:if test="${returnMap.status == 0}">selected="selected"</c:if>>启用</option>
										<option value="1" hassubinfo="true"
											<c:if test="${returnMap.status == 1}">selected="selected"</c:if>>停用</option>
									</select>
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
							<div class="form-group">
								<div class="col-sm-4 col-sm-offset-3">
									<button class="btn btn-primary" type="button"
										onclick="editFee()">提交编辑</button>
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
	function editFee() {
		var id = $('#id').val();
		var rateName = $('#rateName').val();
		var productType = $('#productType').val();
		var rateType = $('#rateType').val();
		var monthlyRent = $('#monthlyRent').val();
		var mininumCharge = $('#mininumCharge').val();
		var billingType = $('#billingType').val();
		var billingUnit = $('#billingUnit').val();
		var gratisUnit = $('#gratisUnit').val();
		var localPrice = $('#localPrice').val();
		var dddPrice = $('#dddPrice').val();
		var iddPrice = $('#iddPrice').val();
		var localPriceB = $('#localPriceB').val();
		var dddPriceB = $('#dddPriceB').val();
		var iddPriceB = $('#iddPriceB').val();
		var recordPrice = $('#recordPrice').val();
		var oncePrice = $('#oncePrice').val();
		var status = $('#status').val();
		var remark = $('#remark').val();
		var p = document.getElementById("editText");

		var flag = notice_edit.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/fee/saveEditFee",
			data : {
				id : id,
				rateName : rateName,
				productType : productType,
				rateType : rateType,
				monthlyRent : monthlyRent,
				mininumCharge : mininumCharge,
				billingType : billingType,
				billingUnit : billingUnit,
				gratisUnit : gratisUnit,
				localPrice : localPrice,
				dddPrice : dddPrice,
				iddPrice : iddPrice,
				localPriceB : localPriceB,
				dddPriceB : dddPriceB,
				iddPriceB : iddPriceB,
				recordPrice : recordPrice,
				oncePrice : oncePrice,
				status : status,
				remark : remark
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