<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>滴答办公系统-学员详细</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/media/layui/css/layui.css" media="all">
<script type="text/javascript" src="${pageContext.request.contextPath}/media/js/jquery.min.js"></script>

</head>
<body>
	<div class="layui-container" style="margin-top: 5px">
		<form class="layui-form" action="${pageContext.request.contextPath}/student/get" method="post">
			<div class="layui-form-item">
				<label class="layui-form-label">学员姓名</label>
				<div class="layui-input-block">
					<div class="layui-form-mid layui-word-aux">${s.name}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">所属班级</label>
				<div class="layui-input-block">
					<div class="layui-form-mid layui-word-aux">${s.gid}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">性别</label>
				<div class="layui-input-block">
					<div class="layui-form-mid layui-word-aux">${s.sex}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">邮箱</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.email}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">手机号</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.phone}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">QQ</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.qq}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">身份证号</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.cardno}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">毕业学校</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.school}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">学历</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.education}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">出生日期</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.birthday}</div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">入学日期</label>
				<div class="layui-input-inline">
					<div class="layui-form-mid layui-word-aux">${s.createdate}</div>
				</div>
			</div>
		</form>
	</div>


	<script src="media/layui/layui.js"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
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
	</script>
</body>
</html>