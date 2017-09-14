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

<title>号码费率</title>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content">
		<!-- Panel Other -->
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="row row-lg">
					<div class="col-sm-12">
						<table class="table table-hover no-margins">
							<c:if test="${data.phoneNumber != null || data.phoneNumber != '' }">
								<tr>
									<td style="background: #e0e0e0;"><small>号码</small></td>
									<td>${data.phoneNumber }</td>
								</tr>
							</c:if>
							<tr>
								<td style="background: #e0e0e0;"><small>月费功能</small></td>
								<td>${rateMap.mininumCharge }（每月1号扣除当月套餐费，消费额度低于低消的需要补扣）</td>
							</tr>
							<tr>
								<td style="background: #e0e0e0;">套餐内包含条数或分钟数</td>
								<td>${rateMap.gratisUnit}<c:if
										test="${rateMap.productType == 3 || rateMap.productType == 4}">
											条
										</c:if> <c:if
										test="${rateMap.productType == 0 || rateMap.productType == 1 || rateMap.productType == 2}">
											*${rateMap.billingUnit }秒
									</c:if></td>
							</tr>
							<tr>
								<td style="background: #e0e0e0;"><small>套餐内扣费规则</small></td>
								<td>实时扣除分钟数，不满一分钟按一分钟计</td>
							</tr>
							<tr>
								<td style="background: #e0e0e0;"><small>套餐外扣费规则</small></td>
								<td><c:if
										test="${rateMap.productType == 3 || rateMap.productType == 4}">
											按条扣费，每条${rateMap.oncePrice }元
										</c:if> <c:if
										test="${rateMap.productType == 0 || rateMap.productType == 1 || rateMap.productType == 2}">
										长途：${rateMap.dddPrice }元/${rateMap.billingUnit }秒，短途：${rateMap.localPrice }元/${rateMap.billingUnit }秒，国际：${rateMap.iddPrice }元/${rateMap.billingUnit }秒。 实时扣费，不满${rateMap.billingUnit }秒按${rateMap.billingUnit }秒计算
									</c:if></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- End Panel Other -->
	</div>
</body>

<script type="text/javascript">
	
</script>
</html>