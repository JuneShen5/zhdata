package com.govmade.zhdata.module.drs.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelData;
import com.govmade.zhdata.module.drs.pojo.Systems;
import com.govmade.zhdata.module.drs.service.SystemService;

@Controller
@RequestMapping(value = "assets/system")
public class SystemController {

    @Autowired
    private SystemService systemService;

    @RequestMapping(method = RequestMethod.GET)
    public String toSystem() {
        return "modules/assets/systemIndex";
    }
    
    @RequestMapping(value="check",method = RequestMethod.GET)
    public String toInfoCheck() {
        return "modules/assets/systemCheck";
    }

    /**
     * 查询系统清单
     * 
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> list(Page<Systems> page) {
       
        page = systemService.getPageForSearch(page);
        
        Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        if (roleId!=1) {
            Map<String, Object> map=Maps.newHashMap();
            map=page.getParams();
            map.put("companyId", companyId);
            page.setParams(map);
        }
        try {
       
            Long total = systemService.getTotal(page);
            
            List<Systems> sList = this.systemService.queryList(page);
            List<Map<String, Object>> list = Lists.newArrayList();
            for (Systems s : sList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", s.getId());
                map.put("companyId", s.getCompanyId());
                map.put("companyName", s.getCompanyName());
              /*  map.put("nameEn", s.getNameEn());*/
                map.put("isAudit", s.getIsAudit());
                
                if(s.getIsAudit()==0){
                    map.put("auditName", "待审核");
                }else{
                    map.put("auditName", "已审核");
                }
//                map.put("isAudit", s.getIsAudit());
                map.put("nameCn", s.getNameCn());
                String info = s.getInfo();
                if (!StringUtils.isBlank(info))
                    map = MapUtil.infoToMap(map, info);
                list.add(map);
            }
            Page<Map<String, Object>> resPage = new Page<Map<String, Object>>();
            resPage.setTotal(total);
            resPage.setRows(list);
            return ResponseEntity.ok(resPage);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 新增系统清单
     * 
     * @param sys
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Systems sys, HttpServletRequest request) {

        try {
            Enumeration paramNames = request.getParameterNames();
            String info = "{";
            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                if (!(paramName.trim().equals("id") || paramName.trim().equals("companyId") || paramName
                        .trim().equals("nameCn")|| paramName.trim().equals("isAudit"))) {
                    info += "\"" + paramName + "\":\"" + paramValue + "\",";
                }
            }
            info = info.substring(0, info.length() - 1);
            info += "}";
            // sys.setReList(reList);
            sys.setInfo(info);
            if (null == sys.getId()) {
                sys.preInsert();
                // systemService.saveSys(sys);
                this.systemService.saveSelective(sys);
            } else {
                sys.preInsert();
                // systemService.updateSys(sys);
                this.systemService.updateSelective(sys);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok("数据保存成功");
    }

    /**
     * 删除系统
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            systemService.deleteByIds(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    /**
     * 系统审核
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "setAudit", method = RequestMethod.POST)
    public ResponseEntity<String> setAudit(String ids) throws Exception {
        try {
            systemService.updateAuditByids(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    /**
     * 导出数据
     * @param page
     * @param request
     * @param response
     */
    @RequestMapping(value = "exportData", method = RequestMethod.POST)
    public void exportData(Page<Systems> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Systems> sList=this.systemService.queryList(page);
        List<Map<String, Object>> infoList = Lists.newArrayList();
       //将info 的json格式改为map格式
        for(Systems systems :sList){
            Map<String, Object> map = new HashMap<String, Object>();
            map = MapUtil.infoToMap(map,systems.getInfo());
            map.put("companyId", systems.getCompanyId());
            map.put("nameCn", systems.getNameCn());
           /* map.put("nameEn", systems.getNameEn());*/
            infoList.add(map);
        }
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="信息系统清单";
            String enTableName ="信息系统清单";
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
    public void downloadTemplate(Page<Systems> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="信息系统清单模板";
            String enTableName ="信息系统清单模板";
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
            while(is){
                dataList = importExcel.uploadAndRead(titleAndAttribute,startRow,commitRow);
                startRow = startRow+commitRow;
                if(dataList.size()!=0){
                    for(Map<String, String> map :dataList){
                        Map<String, String> dataMap = new HashMap<String, String>();
                        String info="{";
                        for (String k : map.keySet())
                        {
                            if (!(k.trim().equals("id") || k.trim().equals("companyId") || k.trim().equals("nameEn") || k
                                    .trim().equals("nameCn")|| k.trim().equals("isAudit"))) {
                                info +=   "\"" + k + "\":\"" + map.get(k) + "\",";
                            }else{
                               String _k = StringUtil.toUnderScoreCase(k);
                               dataMap.put(_k, map.get(k));
                            }
                        }
                        info = info.substring(0, info.length() - 1);
                        info += "}";
                        dataMap.put("info", info);
                        resolurdDtaList.add(dataMap);
                    }
                    systemService.saveAll(resolurdDtaList); 
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
