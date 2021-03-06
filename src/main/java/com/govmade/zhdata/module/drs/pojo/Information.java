package com.govmade.zhdata.module.drs.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_information")
public class Information extends BasePo<Information> {

    private static final long serialVersionUID = 1L;

    private Integer companyId; // 信息资源提供方（所属机构）

    @Transient
    private String companyName;

    private Integer departId; // 审核机构

    @Transient
    private String departName;

    private Integer systemId;

    @Transient
    private String systemName;

    private String dept;

    private String nameEn; // 信息资源代码

    private String nameCn;
    
    private String infoType;

    private String code;

    private String resourceFormat; // 信息资源格式

    private Integer isOpen;// 是否向社会开放

    private String openType;

    private Integer shareType; // 共享类型

    private String shareMode;// 共享方式

    private String shareCondition;// 共享条件

    private Integer manageStyle; // 管理方式

    private String matter;

    private String ranges;

    private Integer isAudit;

    private Integer isCreated;
    
    //新增
    private Integer infoType3;
    
    private Integer infoType4;
    
    private String summary;
    
    private String updateCycle;
    

    private String info; // 信息资源属性

    private String reason; // 信息资源提供方代码

    // private String rightRelation; // 权属关系

    // private String releaseDate; // 发布日期

    @Transient
    private Integer isAuthorize; // 是否需要数据权限控制 0为否 1为是

    @Transient
    private String elementIds;

    @Transient
    private List<Element> elementList = Lists.newArrayList(); // 拥有信息项列表

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

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    public Integer getSystemId() {
        return systemId;
    }

    public void setSystemId(Integer systemId) {
        this.systemId = systemId;
    }

    public String getSystemName() {
        return systemName;
    }

    public void setSystemName(String systemName) {
        this.systemName = systemName;
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

    public Integer getIsOpen() {
        return isOpen;
    }

    public void setIsOpen(Integer isOpen) {
        this.isOpen = isOpen;
    }

    public String getOpenType() {
        return openType;
    }

    public void setOpenType(String openType) {
        this.openType = openType;
    }

    public Integer getShareType() {
        return shareType;
    }

    public void setShareType(Integer shareType) {
        this.shareType = shareType;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getResourceFormat() {
        return resourceFormat;
    }

    public void setResourceFormat(String resourceFormat) {
        this.resourceFormat = resourceFormat;
    }

    public Integer getManageStyle() {
        return manageStyle;
    }

    public void setManageStyle(Integer manageStyle) {
        this.manageStyle = manageStyle;
    }

    public Integer getIsAuthorize() {
        return isAuthorize;
    }

    public void setIsAuthorize(Integer isAuthorize) {
        this.isAuthorize = isAuthorize;
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

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getMatter() {
        return matter;
    }

    public void setMatter(String matter) {
        this.matter = matter;
    }

    public String getRanges() {
        return ranges;
    }

    public void setRanges(String ranges) {
        this.ranges = ranges;
    }

    public Integer getIsCreated() {
        return isCreated;
    }

    public void setIsCreated(Integer isCreated) {
        this.isCreated = isCreated;
    }

    public Integer getInfoType3() {
        return infoType3;
    }

    public void setInfoType3(Integer infoType3) {
        this.infoType3 = infoType3;
    }

    public Integer getInfoType4() {
        return infoType4;
    }

    public void setInfoType4(Integer infoType4) {
        this.infoType4 = infoType4;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getUpdateCycle() {
        return updateCycle;
    }

    public void setUpdateCycle(String updateCycle) {
        this.updateCycle = updateCycle;
    }

    public String getInfoType() {
        return infoType;
    }

    public void setInfoType(String infoType) {
        this.infoType = infoType;
    }
    
    

}
