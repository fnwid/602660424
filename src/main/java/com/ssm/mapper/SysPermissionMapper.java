package com.ssm.mapper;

import java.util.List;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.ssm.bean.SysPermission;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author bruceliu
 * @since 2018-11-07
 */
public interface SysPermissionMapper extends BaseMapper<SysPermission> {

	public List<SysPermission> getMyMenus(int id);
}
