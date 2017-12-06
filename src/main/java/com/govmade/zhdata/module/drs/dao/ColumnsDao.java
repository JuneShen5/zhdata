package com.govmade.zhdata.module.drs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.Columns;

public interface ColumnsDao extends BaseDao<Columns> {

   public void columsToElement(@Param("columns") Columns columns);

   public List<Columns> queryCheckList(Integer infoId);

   public void updateCol(@Param("idList")List<String> idList);


}
