package com.govmade.zhdata.module.sys.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.ExcelConstant;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.CipherUtil;
import com.govmade.zhdata.common.utils.DateUtils;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Controller
@RequestMapping(value = "settings/company")
public class CompanyController {

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
     * 查询部门列表
     * 
     * @param page
     * @return
     */
    /*@RequestMapping(value = "list", method = RequestMethod.GET)
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
    }*/
    
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
    
    
    /**
     * 下载导入机构数据模板
     * 
     * @return
     */
    @RequestMapping(value = "import/template", method = RequestMethod.GET)
    public ResponseEntity<String> importFileTemplate(HttpServletResponse response) {

        // 配置信息
        String fileName = ExcelConstant.COMP_FILENAME_TEM;
        String title = ExcelConstant.COMP_TITLE;
        String[] rowName = ExcelConstant.COMP_ROWNAME;
        List<Object[]> dataList = new ArrayList<Object[]>();
//        ExportExcel importTemp = new ExportExcel(fileName, title, rowName, dataList, response);
        String msg = "";
        try {
//            importTemp.export();
        } catch (Exception e) {
            msg = "导出用户失败！失败信息：" + e.getMessage();
            e.printStackTrace();
        }
        return ResponseEntity.ok(msg);
    }

    
    /**
     * 导出数据
     * @param page
     * @param request
     * @param response
     */
    @RequestMapping(value = "exportData", method = RequestMethod.POST)
    public void exportData(Page<Company> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        String [] rowName =  page.getObj().split(",");; //头部
        
        page.setObj("{\"name\":\"\"}"); //查询的时候有用所以这样整了一下
        PageInfo<Company> pageInfo = companyService.findAll(page);
        List<Company> companyList = pageInfo.getList();
        
//        List<Systems> sList=this.systemService.queryList(page);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for(Company company:companyList){
            infoList.add(MapUtil.beanToMap(company));
        }
        
        //获取实体数据
        try {
            String chTableName ="部门管理";
            String enTableName ="部门管理";
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
            ExportExcelData exportExcel = new ExportExcelData(chTableName,enTableName,rowName,infoList,response);
           exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    
    
}
