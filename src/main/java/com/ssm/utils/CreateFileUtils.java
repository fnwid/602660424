package com.ssm.utils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletContext;

public class CreateFileUtils {

	// 创建目录---以日期，一天一个文件夹
	public static File createDir(ServletContext context) {
		String realPath = context.getRealPath("/media/photo");
		String date = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		File file = new File(realPath, date);
		if (!file.exists()) {
			file.mkdir();
		}
		return file;
	}

	// 创建目录---以日期，一天一个文件夹
	public static File createDirExcel(ServletContext context) {
		String realPath = context.getRealPath("/media/excel");
		String date = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
		File file = new File(realPath, date);
		if (!file.exists()) {
			file.mkdir();
		}
		return file;
	}

	// 创建文件名--区分同名文件,在文件名前加上当前的时间
	public static String createName(String name) {
		return new SimpleDateFormat("yyyyMMddHHmmssSSS").format(Calendar.getInstance().getTime()) + "_" + name;
	}

}
