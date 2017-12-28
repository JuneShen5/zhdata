package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_attribute")
public class Attribute extends BasePo<Attribute> {

    private static final long serialVersionUID = 1L;

    private Integer type;

    private String nameEn;

    private String nameCn;

    private String isRequire;

    private String inputType;

    private String validType;

    private String inputLength;

    private String inputValue;

    private String isShow;

    private String searchType;

    private Integer sort;
    
    private Integer isCore;
    
    protected Integer delFlag; // 删除标记（0：正常；1：删除；2：审核）按照example查询的时候这个如果加载公用地方不起作用

    public Attribute() {
        super();
    }

    public Attribute(Integer type) {
        this.delFlag = DEL_FLAG_NORMAL;
        this.type = type;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    public String getNameCn() {
        return nameCn;
    }

    public void setNameCn(String nameCn) {
        this.nameCn = nameCn;
    }

    public String getIsRequire() {
        return isRequire;
    }

    public void setIsRequire(String isRequire) {
        this.isRequire = isRequire;
    }

    public String getInputType() {
        return inputType;
    }

    public void setInputType(String inputType) {
        this.inputType = inputType;
    }

    public String getValidType() {
        return validType;
    }

    public void setValidType(String validType) {
        this.validType = validType;
    }

    public String getInputLength() {
        return inputLength;
    }

    public void setInputLength(String inputLength) {
        this.inputLength = inputLength;
    }

    public String getInputValue() {
        return inputValue;
    }

    public void setInputValue(String inputValue) {
        this.inputValue = inputValue;
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getIsCore() {
        return isCore;
    }

    public void setIsCore(Integer isCore) {
        this.isCore = isCore;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }
    
    
}
