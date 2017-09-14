<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE HTML>
<html>
<head>
<%@include file="/resources/common/common.jsp"%>

<title>申请号码</title>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<!-- Panel Other -->
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="row row-lg">
					<form class="form-horizontal m-t" id="commentForm"
						action="<%=path%>/number/addApplyNumber" method="post">
						<input id="productType" name="productType" value="${data.productType }" type="hidden">
						<div class="form-group">
							<label class="col-sm-4 control-label">号码归属：</label>
							<div class="col-sm-3">
								 <select id="numberCityId" name="numberCityId" data-placeholder="城市ID" class="chosen-select" tabindex="2">
								 	<option value="" cityName="" hassubinfo="true">请选择城市</option>
                                	<c:forEach items="${cityMap}" var="city">
                                		<option value="${city.cityId }" cityName="${city.cityName }" hassubinfo="true">${city.cityId } - ${city.cityName }</option>
                                    </c:forEach>
                                </select>
							</div>
							<div class="col-sm-2">
								<input id="numberCityName" name="numberCityName" value="${map.numberCityName }"
									minlength="1" type="hidden" class="form-control" required=""
									aria-required="true">
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-4 control-label">号码个数：</label>
							<div class="col-sm-2">
								<input id="numberCount" name="numberCount"
									value="${map.numberCount }" minlength="1" type="text"
									class="form-control" required="" aria-required="true">
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-4 control-label">业务描述：</label>
							<div class="col-sm-4">
								<textarea id="context" name="context"
									value="${map.context }" minlength="1" type="text"
									class="form-control" required="" aria-required="true"></textarea>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-4 control-label">选择套餐：</label>
							<c:forEach items="${feeMap }" var="fee">
								<div id="${fee.id }" class="col-sm-1 package-select">
									<input class="btn btn-danger" style="width: 80px" type="button"
										value="${fee.mininumCharge }/月" class="form-control">
								</div>
							</c:forEach>
							<input id="feeId" name="feeId" value="${data.feeId }" type="hidden">
						</div>

						<div class="form-group">
							<label class="col-sm-4 control-label">套餐说明：</label>
							<c:forEach items="${feeMap }" var="fee">
								<div id="fee-table-${fee.id }" class="col-sm-4" style="display: none">
									<table class="table table-hover no-margins">
										<tr>
											<td style="background: #e0e0e0;"><small>月租</small></td>
											<td><span id="monthlyRent">${fee.monthlyRent }元</span></td>
										</tr>
										<tr>
											<td style="background: #e0e0e0;"><small>月费功能</small></td>
											<td><span id="mininumCharge">${fee.mininumCharge }</span>（每月1号扣除当月套餐费，消费额度低于低消的需要补扣）</td>
										</tr>
										<tr>
											<td style="background: #e0e0e0;">套餐内包含条数或分钟数</td>
											<td><span id="gratisUnit">${fee.gratisUnit}</span>
											<c:if
													test="${data.productType == 3 || data.productType == 4}">
												条
											</c:if> <c:if
													test="${data.productType == 0 || data.productType == 1 || data.productType == 2}">
												*<span id="billingUnit">${fee.billingUnit }</span>秒 
												</c:if></td>
										</tr>
										<tr>
											<td style="background: #e0e0e0;"><small>套餐内扣费规则</small></td>
											<td>实时扣除分钟数，不满一分钟按一分钟计</td>
										</tr>
										<tr>
											<td style="background: #e0e0e0;"><small>套餐外扣费规则</small></td>
											<td id="feeRule"><c:if
													test="${data.productType == 3 || data.productType == 4}">
												按条扣费，每条${fee.oncePrice }元
											</c:if> <c:if
													test="${data.productType == 0 || data.productType == 1 || data.productType == 2}">
											长途：${fee.dddPrice }元/${fee.billingUnit }秒，短途：${fee.localPrice }元/${fee.billingUnit }秒，国际：${fee.iddPrice }元/${fee.billingUnit }秒。 实时扣费，不满${fee.billingUnit }秒按${fee.billingUnit }秒计算
										</c:if></td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>


						<div class="form-group">
							<div class="col-sm-4 col-sm-offset-5">
								<button class="btn btn-primary" type="submit">确认申请</button>
								账号余额≥所需费用 才可办理
								<p id="addText" style="color: red;">${data.msg }</p>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- End Panel Other -->
	</div>
</body>

<script type="text/javascript">
	$(function() {
		$(".package-select").click(
				function() {
					$(this).find("input").removeClass("btn-success").addClass(
							"btn-danger");
					$(this).siblings().find("input").removeClass("btn-danger")
							.addClass("btn-success");
					
					var feeId = $(this).attr("id");
					$("#feeId").val(feeId);
					
					$("#fee-table-" + feeId).css("display", "block");
					$("#fee-table-" + feeId).siblings("div").css("display", "none");
				})
				
		$("#numberCityId").change(function() {
			debugger;
			$(this).find("option:selected");
			$("#numberCityName").val($(this).find("option:selected").attr("cityName"));
		})
		
		$("#numberCityName").val($("#numberCityId").find("option:selected").attr("cityName"));
				
		$(".package-select:first").click();
	})
	
	function loadCanApplyNumber() {
		
	}
</script>
</html>