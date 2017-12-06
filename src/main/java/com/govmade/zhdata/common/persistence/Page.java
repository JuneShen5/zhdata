package com.govmade.zhdata.common.persistence;

import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;

public class Page<T> {

    private Boolean isPage = true;

    private Integer pageNum = 1;// 页码，默认是第一页

    private Integer pageSize = 10;// 每页显示的记录数，默认是10

    private Integer startRow;

    private Integer endRow;

    private Map<String, Object> params = Maps.newHashMap();

    private String obj;
    
    private String startDate;
    
    private String endDate;

    private String queryParams;

    private String tableName;

    private Long total;// 总记录数

    private List<T> rows;// 对应的当前页记录

    public Page() {

    }

    public Boolean getIsPage() {
        return isPage;
    }

    public void setIsPage(Boolean isPage) {
        this.isPage = isPage;
    }
    
    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getStartRow() {
        return startRow;
    }

    public void setStartRow(Integer startRow) {
        this.startRow = startRow;
    }

    public Integer getEndRow() {
        return endRow;
    }

    public void setEndRow(Integer endRow) {
        this.endRow = endRow;
    }

    public String getObj() {
        return obj;
    }

    public void setObj(String obj) {
        this.obj = obj;
    }

    
    public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getQueryParams() {
        return queryParams;
    }

    public void setQueryParams(String queryParams) {
        this.queryParams = queryParams;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    public Map<String, Object> getParams() {
        return params;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }

    public void startPage() {
        this.startRow = pageNum > 0 ? (pageNum - 1) * pageSize : 0;
        this.endRow =  pageSize;
    }
}
