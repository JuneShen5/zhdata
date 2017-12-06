package com.govmade.zhdata.module.drs.dao;



import java.util.List;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.InfoSearch;



public interface InfoSearchDao extends BaseDao<InfoSearch>{
    public List<InfoSearch> queryHotInfo();
    
    
    
    
    
}
