package com.govmade.zhdata.module.drs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.InfoSort;

public interface InfoSortDao extends BaseDao<InfoSort> {

   public void deleteByIds(@Param("idList")List<String> idList);

   public List<InfoSort> queryListByPid(@Param("id")Integer id, @Param("type")Integer type);


}
