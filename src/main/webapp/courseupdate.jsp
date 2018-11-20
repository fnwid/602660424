<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<title>滴答办公系统-部门修改</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/media/layui/css/layui.css" media="all">
<script type="text/javascript" src="${pageContext.request.contextPath}/media/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/media/layui/layui.js"></script>
<script type="text/javascript">



</script>
</head>
<body>

	<div class="layui-container" style="margin-top: 5px">
		<form class="layui-form" action="${pageContext.request.contextPath}/course/update" method="post">
		
			<div class="layui-form-item">
			<div class="layui-input-block">
					<input type="hidden" name="id"  autocomplete="off"
						class="layui-input" id="id1" value="${course.id}" >
				</div>
				<label class="layui-form-label">学科名称</label>
				<div class="layui-input-block">
					<input type="text" name="name" id="f2" lay-verify="name" autocomplete="off"
						value="${course.name}" class="layui-input">
				</div>
			</div>
			
			<div class="layui-form-item">
				<label class="layui-form-label">开班日期</label>
				<div class="layui-input-block">
				 <input type="text" id="f4" autocomplete="off" class="layui-input" value="${course.createdate}">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">学科周期</label>
				<div class="layui-input-block">
					<input type="text" name="week" id="f4" lay-verify="name" autocomplete="off"
						value="${course.week}" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">学科类型</label>
				<div class="layui-input-block">
					<select name="type">
						<option value="普通">普通</option>
						<option value="精品">精品</option>
						<option value="业余">业余</option>
					</select>
				</div>
			</div>
			
		
			<div class="layui-form-item">
				<input class="layui-btn"  style="margin-left: 10%"  type="submit" value="确认修改">
			</div>
		</form>
	</div>
	
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
		layui.use([ 'form', 'laydate' ],
						function() {
							var form = layui.form, layer = layui.layer, laydate = layui.laydate;
							laydate.render({
								elem : '#date'
							});
		});
	</script>
</body>
</html>