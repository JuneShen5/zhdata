package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseEntity;
import com.govmade.zhdata.common.persistence.Page;

public interface DataDao {

    List<Map<String, Object>> queryList(@Param("page") Page<?> page);

    void saveAll(@Param("tableName") String tableName, @Param("dataList") List<Map<String, String>> dataList);
    
    Long saveData(@Param("record")BaseEntity record);
    
    Long updateData(@Param("record")BaseEntity record);

    Long deleteData(@Param("record")BaseEntity record);

    Long queryCount(@Param("page") Page<?> page);

}
