package com.govmade.zhdata.module.drs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.Require;

public interface RequireDao extends BaseDao<Require>{

   public List<Require> queryAllList(@Param("require")Require require);

}
