package com.govmade.zhdata.module.drs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.Tables;

public interface TablesDao extends BaseDao<Tables> {

    public List<Tables> queryTbCols(Integer id);

    public void updateTabs(@Param("idList")List<String> idList);


}
