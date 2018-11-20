package com.ssm.web;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssm.bean.Course;
import com.ssm.bean.Depart;
import com.ssm.service.CourseService;
import com.ssm.service.DepartService;
import com.ssm.utils.PageHelper;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author shiluyu
 * @since 2018-11-09
 */
@Controller
@Scope("prototype")
@RequestMapping("/depart")
public class DepartController {

	@Autowired
	DepartService ds;
	@Autowired
	CourseService cs;
	@RequestMapping("/list/{pageIndex}")
	public String list(@PathVariable(name="pageIndex") Integer pageIndex,Model model,@RequestParam(defaultValue="5") Integer pageSize){
		Page<Depart> page = new Page<Depart>(pageIndex,pageSize);//封装条件
		Page<Depart> list = ds.selectPage(page,new EntityWrapper<Depart>().eq("del", 0));//数据
		int totalCount = ((Long)list.getTotal()).intValue();//获得总数
		List<Depart> grades = list.getRecords();//获取的每页数据
		PageHelper<Depart> pageHelper = new PageHelper<Depart>(pageIndex, pageSize, totalCount, grades, null);
		model.addAttribute("hasPrevious", list.hasPrevious());
		model.addAttribute("hasNext", list.hasNext());
		model.addAttribute("p1", pageHelper);
		return "/departlist.jsp";
		
	}
	
	@RequestMapping(value="/delete/{id}")
	public void delete(@PathVariable(name="id") Integer id,HttpServletRequest request,HttpServletResponse response,Depart depart) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		depart.setId(id);
		depart.setDel(1);
		boolean bool = ds.updateById(depart);
		if (bool == true) {
			response.getWriter().write("<script>alert('删除成功');location.href='"+request.getContextPath()+"/depart/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('删除失败');location.href='"+request.getContextPath()+"/depart/list/1';</script>");
		}
		
		
	}
	
	@RequestMapping("/add")
	public void add(Model model,HttpServletRequest request,HttpServletResponse response,Depart depart) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		depart.setDel(0);
		depart.setFlag(1);
		boolean bool = ds.insert(depart);
		if (bool == true) {
			response.getWriter().write("<script>alert('新增成功');location.href='"+request.getContextPath()+"/depart/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('新增失败');location.href='"+request.getContextPath()+"departadd.jsp';</script>");
		}
		
	}
	@RequestMapping(value="/update")
	public void update(Model model,HttpServletRequest request,HttpServletResponse response,Depart depart) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		boolean bool = ds.updateById(depart);
		if (bool == true) {
			response.getWriter().write("<script>alert('修改成功');location.href='"+request.getContextPath()+"/depart/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('修改失败');location.href='"+request.getContextPath()+"departupdate.jsp';</script>");
		}
	}
	@RequestMapping(value="/pageToUpdate/{id}")
	public String pagrtoupdate(@PathVariable(name="id") Integer id,Model model){
		Depart depart = ds.selectById(id);
		model.addAttribute("depart", depart);
		return "/departupdate.jsp";
	}
	@RequestMapping("/get")
	@ResponseBody
	public List<Depart> get(Depart depart){
		List<Depart> list = ds.selectList(null);
		return list;
		
	}
}

