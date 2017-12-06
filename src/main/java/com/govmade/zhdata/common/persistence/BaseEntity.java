package com.govmade.zhdata.common.persistence;

import java.util.Map;

import com.google.common.collect.Maps;

public class BaseEntity {

    private Integer tong_id;

    private String tableName;

    private Map<String, Object> params = Maps.newHashMap();

   

    public Integer getTong_id() {
        return tong_id;
    }

    public void setTong_id(Integer tong_id) {
        this.tong_id = tong_id;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Map<String, Object> getParams() {
        return params;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }

}
