package com.ssm.service.impl;

import com.ssm.bean.SysPermission;
import com.ssm.mapper.SysPermissionMapper;
import com.ssm.service.SysPermissionService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author bruceliu
 * @since 2018-11-07
 */
@Service
@Transactional
public class SysPermissionServiceImpl extends ServiceImpl<SysPermissionMapper, SysPermission> implements SysPermissionService {

	@Autowired
	SysPermissionMapper spm;
	public List<SysPermission> getMyMenus(int id) {
		return spm.getMyMenus(id);
	}

}
