package com.ssm.web;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.ssm.bean.SysUser;
import com.ssm.service.SysPermissionService;
import com.ssm.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.InetAddress;
import java.text.SimpleDateFormat;
import java.util.Date;


@Controller
@Scope("prototype")
@RequestMapping("/user")
public class SysUserController {
	@Autowired
	SysUserService sus;
	@Autowired
	SysPermissionService sps;
	@RequestMapping("/login")
	public void login(SysUser user,HttpServletRequest request,HttpServletResponse response,HttpSession session)throws Exception {
		response.setContentType("text/html;charset=utf-8");
	    String lasttime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()).toString();
	    String ip = InetAddress.getLocalHost().getHostAddress();
		SysUser u = sus.selectOne(new EntityWrapper<SysUser>(user));
//		List<SysPermission> myMenus = sps.getMyMenus(u.getId());
//		session.setAttribute("myMenus", myMenus);
		u.setIp(ip);
		u.setLasttime(lasttime);
		boolean bool = sus.update(u, new EntityWrapper<SysUser>()
				.eq("username", u.getUsername())
				.eq("password", u.getPassword()));
		if (u!=null && bool==true) {
			
			session.setAttribute("u", u);
			response.getWriter().write("<script>location.href='"+request.getContextPath()+"/index.jsp';</script>");
		}else{
			response.getWriter().write("<script>alert('账号或密码错误!');location.href='"+request.getContextPath()+"/login.jsp';</script>");
		}
		
	}
	@RequestMapping("/pic")
	public void pass(String mFile,Model model,HttpServletRequest request,HttpServletResponse response,SysUser sysUser,HttpSession session) throws Exception{
	    SysUser u = sus.selectOne(new EntityWrapper<SysUser>(sysUser));
	    u.setPic(mFile);
		boolean bool = sus.update(u,new EntityWrapper<SysUser>()
				.eq("id", u.getId()));
		if (bool==true) {
			session.setAttribute("u", u);
			response.getWriter().write("<script>location.href='"+request.getContextPath()+"/user.jsp';</script>");
			
		}else {
			response.getWriter().write("<script>alert('修改失败');location.href='"+request.getContextPath()+"/photo.jsp';</script>");
		}
	}
	@RequestMapping(value="/pw",method = RequestMethod.GET)
	public void pw(String pass,Model model,HttpServletRequest request,HttpServletResponse response,SysUser sysUser,HttpSession session) throws Exception{
		SysUser u = sus.selectOne(new EntityWrapper<SysUser>(sysUser));
		u.setPassword(pass);

        boolean bool = sus.update(u,new EntityWrapper<SysUser>()
                .eq("id", u.getId()));
        ;
		if (bool==true) {
			response.getWriter().write("<script>location.href='"+request.getContextPath()+"/user.jsp';</script>");
		}else {
			response.getWriter().write("<script>alert('修改失败');location.href='"+request.getContextPath()+"/password.jsp';</script>");
		}
	}
	@RequestMapping(value="exit")
	public String exit(HttpSession session){
		session.invalidate();
		return "redirect:/login.jsp";
	}
}

