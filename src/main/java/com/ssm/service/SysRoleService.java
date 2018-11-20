package com.ssm.service;

import com.ssm.bean.SysRole;
import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author shiluyu
 * @since 2018-11-15
 */
public interface SysRoleService extends IService<SysRole> {
    public boolean addRole(SysRole r,Integer[] menus_ids,Integer[] permission_ids);

    public boolean updateRole(SysRole r, Integer[] menus_ids, Integer[] permission_ids);

}
