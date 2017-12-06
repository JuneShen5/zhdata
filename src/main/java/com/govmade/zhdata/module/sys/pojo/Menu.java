package com.govmade.zhdata.module.sys.pojo;

import java.util.List;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "sys_menu")
public class Menu extends BasePo<Menu> {

    private static final long serialVersionUID = 1L;

    private Integer parentId; // 父级菜单

    private String parentIds; // 所有父级编号

    private String name; // 名称

    private Integer sort; // 排序

    private String href; // 链接

    private String target; // 目标（ mainFrame、_blank、_self、_parent、_top）

    private String image; // 图标

    private Integer isShow; // 是否在菜单中显示（1：显示；0：不显示）

    private String permission; // 权限标识
    
    @Transient
    private String parentName;

    @Transient
    private List<Menu> children;

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getParentIds() {
        return parentIds;
    }

    public void setParentIds(String parentIds) {
        this.parentIds = parentIds;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }


    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Integer getIsShow() {
        return isShow;
    }

    public void setIsShow(Integer isShow) {
        this.isShow = isShow;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }
    
    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
    
    

}