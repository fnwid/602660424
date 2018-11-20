package com.ssm.web;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssm.bean.Course;
import com.ssm.bean.Grade;
import com.ssm.service.CourseService;
import com.ssm.service.GradeService;
import com.ssm.utils.PageHelper;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


@Controller
@Scope("prototype")
@RequestMapping(value="/grade")
public class GradeController {
	
	@Autowired
	GradeService gs;
	@Autowired
	CourseService cs;
	
	@RequestMapping("/list/{pageIndex}")
	public String list(@PathVariable(name="pageIndex") Integer pageIndex,Model model,@RequestParam(defaultValue="5") Integer pageSize){
		Page<Grade> page = new Page<Grade>(pageIndex,pageSize);//封装条件
		Page<Grade> list = gs.selectPage(page,new EntityWrapper<Grade>().eq("del", 0));//数据
		int totalCount = ((Long)list.getTotal()).intValue();//获得总数
		List<Grade> grades = list.getRecords();//获取的每页数据
		for (Grade grade : grades) {
			Course course = cs.selectById(grade.getCid());
			grade.setCourse(course);
		}
		PageHelper<Grade> pageHelper = new PageHelper<Grade>(pageIndex, pageSize, totalCount, grades, null);
		model.addAttribute("hasPrevious", list.hasPrevious());
		model.addAttribute("hasNext", list.hasNext());
		model.addAttribute("pageBean", pageHelper);
		return "/gradelist.jsp";
		
	}
	
	@RequestMapping(value="/delete/{id}")
	public boolean delete(@PathVariable(name="id") Integer id,HttpServletRequest request,HttpServletResponse response,Grade grade) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		Grade grade2 = new Grade();
		grade2.setId(id);
		grade2.setDel(1);
		boolean bool = gs.updateById(grade2);
		if (bool == true) {
			response.getWriter().write("<script>alert('删除成功');location.href='"+request.getContextPath()+"/grade/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('删除失败');location.href='"+request.getContextPath()+"/grade/list/1';</script>");
		}
		return bool;
		
	}
	
	@RequestMapping("/add")
	public void add(Model model,HttpServletRequest request,HttpServletResponse response,Grade grade) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		grade.setCount(45);
		grade.setDel(0);
		grade.setFlag(1);
		boolean bool = gs.insert(grade);
		if (bool == true) {
			response.getWriter().write("<script>alert('新增成功');location.href='"+request.getContextPath()+"/grade/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('新增失败');location.href='"+request.getContextPath()+"gradeadd.jsp';</script>");
		}
		
	}
	@RequestMapping(value="/update")
	public void update(Model model,HttpServletRequest request,HttpServletResponse response,Grade grade) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		boolean bool = gs.updateById(grade);
		if (bool == true) {
			response.getWriter().write("<script>alert('修改成功');location.href='"+request.getContextPath()+"/grade/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('修改失败');location.href='"+request.getContextPath()+"gradeupdate.jsp';</script>");
		}
	}
	@RequestMapping(value="/pageToUpdate/{id}")
	public String pagrtoupdate(@PathVariable(name="id") Integer id,Model model){
		Grade grade = gs.selectById(id);
		model.addAttribute("grade", grade);
		return "/gradeupdate.jsp";
	}
	@RequestMapping("/get")
	@ResponseBody
	public List<Grade> list(Grade grade){
		List<Grade> list = gs.selectList(null);
		return list;
	}

}

