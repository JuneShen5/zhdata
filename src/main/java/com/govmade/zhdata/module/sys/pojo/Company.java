package com.govmade.zhdata.module.sys.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_company")
public class Company extends BasePo<Company> {

    private static final long serialVersionUID = 1L;

    private Integer parentId; // 父级
    
    @Transient
    private String parentName; // 父级名称

    private String name; // 名称

    private String code; // 部门编码
    
    private String creditCode;
    
    private String ldxm;
    
    private String ldlxfs;
    
    private String fzrxm;
    
    private String fzrlxfs;
    
    private Integer nsjg1;
    
    private Integer nsjg2;
    
    private Integer rybzqk1;
    
    private Integer rybzqk2;
    
    private Integer rybzqk3;
    
    private Integer rybzqk4;
    
    private Integer ryjszc1;
    
    private Integer ryjszc2;
    
    private Integer ryjszc3;
    
    private Integer ryjszc4;
    
    private Integer ryjszc5;
    
    private Integer ryjszc6;

    private String address; // 地址

    private Integer sort; // 排序

    private Integer type; // 机构类型

    private Integer level; //级别
    
    private Double total2013; //年度总指标金额（万元）
    
    private Double total2014;
    
    private Double total2015;
    
    private Double total2016;
    
    private Double total2017;
    
    @Transient
    private String types; //类型

    @Transient
    private Integer count;
    
    /*树形结构要用*/  
    @Transient
    private Company parent;
    
    @Transient
    private boolean isLeaf;
    
    @Transient
    private int rootId;
    
    @Transient
    private int childSize;
    
    @Transient
    private List<Company> children= Lists.newArrayList();

    public Company() {
        super();
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getTypes() {
        return types;
    }

    public void setTypes(String types) {
        this.types = types;
    }

    
    
    public Company getParent() {
        return parent;
    }

    public void setParent(Company parent) {
        this.parent = parent;
    }

    public boolean isLeaf() {
        return isLeaf;
    }

    public void setLeaf(boolean isLeaf) {
        this.isLeaf = isLeaf;
    }

    public int getRootId() {
        return rootId;
    }

    public void setRootId(int rootId) {
        this.rootId = rootId;
    }

    public int getChildSize() {
        return childSize;
    }

    public void setChildSize(int childSize) {
        this.childSize = childSize;
    }

    
    public List<Company> getChildren() {
        return children;
    }

    public void setChildren(List<Company> children) {
        this.children = children;
    }
    

    public String getCreditCode() {
		return creditCode;
	}

	public void setCreditCode(String creditCode) {
		this.creditCode = creditCode;
	}

	public String getLdxm() {
		return ldxm;
	}

	public void setLdxm(String ldxm) {
		this.ldxm = ldxm;
	}

	public String getLdlxfs() {
		return ldlxfs;
	}

	public void setLdlxfs(String ldlxfs) {
		this.ldlxfs = ldlxfs;
	}

	public String getFzrxm() {
		return fzrxm;
	}

	public void setFzrxm(String fzrxm) {
		this.fzrxm = fzrxm;
	}

	public String getFzrlxfs() {
		return fzrlxfs;
	}

	public void setFzrlxfs(String fzrlxfs) {
		this.fzrlxfs = fzrlxfs;
	}

	public Integer getNsjg1() {
		return nsjg1;
	}

	public void setNsjg1(Integer nsjg1) {
		this.nsjg1 = nsjg1;
	}

	public Integer getNsjg2() {
		return nsjg2;
	}

	public void setNsjg2(Integer nsjg2) {
		this.nsjg2 = nsjg2;
	}

	public Integer getRybzqk1() {
		return rybzqk1;
	}

	public void setRybzqk1(Integer rybzqk1) {
		this.rybzqk1 = rybzqk1;
	}

	public Integer getRybzqk2() {
		return rybzqk2;
	}

	public void setRybzqk2(Integer rybzqk2) {
		this.rybzqk2 = rybzqk2;
	}

	public Integer getRybzqk3() {
		return rybzqk3;
	}

	public void setRybzqk3(Integer rybzqk3) {
		this.rybzqk3 = rybzqk3;
	}

	public Integer getRybzqk4() {
		return rybzqk4;
	}

	public void setRybzqk4(Integer rybzqk4) {
		this.rybzqk4 = rybzqk4;
	}

	public Integer getRyjszc1() {
		return ryjszc1;
	}

	public void setRyjszc1(Integer ryjszc1) {
		this.ryjszc1 = ryjszc1;
	}

	public Integer getRyjszc2() {
		return ryjszc2;
	}

	public void setRyjszc2(Integer ryjszc2) {
		this.ryjszc2 = ryjszc2;
	}

	public Integer getRyjszc3() {
		return ryjszc3;
	}

	public void setRyjszc3(Integer ryjszc3) {
		this.ryjszc3 = ryjszc3;
	}

	public Integer getRyjszc4() {
		return ryjszc4;
	}

	public void setRyjszc4(Integer ryjszc4) {
		this.ryjszc4 = ryjszc4;
	}

	public Integer getRyjszc5() {
		return ryjszc5;
	}

	public void setRyjszc5(Integer ryjszc5) {
		this.ryjszc5 = ryjszc5;
	}

	public Integer getRyjszc6() {
		return ryjszc6;
	}

	public void setRyjszc6(Integer ryjszc6) {
		this.ryjszc6 = ryjszc6;
	}
    
	
	public Double getTotal2013() {
		return total2013;
	}

	public void setTotal2013(Double total2013) {
		this.total2013 = total2013;
	}

	public Double getTotal2014() {
		return total2014;
	}

	public void setTotal2014(Double total2014) {
		this.total2014 = total2014;
	}

	public Double getTotal2015() {
		return total2015;
	}

	public void setTotal2015(Double total2015) {
		this.total2015 = total2015;
	}

	public Double getTotal2016() {
		return total2016;
	}

	public void setTotal2016(Double total2016) {
		this.total2016 = total2016;
	}

	public Double getTotal2017() {
		return total2017;
	}

	public void setTotal2017(Double total2017) {
		this.total2017 = total2017;
	}

	@Override
    public String toString() {
        return "Company [parentId=" + parentId + ", parentName=" + parentName + ", name=" + name + ", code="
                + code + ", address=" + address + ", sort=" + sort + ", type=" + type + ", level=" + level
                + ", types=" + types + ", count=" + count + "]";
    }
    
    
    
    
}
