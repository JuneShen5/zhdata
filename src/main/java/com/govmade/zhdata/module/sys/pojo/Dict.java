package com.govmade.zhdata.module.sys.pojo;

import javax.persistence.Table;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_dict")
public class Dict extends BasePo<Dict> {

    private static final long serialVersionUID = 1L;
    
    private String pid;

	private String value;

    private String label;

    private String type;

    private Integer sort;
    

    public Dict() {
        super();
    }

    public Dict(String type) {
        super();
        this.type = type;
    }
    
    
    public Dict(String value, String label, String type, Integer sort,String remarks) {
		super();
		this.value = value;
		this.label = label;
		this.type = type;
		this.sort = sort;
		this.remarks=remarks;
	}

    public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}
    
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

}
