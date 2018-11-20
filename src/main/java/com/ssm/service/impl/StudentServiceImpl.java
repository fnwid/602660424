package com.ssm.service.impl;

import com.ssm.bean.Student;
import com.ssm.mapper.StudentMapper;
import com.ssm.service.StudentService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author shiluyu
 * @since 2018-11-08
 */
@Service
public class StudentServiceImpl extends ServiceImpl<StudentMapper, Student> implements StudentService {

}
