package com.ssm.service;

import com.ssm.bean.SysPermission;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author bruceliu
 * @since 2018-11-07
 */
public interface SysPermissionService extends IService<SysPermission> {
	public List<SysPermission> getMyMenus(int id);
}
