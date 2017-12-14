package com.govmade.zhdata.module.sys.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_company")
public class Company extends BasePo<Company> {

    private static final long serialVersionUID = 1L;

    private Integer parentId; // 父级

    private String name; // 名称

    private String code; // 部门编码

    private String address; // 地址

    private Integer sort; // 排序

    private Integer type; // 机构类型

    private Integer level; //级别

    @Transient
    private Integer count;

    public Company() {
        super();
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
