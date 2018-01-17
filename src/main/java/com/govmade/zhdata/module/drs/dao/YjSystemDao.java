package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.YjSystems;

public interface YjSystemDao extends BaseDao<YjSystems> {

    public List<YjSystems> queryAllList (@Param("yjSystems") YjSystems yjSystems, @Param("page")Page<YjSystems> page);
    
    public int saveAll(@Param("dataList")List<Map<String, String>> dataList);
    
    public Double queryYwjSum(@Param("yjSystems")YjSystems yjSystems, @Param("comList")List<Integer> comList);

    public List<YjSystems> queryListByCompanyId(@Param("yjSystems")YjSystems yjSystems, @Param("page")Page<YjSystems> page);

    public Integer querySysCount(@Param("yjSystems")YjSystems yjSystems, @Param("comList")List<Integer> comList);

    public Double queryYgywSum(@Param("yjSystems")YjSystems yjSystems, @Param("comList")List<Integer> comList);

    public YjSystems querySum(@Param("yjSystems")YjSystems yjSystems,  @Param("comList")List<Integer> comList);

}
