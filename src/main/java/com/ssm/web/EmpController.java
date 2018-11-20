package com.ssm.web;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssm.bean.Course;
import com.ssm.bean.Depart;
import com.ssm.bean.Emp;
import com.ssm.service.DepartService;
import com.ssm.service.EmpService;
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
@RequestMapping("/emp")

public class EmpController {
	
	@Autowired
	EmpService es;
	@Autowired
	DepartService ds;
	
	@RequestMapping("/list/{pageIndex}")
	public  String list(@PathVariable(name="pageIndex") Integer pageIndex,Model model,@RequestParam(defaultValue="5") Integer pageSize){
		Page<Emp> page = new Page<Emp>(pageIndex,pageSize);//封装条件
		Page<Emp> list = es.selectPage(page,new EntityWrapper<Emp>().eq("del", 0));//数据
		int totalCount = ((Long)list.getTotal()).intValue();//获得总数
		List<Emp> emps = list.getRecords();
		for (Emp emp : emps) {
			Depart depart = ds.selectById(emp.getDid());
			emp.setDepart(depart);
		}
		PageHelper<Emp> pageHelper = new PageHelper<Emp>(pageIndex, pageSize, totalCount, emps, null);
		model.addAttribute("hasPrevious", list.hasPrevious());
		model.addAttribute("hasNext", list.hasNext());
		model.addAttribute("p", pageHelper);
		return "/emplist.jsp";
		
	}
	
	@RequestMapping(value="/delete/{id}")
	public void delete(@PathVariable(name="id") String id,HttpServletRequest request,HttpServletResponse response,Emp emp) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		emp.setNo(id);
		emp.setDel(1);
		boolean bool = es.updateById(emp);
		if (bool == true) {
			response.getWriter().write("<script>alert('删除成功');location.href='"+request.getContextPath()+"/emp/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('删除失败');location.href='"+request.getContextPath()+"/emp/list/1';</script>");
		}
		
		
	}
	
	@RequestMapping("/add")
	public void add(String photo,Model model,HttpServletRequest request,HttpServletResponse response,Emp emp) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		System.out.println(photo);
		emp.setDel(0);
		emp.setFlag(1);
		emp.setPhoto("mFile");
		boolean bool = es.insert(emp);
		if (bool == true) {
			response.getWriter().write("<script>alert('新增成功');location.href='"+request.getContextPath()+"/emp/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('新增失败');location.href='"+request.getContextPath()+"/empadd.jsp';</script>");
		}
		
	}
	@RequestMapping("/update")
	public void update(HttpServletRequest request,HttpServletResponse response,Emp emp) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		boolean bool = es.updateById(emp);
		System.err.println(emp);
		if (bool == true) {
			response.getWriter().write("<script>alert('修改成功');location.href='"+request.getContextPath()+"/emp/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('修改失败');location.href='"+request.getContextPath()+"/empupdate.jsp';</script>");
		}
	}
	@RequestMapping(value="/pageToUpdate/{id}")
	public String pagrtoupdate(@PathVariable(name="id") String id,Model model){
		Emp emp = es.selectById(id);
		model.addAttribute("emp", emp);
		System.out.println(emp);
		return "/empupdate.jsp";
	}
	@RequestMapping(value="/query")
	public String query(){
		return null;
		
	}
	

}

