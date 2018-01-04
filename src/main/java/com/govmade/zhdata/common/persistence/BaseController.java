package com.govmade.zhdata.common.persistence;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.SpringContextUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelImpl;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelImpl;
import com.govmade.zhdata.module.drs.pojo.Attribute;
import com.govmade.zhdata.module.drs.service.AttributeService;



public abstract class BaseController<T> {

    protected String chTableName ; //文件名称
    protected String enTableName ;//sheet名称
    protected String templatFile = null ;//excel模板名
    
    protected Integer commitRow;//读取数据时事务的行数
    protected Integer startRow;//导入时开始读取数据的行
    protected Integer columnIndex; //导入时开始读取数据的列
    
    protected abstract void getFileName(); //获取导出的文件名
    
    protected abstract void getReadExcelStarLine();  //获取导出时开始读取的行列一回滚行数
    
    protected abstract BaseService<T> getService();
    /**
     * 导出数据模板
     * @param id 
     * @param name 文件中文名
     * @param request
     * @param response
     */
    @RequestMapping(value = "downloadTemplate", method = RequestMethod.POST)
    private void downloadTemplate(Page<T> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            getFileName();
            String _chTableName =chTableName+"模板";
            String _enTableName =enTableName+"模板";
            ExportExcelImpl   exportExcel = new ExportExcelTemplate(request,_chTableName,_enTableName,templatFile,rowName,infoList,response);
            exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    
    
    
   //导入数据
   @RequestMapping(value ="importData" , method = RequestMethod.POST)
   public ResponseEntity<String> importData(@RequestParam(value = "file", required = false) MultipartFile file,Integer attributeType,HttpServletRequest request,String code) {
       
       ImportExcelImpl importExcel;
       try {
           importExcel = new ImportExcelImpl(request,file,0,0);
           getReadExcelStarLine();
           getFileName();
           importExcel.uploadAndRead(startRow,columnIndex,commitRow,templatFile);
         } catch (Exception e) {
         e.printStackTrace();
             return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("导入初始化出错，导入失败！");
         }
           
       Map<String, String> titleAndAttribute = new HashMap<String, String>();
       List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
       List<Map<String, String>> resolurdDtaList = new ArrayList<Map<String,String>>();
       boolean is = true;
     
       /*读取表单配置信息*/
       AttributeService attributeService=(AttributeService)SpringContextUtil.getBean("attributeService");  
       Attribute attribute = new Attribute();
       attribute.setType(attributeType);
       attribute.setDelFlag(0);
       List<Attribute> attributeList = attributeService.querAllyList(attribute);
       Map<String,Integer>  attributeMap = new HashMap<String, Integer>();
       for(Attribute att:attributeList){ 
           //这边查出来的getNameEn是大小写的驼峰
           attributeMap.put(att.getNameEn(), att.getIsCore());
       }
       /*读取表单配置信息结束*/
       while(is){
           dataList.clear();
           resolurdDtaList.clear();
           try {
            dataList = importExcel.readExcel(titleAndAttribute,startRow);
           } catch (Exception e) {
                e.printStackTrace();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(importDataReturnMsg(importExcel,"数据读取过程中出现未知错误"));
           }//查询excel中的数据
           
           if(dataList.size()!=0){
               //循环将数据的核心与非核心字段区分开，非核心的存入info中
               for(Map<String, String> excelData :dataList){  //dataList  Map<nameEn,value>中的value是大小的驼峰
                   Map<String, String> dataMap = new HashMap<String, String>();
                   String info ="{";
                   String info_value = "";
                   for (String nameEn : excelData.keySet())
                   {
                       if(attributeMap.get(nameEn) == 1){
                           //判断是核心字段
                           String _nameEn = StringUtil.toUnderScoreCase(nameEn);
                           dataMap.put(_nameEn, excelData.get(nameEn));
                       }else{
                         //判断为非核心字段
                           if(excelData.get(nameEn)!=""&&excelData.get(nameEn)!=null){
                               info_value = StringUtil.replaceBlank(excelData.get(nameEn).trim()); //去除字符串中的空格回车等
                           }
                           info +=   "\"" + nameEn.trim() + "\":\"" + info_value + "\",";
                       }
                       
                   }
                   info = info.substring(0, info.length() - 1);
                   info += "}";
                   if(info.length()>1){
                       dataMap.put("info", info);
                   }
                   resolurdDtaList.add(dataMap);
               }
               
               try {
                   getService().saveAll(resolurdDtaList);
                   importExcel.setAllErrorDataCoordinate(); //每次数据保存成功后将其中的错误数据寄存好
                   startRow = startRow+commitRow; 
               } catch (Exception e) {
                   e.printStackTrace();
                   return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(importDataReturnMsg(importExcel,"数据存储过程中出现未知错误"));
               }
           }
           if(dataList.size()<commitRow || dataList.size()==0){
               is=false; 
           }
       }
       
       return ResponseEntity.ok(importDataReturnMsg(importExcel,"数据导入完成"));
//       } catch (Exception e) {
//           e.printStackTrace();
//           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
//       }
   }
   
   private String importDataReturnMsg(ImportExcelImpl importExcel, String Msg){
       int _errorNum = importExcel.getAllErrorDataCoordinate().size();
       String _errorNumMsg = "";
       if(_errorNum>0){
           String errorDataExcelPath;
        try {
            errorDataExcelPath = importExcel.creatErrorDataExcel();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return "错误数据文件创建失败！";
        }
           _errorNumMsg = "，其中有"+_errorNum+"条错误数据（<a href=\""+errorDataExcelPath+"\">点击下载）,请修改完后重新上传！";
       }
       return Msg+_errorNumMsg;
   }
   
   /**
    * 导出数据
    * @param page
    * @param request
    * @param response
    */
   @RequestMapping(value = "exportData", method = RequestMethod.POST)
   public void exportData(Page<T> page,HttpServletRequest request,HttpServletResponse response){
       page.setIsPage(false);
       String [] rowName =  page.getObj().split(",");; //头部
       List<Map<String, Object>> DataList = queryDataForExp(); //查询出全部实体数据
       //获取实体数据
       try {
           getFileName();
           String _chTableName = chTableName+"数据";
           String _enTableName = chTableName+"数据";
//          String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
              ExportExcelImpl  exportExcel = new ExportExcelData(request,_chTableName,_enTableName,templatFile,rowName,DataList,response);
              exportExcel.export();
          } catch (Exception e1) {
              e1.printStackTrace();
          }
   }
//   
   protected abstract List<Map<String, Object>> queryDataForExp();
       
}
