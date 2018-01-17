package com.govmade.zhdata.module.sys.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseController;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Controller
@RequestMapping(value = "settings/company")
public class CompanyController extends BaseController<Company>{

    @Autowired
    private CompanyService companyService;

    @Autowired
   // private SiteService siteService;

    @RequestMapping(method = RequestMethod.GET)
    public String toCompany() {
        return "modules/settings/companyIndex";
    }

    /**
     * 
     * 部门基本信息-查询部门列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "allist", method = RequestMethod.GET)
    public ResponseEntity<Page<Company>> list(Page<Company> page) {
        try {
            
            PageInfo<Company> pageInfo = companyService.findAll(page);
            List<Company> companyList = pageInfo.getList();
            Page<Company> resPage = new Page<Company>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(companyList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 机构管理-查询部门-树结构数据
     * 
     * @param company
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<List<Company>> list(Company company) {
        try {
            List<Company> comList=this.companyService.queryAllList(company);
            return ResponseEntity.ok(comList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 新增部门
     * 
     * @param company
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Company company){
        try {
            if (null == company.getId()) {
                company.preInsert();
                this.companyService.saveSelective(company);
            } else {
                company.preUpdate();
                this.companyService.updateSelective(company);
            }
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    
    /**
     * 删除部门
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids){
        try {
            String[] array = StringUtil.split(ids, ',');
              List<String> idList = new ArrayList<String>(Arrays.asList(array));
              List<String> list=Lists.newArrayList();
              for (int i = 0; i < array.length; i++) {
                  findAllSubNode(Integer.valueOf(array[i]), list);
              }
              idList.addAll(list);
              
            //this.companyService.deleteByIds(ids);
            this.companyService.deleteByIds(idList);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
           // throw new Exception(Global.DELETE_ERROR);
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    
    
    /**
     * 根据父级查询子级
     * 
     * @param parentId
     * @param list
     */
    private void findAllSubNode(Integer parentId,List<String> list){
        Company record =new Company();
        record.setParentId(Integer.valueOf(parentId));
        List<Company> companies=this.companyService.queryListByWhere(record);
        if (companies!=null) {
          //  List<Menu> menus=this.menuService.queryListByWhere(record);
            for (Company c : companies) {
                list.add(c.getId().toString());
                 findAllSubNode(c.getId(),list);
            }
        }
    }

    @Override
    protected void getFileName() {
        super.chTableName = "机构管理";
        super.chTableName = "机构管理";
        super.templatFile = "jgTemplate.xlsx";
    }

    @Override
    protected void getReadExcelStarLine() {
        super.commitRow = 500;
        super.startRow = 3;
        super.columnIndex = 1;
    }


    @Override
    protected BaseService<Company> getService() {
        return companyService;
    }

    @Override
    protected List<Map<String, Object>> queryDataForExp(Page<Company> page) {
        Company company = new Company();
        company.setTypes("1,2");
        List<Company> comList=this.companyService.queryAllList(company);
//        List<Company> company = companyService.queryForExport();
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for (Company data : comList) {
            infoList.add(MapUtil.beansToMap(data));
        }
        return infoList;
    }
    
}
