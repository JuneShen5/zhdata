package com.govmade.zhdata.module.sys.web;

import java.util.ArrayList;
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
import com.govmade.zhdata.common.utils.excel.ExportExcel;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelData;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.Site;
import com.govmade.zhdata.module.sys.service.CompanyService;
import com.govmade.zhdata.module.sys.service.SiteService;

@Controller
@RequestMapping(value = "settings/company")
public class CompanyController {

    @Autowired
    private CompanyService companyService;

    @Autowired
    private SiteService siteService;

    @RequestMapping(method = RequestMethod.GET)
    public String toCompany() {
        return "modules/settings/companyIndex";
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Company>> list(Page<Company> page) {
        try {
            PageInfo<Company> pageInfo = companyService.findAll(page);
            List<Company> companyList = pageInfo.getList();
            /*if (companyList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            Page<Company> resPage = new Page<Company>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(companyList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Company company) throws Exception {
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
            throw new Exception(Global.HANDLE_ERROR);
        }

    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            companyService.deleteByIds(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_SUCCESS);
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
     * 导出机构数据
     * 
     * @param response
     * @return
     */
    @RequestMapping(value = "export", method = RequestMethod.POST)
    public ResponseEntity<String> exportFile(HttpServletResponse response) {
        // Map<String, Object> conditionMap = null; 根据返回的中文 查询nameCn nameEn
        List<Company> companies = null;
        ExportExcel exportData = null; // 工具类

        // 配置信息
        String fileName = ExcelConstant.COMP_TITLE + DateUtils.getDate("yyyyMMddHHmmss");
        String title = ExcelConstant.COMP_TITLE;
        String[] rowName = ExcelConstant.COMP_ROWNAME;

        // 查询条件
        companies = companyService.queryAll(new Company());
        List<Object[]> dataList = new ArrayList<Object[]>();
        Object[] objs = null;
        for (int i = 0; i < companies.size(); i++) {
            Company company = companies.get(i);
            Site site = siteService.queryById(company.getSiteId());
            objs = new Object[rowName.length];
            objs[0] = i;
            objs[1] = site.getName();
            /*objs[2] = company.getNumber();*/
            objs[3] = company.getName();
            objs[4] = company.getCode();
            objs[5] = company.getAddress();
            objs[6] = company.getRemarks();
            dataList.add(objs);
        }

//        exportData = new ExportExcel(fileName, title, rowName, dataList, response);
        String msg = "";
        try {
            exportData.export();
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
    
    /**
     * 导出数据模板
     * @param id 
     * @param name 文件中文名
     * @param request
     * @param response
     */
    @RequestMapping(value = "downloadTemplate", method = RequestMethod.POST)
    public void downloadTemplate(Page<Company> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="部门管理模板";
            String enTableName ="部门管理模板";
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
            ExportExcelTemplate exportExcel = new ExportExcelTemplate(chTableName,enTableName,rowName,infoList,response);
           exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    
    //导入数据
    @RequestMapping(value ="importData" , method = RequestMethod.POST)
    public ResponseEntity<String> importData(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,String code) {
        try {
            ImportExcelData importExcel = new ImportExcelData(file,0,0);
            Map<String, String> titleAndAttribute = new HashMap<String, String>();
            List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
            List<Map<String, String>> resolurdDtaList = new ArrayList<Map<String,String>>();
            boolean is = true;
            int commitRow = 500; //读取多少返回一次
            int startRow = 3;  //开始读取的行
            String salt=CipherUtil.createSalt();
            while(is){
                dataList = importExcel.uploadAndRead(titleAndAttribute,startRow,commitRow);
                startRow = startRow+commitRow;
                if(dataList.size()!=0){
                    for(Map<String, String> map :dataList){
                        Map<String, String> dataMap = new HashMap<String, String>();
                        for (String k : map.keySet())
                        {
                           String _k = StringUtil.toUnderScoreCase(k);
                           dataMap.put(_k, map.get(k));
                        }
                        resolurdDtaList.add(dataMap);
                    }
                    
                    this.companyService.saveAll(resolurdDtaList); 
                }
                if(dataList.size()<commitRow || dataList.size()==0){
                    is=false; 
                }
            }
            return ResponseEntity.ok(Global.IMPORT_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Global.IMPORT_ERROR);
    }
    
    /**
     * 读取Excel中的用户信息插入数据库
     * @param multipart
     * @param session
     * @return
     */
    /*@RequestMapping(value="import", method = RequestMethod.POST)
    public ResponseEntity<String> importFile(MultipartFile file){
        //定义对应的标题名与对应属性名
        Map<String, String> ta=ExcelConstant.getCoTA();
        
        StringBuilder failureMsg = new StringBuilder();
        try {
        	int successNum = 0;
			int failureNum = 0;
        	 //调用解析工具包
        	ImportExcel testExcel=new ImportExcel(file, 0, 0);
            //解析excel，获取客户信息集合
        	List<Map<String, String>> maps= testExcel.uploadAndRead(ta);
            if(maps != null && !"[]".equals(maps.toString()) && maps.size()>=1){
                
                for (Map<String, String> map : maps) {
                	
                	
                	 * 查询对应的班子
                	 
                	Site site =new Site();
                	site.setName(map.get(ta.get(ExcelConstant.COMP_SITENAME_TITEL)).trim());
                	site=siteService.queryOne(site);
                	Company company=new Company(site.getId(), map.get(ExcelConstant.COMP_NUMBER_AT), map.get(ExcelConstant.COMP_NAME_AT), map.get(ExcelConstant.COMP_CODE_AT), map.get(ExcelConstant.COMP_ADDRESS_AT),map.get(ExcelConstant.REMARKS_AT));
                	company.preInsert();
                	if (this.companyService.saveSelective(company) > 0) {
                		successNum++;
                	}else {
                		failureNum++;
                		failureMsg.append("<br/>名称 " + company.getName() + " 导入失败！");
					}
				}
                if (successNum==maps.size()) {
                	failureMsg.append("批量导入EXCEL成功！");
				}else {
					failureMsg.append("<br/>导入成功："+successNum+"条数据。<br/>导入失败："+failureNum+"条数据。");
				}
            }else{
            	failureMsg.append("批量导入EXCEL失败！");
            }
        } catch (Exception e) {
        	failureMsg.append("读取Excel文件错误！");
        	e.printStackTrace();
        }
        return ResponseEntity.ok(failureMsg.toString());
    }*/
}
