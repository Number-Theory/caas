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

<title>模板添加</title>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-15">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>添加模板</h5>
						<div class="ibox-tools">
							<a href="<%=path%>/userTemplate/templateList">X</a>
						</div>
					</div>
					<div class="ibox-content">
						<form class="form-horizontal m-t" id="commentForm"
							action="<%=path%>/userTemplate/addTemplate" method="post">
							<div class="form-group" style="display: none">
								<label class="col-sm-4 control-label">模板类型：</label>
								<div class="col-sm-8">
									<div class="input-group">
										<select id="templateType" name="templateType"
											data-placeholder="模板类型" class="chosen-select"
											style="width: 330px;" tabindex="2">
											<option value="0" hassubinfo="true"
												<c:if test="${returnMap.userType == 0}">selected="selected"</c:if>>语音通知文字模板</option>
										</select>
									</div>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label">模板名称：</label>
								<div class="col-sm-3">
									<input id="templateName" name="templateName"
										value="${returnMap.templateName }" minlength="1" type="text"
										class="form-control" required="" aria-required="true">
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label">模板内容：</label>
								<div class="col-sm-3">
									<textarea  id="templateContent" name="templateContent" style="height: 100px;"
										value="${returnMap.templateContent }" minlength="1"
										type="text" class="form-control" required=""
										aria-required="true"></textarea>
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
								<div class="col-sm-6 col-sm-offset-5">
									<button class="btn btn-primary" type="button"
										onclick="addTemplate()">提交增加</button>
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
	function addTemplate() {
		var templateType = $('#templateType').val();
		var templateName = $('#templateName').val();
		var templateContent = $('#templateContent').val();
		var remark = $('#remark').val();
		var p = document.getElementById("addText");

		var flag = notice_add.validateData();
		if (!flag) {
			return false;
		}

		$.ajax({
			type : "POST",
			url : "/userTemplate/saveAddTemplate",
			data : {
				templateType : templateType,
				templateName : templateName,
				templateContent : templateContent,
				remark : remark
			},
			dataType : "json",
			success : function(data) {
				if (data == true) {
					p.innerHTML = "添加成功";
					p.style.color = "red";
				} else {
					p.innerHTML = "添加失败";
					p.style.color = "red";
				}
			},
			error : function(data) {
				p.innerHTML = "请求失败";
				p.style.color = "red";
			}
		});
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