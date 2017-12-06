package com.govmade.zhdata.module.sys.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_company")
public class Company extends BasePo<Company> {

    private static final long serialVersionUID = 1L;

    private Integer siteId; // 班子ID

    @Transient
    private String siteName; // 政府班子

    private String name; // 名称

    private String code; // 代码

    private String address; // 地址

    @Transient
    private Integer count;

    public Company() {
        super();
    }

	public Company(Integer siteId, String name, String code,
			String address, String remarks) {
		super();
		this.siteId = siteId;
		this.name = name;
		this.code = code;
		this.address = address;
		this.remarks = remarks;
	}


	public Integer getSiteId() {
        return siteId;
    }

    public void setSiteId(Integer siteId) {
        this.siteId = siteId;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
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
