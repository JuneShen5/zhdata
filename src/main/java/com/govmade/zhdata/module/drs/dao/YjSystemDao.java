package com.govmade.zhdata.module.drs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.YjSystems;

public interface YjSystemDao extends BaseDao<YjSystems>{

	public List<YjSystems> queryAllList (@Param("yjSystems") YjSystems yjSystems);
}
