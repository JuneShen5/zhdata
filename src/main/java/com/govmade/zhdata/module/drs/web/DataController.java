package com.govmade.zhdata.module.drs.web;

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

import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseEntity;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelData;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.service.DataService;
import com.govmade.zhdata.module.drs.service.InformationService;

@Controller
@RequestMapping(value = "catalogset/data")
public class DataController {

    @Autowired
    private InformationService infoService;

    @Autowired
    private DataService dataService;

    /**
     * 打开数据开放页面
     * 
     * @return
     */
    @RequestMapping(value = "toDataOpen", method = RequestMethod.GET)
    public String toSystem() {
        return "modules/catalogset/dataOpenIndex";
    }

    /**
     * 获取数据开放列表
     * 
     * @return
     */
    @RequestMapping(value = "getDataOpen", method = RequestMethod.GET)
    public ResponseEntity<List<Information>> getDataOpen() {
        Information record = new Information();
        record.setOpenType(1);
        List<Information> infoList = infoService.queryListByWhere(record);
        return ResponseEntity.ok(infoList);
    }

    
    /**
     * 获取信息资源中的数据元数据
     * 
     * @param page
     * @return
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "getdata", method = RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> getdata(Page page) {

        List<Map<String, Object>> rows = dataService.queryList(page);
        Long total = dataService.queryCount(page);

        Page<Map<String, Object>> resPage = new Page<Map<String, Object>>();

        resPage.setRows(rows);
        resPage.setTotal(total);

        return ResponseEntity.ok(resPage);
    }
    
    
    
    
    /**
     * 保存实体数据
     * @param request
     * @return 返回处理信息
     */
    @RequestMapping(value = "saveData", method = RequestMethod.POST)
    public ResponseEntity<String> saveData(HttpServletRequest request) {
        Map<String, Object> params = MapUtil.requestToMap(request);
        String tableName = params.get("tableName").toString();
        BaseEntity record = new BaseEntity();
        if(null==params.get("TONG_ID")){
            params.remove("tableName");
            params.remove("TONG_ID");
            record.setTableName(tableName);
            record.setParams(params);
            dataService.saveData(record);
        }else{
            params.remove("tableName");
            record.setTong_id(Integer.valueOf(params.get("TONG_ID").toString()));
            params.remove("TONG_ID");
            record.setTableName(tableName);
            record.setParams(params);
            dataService.updateData(record);
        }
        return ResponseEntity.ok(Global.HANDLE_SUCCESS);
    }

    /**
     * 删除实体数据
     * 
     * @param tableName
     * @param tongId
     * @return
     */
    @RequestMapping(value ="deleteData",method = RequestMethod.GET)
    public ResponseEntity<String> deleteData(HttpServletRequest request) {
        try {
            Map<String, Object> params = MapUtil.requestToMap(request);
            String tableName = params.get("tableName").toString();
            Integer tongId = Integer.valueOf(params.get("TONG_ID").toString());
            
            BaseEntity record = new BaseEntity();
            record.setTong_id(tongId);
            record.setTableName(tableName);
            
            this.dataService.deleteData(record);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Global.DELETE_ERROR);
    }


    
    // 这里是放excel的
    
    /**
     * 导出数据模板
     * @param id 
     * @param name 文件中文名
     * @param request
     * @param response
     */
    @RequestMapping(value ="exportTemplet" , method = RequestMethod.GET)
    public void exportTemplet(Integer id ,String code, String name,HttpServletRequest request,HttpServletResponse response) {
        code="data_"+code;
        String [] rowName =  getHead(id);
        /*Map<String, Object> exampleData = new HashMap<String, Object>();*/
        List<Map<String, Object>>  dataList = new ArrayList<Map<String,Object>>();

        try {
        String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
        ExportExcelTemplate exportExcel = new ExportExcelTemplate(chTableName,code,rowName,dataList,response);
            exportExcel.export();
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }
    
    /**
     * 导出实体数据
     * @param id
     * @param code 文件英文名
     * @param request
     * @param response
     */
    @RequestMapping(value ="exportData" , method = RequestMethod.GET)
    public void exportData(Integer id ,String code,String name,HttpServletRequest request,HttpServletResponse response) {
        String enTableName = code;
        String [] rowName =  getHead(id); //头部
        //获取实体数据
        Page<Map<String, Object>> resPage = new Page<Map<String, Object>>();
        resPage.setIsPage(false);
        resPage.setTableName(enTableName);
        List<Map<String, Object>> resList = dataService.queryList(resPage);
        try {
           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
           ExportExcelData exportExcel = new ExportExcelData(chTableName,enTableName,rowName,resList,response);
           exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    
    @RequestMapping(value ="importData" , method = RequestMethod.POST)
    public ResponseEntity<String> importData(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,String code) {
        try {
            ImportExcelData importExcel = new ImportExcelData(file,0,0);
            Map<String, String> titleAndAttribute = new HashMap<String, String>();
            List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
            boolean is = true;
            int commitRow = 500; //读取多少返回一次
            int startRow = 1;  //开始读取的行
            while(is){
                dataList = importExcel.uploadAndRead(titleAndAttribute,startRow,commitRow);
                startRow = startRow+commitRow;
                if(dataList.size()!=0){
                    dataService.saveAll("data_"+code, dataList); 
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
    
    //导出EXCEL时所需的头部第一行数据
    public String[] getHead(Integer id){
        List<Element> elementList = infoService.findElementById(id);
        int i = elementList.size();
        String [] rowName = new String[i]; 
        int j=0;
        for (Element e : elementList) {
            rowName[j] = e.getNameCn()+"("+e.getNameEn()+")";
            j++;
        }
        return rowName;
    }
  
}
