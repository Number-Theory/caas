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

<title>号码信息</title>
</head>

<body class="gray-bg">
	<div class="modal inmodal" id="rateModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">号码费率</h4>
				</div>
				<div id="rateModalItemBox" class="modal-body ibox-content"
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
							<h4 class="example-title">号码列表</h4>
							<div class="example">
								<p>
									<c:if test="${data.authStatus == 0 }">
										<div class="col-md-1">
										<button class="btn btn-success" type="button"
											onclick="adddata('/number/applyNumber?productType=${data.productType }')">
											<i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">申请号码
											</span>
										</button>
										</div>
									</c:if>
									<c:if test="${data.authStatus != 0 }">
									<div id="authButton" class="col-md-1">
										<button class="btn btn-success " type="button"
											onclick="flushPage('/user/accountCertify')">
											<i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">申请号码
											</span>
										</button>
										</div>
									</c:if>
									&nbsp;&nbsp;
									<button class="btn btn-primary " type="button"
										onclick="freshdata('formNumber')">
										<i class="fa fa-check"></i>&nbsp;&nbsp;刷新
									</button>
									&nbsp;&nbsp;
								</p>
								<div class="alert alert-success alert-dismissable"
									id="operateNote"></div>
								<form action="<%=path%>/number/numberList" method="post"
									id="formNumber">
									<div class="form-group">
										<div class="col-sm-10">
											<div class="row">
												<div class="col-md-3">
													<input type="text" name="phoneNumber" id="phoneNumber"
														value="${data.phoneNumber }" placeholder="电话号码"
														class="form-control"> <input type="hidden"
														name=productType id="productType"
														value="${data.productType }" placeholder="业务类型"
														class="form-control">
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
											<th data-field="phoneNumber">号码</th>
											<th data-field="city">城市ID</th>
											<th data-field="cityCode">区号</th>
											<th data-field="ratisUnit">套餐内计费单元</th>
											<th data-field="employUnit">已产生计费单元</th>
											<th data-field="reSidueUnit">套餐剩余计费单元</th>
											<th data-field="applyDate">开号日期</th>
											<th data-field="rateName">套餐</th>
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
		
		$("#authButton").mouseover(function(){
			$(this).find("button").removeClass("btn-success").addClass("btn-danger");
			$(this).find("button span").html("申请认证");
		}) 
		$("#authButton").mouseout(function(){
			$(this).find("button").removeClass("btn-danger").addClass("btn-success");
			$(this).find("button span").html("申请号码");
		}) 
		
	});

	function showRate(rateId, number) {
		$("#rateModalItemBox").html("");
		$.ajax({
			url : '/number/numberRate',
			type : "post",
			data : {
				rateId : rateId,
				phoneNumber : number
			},
			dataType : "text",
			success : function(data) {
				$("#rateModalItemBox").html(data);
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
								url : '/number/numberListData', // 请求后台的URL（*）
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
											formatter : function(value, row,
													index) {
												return "<input name='box' type='checkbox' value='"
													+ row.id + "'>";
											}
										},
										{
											field : 'rownum',
											width : "20%"
										},
										{
											field : 'phoneNumber',
											width : "20%"
										},
										{
											field : 'city',
											width : "20%"
										},
										{
											field : 'cityCode',
											width : "20%"
										},
										{
											field : 'ratisUnit',
											width : "20%"
										},
										{
											field : 'employUnit',
											width : "20%"
										},
										{
											field : 'reSidueUnit',
											width : "20%"
										},
										{
											field : 'applyDate',
											width : "20%"
										},
										{
											field : 'rateName',
											formatter : function(value, row,
													index) {
												var oper = '<a type="button" data-toggle="modal" onclick="showRate(\''
														+ row.rateId
														+ '\', \''
														+ row.phoneNumber
														+ '\')" data-target="#rateModal">'
														+ value + '</a>';
												return oper;
											},
											width : "20%"
										}/* ,
										{
											field : '#',
											title : '操作',
											align : 'center',
											formatter : function(value, row,
													index) {
												var edit = "/number/editNumber?id="
														+ row.id;
												var d = '<a href="' + edit + '" >修改</a> &nbsp;&nbsp;';
												return d;
											},
											width : "20%"
										}, */ ]
							});
		};

		// 得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { // 这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				length : params.limit, // 页面选择的显示行数
				start : params.offset, // 页码
				phoneNumber : $('#phoneNumber').val(),
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