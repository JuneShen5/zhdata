package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_columns")
public class Code extends BasePo<Code> {

    private static final long serialVersionUID = 1L;

    private String nameEn;

    private String nameCn;

    private Integer tbId;
    
    @Transient
    private String  tbName; //数据表名

    private Integer type; //类型的代替值
    
    @Transient
    private String  typeEn; //真实的类型名

    private Integer length;

    private Integer isKey;
    
    private Integer delFlag;
    
    private Integer toElement;
    
    private Integer eleId;

    public Code() {
        super();
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

    public Integer getTbId() {
        return tbId;
    }

    public void setTbId(Integer tbId) {
        this.tbId = tbId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public Integer getIsKey() {
        return isKey;
    }

    public void setIsKey(Integer isKey) {
        this.isKey = isKey;
    }

    public String getTypeEn() {
        return typeEn;
    }

    public void setTypeEn(String typeEn) {
        this.typeEn = typeEn;
    }

    public String getTbName() {
        return tbName;
    }

    public void setTbName(String tbName) {
        this.tbName = tbName;
    }

    public Integer getToElement() {
        return toElement;
    }

    public void setToElement(Integer toElement) {
        this.toElement = toElement;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }

	public Integer getEleId() {
		return eleId;
	}

	public void setEleId(Integer eleId) {
		this.eleId = eleId;
	}

    
}
