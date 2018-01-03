package com.govmade.zhdata.module.drs.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_info_sort")
public class InfoSort extends BasePo<InfoSort> {

    private static final long serialVersionUID = 1L;

    private Integer parentId; // 父级菜单

    private String code; // 代码

    private String name; // 名称

    private Integer sort; // 排序

    @Transient
    private Integer count; // 总数
    
    @Transient
    private String parentName;
    
    @Transient
    private List<InfoSort> children= Lists.newArrayList();
    
    
    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
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

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List<InfoSort> getChildren() {
        return children;
    }

    public void setChildren(List<InfoSort> children) {
        this.children = children;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

}