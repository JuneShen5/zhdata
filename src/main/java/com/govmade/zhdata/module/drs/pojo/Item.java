package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_item")
public class Item extends BasePo<Item> {

    private static final long serialVersionUID = 1L;

    private String codes;
    
    private String type;
    
    private String typen;
    
    private String name;

    private String len;

    private Integer codeId;
    
    private String des;
    

   

    public String getCodes() {
        return codes;
    }

    public void setCodes(String codes) {
        this.codes = codes;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTypen() {
        return typen;
    }

    public void setTypen(String typen) {
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

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    
    
   
    
}
