<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>滴答办公系统-角色列表</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/media/layui/css/layui.css" media="all">
<script src="${pageContext.request.contextPath}/media/js/jquery.min.js"></script>
    <script type="text/javascript">
        function goPage(pageIndex){
            var pageSize=$("#psize").val();//页码
            $("#roleform").attr("action","${pageContext.request.contextPath}/grade/list/"+pageIndex+"?pageSize="+pageSize);
            $("#roleform").submit(); //提交表单参数
        }

        //更新页面大小
        function changeSize(obj){
            var size=obj.value;
            $("#roleform").attr("action","${pageContext.request.contextPath}/grade/list/1?pageSize="+size);
            $("#roleform").submit(); //提交表单参数
        }
    </script>
</head>
<body>
<form action="${pageContext.request.contextPath}/SysRole/list/1" id="roleform">

</form>
	<div class="layui-container">
			<div class="layui-btn-group">
				<button class="layui-btn layui-btn-norma" onclick="addRole()">
				<i class="layui-icon">&#xe654;</i>添加角色
			</button>
			</div>
	</div>
	<div class="layui-container">
		<table class="layui-table" id="tbdata" lay-filter="tbop">
			<thead>
				<tr>
					<td>序号</td>
					<td>角色名称</td>
					<td>角色备注</td>
					<td>操作</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="g">

				<tr>
					<td>${g.id}</td>
					<td>${g.name}</td>
					<td>${g.remark}</td>
					<td><a class="layui-btn layui-btn-mini" href="showEdit(${g.id})">编辑</a>
						<a class="layui-btn layui-btn-danger layui-btn-mini"
						   lay-event="del" onclick="deleteCourse();">删除</a></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
        <div class="layui-box layui-laypage layui-laypage-default" id="layui-laypage-1">
            <c:if test="${hasPrevious!=true}">
                <a href="javascript:;" class="layui-laypage-prev layui-disabled" data-page="0">
                    <i class="layui-icon">&lt;</i>
                </a>
            </c:if>
            <c:if test="${hasPrevious!=false}">
                <a href="javascript:goPage(${page.pageIndex-1});" class="layui-laypage-prev" data-page="0">
                    <i class="layui-icon">&lt;</i>
                </a>
            </c:if>

            <c:forEach begin="${page.startNum}" end="${page.endNum}" step="1" var="i">
                <c:if test="${page.pageIndex==i}">
                    <span style="color:#009688;font-weight: bold;">${i}</span>
                </c:if>
                <c:if test="${page.pageIndex!=i}">
                    <a href="#" onclick="goPage(${i})">${i}</a>
                </c:if>
            </c:forEach>
            <c:if test="${hasNext!=true}">
                <a href="javascript:;" class="layui-laypage-next layui-disabled" data-page="2">
                    <i class="layui-icon">&gt;</i>
                </a>
            </c:if>
            <c:if test="${hasNext!=false}">
                <a href="javascript:goPage(${page.pageIndex+1});" class="layui-laypage-prev" data-page="0">
                    <i class="layui-icon">&gt;</i>
                </a>
            </c:if>
            <span class="layui-laypage-skip">到第
							   <input type="text" min="1" class="layui-input" id="page" value="${page.pageIndex }">页
							   <button type="button" class="layui-laypage-btn" onclick="tiaozhuan(${page.totalPage});">确定</button>
							</span>
            <span class="layui-laypage-count">共${page.totalCount}条</span>
            <span class="layui-laypage-limits">
							<select onchange="changePageSize(this)" id="pageSize">
							        <option value="5"  selected>5条/页</option>
									<option value="10" >10 条/页</option>
									<option value="15" >15 条/页</option>
							</select>
							</span>
        </div>
    </div>
	
	<script src="${pageContext.request.contextPath}/media/layui/layui.js"></script>

    <script type="text/javascript">
        <script type="text/javascript">
            function deleteCourse(){
                layui.use('table', function() {
                    layer.confirm('是否确认删除角色?',function(index) {
                        layer.msg("删除成功", {icon : 6});
                        layer.msg("删除失败", {icon : 5});
                    });
                });
            }

        var form;

        //编辑角色
        function showEdit(id){
            $.get("${pageContext.request.contextPath}/SysRole/goUpdate/"+id, null, function(obj) {
                var menus=obj.menus;
                for(var i=0;i<menus.length;i++){
                    if(menus[i].parentid==0){
                        if(menus[i].flag==true){
                            $("#dv_updateMenu").append("<input type='checkbox' name='menus_ids' value='"+menus[i].id+"' title='"+menus[i].name+"' checked>");
                        }else{
                            $("#dv_updateMenu").append("<input type='checkbox' name='menus_ids' value='"+menus[i].id+"' title='"+menus[i].name+"'>");
                        }
                        for(var j=0;j<menus.length;j++){
                            if(menus[j].parentid==menus[i].id){
                                if(menus[j].flag==true){
                                    $("#dv_updateMenu").append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='menus_ids' value='"+menus[j].id+"' title='"+menus[j].name+"' checked>");
                                }else{
                                    $("#dv_updateMenu").append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='menus_ids' value='"+menus[j].id+"' title='"+menus[j].name+"' >");
                                }
                            }
                        }
                    }
                }
                var permissions=obj.permissions;
                for(var i=0;i<permissions.length;i++){
                    if(permissions[i].flag==true){
                        $("#dv_updatePermission").append("<input type='checkbox' name='permission_ids' value='"+permissions[i].id+"' title='"+permissions[i].name+"' checked>");
                    }else{
                        $("#dv_updatePermission").append("<input type='checkbox' name='permission_ids' value='"+permissions[i].id+"' title='"+permissions[i].name+"'>");
                    }
                }
                var role=obj.role;
                $("#id_update").val(role.id);
                $("#name_update").val(role.name);
                $("#remark_update").val(role.remark);

                //-----------------------------------------
                layui.use('table', function() {
                    form=layui.form;
                    layer.open({
                        area: ['500px', '480px'],
                        title: '更新角色',
                        type: 1,
                        content: $('#dvlay_update'), //这里content是一个普通的String
                        btn: ['更新', '取消'],
                        yes:function(index, layero){
                            $.ajax({
                                url:"${pageContext.request.contextPath}/SysRole/update",
                                type:"post",
                                dataType:"json",
                                data:$("#fm1_update").serialize(),
                                success:function(result){
                                    if(result==true){
                                        //layer.msg("更新成功", {icon : 6});
                                        alert("更新成功~~");
                                        window.location.reload();//刷新页面
                                    }else{
                                        layer.msg("更新失败", {icon : 5});
                                    }
                                }
                            });
                            layer.close(index);//关闭窗口
                        },
                        cancel: function() {}
                    });
                });


            });
        }

        //弹出新增框
        function addRole(){
            $.get("${pageContext.request.contextPath}/SysRole/toadd", null, function(obj) {
                var menus=obj.menus;
                for(var i=0;i<menus.length;i++){
                    if(menus[i].parentid==0){
                        $("#dv_addMenu").append("<input type='checkbox' name='menus_ids' value='"+menus[i].id+"' title='"+menus[i].name+"'>");
                        for(var j=0;j<menus.length;j++){
                            if(menus[j].parentid==menus[i].id){
                                $("#dv_addMenu").append("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='checkbox' name='menus_ids' value='"+menus[j].id+"' title='"+menus[j].name+"'>");
                            }
                        }
                    }
                }
                var permissions=obj.permissions;
                for(var i=0;i<permissions.length;i++){
                    $("#dv_addPermission").append("<input type='checkbox' name='permission_ids' value='"+permissions[i].id+"' title='"+permissions[i].name+"'>");
                }

                //------------------------------------------

                layui.use('table', function() {
                    form=layui.form;
                    layer.open({
                        area: ['500px', '480px'],
                        title: '添加角色',
                        type: 1,
                        content: $('#dvlay_add'), //这里content是一个普通的String
                        btn: ['新增', '取消'],
                        yes:function(index, layero){
                            $.ajax({
                                url:"${pageContext.request.contextPath}/role/add",
                                type:"post",
                                dataType:"json",
                                data:$("#fm1_add").serialize(),
                                success:function(result){
                                    if(result==true){
                                        layer.msg("新增成功", {icon : 6});
                                    }else{
                                        layer.msg("新增失败", {icon : 5});
                                    }
                                }
                            });
                            layer.close(index);//关闭窗口
                        },
                        cancel: function() {}
                    });
                });

            });
        }
    </script>
	
	
</body>
</html>


<div style="display: none;margin-top: 10px;width: 480px" id="dvlay">
    <form id="fm1" class="layui-form layui-form-pane" >
        <div class="layui-form-item" pane >
            <label class="layui-form-label">角色名称：</label>
            <div class="layui-input-inline">
                <input id="uid" name="id" class="layui-input">
            </div>
        </div>
         <div class="layui-form-item" pane >
            <label class="layui-form-label">角色备注：</label>
            <div class="layui-input-inline">
                <input id="uid" name="name" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" pane>
            <label class="layui-form-label">菜单：</label>
            <div class="layui-input-inline" id="dv1">
                 <input type="checkbox" name="rids" value="权限管理" title="权限管理">
                 <input type="checkbox" name="rids" value="专业管理" title="专业管理">
                 <input type="checkbox" name="rids" value="班级管理" title="班级管理">
                 <input type="checkbox" name="rids" value="学生管理" title="学生管理">
            </div>
        </div>
        <div class="layui-form-item" pane>
            <label class="layui-form-label">权限：</label>
            <div class="layui-input-inline" id="dv1">
                 <input type="checkbox" name="rids" value="用户新增" title="用户新增">
                 <input type="checkbox" name="rids" value="用户更新" title="用户更新">
                 <input type="checkbox" name="rids" value="用户删除" title="用户删除">
                 <input type="checkbox" name="rids" value="用户导入" title="用户导入">
                 <input type="checkbox" name="rids" value="员工新增" title="员工新增">
                 <input type="checkbox" name="rids" value="员工更新" title="员工更新">
                 <input type="checkbox" name="rids" value="员工导入" title="员工导入">
            </div>
        </div>
    </form>
</div>



<div style="display: none;margin-top: 10px;width: 480px" id="dvlay_add">
    <form id="fm1" class="layui-form layui-form-pane" >
        <div class="layui-form-item" pane >
            <label class="layui-form-label">角色名称：</label>
            <div class="layui-input-inline">
                <input id="uid" name="id" class="layui-input">
            </div>
        </div>
         <div class="layui-form-item" pane >
            <label class="layui-form-label">角色备注：</label>
            <div class="layui-input-inline">
                <input id="uid" name="name" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item" pane>
            <label class="layui-form-label">菜单：</label>
            <div class="layui-input-inline" id="dv1">
                 <input type="checkbox" name="rids" value="权限管理" title="权限管理">
                 <input type="checkbox" name="rids" value="专业管理" title="专业管理">
                 <input type="checkbox" name="rids" value="班级管理" title="班级管理">
                 <input type="checkbox" name="rids" value="学生管理" title="学生管理">
            </div>
        </div>
        <div class="layui-form-item" pane>
            <label class="layui-form-label">权限：</label>
            <div class="layui-input-inline" id="dv1">
                 <input type="checkbox" name="rids" value="用户新增" title="用户新增">
                 <input type="checkbox" name="rids" value="用户更新" title="用户更新">
                 <input type="checkbox" name="rids" value="用户删除" title="用户删除">
                 <input type="checkbox" name="rids" value="用户导入" title="用户导入">
                 <input type="checkbox" name="rids" value="员工新增" title="员工新增">
                 <input type="checkbox" name="rids" value="员工更新" title="员工更新">
                 <input type="checkbox" name="rids" value="员工导入" title="员工导入">
            </div>
        </div>
    </form>
</div>