package com.govmade.zhdata.module.drs.pojo;

import java.util.List;
import java.util.Map;

public class Converge {


    private String code;  //表名

    private List<Map<String,String>> list; //实体数据

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public List<Map<String, String>> getList() {
        return list;
    }

    public void setList(List<Map<String, String>> list) {
        this.list = list;
    }
}
