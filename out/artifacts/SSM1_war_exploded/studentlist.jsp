<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<title>滴答办公系统-学员列表</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/media/layui/css/layui.css" media="all">
<script src="${pageContext.request.contextPath}/media/js/jquery.min.js"></script>
<script type="text/javascript">
//跳转页码
function goPage(pageIndex){
	var pageSize=$("#psize").val();//页码
	$("#gradeform").attr("action","${pageContext.request.contextPath}/grade/list/"+pageIndex+"?pageSize="+pageSize);
	$("#gradeform").submit(); //提交表单参数
}

//更新页面大小
function changeSize(obj){
	var size=obj.value;
	$("#gradeform").attr("action","${pageContext.request.contextPath}/grade/list/1?pageSize="+size);
	$("#gradeform").submit(); //提交表单参数
}
//导入Excel
function exportExcel() {
	$("#gradeform").attr("action", "${pageContext.request.contextPath}/student/down");
	$("#gradeform").submit();
}
</script>

</head>
<body>
<form action="${pageContext.request.contextPath}/student/list/1" id="gradeform">
       
    </form>
    <form action="${pageContext.request.contextPath}/student/query">
<div class="layui-container">
    <div class="layui-row" style="margin-top: 10px">
        <div class="layui-col-xs3" style="margin-right: 20px">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">姓名：</label>
                <div class="layui-input-block">
                    <input type="text" name="name" id="name" class="layui-input" placeholder="学生姓名">
                </div>
            </div>
        </div>
       <div class="layui-col-xs3" style="margin-right: 20px">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">班级：</label>
                <div class="layui-input-block">
                    <select class="layui-input" name="gid" id="cds">
                		<option value="-1">--请选择班级--</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn"  onclick="searchData()"><i class="layui-icon layui-icon-search">搜索</i></button>
                </div>
            </div>
        </div>
        </form>
       <div class="layui-col-xs2">
				<div class="layui-form-item">
					<div class="layui-input-block">
						<a class="layui-btn layui-btn-mini layui-btn-mini" href="javascript:exportExcel();" lay-event="detail">导出Excel</a>
					</div>
				</div>
			</div>
    </div>
</div>
	
	<div class="layui-container">
		<table class="layui-table" id="tbdata" lay-filter="tbop">
			<thead>
				<tr>
					<td>学号</td>
					<td>姓名</td>
					<td>班级</td>
					<td>性别</td>
					<td>QQ</td>
					<td>邮箱</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${pageBean.list}" var="g">
				<tr>
					<td>${g.id}</td>
					<td>${g.name}</td>
					<td>${g.grade.name}</td>
					<td>${g.sex}</td>
					<td>${g.qq}</td>
					<td>${g.email}</td>
					<td><a class="layui-btn layui-btn-mini" href="${pageContext.request.contextPath}/student/goupdate/${g.id}">编辑</a>
						<a class="layui-btn layui-btn-mini layui-btn-mini" href="${pageContext.request.contextPath}/student/get/${g.id}" lay-event="detail">查看详情</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini"
						lay-event="del" onclick="deleteCart(${g.id});">删除</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
						   <a href="javascript:;" class="layui-laypage-prev layui-disabled" data-page="0">
							    <i class="layui-icon">&lt;</i>
						   </a> 
							    <span style="color:#009688;font-weight: bold;">1</span> 
							    <c:forEach begin="${pageBean.startNum}" end="${pageBean.endNum}" step="1" var="i">
						           <c:if test="${pageBean.pageIndex==i}">
						            <span style="color:#009688;font-weight: bold;">${i}</span> 
						           </c:if>
						           <c:if test="${pageBean.pageIndex!=i}">
						              <a href="#" onclick="goPage(${i})">${i}</a>
						           </c:if>
       						</c:forEach>
							<a href="javascript:;" class="layui-laypage-next layui-disabled" data-page="2"> 
							    <i class="layui-icon"><a href="#" onclick="goPage(${pageBean.pageIndex+1});">&gt;</i>
							</a> 
							<span class="layui-laypage-skip">到第
							   <input type="text" min="1" value="1" class="layui-input">页
								<button type="button" class="layui-laypage-btn">确定</button>
							</span> 
							<span class="layui-laypage-count">共 1 条</span> 
							<span class="layui-laypage-limits"> 
							    <select lay-ignore="">
							        <option value="10" onchange="changeSize(this);">10 条/页</option>
									<option value="20">20 条/页</option>
									<option value="30">30 条/页</option>
									<option value="40">40 条/页</option>
									<option value="50">50 条/页</option>
									<option value="60">60 条/页</option>
									<option value="70">70 条/页</option>
									<option value="80">80 条/页</option>
									<option value="90">90 条/页</option>
							</select>
							</span>
						</div>
	</div>

	<script src="${pageContext.request.contextPath}/media/layui/layui.js"></script>
	
	<script type="text/javascript">
	 var form;
		layui.use(
					[ 'form','upload', 'layedit', 'laydate' ],
					function() {
						form = layui.form, layer = layui.layer, layedit = layui.layedit, laydate = layui.laydate;
						var upload = layui.upload;
						//日期
						laydate.render({
							elem : '#date1'
						});
						laydate.render({
							elem : '#date2'
						});
			 initData();
		});
		function initData() {
			$.get("${pageContext.request.contextPath}/grade/get",null,function(arr){
				for(i=0;i<arr.length;i++){
					$("#cds").append("<option value='"+arr[i].id+"'>"+arr[i].name+"</option>");
				}
				form.render("select");
			})
		}
	function deleteCart(id){
		  location.href="${pageContext.request.contextPath}/student/delete/"+id;
	  }
	function initData() {
		$.get("${pageContext.request.contextPath}/grade/get",null,function(arr){
			for(i=0;i<arr.length;i++){
				$("#cds").append("<option value='"+arr[i].id+"'>"+arr[i].name+"</option>");
			}
			form.render("select");
		})
	}
	function searchData() {
		$.get("${pageContext.request.contextPath}/student/query");
	}
    
	</script>
	
	
</body>
</html>