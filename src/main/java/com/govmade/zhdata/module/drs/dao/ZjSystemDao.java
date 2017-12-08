package com.govmade.zhdata.module.drs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;

public interface ZjSystemDao extends BaseDao<ZjSystems>{

	public List<ZjSystems> queryAllList (@Param("zjSystems") ZjSystems zjSystems);
}
