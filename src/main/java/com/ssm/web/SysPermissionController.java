package com.ssm.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssm.bean.SysPermission;
import com.ssm.service.SysPermissionService;
import com.ssm.utils.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author bruceliu
 * @since 2018-11-07
 */
@Controller
@Scope("prototype")
@RequestMapping("/sysPermission")
public class SysPermissionController {
    @Autowired
    SysPermissionService sps;
    @RequestMapping("/list/{pageIndex}")
    public String list(@PathVariable(name="pageIndex") Integer pageIndex, Model model, @RequestParam(defaultValue="5") Integer pageSize){
        Page<SysPermission> page = new Page<SysPermission>(pageIndex,pageSize);//封装条件
        Page<SysPermission> list = sps.selectPage(page,new EntityWrapper<SysPermission>().eq("available", 1));//数据
        int totalCount = ((Long)list.getTotal()).intValue();//获得总数
        List<SysPermission> grades = list.getRecords();//获取的每页数据
        PageHelper<SysPermission> pageHelper = new PageHelper<SysPermission>(pageIndex, pageSize, totalCount, grades, null);
        model.addAttribute("hasPrevious", list.hasPrevious());
        model.addAttribute("hasNext", list.hasNext());
        model.addAttribute("pageHelper", pageHelper);
        return "/menus.jsp";

    }

    @RequestMapping(value="/delete/{id}")
    public void delete(@PathVariable(name="id") Integer id, HttpServletRequest request, HttpServletResponse response, SysPermission sysPermission) throws Exception{
        response.setContentType("text/html;charset=utf-8");
        sysPermission.setId(id);
        sysPermission.setAvailable("1");
        boolean bool = sps.updateById(sysPermission);
        if (bool == true) {
            response.getWriter().write("<script>alert('删除成功');location.href='"+request.getContextPath()+"/sysPermission/list/1';</script>");
        }else{
            response.getWriter().write("<script>alert('删除失败');location.href='"+request.getContextPath()+"/sysPermission/list/1';</script>");
        }


    }
    @RequestMapping("/getOneLevelMenu")
    @ResponseBody
    public  List<SysPermission> list(){
        return sps.selectList(new EntityWrapper<SysPermission>()
        .eq("Available","1")
        .eq("Available","0"));
    }
    @RequestMapping("/add")
    @ResponseBody
    public  boolean add(SysPermission sysPermission){
        sysPermission.setAvailable("1");
        sysPermission.setType("menu");
        System.out.println(11);
        return sps.insert(sysPermission);
    }

    @ResponseBody
    @RequestMapping("/updateOneLevelMenu")
    public boolean update(SysPermission sysPermission){
        return  sps.updateById(sysPermission);
    }

    @RequestMapping("/getById/{id}")
    public SysPermission getById(@PathVariable("id") Integer id){
        return sps.selectById(id);
    }

    //回显二级菜单
    @ResponseBody
    @RequestMapping("/getById1/{id}")
    public Map<String,Object> getById1(@PathVariable(name="id") Integer id){
        SysPermission sysPermission = sps.selectById ( id );
        List<SysPermission> list = sps.selectList ( new EntityWrapper<SysPermission> ()
                .eq ( "available", 1 )
                .eq ( "parentid", 0 ) );
        HashMap<String, Object> hashMap = new HashMap<String, Object> ();
        hashMap.put ( "sysPermission" , sysPermission);
        hashMap.put ( "list" ,list);
        return hashMap;
    }

}

