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

<title>号码审核</title>
</head>

<body class="gray-bg">
	<div class="modal inmodal" id="rateApplyModal" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">号码审核</h4>
				</div>
				<div id="rateItemBox" class="modal-body ibox-content"
					style="height: 300px;"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	<div class="wrapper wrapper-content animated fadeInRight">
		<!-- Panel Other -->
		<div class="ibox float-e-margins">
			<div class="ibox-content">
				<div class="row row-lg">
					<div class="col-sm-12">
						<!-- Example Events -->
						<div class="example-wrap">
							<h4 class="example-title">申请号码记录</h4>
							<div class="example">
								<p>
									<button class="btn btn-primary " type="button"
										onclick="freshdata('formApplyNumber')">
										<i class="fa fa-check"></i>&nbsp;&nbsp;刷新
									</button>
									&nbsp;&nbsp;
								</p>
								<div class="alert alert-success alert-dismissable"
									id="operateNote"></div>
								<form action="<%=path%>/mobile/mobileExamine" method="post"
									id="formApplyNumber">
									<div class="form-group">
										<div class="col-sm-10">
											<div class="row">
												<div class="col-md-3">
													<select id="status" name="status" data-placeholder="申请状态"
														class="chosen-select" style="width: 230px;" tabindex="2">
														<option value="" hassubinfo="true">申请状态</option>
														<option value="0" hassubinfo="true"
															<c:if test="${data.status == 0}">selected="selected"</c:if>>申请中</option>
														<option value="1" hassubinfo="true"
															<c:if test="${data.status == 1}">selected="selected"</c:if>>申请成功</option>
														<option value="2" hassubinfo="true"
															<c:if test="${data.status == 2}">selected="selected"</c:if>>申请失败</option>
													</select>
												</div>
												<div class="col-md-3">
													<input id="userId" name="userId" value="${data.userId }"
														placeholder="用户ID" class="form-control">
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
											<th data-field="rownum">序号</th>
											<th data-field="userId">用户ID</th>
											<th data-field="numberCityName">城市名称</th>
											<th data-field="numberCityId">城市ID</th>
											<th data-field="numberCount">业务类型</th>
											<th data-field="numberCount">申请数量</th>
											<th data-field="numberCount">分配数量</th>
											<th data-field="rateName">套餐名称</th>
											<th data-field="rateName">申请状态</th>
											<th data-field="context">备注</th>
											<th data-field="createDate">创建日期</th>
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

	function showRate(rateId, number) {
		$("#rateItemBox").html("");
		$.ajax({
			url : '/number/numberRate',
			type : "post",
			data : {
				rateId : rateId,
				phoneNumber : number
			},
			dataType : "text",
			success : function(data) {
				$("#rateItemBox").html(data);
			}
		});
	}

	var TableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$('#tableDemo').bootstrapTable('destroy');
			$('#tableDemo')
					.bootstrapTable(
							{
								url : '/number/applyNumberListData', // 请求后台的URL（*）
								method : 'post', // 请求方式（*）
								contentType : "application/x-www-form-urlencoded",
								dataType : "json",
								// toolbar: '#toolbar', //工具按钮用哪个容器
								striped : true, // 是否显示行间隔色
								cache : false, // 是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
								pagination : true, // 是否显示分页（*）
								sortable : true, // 是否启用排序
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
								clickToSelect : true, // 是否启用点击选中行
								height : 540, // 行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
								uniqueId : "id", // 每一行的唯一标识，一般为主键列
								// 							cardView: true, //是否显示详细视图
								// 							detailView: true, //是否显示父子表
								// 							showExport: true, //是否显示导出
								// 							exportDataType: "basic", //basic', 'all',
								// 'selected'.
								columns : [
										{
											field : 'rownum',
											width : "20%"
										},
										{
											field : 'userId',
											width : "20%"
										},
										{
											field : 'numberCityName',
											width : "20%"
										},
										{
											field : 'numberCityId',
											width : "20%"
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
											},
											width : "20%"
										},
										{
											field : 'numberCount',
											width : "20%"
										},
										{
											field : 'applyCount',
											width : "20%"
										},
										{
											field : 'rateName',
											formatter : function(value, row,
													index) {
												var oper = '<a type="button" data-toggle="modal" onclick="showRate(\''
														+ row.rateId
														+ '\', \'\')" data-target="#rateApplyModal">'
														+ value + '</a>';
												return oper;
											},
											width : "20%"
										},
										{
											field : 'status',
											formatter : function(value, row,
													index) {
												if (row.status == 0) {
													return "申请中";
												} else if (row.status == 1) {
													return "申请成功";
												} else if (row.status == 2) {
													return "申请失败";
												}
											},
											width : "20%"
										},
										{
											field : 'context',
											width : "20%"
										},
										{
											field : 'createDate',
											width : "20%"
										},
										{
											field : '#',
											formatter : function(value, row,
													index) {
												var edit = '/devide/devideMobile?id='
														+ row.id;
												var d = '<a href="' + edit + '" >分配号码</a> &nbsp;&nbsp;';
												return d;
											},
											width : "20%"
										} ]
							});
		};

		// 得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { // 这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				length : params.limit, // 页面选择的显示行数
				start : params.offset, // 页码
				status : $('#status').val(),
				productType : $('#productType').val(),
				userId : $('#userId').val()
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