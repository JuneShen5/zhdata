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

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelData;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.service.ColumnsService;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.sys.service.DictService;

@Controller
@RequestMapping(value = "/catalog/element")
public class ElementController {

    @Autowired
    private ElementService elementService;
    
    @Autowired
    private DictService dictService;
    
    
    @Autowired
    private ColumnsService columnsService;

    @RequestMapping(method = RequestMethod.GET)
    public String toAttribute() {
        return "modules/catalog/elementIndex";
    }

    /**
     * 查询信息项列表数据
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Element>> list(Page<Element> page) {
        try {
        	
            PageInfo<Element> pageInfo = this.elementService.findList(page);
            List<Element> elementList = pageInfo.getList();
           /* if (elementList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            Page<Element> resPage = new Page<Element>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(elementList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    
    /**
     * 保存信息项
     * 
     * @param element
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Element element) throws Exception {
        try {
            if (element.getId()==null) {
                element.preInsert();
               this.elementService.saveSelective(element);
            }else {
            	element.preUpdate();
            	this.elementService.updateSelective(element);
			}
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    
    /**
     * 删除或批量删除信息项
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
    	try {
    	    if (this.elementService.deleteByIds(ids)>0) {
    	        this.elementService.deleteInfoEle(ids);
    	       this.columnsService.updateColum(ids); //将columns表中的ele_id设置成0
            }
    	   
    	    
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
         } catch (Exception e) {
             e.printStackTrace();
             throw new Exception(Global.HANDLE_ERROR);
         }
    }
    
    
    /**
     * 删除全部-清空所有
     * 
     * @return
     */
    @RequestMapping(value="deleteAll",method=RequestMethod.GET)
    public ResponseEntity<String> deleteAll(){
        try {
            List<Element> eleList=this.elementService.queryAll(new Element());
            List<String> idList = Lists.newArrayList();
            for (Element ele : eleList) {
                idList.add(ele.getId().toString());
            }
           
            this.elementService.deleteAll(idList);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 导出数据
     * @param page
     * @param request
     * @param response
     */
    @RequestMapping(value = "exportData", method = RequestMethod.POST)
    public void exportData(Page<Element> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Element> eList=this.elementService.queryAll(page);
        List<Map<String, Object>> infoList = Lists.newArrayList();
       //将info 的json格式改为map格式
        for(Element element :eList){
            Map<String, Object> beanMap = MapUtil.beanToMap(element);
            infoList.add(beanMap);
        }
        String [] rowName =  page.getObj().split(","); //头部
        //获取实体数据
        try {
            String chTableName ="信息项";
            String enTableName ="信息项";
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
    public void downloadTemplate(Page<Element> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="信息项模板";
            String enTableName ="信息项模板";
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
            ExportExcelTemplate exportExcel = new ExportExcelTemplate(chTableName,enTableName,rowName,infoList,response);
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
            List<Map<String, String>> resolurdDtaList = new ArrayList<Map<String,String>>();
            boolean is = true;
            int commitRow = 500; //读取多少返回一次
            int startRow = 3;  //开始读取的行
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
                    elementService.saveAll(resolurdDtaList); 
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
}
