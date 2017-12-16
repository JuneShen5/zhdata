package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.NjSystems;

public interface NjSystemDao extends BaseDao<NjSystems>{

    public List<NjSystems> queryAllList (@Param("njSystems") NjSystems njSystems);
    
    public int saveAll(@Param("dataList")List<Map<String, String>> dataList);
}
