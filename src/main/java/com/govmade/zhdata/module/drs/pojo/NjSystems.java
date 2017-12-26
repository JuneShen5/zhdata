package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_system_nijian")
public class NjSystems extends BasePo<NjSystems>{
	
	private static final long serialVersionUID = 1L;

	private Integer companyId; // 所属部门ID
	
	@Transient
    private String companyName; // 单位名称（所属部门）
	
	private String xtmc;
	
	private Integer smfl;
	
	private String spbm;
	
	private String spsj;
	
	private String ywgn;
	
	private String xtjsys;
	
	private Integer zjly;
	
	private Integer zjdwqk;
	
	private Integer jsfs;
	
	private String lxr;
	
	private String lxdh;
	
	private Integer xtlb;
	
	private Integer xtlb2;
	
	private Integer jsjpcd;
	
	private String xtjcsjyq;
	
	private String njxtyj;
	
	private String jsyqmb;
	
	private String ygsydx;
	
	private String ygsygm;

	public NjSystems() {
		super();
	}



	public String getXtmc() {
		return xtmc;
	}

	public void setXtmc(String xtmc) {
		this.xtmc = xtmc;
	}

	public Integer getSmfl() {
		return smfl;
	}

	public void setSmfl(Integer smfl) {
		this.smfl = smfl;
	}

	public String getSpbm() {
		return spbm;
	}

	public void setSpbm(String spbm) {
		this.spbm = spbm;
	}

	public String getSpsj() {
		return spsj;
	}

	public void setSpsj(String spsj) {
		this.spsj = spsj;
	}

	public String getYwgn() {
		return ywgn;
	}

	public void setYwgn(String ywgn) {
		this.ywgn = ywgn;
	}

	public String getXtjsys() {
		return xtjsys;
	}

	public void setXtjsys(String xtjsys) {
		this.xtjsys = xtjsys;
	}

	public Integer getZjly() {
		return zjly;
	}

	public void setZjly(Integer zjly) {
		this.zjly = zjly;
	}

	public Integer getZjdwqk() {
		return zjdwqk;
	}

	public void setZjdwqk(Integer zjdwqk) {
		this.zjdwqk = zjdwqk;
	}

	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public Integer getJsjpcd() {
		return jsjpcd;
	}

	public void setJsjpcd(Integer jsjpcd) {
		this.jsjpcd = jsjpcd;
	}

	public String getXtjcsjyq() {
		return xtjcsjyq;
	}

	public void setXtjcsjyq(String xtjcsjyq) {
		this.xtjcsjyq = xtjcsjyq;
	}

	public String getNjxtyj() {
		return njxtyj;
	}

	public void setNjxtyj(String njxtyj) {
		this.njxtyj = njxtyj;
	}

	public String getJsyqmb() {
		return jsyqmb;
	}

	public void setJsyqmb(String jsyqmb) {
		this.jsyqmb = jsyqmb;
	}

	public String getYgsydx() {
		return ygsydx;
	}

	public void setYgsydx(String ygsydx) {
		this.ygsydx = ygsydx;
	}

	public String getYgsygm() {
		return ygsygm;
	}

	public void setYgsygm(String ygsygm) {
		this.ygsygm = ygsygm;
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



	public Integer getJsfs() {
		return jsfs;
	}



	public void setJsfs(Integer jsfs) {
		this.jsfs = jsfs;
	}



	public Integer getXtlb() {
		return xtlb;
	}



	public void setXtlb(Integer xtlb) {
		this.xtlb = xtlb;
	}



	public Integer getXtlb2() {
		return xtlb2;
	}



	public void setXtlb2(Integer xtlb2) {
		this.xtlb2 = xtlb2;
	}
	
		
}
