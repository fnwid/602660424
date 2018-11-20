<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>滴答办公系统-学科列表</title>
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
<form action="${pageContext.request.contextPath}/course/list/1" id="gradeform">
       
    </form>
	<div class="layui-container">
		<table class="layui-table" id="tbdata" lay-filter="tbop">
			<thead>
				<tr>
					<td>序号</td>
					<td>学科名称</td>
					<td>周数</td>
					<td>成立日期</td>
					<td>类型</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
				
				<c:forEach items="${page.list}" var="g">
				<tr>
					<td>${g.id}</td>
					<td>${g.name}</td>
					<td>${g.count}</td>
					<td>${g.week}</td>
					<td>${g.type}</td>
					<td><a class="layui-btn layui-btn-mini" href="${pageContext.request.contextPath}/course/pageToUpdate/${g.id}">编辑</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini"
						lay-event="del" onclick="deleteCart(${g.id});">删除</a></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
						   <a href="javascript:;" class="layui-laypage-prev layui-disabled" data-page="0">
							    <i class="layui-icon">&lt;</i>
						   </a> 
							   <c:forEach begin="${page.startNum}" end="${page.endNum}" step="1" var="i">
						           <c:if test="${page.pageIndex==i}">
						            <span style="color:#009688;font-weight: bold;">${i}</span> 
						           </c:if>
						           <c:if test="${page.pageIndex!=i}">
						              <a href="#" onclick="goPage(${i})">${i}</a>
						           </c:if>
       						</c:forEach>
							<a href="javascript:;" class="layui-laypage-next layui-disabled" data-page="2"> 
							    <i class="layui-icon">&gt;</i>
							</a> 
							<span class="layui-laypage-skip">到第
							   <input type="text" min="1" value="1" class="layui-input">页
								<button type="button" class="layui-laypage-btn">确定</button>
							</span> 
							<span class="layui-laypage-count">共 ${page.totalCount} 条</span> 
							<span class="layui-laypage-limits"> 
							    <select lay-ignore="#" onchange="changeSize(this);">
							        <option value="10" selected="">10 条/页</option>
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
	   function deleteCourse(){
		   layui.use('table', function() {
			   layer.confirm('是否确认删除学科?',function(index) {
				   layer.msg("删除成功", {icon : 6});
				   layer.msg("删除失败", {icon : 5});
			   });
		   });
	   }
	   function deleteCart(id){
			  location.href="${pageContext.request.contextPath}/course/delete/"+id;
		  }
	</script>
	
	
</body>
</html>