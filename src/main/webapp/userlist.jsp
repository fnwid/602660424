<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>滴答办公系统-用户列表</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="media/layui/css/layui.css" media="all">
<script src="media/js/jquery.min.js"></script>
</head>
<body>
<div class="layui-container">
    <div class="layui-row" style="margin-top: 10px">
        <div class="layui-col-xs3" style="margin-right: 20px">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">姓名：</label>
                <div class="layui-input-block">
                    <input type="text" id="no" class="layui-input" placeholder="用户姓名">
                </div>
            </div>
        </div>
        <div class="layui-col-xs3" style="margin-right: 20px">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">用户：</label>
                <div class="layui-input-block">
                    <select class="layui-input" id="fg">
                        <option value="1">启用</option>
                        <option value="2">无效</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-col-xs2">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" onclick="searchData()"><i class="layui-icon layui-icon-search">搜索</i></button>
                </div>
            </div>
        </div>
    </div>
</div>
	
	<div class="layui-container">
		<table class="layui-table" id="tbdata" lay-filter="tbop">
			<thead>
				<tr>
					<td>序号</td>
					<td>工号</td>
					<td>姓名</td>
					<td>职位</td>
					<td>状态</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>9788</td>
					<td>张三</td>
					<td>管理员,讲师,总监</td>
					<td><span style="color: #1E9FFF">启用</span></td>
					<td><a class="layui-btn layui-btn-mini" href="#" onclick="showRoles();">编辑</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini" href="javascript:changeState();" lay-event="detail">禁用</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini"
						lay-event="del" onclick="deleteCourse();">删除</a>
					</td>
				</tr>
				<tr>
					<td>2</td>
					<td>9876</td>
					<td>老王</td>
					<td>讲师</td>
					<td><span style="color: #1E9FFF">启用</span></td>
					<td><a class="layui-btn layui-btn-mini" href="#" onclick="showRoles();">编辑</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini" href="javascript:changeState();" lay-event="detail">禁用</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini"
						lay-event="del" onclick="deleteCourse();">删除</a>
					</td>
				</tr>
				<tr>
					<td>3</td>
					<td>4355</td>
					<td>小李</td>
					<td>班主任,教务</td>
					<td><span style="color: #1E9FFF">禁用</span></td>
					<td><a class="layui-btn layui-btn-mini" href="#" onclick="showRoles();">编辑</a>
						<a class="layui-btn layui-btn-mini layui-btn-mini" href="javascript:changeState();" lay-event="detail">启用</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini"
						lay-event="del" onclick="deleteCourse();">删除</a>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
						   <a href="javascript:;" class="layui-laypage-prev layui-disabled" data-page="0">
							    <i class="layui-icon">&lt;</i>
						   </a> 
							    <span style="color:#009688;font-weight: bold;">1</span> 
							    <a href="#">2</a> 
							    <a href="#">3</a>  
							    <a href="#">4</a> 
							    <a href="#">5</a> 
							<a href="javascript:;" class="layui-laypage-next layui-disabled" data-page="2"> 
							    <i class="layui-icon">&gt;</i>
							</a> 
							<span class="layui-laypage-skip">到第
							   <input type="text" min="1" value="1" class="layui-input">页
								<button type="button" class="layui-laypage-btn">确定</button>
							</span> 
							<span class="layui-laypage-count">共 1 条</span> 
							<span class="layui-laypage-limits"> 
							    <select lay-ignore="">
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
	
	<script src="media/layui/layui.js"></script>
	
	<script type="text/javascript">
	   function deleteCourse(){
		   layui.use('table', function() {
			   layer.confirm('是否确认删除学生?',function(index) {
				   layer.msg("删除成功", {icon : 6});
				   layer.msg("删除失败", {icon : 5});
			   });
		   });
	   }
	   
	   //启用禁用
	   function changeState(){
	   	   layui.use('table', function() {
			   layer.confirm('确认禁用吗?',function(index) {
				   layer.msg("操作成功", {icon : 6});
			   });
		   });
	   }
	   
	   var form;
	   
	   function showRoles(){
	   	  layui.use('table', function() {
					form=layui.form;
					layer.open({
						area: ['500px', '480px'],
						title: '用户编辑',
						type: 1,
						content: $('#dvlay'), //这里content是一个普通的String
						btn: ['更新', '取消'],
						cancel: function() {}
					});
		    });
	   }
	   
	</script>
	
	
</body>
</html>

<div style="display: none;margin-top: 10px;width: 480px" id="dvlay">
    <form id="fm1" class="layui-form layui-form-pane" >
        <div class="layui-form-item" pane >
            <label class="layui-form-label">工号：</label>
            <div class="layui-input-inline">
                <input id="uid" name="id" class="layui-input">
            </div>
        </div>
         <div class="layui-form-item" pane >
            <label class="layui-form-label">姓名：</label>
            <div class="layui-input-inline">
                <input id="uid" name="name" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" pane>
            <label class="layui-form-label">职位：</label>
            <div class="layui-input-inline" id="dv1">
                 <input type="checkbox" name="rids" value="管理员" title="管理员">
                 <input type="checkbox" name="rids" value="总监" title="总监">
                 <input type="checkbox" name="rids" value="讲师" title="讲师">
                 <input type="checkbox" name="rids" value="班主任" title="班主任">
                 <input type="checkbox" name="rids" value="教务" title="教务">
            </div>
        </div>
    </form>
</div>