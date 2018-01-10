package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_system_nijian")
public class NjSystems extends BasePo<NjSystems> {

    private static final long serialVersionUID = 1L;

    private Integer companyId; // 所属部门ID

    @Transient
    private String companyName; // 单位名称（所属部门）

    private String name;

    private Integer smfl;

    private String spbm;

    private String spsj;

    private String ywgn;

    private String xtjsys;

    private Integer zjly;

    private Integer zjdwqk;

    private String jsfs;   //建设方式

    private String lxr;

    private String lxdh;

    private String xtlb;  //系统类别

    private Integer jsjpcd;   //建设紧迫程度

    private String xtjcsjyq;

    private String njxtyj;

    private String jsyqmb;

    private String ygsydx;  //预估使用对象

    private String ygsygm;

    public NjSystems() {
        super();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getJsfs() {
        return jsfs;
    }

    public void setJsfs(String jsfs) {
        this.jsfs = jsfs;
    }

    public String getXtlb() {
        return xtlb;
    }

    public void setXtlb(String xtlb) {
        this.xtlb = xtlb;
    }

   

}
