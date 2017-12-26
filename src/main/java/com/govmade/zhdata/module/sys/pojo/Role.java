package com.govmade.zhdata.module.sys.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_role")
public class Role extends BasePo<Role> {
    private static final long serialVersionUID = 1L;

    private Integer companyId;

    @Transient
    private String companyName;

    private String name;

    private String enname;

    private Integer useable;

    @Transient
    private String menuIds;

    @Transient
    private List<Menu> menuList = Lists.newArrayList(); // 拥有菜单列表

    public Role() {
        super();
    }

    
    
    public Role(Integer companyId, String name, String enname, Integer useable,
			List<Menu> menuList,String remarks) {
		super();
		this.companyId = companyId;
		this.name = name;
		this.enname = enname;
		this.useable = useable;
		this.menuList = menuList;
		this.remarks=remarks;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEnname() {
        return enname;
    }

    public void setEnname(String enname) {
        this.enname = enname;
    }

    public Integer getUseable() {
        return useable;
    }

    public void setUseable(Integer useable) {
        this.useable = useable;
    }

    public String getMenuIds() {
        return menuIds;
    }

    public void setMenuIds(String menuIds) {
        this.menuIds = menuIds;
    }
    
    public List<Menu> getMenuList() {
        return menuList;
    }

    public void setMenuList(List<Menu> menuList) {
        this.menuList = menuList;
    }



    @Override
    public String toString() {
        return "Role [companyId=" + companyId + ", companyName=" + companyName + ", name=" + name
                + ", enname=" + enname + ", useable=" + useable + ", menuIds=" + menuIds + ", menuList="
                + menuList + "]";
    }
    

}
