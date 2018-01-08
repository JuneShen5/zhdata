package com.govmade.zhdata.module.drs.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_information")
public class Information extends BasePo<Information> {

    private static final long serialVersionUID = 1L;

    private Integer companyId; //信息资源提供方（所属机构）
    
    @Transient
    private String companyName;
    
    private Integer departId; //审核机构
    
    @Transient
    private String departName;
    
    private Integer systemId;

    @Transient
    private String systemName;
    
    private String nameEn; // 信息资源代码

    private String nameCn;

    private String tbName;

    private Integer isOpen;// 是否向社会开放

    private Integer openType;

    private Integer shareType;

    private String shareMode;// 共享方式

    private String shareCondition;// 共享条件

    private Integer infoType1;

    private Integer infoType2;

    private Integer isAudit;

    private String info; // 信息资源属性

    private String code; // 信息资源提供方代码

    private String reason; // 信息资源提供方代码

    private String resourceFormat; // 信息资源格式

    private String rightRelation; // 权属关系

    private Integer manageStyle; // 管理方式

    private String releaseDate; // 发布日期

    @Transient
    private Integer isAuthorize; // 是否需要数据权限控制 0为否 1为是


    @Transient
    private String elementIds;

    @Transient
    private List<Element> elementList = Lists.newArrayList(); // 拥有数据元列表

    @Transient
    private Integer count;

    public Information() {
        super();
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public Integer getSystemId() {
        return systemId;
    }

    public void setSystemId(Integer systemId) {
        this.systemId = systemId;
    }

    public String getTbName() {
        return tbName;
    }

    public void setTbName(String tbName) {
        this.tbName = tbName;
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

    public Integer getOpenType() {
        return openType;
    }

    public void setOpenType(Integer openType) {
        this.openType = openType;
    }

    public Integer getShareType() {
        return shareType;
    }

    public void setShareType(Integer shareType) {
        this.shareType = shareType;
    }

    public Integer getInfoType1() {
        return infoType1;
    }

    public void setInfoType1(Integer infoType1) {
        this.infoType1 = infoType1;
    }

    public Integer getInfoType2() {
        return infoType2;
    }

    public void setInfoType2(Integer infoType2) {
        this.infoType2 = infoType2;
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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getSystemName() {
        return systemName;
    }

    public void setSystemName(String systemName) {
        this.systemName = systemName;
    }

    public String getElementIds() {
        return elementIds;
    }

    public void setElementIds(String elementIds) {
        this.elementIds = elementIds;
    }

    public List<Element> getElementList() {
        return elementList;
    }

    public void setElementList(List<Element> elementList) {
        this.elementList = elementList;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getIsOpen() {
        return isOpen;
    }

    public void setIsOpen(Integer isOpen) {
        this.isOpen = isOpen;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Integer getIsAuthorize() {
        return isAuthorize;
    }

    public void setIsAuthorize(Integer isAuthorize) {
        this.isAuthorize = isAuthorize;
    }

    public String getShareMode() {
        return shareMode;
    }

    public void setShareMode(String shareMode) {
        this.shareMode = shareMode;
    }

    public String getShareCondition() {
        return shareCondition;
    }

    public void setShareCondition(String shareCondition) {
        this.shareCondition = shareCondition;
    }

    public String getResourceFormat() {
        return resourceFormat;
    }

    public void setResourceFormat(String resourceFormat) {
        this.resourceFormat = resourceFormat;
    }

    public String getRightRelation() {
        return rightRelation;
    }

    public void setRightRelation(String rightRelation) {
        this.rightRelation = rightRelation;
    }

    public Integer getManageStyle() {
        return manageStyle;
    }

    public void setManageStyle(Integer manageStyle) {
        this.manageStyle = manageStyle;
    }

    public String getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(String releaseDate) {
        this.releaseDate = releaseDate;
    }

    @Override
    public String toString() {
        return "Information [companyId=" + companyId + ", companyName=" + companyName + ", departId="
                + departId + ", departName=" + departName + ", systemId=" + systemId + ", systemName="
                + systemName + ", nameEn=" + nameEn + ", nameCn=" + nameCn + ", tbName=" + tbName
                + ", isOpen=" + isOpen + ", openType=" + openType + ", shareType=" + shareType
                + ", shareMode=" + shareMode + ", shareCondition=" + shareCondition + ", infoType1="
                + infoType1 + ", infoType2=" + infoType2 + ", isAudit=" + isAudit + ", info=" + info
                + ", code=" + code + ", reason=" + reason + ", resourceFormat=" + resourceFormat
                + ", rightRelation=" + rightRelation + ", manageStyle=" + manageStyle + ", releaseDate="
                + releaseDate + ", isAuthorize=" + isAuthorize + ", elementIds=" + elementIds
                + ", elementList=" + elementList + ", count=" + count + "]";
    }

    public Integer getDepartId() {
        return departId;
    }

    public void setDepartId(Integer departId) {
        this.departId = departId;
    }

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }
    
    

}
