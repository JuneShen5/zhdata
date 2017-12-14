package com.govmade.zhdata.module.drs.web;

import java.lang.reflect.Field;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelData;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.service.DataService;
import com.govmade.zhdata.module.drs.service.InfoSearchService;
import com.govmade.zhdata.module.drs.service.InformationService;
import com.govmade.zhdata.module.drs.service.TablesService;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.CompanyService;
import com.govmade.zhdata.module.sys.service.DictService;

@Controller
@RequestMapping(value = "catalog/information")
public class InformationController {

    @Autowired
    private InformationService infoService;

    @Autowired
    private DataService convergeService;

    @Autowired
    private DictService dictService;
    
    @Autowired
    private CompanyService companyService;
    
    @Autowired
    private InfoSearchService infoSearchService;
    
    @Autowired
    private TablesService tablesService;

    @RequestMapping(method = RequestMethod.GET)
    public String toInfo() {
        return "modules/catalog/informationIndex";
    }

    // 跳转至信息资源审查页面
    @RequestMapping(value="check",method = RequestMethod.GET)
    public String toInfoCheck() {
        return "modules/panel/informationCheck";
    }

    // 跳转至目录检索页面
    @RequestMapping(value="retrieval",method = RequestMethod.GET)
    public String toRetrieval() {
        return "modules/catalog/retrievalIndex";
    }
    /**
     * 查询信息资源
     * 
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> list(Page<Information> page) {
        page = infoService.getPageForSearch(page);
        
        Information information = JsonUtil.readValue(page.getObj(), Information.class);
        try{
        String keyword=new String (information.getNameCn().getBytes("ISO-8859-1"), "UTF-8");
        if(keyword!= null && !keyword.equals("")){
        	infoSearchService.saveKeyWord(keyword);}
            
        }catch(Exception e){
        	 e.printStackTrace();
        }
            
        
        
        Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        List<Integer> comList=Lists.newArrayList();
        comList.add(companyId);
        findAllSubNode(companyId, comList);
        if (roleId!=1) {
            Map<String, Object> map=Maps.newHashMap();
            map=page.getParams();
            //map.put("companyId", companyId);
            map.put("companyId", comList);
            page.setParams(map);
        }
        
        try {
            Long total = infoService.getTotal(page);
            List<Information> iList = this.infoService.queryList(page);
            List<Map<String, Object>> list = Lists.newArrayList();
            for (Information s : iList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", s.getId());
                map.put("companyId", s.getCompanyId());
                map.put("companyName", s.getCompanyName());
                map.put("nameEn", s.getNameEn());
                map.put("nameCn", s.getNameCn());
                map.put("tbName", s.getTbName());
                map.put("code", s.getCode());
                map.put("isOpen", s.getIsOpen());
                map.put("openType", s.getOpenType());
                map.put("shareType", s.getShareType());
                map.put("shareMode", s.getShareMode());
                map.put("shareCondition", s.getShareCondition());
                map.put("infoType1", s.getInfoType1());
                map.put("infoType2", s.getInfoType2());
                map.put("remarks", s.getRemarks());
                map.put("isAudit", s.getIsAudit());
                map.put("systemId", s.getSystemId());
                map.put("reason", s.getReason());
                if(s.getIsAudit()==0){
                    map.put("auditName", "待审核");
                }else{
                    map.put("auditName", "已审核");
                }
                map.put("elementList", s.getElementList());
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
     * 根据父级查询子级
     * 
     * @param parentId
     * @param list
     */
    public void findAllSubNode(Integer companyId, List<Integer> comList) {
        Company record =new Company();
        record.setParentId(Integer.valueOf(companyId));
        List<Company> companies=this.companyService.queryListByWhere(record);
        if (companies!=null) {
          //  List<Menu> menus=this.menuService.queryListByWhere(record);
            for (Company c : companies) {
                comList.add(c.getId());
                 findAllSubNode(c.getId(),comList);
            }
        }
        
    }


    /**
     * 新增信息资源清单
     * 
     * @param sys
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Information info, HttpServletRequest request) {
        try {
            Enumeration paramNames = request.getParameterNames(); 
            String infos = "{";
            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                if (!(paramName.trim().equals("id") || paramName.trim().equals("companyId") || paramName.trim().equals("companyName")
                        || paramName.trim().equals("nameEn") || paramName.trim().equals("nameCn") ||paramName.trim().equals("systemId")
                        || paramName.trim().equals("elementIds") || paramName.trim().equals("isOpen")|| paramName.trim().equals("openType")
                        || paramName.trim().equals("shareType")|| paramName.trim().equals("shareMode")|| paramName.trim().equals("shareCondition")
                        || paramName.trim().equals("isAudit")||paramName.trim().equals("infoType1") || paramName.trim().equals("reason")
                        ||paramName.trim().equals("infoType2") ||paramName.trim().equals("tbName")||paramName.trim().equals("code"))) {
                    infos += "\"" + paramName + "\":\"" + paramValue + "\",";
                }
            }
            infos = infos.substring(0, infos.length() - 1);
            infos += "}";
            
            info.setInfo(infos);

            List<Element> elements = Lists.newArrayList();
            String jsonArray = info.getElementIds();
            if (StringUtils.isNotBlank(jsonArray)) {
                // json数组转List对象
                elements = (List<Element>) JsonUtil.jsonArray2List(jsonArray, Element.class);
                info.setElementList(elements);
            }

            if (null == info.getId()) {
                info.preInsert();
              /*  info.setNameEn(ChineseTo.getPinYinHeadChar(info.getNameCn()));*/
                Company company=this.companyService.queryById(info.getCompanyId());
                info.setCode(company.getCode());
                this.infoService.saveInformation(info);
            } else {
                info.preUpdate();
                Company company=this.companyService.queryById(info.getCompanyId());
                info.setCode(company.getCode());
                this.infoService.updateInformation(info);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.ok("数据保存成功");
    }

    /**
     * 根据ID删除信息资源
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            if (this.infoService.deleteByIds(ids)>0) {
                this.infoService.deleteInfoEle(ids);
                this.tablesService.updateTabs(ids); //将数据表中info_id设置成0
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
          List<Information> inforList=this.infoService.queryAll(new Information());
          List<String> idList = Lists.newArrayList();
          for (Information info : inforList) {
            idList.add(info.getId().toString());
        }
            this.infoService.deleteAll(idList);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    

    /**
     * 获取实体数据
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "getHeader", method = RequestMethod.GET)
    public ResponseEntity<List<Map<String, Object>>> getHeader(Integer id) {

        List<Element> elementList = infoService.findElementById(id);

        List<Map<String, Object>> mapList = Lists.newArrayList();

        for (Element e : elementList) {
            // if (e.getIsShow() == 1) {
            Map<String, Object> map = Maps.newHashMap();
            map.put("nameEn", e.getNameEn());
            map.put("nameCn", e.getNameCn());
            // map.put("inputType", e.getInputType());
            // map.put("dict", e.getDict());
            // map.put("searchType", e.getSearchType());
            mapList.add(map);
            // }
        }
        return ResponseEntity.ok(mapList);
    }
    
   /**
    * 获取实体数据
    * 
    * @param id
    * @return
    */
    @RequestMapping(value = "getForm", method = RequestMethod.GET)
    public ResponseEntity<List<Map<String, Object>>> getForm(Integer id) {

        List<Element> elementList = infoService.findElementById(id);

        List<Map<String, Object>> mapList = Lists.newArrayList();

        for (Element e : elementList) {
            Map<String, Object> map = Maps.newHashMap();
            map.put("nameEn", e.getNameEn());
            map.put("nameCn", e.getNameCn());
            mapList.add(map);
        }
        return ResponseEntity.ok(mapList);
    }

    /**
     * 数据开放
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "openData", method = RequestMethod.GET)
    public ResponseEntity<String> openData(Information info) {
        try {
            Information record = new Information();
            record.setId(info.getId());
            if (info.getOpenType() == 1) {
                record.setOpenType(2);
            } else if (info.getOpenType() == 2) {
                record.setOpenType(1);
            }
            infoService.updateSelective(record);
            return ResponseEntity.ok("操作成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 一键审核
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value="setAllAudit",method=RequestMethod.GET)
    public ResponseEntity<String> setAllAudit() throws Exception{
        try {
            infoService.updateAllAudit();
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    
    /**
     * 待办事宜-审核通过
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "setAudit", method = RequestMethod.POST)
    public ResponseEntity<String> setAudit(String ids) throws Exception {
        try {
            infoService.updateAuditByids(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    
    @RequestMapping(value="getCode",method=RequestMethod.GET)
    @ResponseBody
    public  String getCode(){
     // 信息资源编码规则
        User user = UserUtils.getCurrentUser();
        Information info=new Information();
        int ID;
        try {
            ID = this.infoService.findMAX(info) +1;
        } catch (Exception e) {
            ID=1;
        }
        String code = "321000" + String.format("%03d", user.getCompanyId()) +ID;  
        return code;

    }
    
    /**
     * 导出数据
     * @param page
     * @param request
     * @param response
     */
    @RequestMapping(value = "exportData", method = RequestMethod.POST)
    public void exportData(Page<Information> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Information> sList=this.infoService.queryList(page);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for(Information s :sList){
            Map<String, Object> map = Maps.newHashMap();
            map.put("id", s.getId());
            map.put("companyId", s.getCompanyId());
            map.put("companyName", s.getCompanyName());
            map.put("nameEn", s.getNameEn());
            map.put("nameCn", s.getNameCn());
            map.put("tbName", s.getTbName());
            map.put("code", s.getCode());
            map.put("isOpen", s.getIsOpen());
            map.put("openType", s.getOpenType());
            map.put("shareType", s.getShareType());
            map.put("shareMode", s.getShareMode());
            map.put("shareCondition", s.getShareCondition());
            map.put("infoType1", s.getInfoType1());
            map.put("infoType2", s.getInfoType2());
            map.put("remarks", s.getRemarks());
            map.put("isAudit", s.getIsAudit());
            map.put("systemId", s.getSystemId());
            map.put("reason", s.getReason());
            if(s.getIsAudit()==0){
                map.put("auditName", "待审核");
            }else{
                map.put("auditName", "已审核");
            }
            if (s.getElementList().size()>0){
                String elementValue ="";
                for(Element element:s.getElementList()){
                    elementValue +=element.getNameCn()+",";
                }
                map.put("elementIds", elementValue.substring(0,elementValue.length()-1));
            }         
            String info = s.getInfo();
            if (!StringUtils.isBlank(info))
                map = MapUtil.infoToMap(map, info);
            infoList.add(map);
        }
        
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="信息资源普查";
            String enTableName ="信息资源普查";
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
    public void downloadTemplate(Page<Information> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="信息资源普查模板";
            String enTableName ="信息资源普查模板";
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
            List<Map<String, Object>> resolurdDtaList = new ArrayList<Map<String,Object>>();
            boolean is = true;
            int commitRow = 500; //读取多少返回一次
            int startRow = 3;  //开始读取的行
//            Information information = new Information();
            List<Element> elements = Lists.newArrayList();
            while(is){
                dataList = importExcel.uploadAndRead(titleAndAttribute,startRow,commitRow);
                startRow = startRow+commitRow;
                if(dataList.size()!=0){
                    for(Map<String, String> map :dataList){  //将excel表中的数据读取出来进行遍历
                        Information information = new Information();
//                        Map<String, Object> dataMap = new HashMap<String, Object>();
                        String info="{";
                        for (String k : map.keySet())   //对每行数据进行遍历
                        {
                            //拼接info信息
                            if (!(k.trim().equals("id") || k.trim().equals("companyId")
                                    || k.trim().equals("nameEn") || k.trim().equals("nameCn") ||k.trim().equals("systemId")
                                    || k.trim().equals("elementIds") || k.trim().equals("isOpen")|| k.trim().equals("openType")
                                    || k.trim().equals("shareType")|| k.trim().equals("shareMode")|| k.trim().equals("shareCondition")
                                    || k.trim().equals("isAudit")||k.trim().equals("infoType1") || k.trim().equals("reason")
                                    ||k.trim().equals("infoType2") ||k.trim().equals("tbName")||k.trim().equals("code"))) {
                                info +=   "\"" + k + "\":\"" + map.get(k) + "\",";
                           
                            }else if(k.trim().equals("elementIds")){
                                //设置element
                                String jsonArray = map.get(k);
                                if (StringUtils.isNotBlank(jsonArray)) {
                                    // json数组转List对象
                                    elements = (List<Element>) JsonUtil.jsonArray2List(jsonArray, Element.class);
                                    information.setElementList(elements);
                                }
                            }
                            else{
                                //通过反射机制动态设置其他值
                                Field field=information.getClass().getDeclaredField(k);
                                field.setAccessible(true);
                                //判断类型
                                if (field.getGenericType().toString().equals("class java.lang.String")) {
                                    field.set(information,  map.get(k));
                                }else if(field.getGenericType().toString().equals("class java.lang.Integer")){
                                    field.set(information,  Integer.valueOf(map.get(k)));
                                }
                                
                            }
                        }
                        info = info.substring(0, info.length() - 1);
                        info += "}";
                        information.setInfo(info);
                        //每读取一条信息添加一次，因为有中间表，需要获取存储时主表的ID
                        information.preInsert();
                        /*  info.setNameEn(ChineseTo.getPinYinHeadChar(info.getNameCn()));*/
                        Company company=this.companyService.queryById(information.getCompanyId());
                        information.setCode(company.getCode());
                        this.infoService.saveInformation(information);
                    }
                   
//                infoService.saveAll(resolurdDtaList); 
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
     * 首页右上角查询信息资源待办事项总数
     * 
     * @param isAudit
     * @return
     */
    @RequestMapping(value ="auditCount" , method = RequestMethod.GET)
    public ResponseEntity<Integer> queryAuditCount(Integer isAudit){
        try {
            Integer auditCount=this.infoService.queryAuditCount(isAudit);
            return ResponseEntity.ok(auditCount);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 发布审核-审核不通过
     * 
     * @param infor
     * @return
     */
    @RequestMapping(value ="updateReason" , method = RequestMethod.POST)
    public ResponseEntity<String> updateReason(Information infor){
        try {
            this.infoService.updateSelective(infor);
            return ResponseEntity.ok(Global.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
}
