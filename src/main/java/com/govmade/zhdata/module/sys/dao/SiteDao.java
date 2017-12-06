package com.govmade.zhdata.module.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.sys.pojo.Site;

public interface SiteDao extends BaseDao<Site> {

	List<Site> queryAllList(@Param("site") Site site);
	
	

}
