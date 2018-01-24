package com.govmade.zhdata.module.drs.pojo;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_system_zaijian")
public class ZjSystems extends BasePo<ZjSystems> {

    private static final long serialVersionUID = 1L;

    private Integer companyId; // 所属部门ID

    @Transient
    private String companyName; // 单位名称（所属部门）

    private String name;

    private String spbm;

    private String spsj;

    private String ywgn;

    private String jsdwmc;

    private String jsdwlxr;

    private String jsdwlxdh;

    private Double xtjsys; // 系统建设预算/合同金额（万元）

    private Integer zjly;

    private String xtlb; // 系统类别

    private Integer dqjsjd;

    private Integer jsfs;

    private String cjdwmc;

    private String cjdwlxr;

    private String cjdwlxdh;

    private String htqssj;

    private String htydwcsj;

    private String htqsdwbdqsj;

    private Double yfhtje; // 已付合同金额

    @Transient
    private Double yfhtjebl; // 已付合同金额比例=已付合同金额/系统建设预算、合同金额

    private String xtjsyj;

    private String jsyqmb;

    private Integer jsxmjpcd;

    private String jpcdsm;

    private String ygsydx; // 预估使用对象

    private String ygsydxxxsm; // 预估使用对象详细说明

    private String ygsygm;

    private String yjhtrsysj;

    private String bswz; // 部署位置

    private Integer smfl;

    private Integer sftmcl; // 是否脱密处理

    private Integer aqjb;

    private String jhjrwllx; // 计划接入网络类型

    private Integer syfw;

    private Integer sfyqtxtdj;

    private String djqtxtmc;

    private Integer sfxnhbs;

    private String xnhrjcsmc;

    private Integer sfybf;

    private Integer bffs;

    private String bfdwz;

    private String sjbfl;

    private Integer yyrz;

    private Integer xthxjh;

    private String xtjxjsyy;

    public ZjSystems() {
        super();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getJsdwmc() {
        return jsdwmc;
    }

    public void setJsdwmc(String jsdwmc) {
        this.jsdwmc = jsdwmc;
    }

    public String getJsdwlxr() {
        return jsdwlxr;
    }

    public void setJsdwlxr(String jsdwlxr) {
        this.jsdwlxr = jsdwlxr;
    }

    public String getJsdwlxdh() {
        return jsdwlxdh;
    }

    public void setJsdwlxdh(String jsdwlxdh) {
        this.jsdwlxdh = jsdwlxdh;
    }

    public Double getXtjsys() {
        return xtjsys;
    }

    public void setXtjsys(Double xtjsys) {
        this.xtjsys = xtjsys;
    }

    public Integer getZjly() {
        return zjly;
    }

    public void setZjly(Integer zjly) {
        this.zjly = zjly;
    }

    public Integer getDqjsjd() {
        return dqjsjd;
    }

    public void setDqjsjd(Integer dqjsjd) {
        this.dqjsjd = dqjsjd;
    }

    public Integer getJsfs() {
        return jsfs;
    }

    public void setJsfs(Integer jsfs) {
        this.jsfs = jsfs;
    }

    public String getCjdwmc() {
        return cjdwmc;
    }

    public void setCjdwmc(String cjdwmc) {
        this.cjdwmc = cjdwmc;
    }

    public String getCjdwlxr() {
        return cjdwlxr;
    }

    public void setCjdwlxr(String cjdwlxr) {
        this.cjdwlxr = cjdwlxr;
    }

    public String getCjdwlxdh() {
        return cjdwlxdh;
    }

    public void setCjdwlxdh(String cjdwlxdh) {
        this.cjdwlxdh = cjdwlxdh;
    }

    public String getHtqssj() {
        return htqssj;
    }

    public void setHtqssj(String htqssj) {
        this.htqssj = htqssj;
    }

    public String getHtydwcsj() {
        return htydwcsj;
    }

    public void setHtydwcsj(String htydwcsj) {
        this.htydwcsj = htydwcsj;
    }

    public String getHtqsdwbdqsj() {
        return htqsdwbdqsj;
    }

    public void setHtqsdwbdqsj(String htqsdwbdqsj) {
        this.htqsdwbdqsj = htqsdwbdqsj;
    }

    public Double getYfhtje() {
        return yfhtje;
    }

    public void setYfhtje(Double yfhtje) {
        this.yfhtje = yfhtje;
    }

    /*public String getYfhtjebl() {
        return Double.valueOf(this.yfhtjebl)*100+"%";
    }*/

   

    public String getXtjsyj() {
        return xtjsyj;
    }

    
//    public void setYfhtjebl(Double yfhtjebl) {
//        this.yfhtjebl = yfhtjebl;
//    }
//    
    

    public String getYfhtjebl() {
        if(getXtjsys()==0){
            return "";
        }
        DecimalFormat df = new DecimalFormat("0.##");
        return  df.format(getYfhtje()/getXtjsys()*100)+"%";
    }

   /* public void setYfhtjebl(Double yfhtjebl) {
        this.yfhtjebl = yfhtjebl;
    }*/

//    public void setXtjsyj(String xtjsyj) {
//        this.xtjsyj = xtjsyj;
//    }

    public String getJsyqmb() {
        return jsyqmb;
    }

    public void setJsyqmb(String jsyqmb) {
        this.jsyqmb = jsyqmb;
    }

    public Integer getJsxmjpcd() {
        return jsxmjpcd;
    }

    public void setJsxmjpcd(Integer jsxmjpcd) {
        this.jsxmjpcd = jsxmjpcd;
    }

    public String getJpcdsm() {
        return jpcdsm;
    }

    public void setJpcdsm(String jpcdsm) {
        this.jpcdsm = jpcdsm;
    }

    public String getYgsydx() {
        return ygsydx;
    }

    public void setYgsydx(String ygsydx) {
        this.ygsydx = ygsydx;
    }

    public String getYgsydxxxsm() {
        return ygsydxxxsm;
    }

    public void setYgsydxxxsm(String ygsydxxxsm) {
        this.ygsydxxxsm = ygsydxxxsm;
    }

    public String getYgsygm() {
        return ygsygm;
    }

    public void setYgsygm(String ygsygm) {
        this.ygsygm = ygsygm;
    }

    public String getYjhtrsysj() {
        return yjhtrsysj;
    }

    public void setYjhtrsysj(String yjhtrsysj) {
        this.yjhtrsysj = yjhtrsysj;
    }

    public Integer getSmfl() {
        return smfl;
    }

    public void setSmfl(Integer smfl) {
        this.smfl = smfl;
    }

    public Integer getSftmcl() {
        return sftmcl;
    }

    public void setSftmcl(Integer sftmcl) {
        this.sftmcl = sftmcl;
    }

    public Integer getAqjb() {
        return aqjb;
    }

    public void setAqjb(Integer aqjb) {
        this.aqjb = aqjb;
    }

    public Integer getSyfw() {
        return syfw;
    }

    public void setSyfw(Integer syfw) {
        this.syfw = syfw;
    }

    public Integer getSfyqtxtdj() {
        return sfyqtxtdj;
    }

    public void setSfyqtxtdj(Integer sfyqtxtdj) {
        this.sfyqtxtdj = sfyqtxtdj;
    }

    public String getDjqtxtmc() {
        return djqtxtmc;
    }

    public void setDjqtxtmc(String djqtxtmc) {
        this.djqtxtmc = djqtxtmc;
    }

    public Integer getSfxnhbs() {
        return sfxnhbs;
    }

    public void setSfxnhbs(Integer sfxnhbs) {
        this.sfxnhbs = sfxnhbs;
    }

    public Integer getSfybf() {
        return sfybf;
    }

    public void setSfybf(Integer sfybf) {
        this.sfybf = sfybf;
    }

    public Integer getBffs() {
        return bffs;
    }

    public void setBffs(Integer bffs) {
        this.bffs = bffs;
    }

    public String getBfdwz() {
        return bfdwz;
    }

    public void setBfdwz(String bfdwz) {
        this.bfdwz = bfdwz;
    }

    public String getSjbfl() {
        return sjbfl;
    }

    public void setSjbfl(String sjbfl) {
        this.sjbfl = sjbfl;
    }

    public Integer getYyrz() {
        return yyrz;
    }

    public void setYyrz(Integer yyrz) {
        this.yyrz = yyrz;
    }

    public Integer getXthxjh() {
        return xthxjh;
    }

    public void setXthxjh(Integer xthxjh) {
        this.xthxjh = xthxjh;
    }

    public String getXtjxjsyy() {
        return xtjxjsyy;
    }

    public void setXtjxjsyy(String xtjxjsyy) {
        this.xtjxjsyy = xtjxjsyy;
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

    public String getXnhrjcsmc() {
        return xnhrjcsmc;
    }

    public void setXnhrjcsmc(String xnhrjcsmc) {
        this.xnhrjcsmc = xnhrjcsmc;
    }

    public String getXtlb() {
        return xtlb;
    }

    public void setXtlb(String xtlb) {
        this.xtlb = xtlb;
    }

    public String getBswz() {
        return bswz;
    }

    public void setBswz(String bswz) {
        this.bswz = bswz;
    }

    public String getJhjrwllx() {
        return jhjrwllx;
    }

    public void setJhjrwllx(String jhjrwllx) {
        this.jhjrwllx = jhjrwllx;
    }

}
