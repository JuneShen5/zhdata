package com.govmade.zhdata.module.sys.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_site")
public class Site extends BasePo<Site> {

    private static final long serialVersionUID = 1L;

    private String code; // 代码

    private String name; // 名称

    private Integer typeId; // 级别

    @Transient
    private String typeName;

    public Site() {
        super();
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public String getTypeName() {
        /*return SysUtils.getCompanyName(this.getTypeId());*/
        /*return EhcacheUtil.getDictTypeName("site_level", this.getTypeId().toString());*/
    	return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    
}
