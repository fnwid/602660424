<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>滴答办公系统-资源列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/media/layui/css/layui.css" media="all">
    <script src="${pageContext.request.contextPath}/media/js/jquery.min.js"></script>
    <script type="text/javascript">

        //跳转页面
        function goPage(pageIndex) {
            location.href="${pageContext.request.contextPath}/sysPermission/list/"+pageIndex;
        }
        //改变页面大小
        function changePageSize(obj) {
            var page = obj.value;
            location.href="${pageContext.request.contextPath}/sysPermission/list/1?pageSize="+page;
        }

        //跳转指定页面
        function tiaozhuan(totalPage) {
            //获取输入框内容
            var pageIndex = $("#page").val();
            var regex = new RegExp(/^[\d]+$/);
            var bool = regex.test(pageIndex);
            if(bool){
                if(pageIndex>totalPage||pageIndex<1){
                    alert("输入页码不在范围内！请重新输入~");
                    $("#page").focus();
                }else{
                    location.href="${pageContext.request.contextPath}/menu/list/"+pageIndex;
                }
            }else{
                alert("输入不合法！请重新输入~");
                $("#page").focus();
            }

        }

        $(function() {
            $("#pageSize").val(${pageHelper.pageSize});
        })


    </script>
</head>

<body>
<div class="layui-container">
    <div class="layui-btn-group">
        <button class="layui-btn layui-btn-norma" onclick="addMenus()">
            <i class="layui-icon">&#xe654;</i>添加权限
        </button>
    </div>
</div>
<div class="layui-container">
    <table class="layui-table" id="tbdata" lay-filter="tbop">
        <thead>
        <tr>
            <td>序号</td>
            <td>名称</td>
            <td>页面路径</td>
            <td>图标</td>
            <td>级别</td>
            <td>操作</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageHelper.list}" var="menu">
            <tr>
                <td>${menu.id}</td>
                <td>${menu.name}</td>
                <td>${menu.url}</td>
                <td>${menu.icon}</td>
                <td>${menu.parentid==0?'一级菜单':'二级菜单'}</td>
                <td>
                    <c:if test="${menu.parentid==0}">
                        <a class="layui-btn layui-btn-mini" href="javascript:updateMenu1(${menu.id});">编辑</a>
                    </c:if>
                    <c:if test="${menu.parentid!=0}">
                        <a class="layui-btn layui-btn-mini" href="javascript:updateMenu2(${menu.id});">编辑</a>
                    </c:if>
                    <a class="layui-btn layui-btn-danger layui-btn-mini" lay-event="del" onclick="deleteMenus();">删除</a>
                </td>
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
            <a href="javascript:goPage(${pageHelper.pageIndex-1});" class="layui-laypage-prev" data-page="0">
                <i class="layui-icon">&lt;</i>
            </a>
        </c:if>

        <c:forEach begin="${pageHelper.startNum}" end="${pageHelper.endNum}" step="1" var="i">
            <c:if test="${pageHelper.pageIndex==i}">
                <span style="color:#009688;font-weight: bold;">${i}</span>
            </c:if>
            <c:if test="${pageHelper.pageIndex!=i}">
                <a href="#" onclick="goPage(${i})">${i}</a>
            </c:if>
        </c:forEach>
        <c:if test="${hasNext!=true}">
            <a href="javascript:;" class="layui-laypage-next layui-disabled" data-page="2">
                <i class="layui-icon">&gt;</i>
            </a>
        </c:if>
        <c:if test="${hasNext!=false}">
            <a href="javascript:goPage(${pageHelper.pageIndex+1});" class="layui-laypage-prev" data-page="0">
                <i class="layui-icon">&gt;</i>
            </a>
        </c:if>
        <span class="layui-laypage-skip">到第
							   <input type="text" min="1" class="layui-input" id="page" value="${pageHelper.pageIndex }">页
							   <button type="button" class="layui-laypage-btn" onclick="tiaozhuan(${pageHelper.totalPage});">确定</button>
							</span>
        <span class="layui-laypage-count">共${pageHelper.totalCount}条</span>
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
    function deleteMenus() {
        layui.use('table', function() {
            layer.confirm('是否确认删除菜单?', function(index) {
                layer.msg("删除成功", {
                    icon: 6
                });
                layer.msg("删除失败", {
                    icon: 5
                });
            });
        });
    }


    var form;
    //添加菜单 事件
    function addMenus() {
        layui.use('table', function() {
            form=layui.form;

            //给单选框添加事件
            form.on('radio(level)', function (data) {
                changePid(data.value);单击事件
            });
            //给下拉框添加事件
            form.on('select(parent)', function (obj) {
                setPid(obj);//给下拉框绑定事件
            });


            //弹出DIV页面--新增菜单
            layer.open({
                area: ['500px', '380px'],
                title: '菜单页面新增',
                type: 1,
                content: $('#dvlay_addMenu'), //这里content是一个普通的String
                btn: ['新增', '取消'],
                yes:function(index, layero){
                    $.ajax({
                        url:"${pageContext.request.contextPath}/sysPermission/add",
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
                cancel: function() {
                    alert("取消新增");
                }

            });

        });
    }

    //单选框的单击事件
    function changePid(i) {
        $("#dvl1").css("display", "block");
        form.render();
        if(i == -1) {
            //查询一级菜单
            $.get("${pageContext.request.contextPath}/sysPermission/getOneLevelMenu", null, function(arr) {
                for(i = 0; i < arr.length; i++) {
                    $("#spid").append("<option value=\"" + arr[i].id + "\">" + arr[i].name + "</option>");
                }
                $("#dvl1").css("display", "block"); //显示出来
                form.render();
            });
        } else {
            $("#dvl1").css("display", "none");
            $("#pid").val(i);
        }
    }

    function setPid(obj) {
        //单击单选按钮 修改隐藏域中parentID的Value
        $("#pid").val(obj.value);
    }

    //更新1级菜单
    function updateMenu1(id) {
        //回显表单数据
        $.get("${pageContext.request.contextPath}/sysPermission/getById/"+id, null, function(obj) {
            $("#id_udpate1").val(obj.id);
            $("#name_udpate1").val(obj.name);
            $("#icon_udpate1").val(obj.icon);
            $("#url_udpate1").val(obj.url);
            //--------------------------------------------------

            layui.use('table', function() {
                form=layui.form;
                layer.open({
                    area: ['500px', '380px'],
                    title: '一级菜单更新',
                    type: 1,
                    content: $('#dvupdate1'), //这里content是一个普通的String
                    btn: ['更新', '取消'],
                    yes:function(index, layero){
                        $.ajax({
                            url:"${pageContext.request.contextPath}/sysPermission/updateOneLevelMenu",
                            type:"post",
                            dataType:"json",
                            data:$("#fm1_update1").serialize(),
                            success:function(result){
                                if(result==true){
                                    layer.msg("更新成功", {icon : 6});
                                }else{
                                    layer.msg("更新失败", {icon : 5});
                                }
                            }
                        });
                        layer.close(index);//关闭窗口
                    },
                    cancel: function() {

                    }
                });
            });

        });
    }

    //更新2级菜单
    function updateMenu2(id) {
        $.get("${pageContext.request.contextPath}/sysPermission/getById1/"+id, null, function(obj) {
            var menus=obj.list;
            for(i = 0; i < menus.length; i++) {
                $("#spid_udapte2").append("<option value=\"" + menus[i].id + "\">" + menus[i].name + "</option>");
            }

            var p=obj.sysPermission;
            $("#id_udpate2").val(p.id);
            $("#name_udpate2").val(p.name);
            $("#icon_udpate2").val(p.icon);
            $("#url_udpate2").val(p.url);

            $("#spid_udapte2").val(p.parentid); //选择下拉框


            layui.use('table', function() {
                form=layui.form;
                layer.open({
                    area: ['500px', '380px'],
                    title: '二级菜单更新',
                    type: 1,
                    content: $('#dvupdate2'), //这里content是一个普通的String
                    btn: ['更新', '取消'],
                    yes:function(index, layero){
                        $.ajax({
                            url:"${pageContext.request.contextPath}/menu/updateOneLevelMenu",
                            type:"post",
                            dataType:"json",
                            data:$("#fm1_update2").serialize(),
                            success:function(result){
                                if(result==true){
                                    layer.msg("更新成功", {icon : 6});
                                }else{
                                    layer.msg("更新失败", {icon : 5});
                                }
                            }
                        });
                        layer.close(index);//关闭窗口
                    },
                    cancel: function() {

                    }
                });
            });

        });

    }

</script>

</body>

</html>

<!-- 新增菜单 界面 默认没打开  点击按钮代开 -->
<div style="display: none;margin-top: 10px;width: 480px" id="dvlay_addMenu">
    <form id="fm1_add" class="layui-form " method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">名称：</label>
            <div class="layui-input-inline">
                <input name="name" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图标：</label>
            <div class="layui-input-inline">
                <input name="icon" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">路径：</label>
            <div class="layui-input-inline">
                <input name="url" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">级别：</label>
            <div class="layui-input-inline">
                <input type="radio" name="pid" value="0" lay-filter="level" title="一级" checked>
                <input type="radio" name="pid" value="-1" lay-filter="level" title="二级">
            </div>
        </div>
        <input type="hidden" name="parentids" id="pid" value="0">
        <div class="layui-form-item" id="dvl1" style="display: none">
            <label class="layui-form-label">上级路径：</label>
            <div class="layui-input-inline">
                <select id="spid"  lay-filter="parent">

                </select>
            </div>
        </div>
    </form>
</div>








<div style="display: none;margin-top: 10px;width: 480px" id="dvupdate1">
    <form id="fm1_update1" class="layui-form ">
        <div class="layui-form-item">
            <label class="layui-form-label">名称：</label>
            <div class="layui-input-inline">
                <input name="name" class="layui-input" id="name_udpate1">
                <input name="id" type="hidden" id="id_udpate1">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图标：</label>
            <div class="layui-input-inline">
                <input name="icon" class="layui-input" id="icon_udpate1">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">路径：</label>
            <div class="layui-input-inline">
                <input name="url" class="layui-input" id="url_udpate1">
            </div>
        </div>
    </form>
</div>


<div style="display: none;margin-top: 10px;width: 480px" id="dvupdate2">
    <form id="fm1_update2" class="layui-form ">
        <div class="layui-form-item" id="dvl1">
            <label class="layui-form-label">上级路径：</label>
            <div class="layui-input-inline">
                <select name="parentid" id="spid_udapte2">

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">名称：</label>
            <div class="layui-input-inline">
                <input type="hidden" name="id" id="id_udpate2"/>
                <input name="name" class="layui-input" id="name_udpate2">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图标：</label>
            <div class="layui-input-inline">
                <input name="icon" class="layui-input" id="icon_udpate2">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">路径：</label>
            <div class="layui-input-inline">
                <input name="url" class="layui-input" id="url_udpate2">
            </div>
        </div>
    </form>
</div>