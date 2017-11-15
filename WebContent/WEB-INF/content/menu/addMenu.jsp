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
    
<title>目录添加</title>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-15">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>添加目录</h5>
                        <div class="ibox-tools">
                            <a href="<%=path%>/menu/menuList">X</a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="commentForm" action="<%=path%>/menu/addMenu" method="post">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">菜单名称：</label>
                                <div class="col-sm-3">
                                    <input id="name" name="name" value="${map.name }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">URL路径：</label>
                                <div class="col-sm-3">
                                    <input id="url" name="url" value="${map.url }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">父级目录：</label>
                                <div class="col-sm-8">
		                            <div class="input-group">
		                                <select id="super_id" name="super_id" data-placeholder="父级目录" class="chosen-select" style="width:330px;" tabindex="2">
		                                	<option value="0" hassubinfo="true">-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-&nbsp;-</option>
		                                	<c:forEach items="${sessionScope.rolemenu.first}" var="first">
		                                		<c:if test="${param.super_id == first.id}">
		                                			<option value="${first.id }" hassubinfo="true" selected="selected">${first.name }</option>
		                                		</c:if>
		                                    	<c:if test="${param.super_id != first.id}">
		                                			<option value="${first.id }" hassubinfo="true">${first.name }</option>
		                                		</c:if>
		                                    </c:forEach>
		                                </select>
		                            </div>
                                </div>    
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">是否启用：</label>
                                <div class="col-sm-8">
		                            <div class="input-group">
		                                <select id="status" name="status" data-placeholder="启用状态" class="chosen-select" style="width:330px;" tabindex="2">
	                                		<option value="0" hassubinfo="true" <c:if test="${param.status == 0}">selected="selected"</c:if>>启用</option>
	                                		<option value="1" hassubinfo="true" <c:if test="${param.status == 1}">selected="selected"</c:if>>停用</option>
		                                </select>
		                            </div>
                                </div>    
                            </div>
                            
                            <%-- <div class="form-group">
                                <label class="col-sm-3 control-label">过期时间：</label>
                                <div class="col-sm-8">
                                   <input class="form-control layer-date" name="notice_endtime" id="notice_endtime" required="" aria-required="true" value="${map.notice_endtime }" placeholder="" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                                </div>
                            </div> --%>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">排序号：</label>
                                <div class="col-sm-3">
                                    <input id="sort" name="sort" value="${map.sort }" minlength="1" type="text" class="form-control" required="" aria-required="true" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-4 control-label">备注：</label>
                                <div class="col-sm-3">
                                    <input id="remark" name="remark" value="${map.remark }" minlength="0" type="text" class="form-control" required="" aria-required="" >
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-sm-6 col-sm-offset-5">
                                    <button class="btn btn-primary" type="button" onclick="addMenu()">提交添加</button>
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
$(function(){
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
		for ( var selector in config)
			$(selector).chosen(config[selector]);
		
})

function addMenu(){
	var url = $('#url').val();
	var name = $('#name').val();
	var super_id = $('#super_id').val();
	var status = $('#status').val();
	var sort = $('#sort').val();
	var remark = $('#remark').val();
	var p = document.getElementById("addText");
	
	var flag = notice_add.validateData();
	if (!flag) {
		return false;
	}
	
	$.ajax({
		type: "POST",
		url: "/menu/saveAddMenu",
		data: {
			url : url,
			name : name,
			super_id : super_id,
			status : status,
			sort : sort,
			remark : remark
		},
		dataType: "json",
		success: function(data) {
			if(data == 'true'){
				p.innerHTML = "添加成功";
				p.style.color = "red";
				setTimeout("codefans()",3000);//3秒
			}else{
				p.innerHTML = "添加失败";
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