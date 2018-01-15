package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;

public interface ZjSystemDao extends BaseDao<ZjSystems>{

    public List<ZjSystems> queryAllList (@Param("zjSystems") ZjSystems zjSystems, @Param("page")Page<ZjSystems> page);
    
    public int saveAll(@Param("dataList")List<Map<String, String>> dataList);
    
    public List<ZjSystems> queryListByCompanyId(@Param("zjSystems")ZjSystems zjSystems, @Param("page")Page<ZjSystems> page);
}
