package com.ssm.web;


import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssm.bean.Grade;
import com.ssm.bean.Student;
import com.ssm.service.GradeService;
import com.ssm.service.StudentService;
import com.ssm.utils.CreateFileUtils;
import com.ssm.utils.ExcelUtils;
import com.ssm.utils.PageHelper;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
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
 * @since 2018-11-08
 */
@Controller
@Scope("prototype")
@RequestMapping("/student")
public class StudentController {
	@Autowired
	StudentService ss;
	@Autowired
	GradeService gs;
	
	@RequestMapping("/list/{pageIndex}")
	public String list(@PathVariable(name="pageIndex") Integer pageIndex,Model model,@RequestParam(defaultValue="5") Integer pageSize){
		Page<Student> page = new Page<Student>(pageIndex,pageSize);
		Page<Student> list = ss.selectPage(page,new EntityWrapper<Student>().eq("del", 0));
		int totalcount = ((Long)list.getTotal()).intValue();
		List<Student> students = list.getRecords();
		for (Student student : students) {
			Grade grade = gs.selectById(student.getGid());
			student.setGrade(grade);
		}
		PageHelper<Student> pageHelper = new PageHelper<Student>(pageIndex, pageSize, totalcount, students, null);
		model.addAttribute("hasPrevious", list.hasPrevious());
		model.addAttribute("hasNext", list.hasNext());
		model.addAttribute("pageBean", pageHelper);
		return "/studentlist.jsp";
		
	}
	@RequestMapping("/delete/{id}")
	public void delete(@PathVariable(value="id") Integer id,Student student,HttpServletRequest request,HttpServletResponse response)throws Exception{
		response.setContentType("text/html;charset:utf-8");
		student.setId(id);
		student.setDel(1);
		boolean bool = ss.updateById(student);
		if (bool == true) {
			response.getWriter().write("<script>alert('删除成功');location.href='"+request.getContextPath()+"/student/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('删除失败');location.href='"+request.getContextPath()+"/student/list/1';</script>");
		}
	}
	@RequestMapping("/get/{id}")
	public String get(@PathVariable(value="id") Integer id,Model model){
		Student s = ss.selectById(id);
		model.addAttribute("s", s);
		return "/studentdetails.jsp";
	}
	@RequestMapping("/goupdate/{id}")
	public String goUpdate(@PathVariable(value="id") Integer id, Model model){
		Student s = ss.selectById(id);
		model.addAttribute("s",s);
		return "/studentupdate.jsp";
	}
	
	@RequestMapping(value="/update")
	public void update(Model model,HttpServletRequest request,HttpServletResponse response,Student student) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		boolean bool = ss.updateById(student);
		System.out.println(student);
		if (bool == true) {
			response.getWriter().write("<script>alert('修改成功');location.href='"+request.getContextPath()+"/student/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('修改失败');location.href='"+request.getContextPath()+"/studentupdate.jsp';</script>");
		}
	}
	@RequestMapping(value="/add")
	public void add(Model model,HttpServletRequest request,HttpServletResponse response,Student student) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		student.setFlag(1);
		student.setDel(0);
		boolean bool = ss.insert(student);
		if (bool == true) {
			response.getWriter().write("<script>alert('新增成功');location.href='"+request.getContextPath()+"/student/list/1';</script>");
		}else{
			response.getWriter().write("<script>alert('新增失败');location.href='"+request.getContextPath()+"/studentupdate.jsp';</script>");
		}
	}
	
	@RequestMapping(value="/query",method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<Student> query(@PathVariable(value="name") String name,@PathVariable(value="gid") Integer gid){
		System.err.println(111);
		List<Student> list = ss.selectList(new EntityWrapper<Student>()
				.eq("del", 0)
				.like("name", name)
				.orNew()
				.eq("gid", gid)
				);
		return list;
		
	}
	@RequestMapping(value="down")
	public void down(HttpServletRequest request,HttpServletResponse response,Student s)throws Exception{
		EntityWrapper<Student> wrapper = new EntityWrapper<Student>();
		if (s != null && s.getName() != null) {
			wrapper.like("name", s.getName());
		}
		if (s != null && s.getGid() != null&& s.getGid()!=-1) {
			wrapper.eq("gid", s.getGid());
		}
		wrapper.eq("del", 0);
		
		List<Student> students = ss.selectList(wrapper); // 要导出的数据
		for (Student stu : students) {
			System.out.println(stu);
		}
		// 生成Excel表格 作为流返回(下载)

		// 先创建工作簿对象
		HSSFWorkbook wb = new HSSFWorkbook();
		// 创建工作表对象并命名
		HSSFSheet sheet = wb.createSheet("学生信息表");
		
		int rowCount = 0; // 行数 默认第一行
		sheet.addMergedRegion( new CellRangeAddress(0, 0, 0, 10)  ); //合并单元格
		HSSFRow rowTitle = sheet.createRow(rowCount++);
		HSSFCell cellTile = rowTitle.createCell(0);
		
		HSSFCellStyle cellStyle = wb.createCellStyle(); 
		cellStyle.setFillForegroundColor((short) 13);// 设置背景色  
		cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);  
		cellStyle.setAlignment(HorizontalAlignment.CENTER); // 居中  
		cellTile.setCellStyle(cellStyle);
		
		cellTile.setCellValue("学生信息表");
		
		
		HSSFRow rowHead = sheet.createRow(rowCount++);  //标题行
		String[] titiles={"学号","姓名","性别","出生日期","身份证号","毕业学校","学历","邮箱","QQ","电话","入学日期"};
		for (int i = 0; i < titiles.length; i++) {
			rowHead.createCell(i).setCellValue(titiles[i]);
		}
		
		// 遍历集合对象创建行和单元格
		for (int i = 0; i < students.size(); i++) {
			
			Student student = students.get(i);// 取出Student对象
			// 创建行
			HSSFRow row = sheet.createRow(rowCount++);
			// 开始创建单元格并赋值
			HSSFCell noCell = row.createCell(0); // 创建第一个单元格
			noCell.setCellValue(student.getNo());

			HSSFCell nameCell = row.createCell(1);
			nameCell.setCellValue(student.getName());

			HSSFCell sexCell = row.createCell(2);
			sexCell.setCellValue(student.getSex());

			HSSFCell birthday = row.createCell(3);
			birthday.setCellValue(student.getBirthday());

			HSSFCell cardnoCell = row.createCell(4);
			cardnoCell.setCellValue(student.getCardno());

			HSSFCell schoolCell = row.createCell(5);
			schoolCell.setCellValue(student.getSchool());

			HSSFCell educationCell = row.createCell(6);
			educationCell.setCellValue(student.getEducation());

			HSSFCell emailCell = row.createCell(7);
			emailCell.setCellValue(student.getEmail());

			HSSFCell qqCell = row.createCell(8);
			qqCell.setCellValue(student.getQq());

			HSSFCell phoneCell = row.createCell(9);
			phoneCell.setCellValue(student.getPhone());

			HSSFCell dateCell = row.createCell(10);
			dateCell.setCellValue(student.getCreatedate());
		}

		String fileName="学生信息表"+System.currentTimeMillis()+".xls";//文件名
	
		//生成Excel并提供下载
		String userAgent=request.getHeader("User-Agent");
		if(userAgent.contains("Safari")){
			response.addHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(fileName, "UTF-8")) ;
		}else{
			response.addHeader("Content-Disposition", "attachment;filename="+new String(fileName.getBytes("utf-8"),"ISO-8859-1")) ;
		}
		ServletOutputStream out = response.getOutputStream(); //输出流
		wb.write(out);
		
		
		out.close();//关闭流
		
	}
	//导入Excel
	@RequestMapping("/importStudent")
	public void importStudent(Integer gid, @RequestParam("mFile") MultipartFile file,HttpServletRequest request,HttpServletResponse response) throws Exception{
		String excelPath = "";
		File createDir =CreateFileUtils.createDirExcel(request.getSession().getServletContext());
		if (!file.isEmpty()) {
			String filename = file.getOriginalFilename();
			String createName = CreateFileUtils.createName(filename);
			File f = new File(createDir,createName);
			excelPath = "media/excel/" + new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime()) + "/" + createName;
			file.transferTo(f);
		}
		String realPath = request.getSession().getServletContext().getRealPath(excelPath);//获取服务器路径
		List<Student> students = ExcelUtils.readFromExcel(realPath);
		for (Student s : students) {
			s.setGid(gid);
			s.setDel(0);
			System.out.println(s);
		}

		boolean b = ss.insertBatch(students);
		if (b) {
			response.getWriter().write("<script>alert('导入成功');location.href='" + request.getContextPath() + "/student/list/1'</script>");
		} else {
			response.getWriter().write("<script>alert('导入失败');location.href='" + request.getContextPath() + "/student/list/1'</script>");
		}
	}
	
}

