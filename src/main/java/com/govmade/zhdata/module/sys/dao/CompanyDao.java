package com.govmade.zhdata.module.sys.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.sys.pojo.Company;

public interface CompanyDao extends BaseDao<Company> {

    public List<Company> queryCompany(Company company);

    public List<Company> queryCompany(@Param("company")Company company, @Param("isAudit")Integer isAudit);

    public void saveAll(@Param("dataList") List<Map<String, String>> dataList);

    public void deleteByIds(@Param("idList")List<String> idList);

    public List<Company> queryAllList(@Param("company")Company company, @Param("idList")List<String> idList);

    public List<Company> queryListById(@Param("page")Page<Company> page, @Param("idList")List<String> idList);

    public Integer queryTotal(@Param("page")Page<Company> page, @Param("idList")List<String> idList);

    public Company queryByInfoId(Integer id);

    public List<Company> queryListByIds(@Param("page")Page<Company> page, @Param("company")Company company);


}
