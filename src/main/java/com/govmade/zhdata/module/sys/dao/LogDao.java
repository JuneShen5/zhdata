package com.govmade.zhdata.module.sys.dao;

import java.util.List;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.sys.pojo.Log;

public interface LogDao extends BaseDao<Log> {

    public void insert(Log log);

    public List<Log> findAllList(Log log);
}
