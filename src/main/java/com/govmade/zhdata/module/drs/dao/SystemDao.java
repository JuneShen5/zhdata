package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.Systems;

public interface SystemDao extends BaseDao<Systems> {

    public List<Systems> search(@Param("page") Page<Systems> page);

    public Long getSearchCount(@Param("page") Page<Systems> page);
    
    void saveAll(@Param("dataList") List<Map<String, String>> dataList);

    public List<Systems> queryListByPages(@Param("page")Page<Systems> page);

    //public Integer saveRelation(Systems sys);

    //public List<Systems> findList(Page<Systems> page);

    //public void deletBySysId(@Param("idList")List<String> idList);
    

}
