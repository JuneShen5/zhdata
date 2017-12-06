package com.govmade.zhdata.common.persistence;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.govmade.zhdata.common.utils.UserUtils;

public class BasePo<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    protected Integer id; // 唯一标识

    protected Integer createBy; // 创建者
    
    @Transient
    protected String createName; // 创建者姓名

    protected Date createDate; // 创建日期

    protected Integer updateBy; // 更新者
    
    @Transient
    protected String updateName; // 更新者姓名

    protected Date updateDate; // 更新日期

    protected String remarks; // 备注

    protected Integer delFlag; // 删除标记（0：正常；1：删除；2：审核）

    public BasePo() {
        this.delFlag = DEL_FLAG_NORMAL;
    }

    public BasePo(Integer id) {
        this();
        this.id = id;
    }

    /**
     * 插入之前执行方法，需要手动调用
     */
    public void preInsert() {
        // save前初始化数据
        this.createBy = UserUtils.getCurrentUser().getId();
        this.updateBy = this.createBy;
        this.updateDate = new Date();
        if (this.createDate == null) {
            this.createDate = this.updateDate;
        }
    }

    /**
     * 更新之前执行方法，需要手动调用
     */
    public void preUpdate() {
        this.updateBy = UserUtils.getCurrentUser().getId();
        this.updateDate = new Date();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Integer createBy) {
        this.createBy = createBy;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    public Date getCreateDate() {
        return createDate;
    }
    
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(Integer updateBy) {
        this.updateBy = updateBy;
    }

    public String getUpdateName() {
        return updateName;
    }

    public void setUpdateName(String updateName) {
        this.updateName = updateName;
    }
    
    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }

    /**
     * 删除标记（0：正常；1：删除；2：审核；）
     */
    public static final int DEL_FLAG_NORMAL = 0;

    public static final int DEL_FLAG_DELETE = 1;

    public static final int DEL_FLAG_AUDIT = 2;
}
