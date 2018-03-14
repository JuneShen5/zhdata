package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.Element;

public interface ElementDao extends BaseDao<Element>{

    public List<Element> findList(@Param("page") Page<Element> page,@Param("element") Element element);

    public List<Element> queryList(Integer id);
    
    public void saveAll(@Param("dataList") List<Map<String, String>> dataList);
    
    public List<Element> queryAll(@Param("page") Page<Element> page,@Param("element") Element element);

    @SuppressWarnings("rawtypes")
    public void updateEle(@Param("idList")List idList, @Param("toPool")Integer toPool);

    public void updateEleByPool(@Param("eleIds")List<Integer> eleIds);

    public List<Element> queryAnalyList(Element element);

    public List<Element> queryEleByInfoId(Integer id);

    public List<Element> queyListById(@Param("eleIdList")List<String> eleIdList);

    //public void deleteInfoEle(@Param("idList")List<String> idList);

    public List<Element> queryAlList(@Param("element")Element element);

    public List<Element> queryHotItem();

    public void deleteEle(@Param("idList")List<String> idList);

    public Integer delete(@Param("idList")List<String> idList);

}
