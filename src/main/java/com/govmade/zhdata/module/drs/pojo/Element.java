package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_element")
public class Element extends BasePo<Element> {

    private static final long serialVersionUID = 1L;
    
    private String nameCn; // 中文名字

    private Integer companyId;
    
    private Integer infoId;
    
    private Integer itemId;
  
    @Transient
    private String companyName;
    
    @Transient
    private String idCode;
    
    @Transient
    private String dataTypeName;// 数据类型
    
    @Transient
    private Integer toPool; //导入数据元池
    
    @Transient
    private Integer count;  
    
    @Transient
    private Integer colId;
    
   


    public String getNameCn() {
		return nameCn;
	}



	public void setNameCn(String nameCn) {
		this.nameCn = nameCn;
	}



	public Integer getCompanyId() {
		return companyId;
	}



	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}



	public Integer getInfoId() {
		return infoId;
	}



	public void setInfoId(Integer infoId) {
		this.infoId = infoId;
	}



	public Integer getItemId() {
		return itemId;
	}



	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}



	public String getCompanyName() {
		return companyName;
	}



	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}



	public String getIdCode() {
		return idCode;
	}



	public void setIdCode(String idCode) {
		this.idCode = idCode;
	}



	public String getDataTypeName() {
		return dataTypeName;
	}



	public void setDataTypeName(String dataTypeName) {
		this.dataTypeName = dataTypeName;
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



	@Override
    public String toString() {
        return "Element [idCode=" + idCode + ", nameCn=" + nameCn 
                + ", dataTypeName=" + dataTypeName + ", companyId="
                + companyId + ", companyName=" + companyName + ", toPool=" + toPool + ", count=" + count
                + ", colId=" + colId + ", infoId=" + infoId + ", itemId=" + itemId
                 + "]";
    }



	public Element() {
		super();
		// TODO Auto-generated constructor stub
	}
    
    
	
    
   

    
    
}
