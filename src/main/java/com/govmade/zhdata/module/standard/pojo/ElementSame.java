package com.govmade.zhdata.module.standard.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_element_same")
public class ElementSame extends BasePo<ElementSame> {

    private static final long serialVersionUID = 1L;

    private String name;

    private Integer levels;

    private Integer parentId;

    private Integer companyId;

    @Transient
    private List<ElementSame> childList;
    
    @Transient
    private String sqlName; //同义词条件  例：*姓名
    
  
   
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getLevels() {
        return levels;
    }

    public void setLevels(Integer levels) {
        this.levels = levels;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public List<ElementSame> getChildList() {
        return childList;
    }

    public void setChildList(List<ElementSame> childList) {
        this.childList = childList;
    }

    public String getSqlName() {
        return name.replaceAll("\\*", "%");
    }

   /* public void setSqlName(String sqlName) {
        this.sqlName = sqlName;
    }*/

    
    
}
