package com.govmade.zhdata.module.sys.dao;

import java.util.List;
import java.util.Map;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.sys.pojo.Dict;

public interface DictDao extends BaseDao<Dict> {

	public List<Map<String, String>> getOpenType();

	public List<Map<String, String>> getShareType();

	public List<Map<String, String>> getDataType();

	public List<Map<String, String>> getObjectType();

	public List<Map<String, String>> getSiteLevel();

	public Dict queryDictByValue(Integer value);
    
}
