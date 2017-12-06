package com.govmade.zhdata.module.sys.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.sys.pojo.User;

public interface UserDao extends BaseDao<User> {

    void saveAll(@Param("dataList") List<Map<String, String>> dataList);

}
