<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql"  prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml"  prefix="x" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <%@include file="/resources/common/common.jsp"%>
    
<title>目录编辑页面</title>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-15">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>添加模板</h5>
                        <div class="ibox-tools">
                            <a href="<%=path%>/template/templateList">X</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="commentForm">
                            <input id="id" name="id" value="${returnMap.id }" type="hidden" >
                            <div class="form-group">
                                <label class="col-sm-4 control-label">用户ID：</label>
                                <div class="col-sm-3">
                                    <input id="userId" name="userId" value="${returnMap.userId }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">外部模板：</label>
                                <div class="col-sm-3">
                                    <input id="insideCode" name="insideCode" value="${returnMap.insideCode }" minlength="1" type="email" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">内部模板：</label>
                                <div class="col-sm-3">
                                    <input id="externalCode" name="externalCode" value="${returnMap.externalCode }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                             <div class="form-group">
                                <label class="col-sm-4 control-label">模板类型：</label>
                                <div class="col-sm-8">
		                            <div class="input-group">
		                                <select id="templateType" name="templateType" data-placeholder="模板类型" class="chosen-select" style="width:330px;" tabindex="2">
	                                		<option value="0" hassubinfo="true" <c:if test="${returnMap.userType == 0}">selected="selected"</c:if>>语音通知文字模板</option>
		                                </select>
		                            </div>
                                </div>    
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">模板名称：</label>
                                 <div class="col-sm-3">
                                    <input id="templateName" name="templateName" value="${returnMap.templateName }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">模板内容：</label>
                                 <div class="col-sm-3">
                                    <input id="templateContent" name="templateContent" value="${returnMap.templateContent }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">模板状态：</label>
                                <div class="col-sm-8">
		                            <div class="input-group">
		                                <select id="status" name="status" data-placeholder="模板状态" class="chosen-select" style="width:330px;" tabindex="2">
	                                		<option value="0" hassubinfo="true" <c:if test="${returnMap.status == 0}">selected="selected"</c:if>>审核通过</option>
	                                		<option value="1" hassubinfo="true" <c:if test="${returnMap.status == 1}">selected="selected"</c:if>>待审核</option>
	                                		<option value="2" hassubinfo="true" <c:if test="${returnMap.status == 2}">selected="selected"</c:if>>审核不通过</option>
	                                		<option value="3" hassubinfo="true" <c:if test="${returnMap.status == 3}">selected="selected"</c:if>>已删除</option>
		                                </select>
		                            </div>
                                </div>    
                            </div> 
                            <div class="form-group">
                                <div class="col-sm-6 col-sm-offset-5">
                                    <button class="btn btn-primary" type="button" onclick="editTemplate()">提交添加</button>
                                    <p id="editText"></p>
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
function editTemplate(){
	var id = $('#id').val();
	var userId = $('#userId').val();
	var insideCode = $('#insideCode').val();
	var externalCode = $('#externalCode').val();
	var templateType = $('#templateType').val();
	var templateName = $('#templateName').val();
	var templateContent = $('#templateContent').val();
	var status = $('#status').val();
	var p = document.getElementById("editText");
	
	var flag = notice_edit.validateData();
	if (!flag) {
		return false;
	}
	
	$.ajax({
		type: "POST",
		url: "/template/saveEditTemplate",
		data: {
			id : id,
			userId : userId,
			insideCode : insideCode,
			externalCode : externalCode,
			templateType : templateType,
			templateName : templateName,
			templateContent : templateContent,
			status : status
		},
		dataType: "json",
		success: function(data) {
			if(data == true){
				p.innerHTML = "更新成功";
				p.style.color = "red";
				setTimeout("codefans()",3000);//3秒
			}else{
				p.innerHTML = "更新失败";
				p.style.color = "red";
				setTimeout("codefans()",3000);//3秒
			}
		},
		error: function(data) {
			p.innerHTML = "请求失败";
			p.style.color = "red";	
			setTimeout("codefans()",3000);//3秒
		}
	});
}
//设置显示的过期时间
function codefans(){
	var p = document.getElementById("editText");	
    p.innerHTML = "";
}
//正则判断
var notice_edit = {
		validateData : function() {
			
			return true;
		}
	}
</script>
</html>