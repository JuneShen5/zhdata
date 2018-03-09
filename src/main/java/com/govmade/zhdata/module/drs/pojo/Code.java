package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;


import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_code")
public class Code extends BasePo<Code> {

    private static final long serialVersionUID = 1L;

    private Integer pid;
    
    private String pcode;

    private String pname;

    private Integer type;
    
    private Integer  companyId; 

    private Integer status; 
    
    private String  code; 
    
    private String  codeName;


    public Code() {
        super();
    }


	public Integer getPid() {
		return pid;
	}


	public void setPid(Integer pid) {
		this.pid = pid;
	}


	public String getPcode() {
		return pcode;
	}


	public void setPcode(String pcode) {
		this.pcode = pcode;
	}


	public String getPname() {
		return pname;
	}


	public void setPname(String pname) {
		this.pname = pname;
	}


	public Integer getType() {
		return type;
	}


	public void setType(Integer type) {
		this.type = type;
	}


	public Integer getCompanyId() {
		return companyId;
	}


	public void setCompanyId(Integer companyId) {
		this.companyId = companyId;
	}


	public Integer getStatus() {
		return status;
	}


	public void setStatus(Integer status) {
		this.status = status;
	}


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


	public String getCodeName() {
		return codeName;
	}


	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

    
    
}
