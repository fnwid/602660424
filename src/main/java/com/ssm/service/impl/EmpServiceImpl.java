package com.ssm.service.impl;

import com.ssm.bean.Emp;
import com.ssm.mapper.EmpMapper;
import com.ssm.service.EmpService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author shiluyu
 * @since 2018-11-09
 */
@Service
public class EmpServiceImpl extends ServiceImpl<EmpMapper, Emp> implements EmpService {

}
