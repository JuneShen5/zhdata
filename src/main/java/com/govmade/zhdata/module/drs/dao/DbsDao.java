package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.Dbs;

public interface DbsDao extends BaseDao<Dbs> {

    void saveAll(@Param("dataList") List<Map<String, String>> dataList);

}
