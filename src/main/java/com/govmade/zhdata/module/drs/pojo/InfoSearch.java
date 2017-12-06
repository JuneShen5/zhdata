package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;


@Table(name = "drs_info_search")
public class InfoSearch extends BasePo<InfoSearch> {
	
	private static final long serialVersionUID = 1L;
	
	private String keyword;

	@Transient
    private Integer count;
	
	
	public InfoSearch() {
		super();
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}
	
}
