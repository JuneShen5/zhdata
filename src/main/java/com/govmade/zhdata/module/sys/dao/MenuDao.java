package com.govmade.zhdata.module.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.sys.pojo.Menu;

public interface MenuDao extends BaseDao<Menu> {

    public List<Menu> selectByUserId(int userId);
    
    public List<Menu> findAll(Menu menu);

    public void deletByMenuId(@Param("idList")List<String> idList);

    public Integer deleteByIds(@Param("idList")List<String> idList);
 
    public String queryLogByUri(String href);

    public void saveRoleMenuRation(@Param("roleId")Integer roleId, @Param("menuId")Integer menuId);

    public void deleteRationByMenuId(Integer id);

}
