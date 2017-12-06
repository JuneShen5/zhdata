package com.govmade.zhdata.module.drs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.govmade.zhdata.common.persistence.BaseEntity;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.DataDao;

@Service
public class DataService {

    @Autowired
    private DataDao dataDao;

    public void saveAll(String tableName,List<Map<String,String>> dataList) {
        dataDao.saveAll(tableName, dataList);
    }

    public Long saveData(BaseEntity record) {
        return dataDao.saveData(record);
    }
    
    public Long updateData(BaseEntity record) {
        return dataDao.updateData(record);
    }

    public Long deleteData(BaseEntity record) {
        return dataDao.deleteData(record);
        
    }

    public List<Map<String, Object>> queryList(Page<?> page) {
    	page=queryPage(page);
        page.startPage();
        return dataDao.queryList(page);
    }

    public Page<?> queryPage(Page<?> page) {
        try {
            String queryParams = new String(page.getQueryParams().getBytes("ISO-8859-1"), "UTF-8");
            if (!StringUtil.isBlank(queryParams)) {
                page.setParams(JsonUtil.json2Map(queryParams));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        Map<String, Object> params = page.getParams();
        if (params.get("date") != null) {
            String dateNameEn = params.get("date").toString();
            String startDate = params.get("startDate").toString();
            String endDate = params.get("endDate").toString();
            if (!StringUtil.isEmpty(startDate) && !StringUtil.isEmpty(endDate)) {
                page.setStartDate(startDate);
                page.setEndDate(endDate);
                page.setObj(dateNameEn);
            } else {
                page.getParams().remove("date");
                page.getParams().remove("startDate");
                page.getParams().remove("endDate");
            }
        }
        return page;
    }

    
    public Long queryCount(Page<?> page) {
    	page=queryPage(page);
        return dataDao.queryCount(page);
    }
}
