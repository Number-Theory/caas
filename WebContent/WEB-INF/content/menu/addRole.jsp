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
<style type="text/css">
.permission-list {
	border: solid 1px #eee;
}

.permission-list>dt {
	background-color: #efefef;
	padding: 0px 10px
}

.permission-list>dd {
	padding: 5px;
	padding-left: 30px
}

.permission-list>dd>dl {
	border-bottom: solid 1px #eee;
	padding: 0px 0
}

.permission-list>dd>dl>dt {
	display: inline-block;
	float: left;
	white-space: nowrap;
	width: 100px
}

.permission-list>dd>dl>dd {
	margin-left: 100px;
}

.permission-list>dd>dl>dd>label {
	padding-right: 10px
}
</style>
<title>角色添加</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-15">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>添加角色</h5>
						<div class="ibox-tools">
							<a href="<%=path%>/menu/roleList">X</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm"
							action="<%=path%>/menu/addRole" method="post">
							<div class="form-group">
								<label class="col-sm-4 control-label">角色名称：</label>
								<div class="col-sm-3">
									<input id="name" name="name" value="${returnMap.name }"
										minlength="1" type="text" class="form-control" required=""
										aria-required="true">
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label">权限设置：</label>
								<div class="col-sm-4">
									<c:forEach items="${sessionScope.rolemenu.first}" var="first"
										varStatus="xh">
										<c:set var="key" value="${first.id }"></c:set>
										<dl class="permission-list">
											<dt>
												<label> <input type="checkbox" value="${first.id}"
													alt="1" class="checked-whether-${first.id }"
													name="character" id="user-Character-${xh.index}">
													${first.name}
												</label>
											</dt>
											<c:forEach items="${sessionScope.rolemenu.second}"
												var="second">
												<c:set var="key1" value="${second.id }"></c:set>
												<c:if test="${second.super_id == first.id}">
													<dd>
														<dl class="cl permission-list2">
															<dt>
																<label class=""> <input type="checkbox"
																	value="${second.id}" alt="1"
																	class="checked-whether-${second.id }" name="character"
																	id="user-Character-${xh.index}-0">
																	${second.name}
																</label>
															</dt>
														</dl>
													</dd>
												</c:if>
											</c:forEach>
										</dl>
									</c:forEach>
								</div>
							</div>

							<div class="form-group">
								<div class="col-sm-6 col-sm-offset-5">
									<button class="btn btn-primary" type="button"
										onclick="addRole()">提交添加</button>
									<p id="addText"></p>
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
	$(function() {
		var priv = $("#priv").val();
		for ( var key in priv) {
			$(".checked-whether-" + key).attr("checked", "checked");
		}

		$(".permission-list dt input:checkbox").click(
				function() {
					$(this).closest("dl").find("dd input:checkbox").prop(
							"checked", $(this).prop("checked"));
					var l = $(this).parents(".permission-list").find("dd")
							.find("input:checked").length;
					if (l == 0) {
						$(this).parents(".permission-list").find("dt").first()
								.find("input:checkbox").prop("checked",
										$(this).prop("checked"));
					}
					if ($(this).prop("checked")) {
						$(this).parents(".permission-list").find("dt").first()
								.find("input:checkbox").prop("checked",
										$(this).prop("checked"));
					}
				});
		$(".permission-list2 dd input:checkbox")
				.click(
						function() {
							var l = $(this).parent().parent().find(
									"input:checked").length;
							var l2 = $(this).parents(".permission-list").find(
									".permission-list2 dd").find(
									"input:checked").length;
							if ($(this).prop("checked")) {
								$(this).closest("dl").find("dt input:checkbox")
										.prop("checked", true);
								$(this).parents(".permission-list").find("dt")
										.first().find("input:checkbox").prop(
												"checked", true);
							} else {
								if (l == 0) {
									$(this).closest("dl").find(
											"dt input:checkbox").prop(
											"checked", false);
								}
								if (l2 == 0) {
									$(this).parents(".permission-list").find(
											"dt").first()
											.find("input:checkbox").prop(
													"checked", false);
								}
							}
						});

	})

	function addRole() {
		var name = $('#name').val();
		
		var chestr="";
		var str=$("input[name='character']");
		if(str.length>0){
			var flag = false
			for (var i = 0; i < str.length; i++) {
				if(str[i].checked == true) {
					chestr += flag == true ? ("," + str[i].value) : str[i].value;
					flag = true;
				}
			}
		}
		
		var p = document.getElementById("addText");

		var flag = notice_add.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/menu/saveAddRole",
			data : {
				name : name,
				menu_priv : chestr
			},
			dataType : "json",
			success : function(data) {
				if (data == 'true') {
					p.innerHTML = "添加成功";
					p.style.color = "red";
					setTimeout("codefans()", 3000);//3秒
				} else {
					p.innerHTML = "添加失败";
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
		var p = document.getElementById("addText");
		p.innerHTML = "";
	}
	//正则判断
	var notice_add = {
		validateData : function() {

			// 			var notice_title = $('#notice_title').val();
			// 			if (notice_title == null || notice_title == '') {
			// 				alert('请输入公告标题');
			// 				return false;
			// 			}
			// 			var notice_endtime = $('#notice_endtime').val();
			// 			if (notice_endtime == null || notice_endtime == '' ) {
			// 				alert('请输入过期时间');
			// 				return false;
			// 			} 
			// 			var notice_content = $('#notice_content').val();
			// 			if (notice_content == null || notice_content == '') {
			// 				alert('请输入公告内容');
			// 				return false;
			// 			}

			return true;
		}
	}
</script>

</html>