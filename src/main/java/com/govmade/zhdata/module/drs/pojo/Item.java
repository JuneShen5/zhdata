package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_item")
public class Item extends BasePo<Item> {

    private static final long serialVersionUID = 1L;

    private String code;
    
    private Integer type;
    
    private Integer typen;
    
    private String name;

    private String len;

    private Integer codeId;
    
    private String range;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getTypen() {
        return typen;
    }

    public void setTypen(Integer typen) {
        this.typen = typen;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLen() {
        return len;
    }

    public void setLen(String len) {
        this.len = len;
    }

    
    public Integer getCodeId() {
        return codeId;
    }

    public void setCodeId(Integer codeId) {
        this.codeId = codeId;
    }

    public String getRange() {
        return range;
    }

    public void setRange(String range) {
        this.range = range;
    }
    
    
    
   
    
}
