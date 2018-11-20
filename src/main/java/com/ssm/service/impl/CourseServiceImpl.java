package com.ssm.service.impl;

import com.ssm.bean.Course;
import com.ssm.mapper.CourseMapper;
import com.ssm.service.CourseService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author bruceliu
 * @since 2018-11-07
 */
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course> implements CourseService {

}
