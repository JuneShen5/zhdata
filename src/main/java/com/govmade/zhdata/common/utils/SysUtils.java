package com.govmade.zhdata.common.utils;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.RedisService;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.Systems;
import com.govmade.zhdata.module.drs.service.InfoSortService;
import com.govmade.zhdata.module.drs.service.SystemService;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.Dict;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.pojo.Role;
import com.govmade.zhdata.module.sys.pojo.Site;
import com.govmade.zhdata.module.sys.service.CompanyService;
import com.govmade.zhdata.module.sys.service.DictService;
import com.govmade.zhdata.module.sys.service.MenuService;
import com.govmade.zhdata.module.sys.service.RoleService;
import com.govmade.zhdata.module.sys.service.SiteService;

@Component
public class SysUtils {

    @Autowired
    private RoleService roleService;

    @Autowired
    private CompanyService companyService;

    @Autowired
    private SiteService siteService;

    @Autowired
    private RedisService redisService;

    @Autowired
    private DictService dictService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private SystemService systemService;

    
    @Autowired
    private InfoSortService infosortservice;

    private static SysUtils sysUtils;

    /**
     * 初始化注解
     */
    @PostConstruct
    public void init() {
        sysUtils = this;
        sysUtils.roleService = this.roleService;
        sysUtils.companyService = this.companyService;
        sysUtils.siteService = this.siteService;
        sysUtils.dictService = this.dictService;
        sysUtils.redisService = this.redisService;
        sysUtils.menuService = this.menuService;
        sysUtils.systemService = this.systemService;
        sysUtils.infosortservice = this.infosortservice;

    }

    /**
     * 获取通用对象列表
     * 
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static List getList(String type) {
        List list = Lists.newArrayList();
        if (!StringUtil.isEmpty(type)) {
            switch (type.trim().toLowerCase()) {
            case "company":
                list = SysUtils.getCompanyList();
                break;
            case "site":
                list = SysUtils.getSiteList();
                break;
            case "role":
                list = SysUtils.getRoleList();
                break;
            case "menu":
                list = SysUtils.getMenuList();
                break;
            case "sys":
                list = SysUtils.getSysList();
                break;
            default:
                break;
            }
        }
        return list;
    }

    /**
     * 获得角色列表
     * 
     * @return
     */
    public static List<Role> getRoleList() {
        List<Role> roleList = Lists.newArrayList();
        roleList = sysUtils.roleService.queryAll(new Role());
        return roleList;
    }

    /**
     * 获得公司列表
     * 
     * @return
     */
    public static List<Company> getCompanyList() {
        List<Company> companyList = Lists.newArrayList();
        companyList = sysUtils.companyService.queryAll(new Company());
        return companyList;
    }
    
    
    /**
     * 获得公司列表
     * 
     * @return
     */
    public static String getCompanyName(Integer id) {
        Company company = sysUtils.companyService.queryById(id);
        return company.getName();
    }
    
    public static String queryCompanyName() {
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        Company company = sysUtils.companyService.queryById(companyId);
        System.out.println("companyId====="+companyId);
        System.out.println("companyName===="+company.getName());
        return company.getName();
    }
    
    
    public static String queryRoleName() {
        Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Role role = sysUtils.roleService.queryById(roleId);
        return role.getName();
    }

    /**
     * 获得班子列表
     * 
     * @return
     */
    public static List<Site> getSiteList() {
        List<Site> siteList = Lists.newArrayList();
        siteList = sysUtils.siteService.queryAll(new Site());
        return siteList;
    }

    /**
     * 获得信息资源分类列表
     * 
     * @return
     */
    public static List<InfoSort> getInfoSortList() {
        List<InfoSort> infosorList = Lists.newArrayList();
        infosorList =  sysUtils.infosortservice.findAll();
        return infosorList;
    }
    
    
    /**
     * 根据父级ID查询信息资源分类目录
     * 
     * @param parentId
     * @return
     */
    public static List<InfoSort> getInfoSortByParentId(Integer parentId) {
        List<InfoSort> infosorList = Lists.newArrayList();
        infosorList =  sysUtils.infosortservice.queryInfoSortByParentId(parentId);
        return infosorList;
    }
    
    
    /**
     * 获得字典列表
     * 
     * @return
     */
    public static List<Dict> getDictList(String type) {
        List<Dict> dictList = Lists.newArrayList();
        dictList = sysUtils.dictService.queryAll(new Dict(type));
        return dictList;
    }

    /**
     * 获得菜单列表
     * 
     * @return
     */
    public static List<Menu> getMenuList() {
        List<Menu> menuList = Lists.newArrayList();
        menuList = sysUtils.menuService.findAll(new Menu());
        return menuList;
    }

    /**
     * 获得系统列表
     * 
     * @return
     */
    public static List<Systems> getSysList() {
        List<Systems> sysList = Lists.newArrayList();
        sysList = sysUtils.systemService.queryAll(new Systems());
        return sysList;
    }


}
