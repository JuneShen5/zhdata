package com.govmade.zhdata.module.drs.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.drs.pojo.Item;

public interface ItemDao extends BaseDao<Item>{

    public List<Item> queryAlList(@Param("item")Item item);

}
