package com.govmade.zhdata.module.sys.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_company")
public class Company extends BasePo<Company> {

    private static final long serialVersionUID = 1L;

    private Integer parentId; // 父级
    
    @Transient
    private String parentName; // 父级名称

    private String name; // 名称

    private String code; // 部门编码

    private String address; // 地址

    private Integer sort; // 排序

    private Integer type; // 机构类型

    private Integer level; //级别
    
    @Transient
    private String types; //类型

    @Transient
    private Integer count;
    
    /*树形结构要用*/  
    @Transient
    private Company parent;
    
    @Transient
    private boolean isLeaf;
    
    @Transient
    private int rootId;
    
    @Transient
    private int childSize;
    
    @Transient
    private List<Company> children= Lists.newArrayList();

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

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getTypes() {
        return types;
    }

    public void setTypes(String types) {
        this.types = types;
    }

    
    
    public Company getParent() {
        return parent;
    }

    public void setParent(Company parent) {
        this.parent = parent;
    }

    public boolean isLeaf() {
        return isLeaf;
    }

    public void setLeaf(boolean isLeaf) {
        this.isLeaf = isLeaf;
    }

    public int getRootId() {
        return rootId;
    }

    public void setRootId(int rootId) {
        this.rootId = rootId;
    }

    public int getChildSize() {
        return childSize;
    }

    public void setChildSize(int childSize) {
        this.childSize = childSize;
    }

    
    public List<Company> getChildren() {
        return children;
    }

    public void setChildren(List<Company> children) {
        this.children = children;
    }

    @Override
    public String toString() {
        return "Company [parentId=" + parentId + ", parentName=" + parentName + ", name=" + name + ", code="
                + code + ", address=" + address + ", sort=" + sort + ", type=" + type + ", level=" + level
                + ", types=" + types + ", count=" + count + "]";
    }
    
    
    
    
}
