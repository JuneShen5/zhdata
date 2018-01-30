package com.govmade.zhdata.common.utils;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.github.abel533.entity.Example;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.RedisService;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.drs.service.InfoSortService;
import com.govmade.zhdata.module.drs.service.InformationService;
import com.govmade.zhdata.module.drs.service.YjSystemService;
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

   /* @Autowired
    private SystemService systemService;*/
    
    @Autowired
    private YjSystemService yjSystemService;
    
    @Autowired
    private ElementService elementService;
    
    @Autowired
    private InfoSortService infosortservice;
    
    @Autowired
    private InformationService informationService;

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
        sysUtils.yjSystemService = this.yjSystemService;
        sysUtils.infosortservice = this.infosortservice;
        sysUtils.elementService = this.elementService;
        sysUtils.informationService = this.informationService;

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
        Example example =new Example(Company.class);
        example.createCriteria().andNotBetween("type", 1, 2);
        companyList = sysUtils.companyService.queryByExample(example);
        
       // companyList = sysUtils.companyService.queryAll(new Company());
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
    public static Company getCompany(Company company){
        return sysUtils.companyService.queryOne(company);
    }
    
    
    public static String queryCompanyName() {
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        Company company = sysUtils.companyService.queryById(companyId);
        return company.getName();
    }
    
    
    public static String queryRoleName() {
        Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Role role = sysUtils.roleService.queryById(roleId);
        return role.getName();
    }
    
    public static String getRoleName(Integer id){
        return sysUtils.roleService.queryById(id).getName();
    }
    
    public static Role getRole(Role role){
        return sysUtils.roleService.queryOne(role);
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

    public static String getSiteName(Integer id){
        return sysUtils.siteService.queryById(id).getName();
    }
    
    public static Site getSite(Site site){
        return sysUtils.siteService.queryOne(site);
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
    public static List<Dict> getDictList() {
        List<Dict> dictList = Lists.newArrayList();
        dictList = sysUtils.dictService.queryAll(new Dict());
        return dictList;
    }
    
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
    
    public static String getMenuName(Integer id){
        return sysUtils.menuService.queryById(id).getName();
    }
    
    public static Menu getMenu(Menu menu){
        return sysUtils.menuService.queryOne(menu);
    }

    /**
     * 获得系统列表
     * 
     * @return
     */
    public static List<YjSystems> getSysList() {
        List<YjSystems> sysList = Lists.newArrayList();
        sysList = sysUtils.yjSystemService.queryAll(new YjSystems());
        return sysList;
    }
    public static String getSysName(Integer id){
        return sysUtils.yjSystemService.queryById(id).getName();
    }
    
    public static YjSystems getSys(YjSystems yjSystems){
        return sysUtils.yjSystemService.queryOne(yjSystems);
    }
    
    /**
     * 获得信息资源列表
     * 
     * @return
     */
    public static List<Information> getInfoList() {
        List<Information> infoList = Lists.newArrayList();
        infoList = sysUtils.informationService.queryAll(new Information());
        return infoList;
    }

    /**
     * 查询所有信息项（这边建议后期做缓存）
     * @return
     */
    public static List<Element> getElementList() {
        List<Element> elementList = Lists.newArrayList();
        elementList = sysUtils.elementService.queryAll(new Element());
        return elementList;
    }
}
