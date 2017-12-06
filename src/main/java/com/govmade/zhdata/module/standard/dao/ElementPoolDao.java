package com.govmade.zhdata.module.standard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.standard.pojo.ElementPool;
import com.govmade.zhdata.module.standard.pojo.ElementSame;

public interface ElementPoolDao extends BaseDao<ElementPool>{

    public List<ElementPool> queryRepeatList(@Param("elepool") ElementPool elepool);

    @SuppressWarnings("rawtypes")
    public int importEle(@Param("idList") List idList);

    public void queryEqualList();

    public Integer queryCount(@Param("list")List<ElementSame> list);

    public List<ElementSame> querySameList(@Param("list") List<ElementSame> childList);

    public List<Integer> queryEleIds(@Param("id")Integer id);

    public List<ElementPool>queryEleListById(@Param("eslList") List<ElementSame> eslList);

    public void updateToPub(@Param("idList")List<String> idList);


    

}
