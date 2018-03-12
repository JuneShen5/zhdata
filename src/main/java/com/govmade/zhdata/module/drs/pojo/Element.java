package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_element")
public class Element extends BasePo<Element> {

    private static final long serialVersionUID = 1L;

    private String nameCn; // 中文名字

    private Integer companyId;

    private Integer infoId;

    private Integer itemId;

    @Transient
    private String companyName;

    @Transient
    private String codes; // 数据元编码

    @Transient
    private String type; // 数据元类别-中文

    @Transient
    private String typen; // 数据元类型-英文

    @Transient
    private String name; // 数据元名称

    @Transient
    private String len; // 数据元长度
    
    @Transient
    private String des; // 数据元说明
    
    

    // @Transient
    // private String idCode;

    // @Transient
    // private String dataTypeName;// 数据类型

    // @Transient
    // private Integer toPool; //导入数据元池

    // @Transient
    // private Integer count;

    // @Transient
    // private Integer colId;

    public Element() {
        super();
    }

    public String getNameCn() {
        return nameCn;
    }

    public void setNameCn(String nameCn) {
        this.nameCn = nameCn;
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public Integer getInfoId() {
        return infoId;
    }

    public void setInfoId(Integer infoId) {
        this.infoId = infoId;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getCodes() {
        return codes;
    }

    public void setCodes(String codes) {
        this.codes = codes;
    }

    
    
    
}
