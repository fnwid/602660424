<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>滴答办公系统-班级列表</title>
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
	
</script>
</head>
<body>
   <form action="${pageContext.request.contextPath}/grade/list/1" id="gradeform">
       
    </form>
	<div class="layui-container">
		<table class="layui-table" id="tbdata" lay-filter="tbop">
			<thead>
				<tr>
					<td>序号</td>
					<td>班级名称</td>
					<td>班级人数</td>
					<td>学科名称</td>
					<td>周数</td>
					<td>位置</td>
					<td>开班日期</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${pageBean.list}" var="g">
				<tr>
					<td>${g.id}</td>
					<td>${g.name}</td>
					<td>${g.count}</td>
					<td>${g.course.name}</td>
					<td>${g.week}</td>
					<td>${g.location}</td>
					<td>${g.createdate}</td>
					<td><a class="layui-btn layui-btn-mini" href="${pageContext.request.contextPath}/grade/pageToUpdate/${g.id}">编辑</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini"
						lay-event="del" onclick="deleteCart(${g.id});">删除</a></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
						   <a href="javascript:;" class="layui-laypage-prev layui-disabled" data-page="0">
							    <i class="layui-icon"><a href="#" onclick="goPage(${pageBean.pageIndex-1});">&lt;</a></i>
						   </a> 
							    
						    <c:forEach begin="${pageBean.startNum}" end="${pageBean.endNum}" step="1" var="i">
						           <c:if test="${pageBean.pageIndex==i}">
						            <span style="color:#009688;font-weight: bold;">${i}</span> 
						           </c:if>
						           <c:if test="${pageBean.pageIndex!=i}">
						              <a href="#" onclick="goPage(${i})">${i}</a>
						           </c:if>
       						</c:forEach>
							     
							<a href="javascript:;" class="layui-laypage-next layui-disabled" data-page="2"> 
							
							    <i class="layui-icon"><a href="#" onclick="goPage(${pageBean.pageIndex+1});">&gt;</a></i>
							</a> 
							<span class="layui-laypage-skip">到第
							   <input type="text" min="1" value="1" class="layui-input">页
								<button type="button" class="layui-laypage-btn">确定</button>
							</span> 
							<span class="layui-laypage-count">共${pageBean.totalCount}条</span> 
							<span class="layui-laypage-limits"> 
							    <select name="#" onchange="changeSize(this);">
							        <option value="5" selected>5 条/页</option>
									<option value="10">10条/页</option>
									<option value="15">15 条/页</option>
									<option value="20">20 条/页</option>
							</select>
							</span>
						</div>
	</div>
	
	<script src="${pageContext.request.contextPath}/media/layui/layui.js"></script>
	
	<script type="text/javascript">
	  
	   function deleteCart(id){
			  location.href="${pageContext.request.contextPath}/grade/delete/"+id;
		  }
	</script>

</body>
</html>