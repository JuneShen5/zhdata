package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.ComputerRoom;

public interface ComputerRoomDao extends BaseDao<ComputerRoom> {

    List<ComputerRoom> search(@Param("params") Map<String, Object> params);
	

}
