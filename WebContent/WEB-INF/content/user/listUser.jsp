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

<title>用户信息</title>
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
							<h4 class="example-title">用户列表</h4>
							<div class="example">
								<p>
									<button class="btn btn-primary " type="button"
										onclick="freshdata('formUser')">
										<i class="fa fa-check"></i>&nbsp;&nbsp;刷新
									</button>
									&nbsp;&nbsp;
									<button class="btn btn-success " type="button"
										onclick="adddata('/user/addUser')">
										<i class="fa fa-upload"></i>&nbsp;&nbsp;<span class="bold">新增
										</span>
									</button>
									&nbsp;&nbsp;
									<button class="btn btn-info " type="button"
										onclick="editdata('/user/editUser')">
										<i class="fa fa-paste"></i>&nbsp;&nbsp;编辑
									</button>
									&nbsp;&nbsp;
									<button class="btn btn-warning " type="button"
										onclick="deldata('/user/batchDeleteUser')">
										<i class="fa fa-warning"></i>&nbsp;&nbsp;<span class="bold">删除</span>
									</button>
									&nbsp;&nbsp;

								</p>
								<div class="alert alert-success alert-dismissable"
									id="operateNote"></div>
								<form action="<%=path%>/user/userList" method="post"
									id="formUser">
									<div class="form-group">
										<div class="col-sm-10">
											<div class="row">
												<div class="col-md-3">
													<input type="text" name="condition" id="condition"
														value="${param.condition }" placeholder="用户名/用户ID/邮箱/手机号"
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
											<th data-field="userName">用户名</th>
											<th data-field="sid">UserId</th>
											<th data-field="token">Token</th>
											<th data-field="mobile">手机号码</th>
											<th data-field="email">邮箱</th>
											<th data-field="roleName">角色名称</th>
											<th data-field="balance">余额</th>
											<th data-field="creditType">透支状态</th>
											<th data-field="creditMoney">透支额度</th>
											<th data-field="status">状态</th>
											<th data-field="createType">开户类型</th>
											<th data-field="userType">付费模式</th>
											<th data-field="salesMan">商务经理</th>
											<th data-field="creationUser">创建人</th>
											<th data-field="creationTime">创建时间</th>
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
								url : '/user/userListData', // 请求后台的URL（*）
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
								pageList : [ 10, 20, 50, 100 ], // 可供选择的每页的行数（*）
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
											field : 'userName',
										},
										{
											field : 'userId',
										},
										{
											field : 'token',
										},
										{
											field : 'mobile',
										},
										{
											field : 'email',
										},
										{
											field : 'roleName',
										},
										{
											field : 'balance',
											formatter : function(value, row,
													index) {
												return row.balance / 1000000;
											}
										},
										{
											field : 'creditType',
											formatter : function(value, row,
													index) {
												if (row.creditType == 1) {
													return "可透支";
												} else {
													return "不可透支";
												}
											}
										},
										{
											field : 'creditMoney',
											formatter : function(value, row,
													index) {
												return row.creditMoney / 1000000;
											}
										},
										{
											field : 'status',
											formatter : function(value, row,
													index) {
												if (row.status == 0) {
													return "正常";
												} else if (row.status == 1) {
													return "禁用";
												} else if (row.status == 2) {
													return "删除";
												} else if (row.status == 3) {
													return "欠费";
												}
											}
										},
										{
											field : 'createType',
											formatter : function(value, row,
													index) {
												return row.status == 0 ? '自助开户'
														: '管理员开户';
											}
										},
										{
											field : 'userType',
											formatter : function(value, row,
													index) {
												return row.userType == 0 ? '预付费'
														: '后付费';
											}
										},
										{
											field : 'salesMan',
										},
										{
											field : 'creationUser',
										},
										{
											field : 'creationTime',
										},
										{
											field : '#',
											title : '操作',
											align : 'center',
											formatter : function(value, row,
													index) {
												var edit = "/user/editUser?id="
														+ row.id;
												var charge = "/user/chargeUser?id="
														+ row.id;
												var repasswd = "/user/repasswd?id="
														+ row.id;
												var d = '<a href="' + edit + '" >修改</a> &nbsp;&nbsp;<a href="' + charge + '" >充值</a> &nbsp;&nbsp;<a href="' + repasswd + '" >更改密码</a> &nbsp;&nbsp;';
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
				condition : $('#condition').val()
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