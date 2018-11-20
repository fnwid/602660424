<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>滴答办公系统-学员更新</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/media/layui/css/layui.css" media="all">
<script type="text/javascript" src="${pageContext.request.contextPath}/media/js/jquery.min.js"></script>
</head>
<body>
	<div class="layui-container" style="margin-top: 5px">
		<form class="layui-form" action="${pageContext.request.contextPath}/student/update" method="post">
			<div class="layui-form-item">
			<div class="layui-input-block">
					<input type="hidden" name="id"  autocomplete="off"
						class="layui-input" id="id1" value="${s.id}" >
				</div>
				<label class="layui-form-label">学员学号</label>
				<div class="layui-input-block">
					<input type="text" name="no" lay-verify="name" autocomplete="off"
						value="${s.no}" id="no" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">学员姓名</label>
				<div class="layui-input-block">
					<input type="text" name="name" lay-verify="name" autocomplete="off"
						value=${s.name} class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">所属班级</label>
				<div class="layui-input-block">
					<select name="gid" id="cds">
						<option value="${s.gid}">--请选择班级--</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">性别</label>
				<div class="layui-input-block">
					
					<input type="radio" name="sex" value="男" title="男" ${s.sex=='男'?'selected':''} >
					<input type="radio" name="sex" value="女" title="女" ${s.sex=='女'?'selected':''}>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">邮箱</label>
				<div class="layui-input-inline">
					<input type="text" name="email" lay-verify="required"
						value="${s.email}" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">手机号</label>
				<div class="layui-input-inline">
					<input type="text" name="phone" lay-verify="required"
						value="${s.phone}" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">QQ</label>
				<div class="layui-input-inline">
					<input type="text" name="qq" lay-verify="required"
						value="${s.qq}" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">身份证号</label>
				<div class="layui-input-inline">
					<input type="text" name="cardno" lay-verify="required"
						value="${s.phone}" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">毕业学校</label>
				<div class="layui-input-inline">
					<input type="text" name="school" lay-verify="required"
						value="${s.school}" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">学历</label>
				<div class="layui-input-inline">
					<select name="education">
						<option>初中</option>
						<option>高中</option>
						<option>专科</option>
						<option>本科</option>
						<option>硕士</option>
						<option>博士</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">出生日期</label>
				<div class="layui-input-inline">
					<input type="text" name="birthday" id="date1" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">入学日期</label>
				<div class="layui-input-inline">
					<input type="text" name="createdate" id="date2" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<input class="layui-btn"  style="margin-left: 10%" id="btn1" type="submit"
					value="确认更新">
			</div>
		</form>
	</div>


	<script src="${pageContext.request.contextPath}/media/layui/layui.js"></script>
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
		function initData() {
			$.get("${pageContext.request.contextPath}/grade/get",null,function(arr){
				for(i=0;i<arr.length;i++){
					$("#cds").append("<option value='"+arr[i].id+"'>"+arr[i].name+"</option>");
				}
				form.render("select");
			})
		}
	</script>
</body>
</html>