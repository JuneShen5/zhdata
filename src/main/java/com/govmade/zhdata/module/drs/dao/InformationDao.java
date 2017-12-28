package com.govmade.zhdata.module.drs.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.govmade.zhdata.common.persistence.BaseDao;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;

public interface InformationDao extends BaseDao<Information> {

    public List<Information> findByCompanyId(@Param("info")Information info);

    public List<Information> search(@Param("page") Page<Information> page);

    public Information getInfoElementById(Integer id);

    public void saveTable(@Param("tableSQL")String tableSQL);

    public void delTab(@Param("dropSQL")String dropSQL);
    
    public List<Element> findElementById(Integer id);

    public Long getSearchCount(@Param("page") Page<Information> page);

    public List<Information> queryInfoList(@Param("info")Information info);

    public Long queryCount(@Param("info")Information info);

    public int findMAX(Information info);

    public int saveAll(@Param("dataList")List<Map<String, Object>> dataList);

    public int queryInfoByshareType(@Param("companyId")Integer companyId, @Param("shareType")String shareType);
   
    
    public Integer shareCount();
    public Integer openCount();

    public void deleteInfoEle(@Param("idList")List<String> idList);

    public List<Information> queryCompCount(Integer id);

    public List<Information> queryInfoByEleId(Integer id);

    public List<Information> queryElePoolById(@Param("elIds")List<String> elIds);

    public void relationSave(@Param("id") Integer id, @Param("elIds") List<String> elIds);

    public void updateAllAudit(@Param("comList") List<Integer> comList);

    public List<Information> queryByCompanyIds(@Param("comList") List<Integer> comList);

    public int delete(@Param("idList")List<String> idList);

    public Integer queryIsAuditCount(@Param("comList")List<Integer> comList);


}
