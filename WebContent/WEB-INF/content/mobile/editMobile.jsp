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
    
<title>用户编辑页面</title>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-15">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>用户详情</h5>
                        <div class="ibox-tools">
                            <a href="<%=path%>/user/userList">X</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="commentForm">
                            <input id="id" name="id" value="${returnMap.id }" type="hidden" >
                            <div class="form-group">
                                <label class="col-sm-4 control-label">用户名：</label>
                                <div class="col-sm-3">
                                    <input id="userName" name="userName" value="${returnMap.userName }" minlength="1" readonly="readonly" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">SID：</label>
                                <div class="col-sm-3">
                                    <input id="url" name="url" value="${returnMap.sid }" minlength="1" readonly="readonly" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Token：</label>
                                <div class="col-sm-3">
                                    <input id="url" name="url" value="${returnMap.token }" minlength="1" readonly="readonly" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">邮箱：</label>
                                <div class="col-sm-3">
                                    <input id="email" name="email" value="${returnMap.email }" minlength="1" readonly="readonly" type="email" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">手机号码：</label>
                                <div class="col-sm-3">
                                    <input id="mobile" name="mobile" value="${returnMap.mobile }" minlength="1" readonly="readonly" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">所属角色：</label>
                                <div class="col-sm-8">
		                            <div class="input-group">
		                                <select id="roleId" name="roleId" data-placeholder="所属角色" class="chosen-select" style="width:330px;" tabindex="2">
		                                	<option value="" hassubinfo="true">所属角色</option>
		                                	<c:forEach items="${roleMap }" var="role">
		                                		<c:if test="${returnMap.roleId == role.id}">
		                                			<option value="${role.id }" hassubinfo="true" selected="selected">${role.name }</option>
		                                		</c:if>
		                                    	<c:if test="${returnMap.roleId != role.id}">
		                                			<option value="${role.id }" hassubinfo="true">${role.name }</option>
		                                		</c:if>
		                                    </c:forEach>
		                                </select>
		                            </div>
                                </div> 
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">账号状态：</label>
                                <div class="col-sm-8">
		                            <div class="input-group">
		                                <select id="status" name="status" data-placeholder="账号状态" class="chosen-select" style="width:330px;" tabindex="2">
	                                		<option value="0" hassubinfo="true" <c:if test="${returnMap.status == 0}">selected="selected"</c:if>>正常</option>
	                                		<option value="1" hassubinfo="true" <c:if test="${returnMap.status == 1}">selected="selected"</c:if>>禁用</option>
	                                		<option value="2" hassubinfo="true" <c:if test="${returnMap.status == 2}">selected="selected"</c:if>>已删除</option>
	                                		<option value="3" hassubinfo="true" <c:if test="${returnMap.status == 3}">selected="selected"</c:if>>欠费</option>
		                                </select>
		                            </div>
                                </div>    
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">付费模式：</label>
                                <div class="col-sm-8">
		                            <div class="input-group">
		                                <select id="userType" name="userType" data-placeholder="付费模式" class="chosen-select" style="width:330px;" tabindex="2">
	                                		<option value="0" hassubinfo="true" <c:if test="${returnMap.userType == 0}">selected="selected"</c:if>>预付费</option>
	                                		<option value="1" hassubinfo="true" <c:if test="${returnMap.userType == 1}">selected="selected"</c:if>>后付费</option>
		                                </select>
		                            </div>
                                </div>    
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">商务经理：</label>
                                <div class="col-sm-3">
                                    <input id="salesMan" name="salesMan" value="${returnMap.salesMan }" minlength="0" type="text" class="form-control" required="" aria-required="" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="button" onclick="editUser()">提交编辑</button>
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
function editUser(){
	var id = $('#id').val();
	var email = $('#email').val();
	var mobile = $('#mobile').val();
	var roleId = $('#roleId').val();
	var status = $('#status').val();
	var userType = $('#userType').val();
	var salesMan = $('#salesMan').val();
	var p = document.getElementById("editText");
	
	var flag = notice_edit.validateData();
	if (!flag) {
		return false;
	}
	
	$.ajax({
		type: "POST",
		url: "/user/saveEditUser",
		data: {
			id : id,
			email : email,
			mobile : mobile,
			roleId : roleId,
			status : status,
			userType : userType,
			salesMan : salesMan
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