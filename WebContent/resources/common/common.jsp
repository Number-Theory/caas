<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<meta http-equiv="Cache-Control" content="no-siteapp" />
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 自定义js -->

<script type="text/javascript"
	src="<%=path%>/resources/common/common.js"></script>

<link rel="shortcut icon" href="favicon.ico">
<link href="<%=path%>/resources/css/bootstrap.min14ed.css?v=3.3.6"
	rel="stylesheet">
<link href="<%=path%>/resources/css/font-awesome.min93e3.css?v=4.4.0"
	rel="stylesheet">
<link href="<%=path%>/resources/css/animate.min.css" rel="stylesheet">
<link href="<%=path%>/resources/css/style.min862f.css?v=4.1.0"
	rel="stylesheet">

<link
	href="<%=path%>/resources/css/plugins/bootstrap-table/bootstrap-table.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/sweetalert.css">


<link href="<%=path%>/resources/css/plugins/switchery/switchery.css"
	rel="stylesheet">
<link
	href="<%=path%>/resources/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css"
	rel="stylesheet">


<link
	href="<%=path%>/resources/css/plugins/colorpicker/css/bootstrap-colorpicker.min.css"
	rel="stylesheet">
<link href="<%=path%>/resources/css/plugins/datapicker/datepicker3.css"
	rel="stylesheet">
<link href="<%=path%>/resources/css/plugins/clockpicker/clockpicker.css"
	rel="stylesheet">


<link href="<%=path%>/resources/css/plugins/iCheck/custom.css"
	rel="stylesheet">
<link href="<%=path%>/resources/css/plugins/chosen/chosen.css"
	rel="stylesheet">
<link href="<%=path%>/resources/css/plugins/cropper/cropper.min.css"
	rel="stylesheet">
<link
	href="<%=path%>/resources/css/plugins/jasny/jasny-bootstrap.min.css"
	rel="stylesheet">

<script src="<%=path%>/resources/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path%>/resources/js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=path%>/resources/js/content.min.js?v=1.0.0"></script>
<script
	src="<%=path%>/resources/js/plugins/validate/jquery.validate.min.js"></script>
<script src="<%=path%>/resources/js/plugins/validate/messages_zh.min.js"></script>
<%-- <script src="<%=path%>/resources/js/demo/form-validate-demo.min.js"></script> --%>
<script type="text/javascript"
	src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/plugins/layer/laydate/laydate.js"></script>

<script
	src="<%=path%>/resources/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script
	src="<%=path%>/resources/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
<script
	src="<%=path%>/resources/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="<%=path%>/resources/js/demo/bootstrap-table-demo.min.js"></script>
<script src="<%=path%>/resources/js/bootstrap-table-export.js"></script>
<script src="<%=path%>/resources/js/tableExport.js"></script>
<script src="<%=path%>/resources/js/sweetalert.min.js"></script>

<script type="text/javascript"
	src="<%=path%>/resources/js/contabs.min.js"></script>

<script
	src="<%=path%>/resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<script
	src="<%=path%>/resources/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<script src="<%=path%>/resources/js/plugins/clockpicker/clockpicker.js"></script>

<script src="<%=path%>/resources/js/plugins/chosen/chosen.jquery.js"></script>
<script src="<%=path%>/resources/js/plugins/jsKnob/jquery.knob.js"></script>
<script
	src="<%=path%>/resources/js/plugins/jasny/jasny-bootstrap.min.js"></script>

<script
	src="<%=path%>/resources/js/plugins/prettyfile/bootstrap-prettyfile.js"></script>
<script
	src="<%=path%>/resources/js/plugins/nouslider/jquery.nouislider.min.js"></script>
<script src="<%=path%>/resources/js/plugins/switchery/switchery.js"></script>

<script
	src="<%=path%>/resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>

<script src="<%=path%>/resources/js/plugins/cropper/cropper.min.js"></script>

<script type="text/javascript">
	$(function() {

		var config = {
			".chosen-select" : {},
			".chosen-select-deselect" : {
				allow_single_deselect : !0
			},
			".chosen-select-no-single" : {
				disable_search_threshold : 10
			},
			".chosen-select-no-results" : {
				no_results_text : "Oops, nothing found!"
			},
			".chosen-select-width" : {
				width : "95%"
			}
		};
		for ( var selector in config) {
			if ($(selector) != null) {
				$(selector).chosen(config[selector]);
			}
		}
	});

	function freshdata(obj) {
		debugger;
		$("#" + obj).submit();
	}

	function adddata(url) {
		window.location.href = url;
	}

	function editdata(url) {
		var chestr = "";
		var count = 0;
		var str = document.getElementsByName("box");

		for (var i = 0; i < str.length; i++) {
			if (str[i].checked == true) {
				count++;
				chestr += str[i].value;
			}
		}

		if (count == 1) {
			url = url + "?id=" + chestr;
			window.location.href = url;
		} else if (count == 0) {
			var p = document.getElementById('operateNote');
			p.style.display = "block";
			p.innerHTML = "请选择一行";
			setTimeout("codefans()", 3000);// 3秒
		} else {
			var p = document.getElementById('operateNote');
			p.style.display = "block";
			p.innerHTML = "一次仅能选择一行"
			setTimeout("codefans()", 3000);
		}

	}

	function deldata(url) {
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
				title : "确定删除选中项吗？",
				text : "",
				type : "warning",
				showCancelButton : true,
				confirmButtonColor : "#9fc5e8",
				confirmButtonText : "是的，我要删除！",
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
									title : "删除成功",
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
									title : "删除失败",
									text : "批量删除失败！",
									type : "error"
								});
							}

						},
						error : function(data) {
							swal({
								title : "删除失败",
								text : JSON.stringify(data),
								type : "error"
							});
						}
					});

				} else {
					swal("已取消", "您取消了删除操作！", "error")
				}
			});
		}
	}
</script>
</head>
<body>
	<input id="projectPath" value="<%=basePath%>" type="hidden">
</body>
</html>