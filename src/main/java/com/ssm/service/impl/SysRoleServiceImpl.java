package com.ssm.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.ssm.bean.SysRole;
import com.ssm.bean.SysRolePermission;
import com.ssm.mapper.SysRoleMapper;
import com.ssm.mapper.SysRolePermissionMapper;
import com.ssm.service.SysRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author shiluyu
 * @since 2018-11-15
 */
@Service
@Transactional(propagation=Propagation.REQUIRED)
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {
    @Autowired
    SysRoleMapper srm;
    @Autowired
    SysRolePermissionMapper srpm;

    public boolean addRole(SysRole role,Integer[] menus_ids, Integer[] permission_ids){
        Integer count = srm.insert ( role );
        if (count >0){
            for (int i = 0;i<permission_ids.length;i++){
                SysRolePermission permission = new SysRolePermission ();
                permission.setId ( role.getId () );
                permission.setSysPermissionId ( permission_ids[i] );
                srpm.insert ( permission );
            }
            for (int i = 0; i < menus_ids.length; i++) {
                SysRolePermission permission = new SysRolePermission ();
                permission.setId ( role.getId () );
                permission.setSysPermissionId ( menus_ids[i] );
                srpm.insert ( permission );
            }
            return true;
        }
            return  false;
    }

    public boolean updateRole(SysRole role, Integer[] menus_ids, Integer[] permission_ids) {
        Integer count = srm.updateById ( role );
        if (count>0){
            srpm.delete ( new EntityWrapper<SysRolePermission> (  ).eq ( "sys_role_id",role.getId () ) );
            for (int i = 0; i < permission_ids.length; i++) {
                SysRolePermission permission = new SysRolePermission ();
                permission.setId ( role.getId () );
                permission.setSysPermissionId ( permission_ids[i] );
                srpm.insert ( permission );
            }
            for (int i = 0; i < menus_ids.length; i++) {
                SysRolePermission permission = new SysRolePermission ();
                permission.setId ( role.getId () );
                permission.setSysPermissionId ( menus_ids[i] );
                srpm.insert ( permission );
            }
            return true;
        }
        return false;
    }

}
