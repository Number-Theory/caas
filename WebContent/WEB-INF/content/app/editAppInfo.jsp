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
    
<title>应用编辑页面</title>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-15">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>应用详情</h5>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="commentForm">
                            <input id="id" name="id" value="${appMap.id }" type="hidden" >
                            <div class="form-group">
                                <label class="col-sm-4 control-label">服务器白名单：</label>
                                <div class="col-sm-3">
                                    <input id="ipWhiteList" name="ipWhiteList" value="${appMap.ipWhiteList }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                                <label class="col-sm-4 control-label" style="text-align: left;">多个用分号(;)隔开</label>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">状态回调地址：</label>
                                <div class="col-sm-3">
                                    <input id="statusUrl" name="statusUrl" value="${appMap.statusUrl }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">挂机回调地址：</label>
                                <div class="col-sm-3">
                                    <input id="hangupUrl" name="hangupUrl" value="${appMap.hangupUrl }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">录音回调地址：</label>
                                <div class="col-sm-3">
                                    <input id="recordUrl" name="recordUrl" value="${appMap.recordUrl }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
	                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button class="btn btn-primary" type="button" onclick="editAppInfo()">提交编辑</button>
                                     <p id="editAppInfoText"></p>
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
function editAppInfo(){
	var id = $('#id').val();
	var ipWhiteList = $('#ipWhiteList').val();
	var statusUrl = $('#statusUrl').val();
	var hangupUrl = $('#hangupUrl').val();
	var recordUrl = $('#recordUrl').val();
	
	var p = document.getElementById("editAppInfoText");
	
	var flag = notice_edit.validateData();
	if (!flag) {
		return false;
	}
	
	$.ajax({
		type: "POST",
		url: "/app/saveEditAppInfo",
		data: {
			id : id,
			ipWhiteList : ipWhiteList,
			statusUrl : statusUrl,
			hangupUrl : hangupUrl,
			recordUrl : recordUrl
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
	var p = document.getElementById("editAppInfoText");	
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