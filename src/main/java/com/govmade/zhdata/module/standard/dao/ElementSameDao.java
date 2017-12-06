package com.govmade.zhdata.module.standard.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.standard.pojo.ElementSame;

public interface ElementSameDao extends BaseDao<ElementSame>{

    public  List<ElementSame> queryAllList(ElementSame elementSame);

    public List<ElementSame> queryListById(@Param("id")Integer id);




	
}
