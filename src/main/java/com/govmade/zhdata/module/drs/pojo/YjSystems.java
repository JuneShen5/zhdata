package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_system_yijian")
public class YjSystems extends BasePo<YjSystems> {

    private static final long serialVersionUID = 1L;

    private Integer companyId; // 所属部门ID

    @Transient
    private String companyName; // 单位名称（所属部门）

    private String name;  //系统名称

    private String jsyj;

    private String spbm;

    private String spsj;

    private String ywgn;

    private String gkksmc;

    private String jsdwlxr;

    private String jsdwlxdh;

    private String cjdwmc;

    private String cjdwlxr;

    private String cjdwlxdh;

    private Integer jslx;

    private Integer jsfs;

    private String jsqssj;

    private String trsysj;

    private Integer xtlb;

    private Integer xtlb2;

    private Integer bswz;

    private Integer smfl;

    private Integer aqjb;

    private Integer yjr;

    private Integer wllxsyfw;

    private Integer xtjg;

    private Integer yyfwqczxt;

    private Integer sjkfwqczxt;

    private String zjjbb;

    private String sjkbb;

    private Integer sfyqtxtdj;

    private String djqtxtmc;

    private Integer sfxnhbs;

    private String xnhrjjcsmc;

    private Integer sfsqzhzh;

    private String zhzhyysm;

    private Integer sfysjxq;

    private String sjxqxxsm;

    private Integer sfjsxt;

    private String sydx; // 使用对象

    private String yhgm;

    private String mysypd;

    private String xtsjdfwqip;

    private String xtfwdz;

    private String ywdwmc;

    private String ywdwlxr;

    private String ywdwlxdh;

    private Integer ywfs;

    private String ywhtqsdqsj;

    private Integer sfybf;

    private Integer bffs;

    private String bfdwz;

    private String sjbfl;

    private Integer sjbfpl;

    private Integer yysh;

    private String tcshxz;

    private Integer yyrz;

    private Integer jszl;

    private Integer zjly;

    private Double jsje;

    private Double ywje;

    private String nd;

    private String qhmc;

    private String ywcsmc;

    private String ysdwmc;

    private String zjxzmc;

    private String gnflmc;

    private String xmflmc;

    private String jjflmc;

    private String zffsmc;

    private String zblxmc;

    private String zblymc;

    private String zbfpndmc;

    private String ysxmbm;

    private String ysxmmc;

    private String zzbje;

    private String kyje;

    private String yyje;

    private String xxlrfs; // 信息录入方式

    private String xtsjzzqk;

    private String clsjnx;

    private String clsjyxq;

    private Integer sjccfs;

    private Integer sjwjdx;

    private Integer sjjmfs;

    private Integer sjgxms;

    private String wbbs; // 外部报送

    private Integer bssx;

    public YjSystems() {
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


    public String getJsyj() {
        return jsyj;
    }

    public void setJsyj(String jsyj) {
        this.jsyj = jsyj;
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

    public String getGkksmc() {
        return gkksmc;
    }

    public void setGkksmc(String gkksmc) {
        this.gkksmc = gkksmc;
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

    public Integer getJslx() {
        return jslx;
    }

    public void setJslx(Integer jslx) {
        this.jslx = jslx;
    }

    public Integer getJsfs() {
        return jsfs;
    }

    public void setJsfs(Integer jsfs) {
        this.jsfs = jsfs;
    }

    public String getJsqssj() {
        return jsqssj;
    }

    public void setJsqssj(String jsqssj) {
        this.jsqssj = jsqssj;
    }

    public String getTrsysj() {
        return trsysj;
    }

    public void setTrsysj(String trsysj) {
        this.trsysj = trsysj;
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

    public Integer getBswz() {
        return bswz;
    }

    public void setBswz(Integer bswz) {
        this.bswz = bswz;
    }

    public Integer getSmfl() {
        return smfl;
    }

    public void setSmfl(Integer smfl) {
        this.smfl = smfl;
    }

    public Integer getAqjb() {
        return aqjb;
    }

    public void setAqjb(Integer aqjb) {
        this.aqjb = aqjb;
    }

    public Integer getYjr() {
        return yjr;
    }

    public void setYjr(Integer yjr) {
        this.yjr = yjr;
    }

    public Integer getWllxsyfw() {
        return wllxsyfw;
    }

    public void setWllxsyfw(Integer wllxsyfw) {
        this.wllxsyfw = wllxsyfw;
    }

    public Integer getXtjg() {
        return xtjg;
    }

    public void setXtjg(Integer xtjg) {
        this.xtjg = xtjg;
    }

    public Integer getYyfwqczxt() {
        return yyfwqczxt;
    }

    public void setYyfwqczxt(Integer yyfwqczxt) {
        this.yyfwqczxt = yyfwqczxt;
    }

    public Integer getSjkfwqczxt() {
        return sjkfwqczxt;
    }

    public void setSjkfwqczxt(Integer sjkfwqczxt) {
        this.sjkfwqczxt = sjkfwqczxt;
    }

    public String getZjjbb() {
        return zjjbb;
    }

    public void setZjjbb(String zjjbb) {
        this.zjjbb = zjjbb;
    }

    public String getSjkbb() {
        return sjkbb;
    }

    public void setSjkbb(String sjkbb) {
        this.sjkbb = sjkbb;
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

    public String getXnhrjjcsmc() {
        return xnhrjjcsmc;
    }

    public void setXnhrjjcsmc(String xnhrjjcsmc) {
        this.xnhrjjcsmc = xnhrjjcsmc;
    }

    public Integer getSfsqzhzh() {
        return sfsqzhzh;
    }

    public void setSfsqzhzh(Integer sfsqzhzh) {
        this.sfsqzhzh = sfsqzhzh;
    }

    public String getZhzhyysm() {
        return zhzhyysm;
    }

    public void setZhzhyysm(String zhzhyysm) {
        this.zhzhyysm = zhzhyysm;
    }

    public Integer getSfysjxq() {
        return sfysjxq;
    }

    public void setSfysjxq(Integer sfysjxq) {
        this.sfysjxq = sfysjxq;
    }

    public String getSjxqxxsm() {
        return sjxqxxsm;
    }

    public void setSjxqxxsm(String sjxqxxsm) {
        this.sjxqxxsm = sjxqxxsm;
    }

    public Integer getSfjsxt() {
        return sfjsxt;
    }

    public void setSfjsxt(Integer sfjsxt) {
        this.sfjsxt = sfjsxt;
    }

    public String getSydx() {
        return sydx;
    }

    public void setSydx(String sydx) {
        this.sydx = sydx;
    }

    public String getYhgm() {
        return yhgm;
    }

    public void setYhgm(String yhgm) {
        this.yhgm = yhgm;
    }

    public String getMysypd() {
        return mysypd;
    }

    public void setMysypd(String mysypd) {
        this.mysypd = mysypd;
    }

    public String getXtsjdfwqip() {
        return xtsjdfwqip;
    }

    public void setXtsjdfwqip(String xtsjdfwqip) {
        this.xtsjdfwqip = xtsjdfwqip;
    }

    public String getXtfwdz() {
        return xtfwdz;
    }

    public void setXtfwdz(String xtfwdz) {
        this.xtfwdz = xtfwdz;
    }

    public String getYwdwmc() {
        return ywdwmc;
    }

    public void setYwdwmc(String ywdwmc) {
        this.ywdwmc = ywdwmc;
    }

    public String getYwdwlxr() {
        return ywdwlxr;
    }

    public void setYwdwlxr(String ywdwlxr) {
        this.ywdwlxr = ywdwlxr;
    }

    public String getYwdwlxdh() {
        return ywdwlxdh;
    }

    public void setYwdwlxdh(String ywdwlxdh) {
        this.ywdwlxdh = ywdwlxdh;
    }

    public Integer getYwfs() {
        return ywfs;
    }

    public void setYwfs(Integer ywfs) {
        this.ywfs = ywfs;
    }

    public String getYwhtqsdqsj() {
        return ywhtqsdqsj;
    }

    public void setYwhtqsdqsj(String ywhtqsdqsj) {
        this.ywhtqsdqsj = ywhtqsdqsj;
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

    public Integer getSjbfpl() {
        return sjbfpl;
    }

    public void setSjbfpl(Integer sjbfpl) {
        this.sjbfpl = sjbfpl;
    }

    public Integer getYysh() {
        return yysh;
    }

    public void setYysh(Integer yysh) {
        this.yysh = yysh;
    }

    public String getTcshxz() {
        return tcshxz;
    }

    public void setTcshxz(String tcshxz) {
        this.tcshxz = tcshxz;
    }

    public Integer getYyrz() {
        return yyrz;
    }

    public void setYyrz(Integer yyrz) {
        this.yyrz = yyrz;
    }

    public Integer getJszl() {
        return jszl;
    }

    public void setJszl(Integer jszl) {
        this.jszl = jszl;
    }

    public Integer getZjly() {
        return zjly;
    }

    public void setZjly(Integer zjly) {
        this.zjly = zjly;
    }

    public Double getJsje() {
        return jsje;
    }

    public void setJsje(Double jsje) {
        this.jsje = jsje;
    }

    public Double getYwje() {
        return ywje;
    }

    public void setYwje(Double ywje) {
        this.ywje = ywje;
    }

    public String getNd() {
        return nd;
    }

    public void setNd(String nd) {
        this.nd = nd;
    }

    public String getQhmc() {
        return qhmc;
    }

    public void setQhmc(String qhmc) {
        this.qhmc = qhmc;
    }

    public String getYwcsmc() {
        return ywcsmc;
    }

    public void setYwcsmc(String ywcsmc) {
        this.ywcsmc = ywcsmc;
    }

    public String getYsdwmc() {
        return ysdwmc;
    }

    public void setYsdwmc(String ysdwmc) {
        this.ysdwmc = ysdwmc;
    }

    public String getZjxzmc() {
        return zjxzmc;
    }

    public void setZjxzmc(String zjxzmc) {
        this.zjxzmc = zjxzmc;
    }

    public String getGnflmc() {
        return gnflmc;
    }

    public void setGnflmc(String gnflmc) {
        this.gnflmc = gnflmc;
    }

    public String getXmflmc() {
        return xmflmc;
    }

    public void setXmflmc(String xmflmc) {
        this.xmflmc = xmflmc;
    }

    public String getJjflmc() {
        return jjflmc;
    }

    public void setJjflmc(String jjflmc) {
        this.jjflmc = jjflmc;
    }

    public String getZffsmc() {
        return zffsmc;
    }

    public void setZffsmc(String zffsmc) {
        this.zffsmc = zffsmc;
    }

    public String getZblxmc() {
        return zblxmc;
    }

    public void setZblxmc(String zblxmc) {
        this.zblxmc = zblxmc;
    }

    public String getZblymc() {
        return zblymc;
    }

    public void setZblymc(String zblymc) {
        this.zblymc = zblymc;
    }

    public String getZbfpndmc() {
        return zbfpndmc;
    }

    public void setZbfpndmc(String zbfpndmc) {
        this.zbfpndmc = zbfpndmc;
    }

    public String getYsxmbm() {
        return ysxmbm;
    }

    public void setYsxmbm(String ysxmbm) {
        this.ysxmbm = ysxmbm;
    }

    public String getYsxmmc() {
        return ysxmmc;
    }

    public void setYsxmmc(String ysxmmc) {
        this.ysxmmc = ysxmmc;
    }

    public String getZzbje() {
        return zzbje;
    }

    public void setZzbje(String zzbje) {
        this.zzbje = zzbje;
    }

    public String getKyje() {
        return kyje;
    }

    public void setKyje(String kyje) {
        this.kyje = kyje;
    }

    public String getYyje() {
        return yyje;
    }

    public void setYyje(String yyje) {
        this.yyje = yyje;
    }

    public String getXxlrfs() {
        return xxlrfs;
    }

    public void setXxlrfs(String xxlrfs) {
        this.xxlrfs = xxlrfs;
    }

    public String getXtsjzzqk() {
        return xtsjzzqk;
    }

    public void setXtsjzzqk(String xtsjzzqk) {
        this.xtsjzzqk = xtsjzzqk;
    }

    public String getClsjnx() {
        return clsjnx;
    }

    public void setClsjnx(String clsjnx) {
        this.clsjnx = clsjnx;
    }

    public String getClsjyxq() {
        return clsjyxq;
    }

    public void setClsjyxq(String clsjyxq) {
        this.clsjyxq = clsjyxq;
    }

    public Integer getSjccfs() {
        return sjccfs;
    }

    public void setSjccfs(Integer sjccfs) {
        this.sjccfs = sjccfs;
    }

    public Integer getSjwjdx() {
        return sjwjdx;
    }

    public void setSjwjdx(Integer sjwjdx) {
        this.sjwjdx = sjwjdx;
    }

    public Integer getSjjmfs() {
        return sjjmfs;
    }

    public void setSjjmfs(Integer sjjmfs) {
        this.sjjmfs = sjjmfs;
    }

    public Integer getSjgxms() {
        return sjgxms;
    }

    public void setSjgxms(Integer sjgxms) {
        this.sjgxms = sjgxms;
    }

    public String getWbbs() {
        return wbbs;
    }

    public void setWbbs(String wbbs) {
        this.wbbs = wbbs;
    }

    public Integer getBssx() {
        return bssx;
    }

    public void setBssx(Integer bssx) {
        this.bssx = bssx;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    

}
