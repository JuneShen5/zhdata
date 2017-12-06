package com.govmade.zhdata.module.drs.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_tables")
public class Tables extends BasePo<Tables> {
    
    private static final long serialVersionUID = 1L;

    private Integer dbId;

    private String nameEn;

    private String nameCn;
    
    private Integer infoId;
    
    @Transient
    private String dbName; //数据库中文名
    
    @Transient
    private List<Columns> colList=Lists.newArrayList();

  /*  public Tables() {
        super();
    }*/

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDbId() {
        return dbId;
    }

    public void setDbId(Integer dbId) {
        this.dbId = dbId;
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

    public List<Columns> getColList() {
        return colList;
    }

    public void setColList(List<Columns> colList) {
        this.colList = colList;
    }

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

	public Integer getInfoId() {
		return infoId;
	}

	public void setInfoId(Integer infoId) {
		this.infoId = infoId;
	}
    
}
