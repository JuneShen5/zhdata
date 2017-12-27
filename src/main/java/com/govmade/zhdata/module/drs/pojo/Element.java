package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_element")
public class Element extends BasePo<Element> {

    private static final long serialVersionUID = 1L;

    @Transient
    private String idCode;


    private String nameCn; // 中文名字

    private String nameEn; // 英文名字
    
    private String code; // 信息项编码
    
    private String des; // 信息项描述说明
    
    private Integer dataType;

    private String dataTypen;// 数据类型英文名
    
    private String len;// 输入长度

    @Transient
    private String dataTypeName;// 数据类型

    private String label;// 标签


    private Integer sort;

    private Integer companyId;

    @Transient
    private String companyName;
    
    @Transient
    private Integer toPool; //导入数据元池
    
    @Transient
    private Integer count;  
    
    @Transient
    private Integer colId;
    
    private Integer objectType;
    
    private Integer dataLabel;
    
    private Integer isDict;
    
    private Integer shareType;
    
    private Integer shareCondition;
    
    private Integer shareMode;
    
    private Integer isOpen;
    
    private Integer openType;
    
    private Integer updateCycle;

    public Integer getObjectType() {
		return objectType;
	}

	public void setObjectType(Integer objectType) {
		this.objectType = objectType;
	}

	public Integer getDataLabel() {
		return dataLabel;
	}

	public void setDataLabel(Integer dataLabel) {
		this.dataLabel = dataLabel;
	}

	public Integer getIsDict() {
		return isDict;
	}

	public void setIsDict(Integer isDict) {
		this.isDict = isDict;
	}

	public Integer getShareType() {
		return shareType;
	}

	public void setShareType(Integer shareType) {
		this.shareType = shareType;
	}

	public Integer getShareCondition() {
		return shareCondition;
	}

	public void setShareCondition(Integer shareCondition) {
		this.shareCondition = shareCondition;
	}

	public Integer getShareMode() {
		return shareMode;
	}

	public void setShareMode(Integer shareMode) {
		this.shareMode = shareMode;
	}

	public Integer getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(Integer isOpen) {
		this.isOpen = isOpen;
	}

	public Integer getOpenType() {
		return openType;
	}

	public void setOpenType(Integer openType) {
		this.openType = openType;
	}

	public Integer getUpdateCycle() {
		return updateCycle;
	}

	public void setUpdateCycle(Integer updateCycle) {
		this.updateCycle = updateCycle;
	}

	public String getIdCode() {
        return idCode;
    }

    public void setIdCode(String idCode) {
        this.idCode = idCode;
    }


    public String getNameCn() {
        return nameCn;
    }

    public void setNameCn(String nameCn) {
        this.nameCn = nameCn;
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn;
    }

    public Integer getDataType() {
        return dataType;
    }

    public void setDataType(Integer dataType) {
        this.dataType = dataType;
    }

    public String getLen() {
        return len;
    }

    public void setLen(String len) {
        this.len = len;
    }

   /* public String getDataTypeName() {
    	return EhcacheUtil.getDictTypeName("data_type", this.getDataType().toString());
    }*/

    public void setDataTypeName(String dataTypeName) {
        this.dataTypeName = dataTypeName;
    }
    
    

    public String getDataTypeName() {
        return dataTypeName;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
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

    public Integer getToPool() {
        return toPool;
    }

    public void setToPool(Integer toPool) {
        this.toPool = toPool;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

	public Integer getColId() {
		return colId;
	}

	public void setColId(Integer colId) {
		this.colId = colId;
	}

	public String getDataTypen() {
		return dataTypen;
	}

	public void setDataTypen(String dataTypen) {
		this.dataTypen = dataTypen;
	}

    @Override
    public String toString() {
        return "Element [idCode=" + idCode + ", nameCn=" + nameCn + ", nameEn=" + nameEn + ", code=" + code
                + ", des=" + des + ", dataType=" + dataType + ", dataTypen=" + dataTypen + ", len=" + len
                + ", dataTypeName=" + dataTypeName + ", label=" + label + ", sort=" + sort + ", companyId="
                + companyId + ", companyName=" + companyName + ", toPool=" + toPool + ", count=" + count
                + ", colId=" + colId + ", objectType=" + objectType + ", dataLabel=" + dataLabel
                + ", isDict=" + isDict + ", shareType=" + shareType + ", shareCondition=" + shareCondition
                + ", shareMode=" + shareMode + ", isOpen=" + isOpen + ", openType=" + openType
                + ", updateCycle=" + updateCycle + "]";
    }
    
    

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

	
    
   

    
    
}
