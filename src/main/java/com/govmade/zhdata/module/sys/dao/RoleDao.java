package com.govmade.zhdata.module.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.sys.pojo.Role;

public interface RoleDao extends BaseDao<Role> {

    public List<Role> findList(@Param("page")Page<Role> page,@Param("role")Role role);

    public void deletByRoleId(@Param("idList")List<String> idList);
    
    public List<Role> findAllList(Role role);

}
