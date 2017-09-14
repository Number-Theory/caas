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
    
<title>号码添加</title>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-15">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>添加号码</h5>
                        <div class="ibox-tools">
                            <a href="<%=path%>/user/userList">X</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="commentForm" action="<%=path%>/user/addUser" method="post">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">号码：</label>
                                <div class="col-sm-3">
                                    <input id="phoneNumber" name="phoneNumber" value="${returnMap.phoneNumber }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">号码归属地：</label>
                                <div class="col-sm-3">
                                    <input id="city" name="city" value="${returnMap.city }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">号码归属地区号：</label>
                                <div class="col-sm-3">
                                    <input id="cityCode" name="cityCode" value="${returnMap.cityCode }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">运营商：</label>
                                <div class="col-sm-3">
                                    <input id="cityCode" name="cityCode" value="${returnMap.cityCode }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">yunyings：</label>
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
                                <div class="col-sm-6 col-sm-offset-5">
                                    <button class="btn btn-primary" type="button" onclick="addUser()">提交添加</button>
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
function addUser(){
	var userName = $('#userName').val();
	var email = $('#email').val();
	var mobile = $('#mobile').val();
	var roleId = $('#roleId').val();
	var status = $('#status').val();
	var userType = $('#userType').val();
	var salesMan = $('#salesMan').val();
	var p = document.getElementById("addText");
	
	var flag = notice_add.validateData();
	if (!flag) {
		return false;
	}
	
	$.ajax({
		type: "POST",
		url: "/user/saveAddUser",
		data: {
			userName : userName,
			email : email,
			mobile : mobile,
			roleId : roleId,
			status : status,
			userType : userType,
			salesMan : salesMan
		},
		dataType: "json",
		success: function(data) {
			debugger;
			if(data.result == 'true'){
				p.innerHTML = "添加成功";
				p.style.color = "red";
			}else{
				p.innerHTML = "添加失败" + data.msg;
				p.style.color = "red";
			}
		},
		error: function(data) {
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