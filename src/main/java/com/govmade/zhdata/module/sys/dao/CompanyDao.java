package com.govmade.zhdata.module.sys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.module.sys.pojo.Company;

public interface CompanyDao extends BaseDao<Company> {

    List<Company> queryCompany(Company company);

    List<Company> queryCompany(@Param("company")Company company, @Param("isAudit")Integer isAudit);

    void saveAll(@Param("dataList") List<Map<String, String>> dataList);

}
