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

<title>套餐信息</title>
</head>

<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<!-- Panel Other -->
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="row row-lg">
					<div class="col-sm-12">
						<!-- Example Events -->
						<div class="example-wrap">
							<h4 class="example-title">套餐列表</h4>
							<div class="example">
								<p>
									<button class="btn btn-primary " type="button"
										onclick="freshdata('formFee')">
										<i class="fa fa-check"></i>&nbsp;&nbsp;刷新
									</button>
									&nbsp;&nbsp;
									<button class="btn btn-success " type="button"
										onclick="adddata('/fee/addFee')">
										<i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">新增
										</span>
									</button>
									&nbsp;&nbsp;
									<button class="btn btn-info " type="button"
										onclick="editdata('/fee/editFee')">
										<i class="fa fa-paste"></i>&nbsp;&nbsp;编辑
									</button>
									&nbsp;&nbsp;
									<button class="btn btn-warning " type="button"
										onclick="deldata('/fee/batchDeleteFee')">
										<i class="fa fa-warning"></i>&nbsp;&nbsp;<span class="bold">删除</span>
									</button>
									&nbsp;&nbsp;

								</p>
								<div class="alert alert-success alert-dismissable"
									id="operateNote"></div>
								<form action="<%=path%>/fee/feeList" method="post" id="formFee">
									<div class="form-group">
										<div class="col-sm-10">
											<div class="row">
												<div class="col-md-3">
													<input type="text" name="condition" id="condition"
														value="${data.condition }" placeholder="套餐名称"
														class="form-control">
												</div>
												<div class="col-md-3">
													<select id="status" name="status" data-placeholder="号码状态"
														class="chosen-select" style="width: 230px;" tabindex="2">
														<option value="" hassubinfo="true">号码状态</option>
														<option value="0" hassubinfo="true"
															<c:if test="${data.status == 0}">selected="selected"</c:if>>正常</option>
														<option value="1" hassubinfo="true"
															<c:if test="${data.status == 1}">selected="selected"</c:if>>禁用</option>
													</select>
												</div>
												<div class="col-md-3">
													<select id="productType" name="productType"
														data-placeholder="业务类型" class="chosen-select"
														style="width: 230px;" tabindex="2">
														<option value="" hassubinfo="true">业务类型</option>
														<option value="0" hassubinfo="true"
															<c:if test="${data.productType == 0}">selected="selected"</c:if>>隐号业务</option>
														<option value="1" hassubinfo="true"
															<c:if test="${data.productType == 1}">selected="selected"</c:if>>小号业务</option>
														<option value="2" hassubinfo="true"
															<c:if test="${data.productType == 2}">selected="selected"</c:if>>回拨业务</option>
														<option value="3" hassubinfo="true"
															<c:if test="${data.productType == 3}">selected="selected"</c:if>>语音验证码</option>
														<option value="4" hassubinfo="true"
															<c:if test="${data.productType == 4}">selected="selected"</c:if>>语音通知</option>
													</select>
												</div>
												<div class="col-md-1">
													<span class="input-group-btn"><button type="submit"
															class="btn btn-primary">搜索</button></span>
												</div>
											</div>
										</div>

									</div>
								</form>
								<table id="tableDemo" class="table table-hover"
									data-show-columns="true" data-search="false"
									data-show-refresh="false" data-show-toggle="false"
									data-pagination="true" data-height="900">
									<thead>
										<tr>
											<th></th>
											<th data-field="rownum">序号</th>
											<th data-field="id">套餐ID</th>
											<th data-field="rateName">套餐名称</th>
											<th data-field="productType">业务类型</th>
											<th data-field="rateType">费率类型</th>
											<th data-field="monthlyRent">月租</th>
											<th data-field="mininumCharge">低消</th>
											<th data-field="billingType">计费方式</th>
											<th data-field="billingUnit">计费周期</th>
											<th data-field="gratisUnit">免费计费单元</th>
											<th data-field="localPrice">A路市话价格</th>
											<th data-field="dddPrice">A路长途价</th>
											<th data-field="iddPrice">A路国际价</th>
											<th data-field="localPriceB">B路市话价格</th>
											<th data-field="dddPriceB">B路长途价</th>
											<th data-field="iddPriceB">B路国际价</th>
											<th data-field="recordPrice">录音价</th>
											<th data-field="oncePrice">条/次价格</th>
											<th data-field="status">套餐状态</th>
											<th data-field="creationTime">创建时间</th>
											<th data-field="remark">备注</th>
											<th data-field="#">操作</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
						<!-- End Example Events -->
					</div>
				</div>
			</div>
		</div>
		<!-- End Panel Other -->
	</div>


</body>

<script type="text/javascript">
	$(function() {

		// 1.初始化Table
		var oTable = new TableInit();
		oTable.Init();
		var p = document.getElementById('operateNote');
		p.style.display = "block";
		p.innerHTML = "加载完成";

		setTimeout("codefans()", 3000);// 3秒
	});

	var TableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$('#tableDemo').bootstrapTable('destroy');
			$('#tableDemo')
					.bootstrapTable(
							{
								url : '/fee/feeListData', // 请求后台的URL（*）
								method : 'post', // 请求方式（*）
								contentType : "application/x-www-form-urlencoded",
								dataType : "json",
								// toolbar: '#toolbar', //工具按钮用哪个容器
								striped : true, // 是否显示行间隔色
								cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
								pagination : true, // 是否显示分页（*）
								sortable : false, // 是否启用排序
								sortOrder : "asc",
								queryParamsType : "limit", // 参数格式,发送标准的RESTFul类型的参数请求
								// //排序方式,如果为"",则获取的参数为pageSize，pageNumber
								queryParams : oTableInit.queryParams,// 传递参数（*）
								sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
								// pageNumber:1, //初始化加载第一页，默认第一页
								pageSize : 20, // 每页的记录行数（*）
								showColumns : true, // 是否显示所有的列
								pageList : [ 10, 20, 50 ], // 可供选择的每页的行数（*）
								strictSearch : true,
								clickToSelect : false, // 是否启用点击选中行
								height : 540, // 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
								uniqueId : "id", // 每一行的唯一标识，一般为主键列
								// cardView: false, //是否显示详细视图
								// detailView: false, //是否显示父子表
								// showExport: true, //是否显示导出
								// exportDataType: "basic", //basic', 'all',
								// 'selected'.
								columns : [
										{
											formatter : function(value, row,
													index) {
												return "<input name='box' type='checkbox' value='"
													+ row.id + "'>";
											}
										},
										{
											field : 'rownum',
										},
										{
											field : 'id',
										},
										{
											field : 'rateName',
										},
										{
											field : 'productType',
											formatter : function(value, row,
													index) {
												if (row.productType == 0) {
													return "隐号业务";
												} else if (row.productType == 1) {
													return "小号业务";
												} else if (row.productType == 2) {
													return "回拨业务";
												} else if (row.productType == 3) {
													return "语音验证码";
												} else if (row.productType == 4) {
													return "语音通知";
												}
											}
										},
										{
											field : 'rateType',
											formatter : function(value, row,
													index) {
												if (row.rateType == 0) {
													return "公告套餐";
												} else if (row.rateType == 1) {
													return "独立套餐";
												}
											}
										},
										{
											field : 'monthlyRent',
											formatter : function(value, row,
													index) {
												return row.monthlyRent / 1000000;
											}
										},
										{
											field : 'mininumCharge',
											formatter : function(value, row,
													index) {
												return row.mininumCharge / 1000000;
											}
										},
										{
											field : 'billingType',
											formatter : function(value, row,
													index) {
												if (row.billingType == 0) {
													return "A路开始计费";
												} else if (row.billingType == 1) {
													return "B路开始计费";
												} else if (row.billingType == 2) {
													return "单路呼出计费";
												} else if (row.billingType == 3) {
													return "条/次计费";
												}
											}
										},
										{
											field : 'billingUnit',
										},
										{
											field : 'gratisUnit',
										},
										{
											field : 'localPrice',
											formatter : function(value, row,
													index) {
												return row.localPrice / 1000000;
											}
										},
										{
											field : 'dddPrice',
											formatter : function(value, row,
													index) {
												return row.dddPrice / 1000000;
											}
										},
										{
											field : 'iddPrice',
											formatter : function(value, row,
													index) {
												return row.iddPrice / 1000000;
											}
										},
										{
											field : 'localPriceB',
											formatter : function(value, row,
													index) {
												return row.localPriceB / 1000000;
											}
										},
										{
											field : 'dddPriceB',
											formatter : function(value, row,
													index) {
												return row.dddPriceB / 1000000;
											}
										},
										{
											field : 'iddPriceB',
											formatter : function(value, row,
													index) {
												return row.iddPriceB / 1000000;
											}
										},
										{
											field : 'recordPrice',
											formatter : function(value, row,
													index) {
												return row.recordPrice / 1000000;
											}
										},
										{
											field : 'oncePrice',
											formatter : function(value, row,
													index) {
												return row.oncePrice / 1000000;
											}
										},
										{
											field : 'status',
											formatter : function(value, row,
													index) {
												if (row.status == 0) {
													return "启用";
												} else if (row.status == 1) {
													return "停用";
												}
											}
										},
										{
											field : 'creationTime',
										},
										{
											field : 'remark',
										},
										{
											field : '#',
											title : '操作',
											align : 'center',
											formatter : function(value, row,
													index) {
												var edit = "/fee/editFee?id="
														+ row.id;
												var d = '<a href="' + edit + '" >修改</a> &nbsp;&nbsp;';
												return d;
											}
										}, ]
							});
		};

		// 得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { // 这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				length : params.limit, // 页面选择的显示行数
				start : params.offset, // 页码
				condition : $('#condition').val(),
				status : $('#status').val(),
				productType : $('#productType').val()
			};
			return temp;
		};
		return oTableInit;
	};

	// 设置显示的过期时间
	function codefans() {
		var p = document.getElementById("operateNote");
		//	p.style.display = "none";
		// p.innerHTML="加载完成";
	}
</script>
</html>