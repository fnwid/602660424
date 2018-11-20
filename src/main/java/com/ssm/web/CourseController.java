package com.ssm.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssm.bean.Course;
import com.ssm.service.CourseService;
import com.ssm.service.GradeService;
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
import java.util.List;


@Controller
@Scope("prototype")
@RequestMapping("/course")
public class CourseController {
	
	@Autowired
	GradeService gs;
	@Autowired
	CourseService cs;
	@RequestMapping("/get")
	@ResponseBody
	public List<Course> get(Course course){
		List<Course> list = cs.selectList(null);
		return list;
		
	}
	@RequestMapping("/list/{pageIndex}")
	public String list(@PathVariable(name="pageIndex") Integer pageIndex,Model model,@RequestParam(defaultValue="5") Integer pageSize){
		Page<Course> page = new Page<Course>(pageIndex,pageSize);//封装条件
		Page<Course> list = cs.selectPage(page,new EntityWrapper<Course>().eq("del", 0));//数据
		int totalCount = ((Long)list.getTotal()).intValue();//获得总数
		List<Course> grades = list.getRecords();//获取的每页数据
		PageHelper<Course> pageHelper = new PageHelper<Course>(pageIndex, pageSize, totalCount, grades, null);
		model.addAttribute("hasPrevious", list.hasPrevious());
		model.addAttribute("hasNext", list.hasNext());
		model.addAttribute("page", pageHelper);
		return "/courselist.jsp";
		
	}
	
	@RequestMapping(value="/delete/{id}")
	public void delete(@PathVariable(name="id") Integer id,HttpServletRequest request,HttpServletResponse response,Course course) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		Course course2 = new Course();
		course2.setId(id);
		course2.setDel(1);
		boolean bool = cs.updateById(course2);
		if (bool == true) {
			response.getWriter().write("<script>alert('删除成功');location.href='"+request.getContextPath()+"/course/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('删除失败');location.href='"+request.getContextPath()+"/course/list/1';</script>");
		}
		
		
	}
	
	@RequestMapping("/add")
	public void add(Model model,HttpServletRequest request,HttpServletResponse response,Course course) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		course.setCount(45);
		course.setDel(0);
		course.setFlag(1);
		boolean bool = cs.insert(course);
        if (bool == true) {
			response.getWriter().write("<script>alert('新增成功');location.href='"+request.getContextPath()+"/course/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('新增失败');location.href='"+request.getContextPath()+"courseadd.jsp';</script>");
		}
		
	}
	@RequestMapping(value="/update")
	public void update(HttpServletRequest request,HttpServletResponse response,Course course) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		boolean bool = cs.updateById(course);
		if (bool == true) {
			response.getWriter().write("<script>alert('修改成功');location.href='"+request.getContextPath()+"/course/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('修改失败');location.href='"+request.getContextPath()+"/courseupdate.jsp';</script>");
		}
	}
	@RequestMapping(value="/pageToUpdate/{id}")
	public String pagrtoupdate(@PathVariable(name="id") Integer id,Model model){
		Course course = cs.selectById(id);
		model.addAttribute("course", course);
		return "/courseupdate.jsp";
	}
	

}

