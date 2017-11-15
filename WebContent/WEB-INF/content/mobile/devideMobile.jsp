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

<title>分配号码</title>
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
							<h4 class="example-title">号码列表</h4>
							<div class="example">
								<p>
									<button class="btn btn-primary " type="button"
										onclick="freshdata('formDevideMobile')">
										<i class="fa fa-check"></i>&nbsp;&nbsp;刷新
									</button>
									&nbsp;&nbsp;
									<button class="btn btn-success " type="button"
										onclick="devide('/devide/saveDevideMobile?id=${applyMap.id}')">
										<i class="fa fa-check"></i>&nbsp;&nbsp;分配号码
									</button>
								</p>
								<div class="alert alert-success alert-dismissable">
									<div class="row">
										<div class="col-sm-3">用户ID：${applyMap.userId }</div>
										<div class="col-sm-3">用户名：${applyMap.userName }</div>
										<div class="col-sm-3">申请号码数：${applyMap.numberCount }</div>
									</div>
									<div class="row">
										<div class="col-sm-3">号码所属城市ID：${applyMap.numberCityId }</div>
										<div class="col-sm-3">号码所属城市名称：${applyMap.numberCityName }</div>
										<div class="col-sm-3">已分配数量：${applyMap.applyCount }</div>
									</div>
								</div>
								<div class="alert alert-success alert-dismissable"
									id="operateNote"></div>
								<form action="<%=path%>/devide/devideMobile?id=${applyMap.id}"
									method="post" id="formDevideMobile">
									<div class="form-group">
										<div class="col-sm-10">
											<div class="row">
												<div class="col-md-3">
													<input type="hidden" name="productType" id="productType"
														value="${applyMap.productType }"> <input
														type="text" name="condition" id="condition"
														value="${data.condition }" placeholder="电话号码"
														class="form-control">
												</div>
												<div class="col-md-3">
													<input type="text" name="city" id="city"
														value="${data.city }" placeholder="城市ID/城市名称"
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
											<th data-field="city">城市名称</th>
											<th data-field="cityCode">城市ID</th>
											<th data-field="operator">运营商</th>
											<th data-field="numberType">号码类型</th>
											<th data-field="applyDate">开号日期</th>
											<th data-field="serverProduct">业务类型</th>
											<th data-field="attribute">号码属性</th>
											<th data-field="status">号码状态</th>
											<th data-field="remark">备注</th>
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
								url : '/mobile/mobileListData', // 请求后台的URL（*）
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
											field : 'operator',
											width : "20%"
										},
										{
											field : 'numberType',
											formatter : function(value, row,
													index) {
												if (row.numberType == 0) {
													return "API资源";
												} else if (row.numberType == 1) {
													return "线路资源";
												}
											},
											width : "20%"
										},
										{
											field : 'applyDate',
											width : "20%"
										},
										{
											field : 'serverProduct',
											formatter : function(value, row,
													index) {
												if (row.serverProduct == 0) {
													return "隐号业务";
												} else if (row.serverProduct == 1) {
													return "小号业务";
												} else if (row.serverProduct == 2) {
													return "回拨业务";
												} else if (row.serverProduct == 3) {
													return "语音验证码";
												} else if (row.serverProduct == 4) {
													return "语音通知";
												}
											},
											width : "20%"
										},
										{
											field : 'attribute',
											formatter : function(value, row,
													index) {
												if (row.attribute == 0) {
													return "正式号码";
												} else if (row.attribute == 1) {
													return "测试号码";
												}
											},
											width : "20%"
										},
										{
											field : 'status',
											formatter : function(value, row,
													index) {
												if (row.status == 0) {
													return "可用";
												} else if (row.status == 1) {
													return "不可用";
												}
											},
											width : "20%"
										}, {
											field : 'remark',
											width : "20%"
										} ]
							});
		};

		// 得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = { // 这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
				length : params.limit, // 页面选择的显示行数
				start : params.offset, // 页码
				condition : $('#condition').val(),
				city : $('#city').val(),
				allotStatus : '0',
				serverProduct : $('#productType').val()
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
	
	
	function devide(url) {
		var chestr = "";
		var count = 0;
		var str = document.getElementsByName("box");
		for (var i = 0; i < str.length; i++) {
			if (str[i].checked == true) {
				chestr += count == 0 ? str[i].value : "," + str[i].value;
				count++;
			}
		}
		if (count == 0) {
			var p = document.getElementById('operateNote');
			p.innerHTML = "请选择一行";
			p.style.display = "block";
			setTimeout("codefans()", 3000);// 3秒
		} else {

			swal({
				title : "确定分配选中号码？",
				text : "",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#9fc5e8",
				confirmButtonText : "是的，我要分配！",
				cancelButtonText : "让我再考虑一下…",
				closeOnConfirm : false,
				closeOnCancel : false
			}, function(isConfirm) {
				if (isConfirm) {
					$.ajax({
						type : "POST",
						url : url,
						data : {
							str : chestr
						},
						dataType : "json",
						success : function(data) {

							if (data == true) {
								swal({
									title : "分配成功",
									text : "",
									type : "success",
									confirmButtonColor : "#9fc5e8",
									confirmButtonText : "OK",
									closeOnConfirm : false
								}, function(isConfirm) {
									if (isConfirm) {
										window.location.reload();
									}
								});
							} else {
								swal({
									title : "分配失败",
									text : "批量分配失败！",
									type : "error"
								});
							}

						},
						error : function(data) {
							swal({
								title : "分配失败",
								text : JSON.stringify(data),
								type : "error"
							});
						}
					});

				} else {
					swal("已取消", "您取消了分配操作！", "error")
				}
			});
		}
	}
</script>
</html>