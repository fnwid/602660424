package com.ssm.bean;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author bruceliu
 * @since 2018-11-07
 */
@TableName("sys_role_permission")
public class SysRolePermission implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 角色id
     */
    private Integer sysRoleId;
    /**
     * 权限id
     */
    private Integer sysPermissionId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSysRoleId() {
        return sysRoleId;
    }

    public void setSysRoleId(Integer sysRoleId) {
        this.sysRoleId = sysRoleId;
    }

    public Integer getSysPermissionId() {
        return sysPermissionId;
    }

    public void setSysPermissionId(Integer sysPermissionId) {
        this.sysPermissionId = sysPermissionId;
    }

    @Override
    public String toString() {
        return "SysRolePermission{" +
        ", id=" + id +
        ", sysRoleId=" + sysRoleId +
        ", sysPermissionId=" + sysPermissionId +
        "}";
    }
}
