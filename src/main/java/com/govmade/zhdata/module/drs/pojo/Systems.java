package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_systems")
public class Systems extends BasePo<Systems> {

    private static final long serialVersionUID = 1L;

    private Integer companyId;

    @Transient
    private String companyName;

  /*  private String nameEn;*/

    private String nameCn;

    private Integer isAudit;
    
    private String info;

    public Systems() {
        super();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

   

    public String getNameCn() {
        return nameCn;
    }

    public void setNameCn(String nameCn) {
        this.nameCn = nameCn;
    }

    public Integer getIsAudit() {
		return isAudit;
	}

	public void setIsAudit(Integer isAudit) {
		this.isAudit = isAudit;
	}

	public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
