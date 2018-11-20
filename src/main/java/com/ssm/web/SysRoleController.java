package com.ssm.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssm.bean.SysPermission;
import com.ssm.bean.SysRole;
import com.ssm.bean.SysRolePermission;
import com.ssm.service.SysPermissionService;
import com.ssm.service.SysRolePermissionService;
import com.ssm.service.SysRoleService;
import com.ssm.utils.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/SysRole")
@Scope("prototype")
public class SysRoleController {
    @Autowired
    SysRoleService srs;
    @Autowired
    SysPermissionService sps;
    @Autowired
    SysRolePermissionService srps;

    @RequestMapping("/list/{pageIndex}")
    public String list(@PathVariable(name="pageIndex") Integer pageIndex, Model model, @RequestParam(defaultValue="5") Integer pageSize){
        Page<SysRole> page = new Page<SysRole>(pageIndex,pageSize);//封装条件
        Page<SysRole> list = srs.selectPage(page,new EntityWrapper<SysRole>().eq("available", 1));//数据
        System.out.println(list);
        int totalCount = ((Long)list.getTotal()).intValue();//获得总数
        List<SysRole> grades = list.getRecords();//获取的每页数据
        PageHelper<SysRole> pageHelper = new PageHelper<SysRole>(pageIndex, pageSize, totalCount, grades, null);
        System.out.println("人数是"+totalCount);
        model.addAttribute("hasPrevious", list.hasPrevious());
        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("page", pageHelper);
        return "/rolelist.jsp";

    }
    @RequestMapping(value="/delete/{id}")
    public void delete(@PathVariable(name="id") Integer id, HttpServletRequest request, HttpServletResponse response, SysRole sysRole) throws Exception {
        response.setContentType ( "text/html;charset=utf-8" );
        sysRole.setId ( id );
        sysRole.setAvailable ( "1" );
        boolean bool = srs.updateById ( sysRole );
        if (bool == true) {
            response.getWriter ().write ( "<script>alert('删除成功');location.href='" + request.getContextPath () + "/SysRole/list/1';</script>" );
        } else {
            response.getWriter ().write ( "<script>alert('删除失败');location.href='" + request.getContextPath () + "/SysRole/list/1';</script>" );
        }
    }
    @ResponseBody
    @RequestMapping("/toadd")
    public Map<String,Object> getMenus(){
        System.out.println("进入add");
            List<SysPermission> menus = sps.selectList ( new EntityWrapper<SysPermission> ()
                    .eq ( "type", "menu" )
                    .eq ( "available", 1 ) );
            List<SysPermission> permissions = sps.selectList ( new EntityWrapper<SysPermission> ()
                    .eq ( "type", "permission" )
                    .eq ( "available", 1 ) );
            HashMap<String, Object> map = new HashMap<String, Object> ();
            map.put ( "permissions",permissions );
            map.put ( "menus",menus );
            return map;
        }
    @ResponseBody
    @RequestMapping("/add")
    public boolean add(SysRole role,Integer[] menus_ids, Integer[] permission_ids){
        role.setAvailable ("1");
        return srs.addRole ( role,menus_ids,permission_ids );
    }
    @ResponseBody
    @RequestMapping("/goUpdate/{id}")
    public Map<String,Object> toUpdate(@PathVariable(name = "id") Integer id){
        System.out.println(id);
        SysRole role = srs.selectById ( id );
        List<SysPermission> menus = sps.selectList ( new EntityWrapper<SysPermission> ()
                .eq ( "type", "menu" )
                .eq ( "available", 1 ) );
        for (SysPermission menu : menus) {
            Integer permissionId = menu.getId ();
            int count = srps.selectCount ( new EntityWrapper<SysRolePermission> ()
                    .eq ( "sys_role_id", "id" )
                    .eq ( "sys_permission_id", permissionId ) );
            if (count>0){
                menu.setFlag ( true );
            }
        }
        List<SysPermission> permissions = sps.selectList ( new EntityWrapper<SysPermission> ()
                .eq ( "type", "permission" )
                .eq ( "available", 1 ) );
        for (SysPermission permission : permissions) {
            Integer permissionId = permission.getId ();
            int count = srps.selectCount ( new EntityWrapper<SysRolePermission> ()
                    .eq ( "sys_role_id", id )
                    .eq ( "sys_permission_id", permissionId ) );
            if (count>0){
                permission.setFlag ( true );
            }
        }
        HashMap<String, Object> map = new HashMap<String, Object> ();
        map.put ( "role",role );
        map.put ( "menus",menus );
        map.put ( "permissions",permissions );
    return  map;
    }
    @ResponseBody
    @RequestMapping("/update")
    public boolean update(SysRole role,Integer[] menus_ids,Integer[] permission_ids){
        role.setAvailable ( "1" );
        return srs.updateRole ( role,menus_ids,permission_ids );
    }
}

