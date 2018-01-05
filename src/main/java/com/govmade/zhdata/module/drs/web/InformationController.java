package com.govmade.zhdata.module.drs.web;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseController;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.UserUtils;
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
public class InformationController extends BaseController<Information>{

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

    // 跳转至信息资源-待办事宜页面
    @RequestMapping(value="check",method = RequestMethod.GET)
    public String toInfoCheck() {
        return "modules/panel/informationCheck";
    }
    
 // 跳转至信息资源-未审核资源页面
    @RequestMapping(value="audit",method = RequestMethod.GET)
    public String toInfoAudit() {
        return "modules/catalog/informationAudit";
    }
    
 // 跳转至信息资源-已退回资源页面
    @RequestMapping(value="return",method = RequestMethod.GET)
    public String toInfoReturn() {
        return "modules/catalog/informationReturn";
    }
    

    // 跳转至信息资源-已审核资源页面
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
        
        if (roleId!=1&& information.getIsAuthorize()==1) {
            comList.add(companyId);
            findAllSubNode(companyId, comList);
            Map<String, Object> map=Maps.newHashMap();
            map=page.getParams();
            //map.put("companyId", companyId);
            map.put("companyIds", comList);
            page.setParams(map);
        }
        Integer isAuditCount=this.infoService.queryIsAuditCount(comList);
        
        try {
            Long total = infoService.getTotal(page);
          /*  if (condition) {
                
            }*/
            List<Information> iList = this.infoService.queryList(page);
            List<Map<String, Object>> list = Lists.newArrayList();
            for (Information s : iList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", s.getId());
                map.put("companyId", s.getCompanyId());
                map.put("departId", s.getDepartId());
                map.put("companyName", s.getCompanyName());
                map.put("departName", s.getDepartName());
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
                map.put("resourceFormat", s.getResourceFormat());
                map.put("rightRelation", s.getRightRelation());
                map.put("manageStyle", s.getManageStyle());
                map.put("releaseDate", s.getReleaseDate());
                switch (s.getIsAudit()) {
                case 0:
                    map.put("auditName", "未发布");
                    break;
                case 1:
                    map.put("auditName", "已发布未审核");
                    break;
                case 2:
                    map.put("auditName", "已发布已审核");
                    break;
                case 3:
                    map.put("auditName", "已发布审核不通过");
                    break;
                default:
                    map.put("auditName", "未发布");
                    break;
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
            resPage.setStartRow(isAuditCount);  //startRow暂时用作待审核数量
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
                        ||paramName.trim().equals("resourceFormat")||paramName.trim().equals("rightRelation")
                        ||paramName.trim().equals("resourceFormat")||paramName.trim().equals("releaseDate")
                        ||paramName.trim().equals("manageStyle") ||paramName.trim().equals("tbName")||paramName.trim().equals("code"))) {
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
                info.setCode(company.getCreditCode());
                this.infoService.saveInformation(info);
            } else {
                info.preUpdate();
                Company company=this.companyService.queryById(info.getCompanyId());
                info.setCode(company.getCreditCode());
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
            Integer roleId=UserUtils.getCurrentUser().getRoleId();
            Integer companyId=UserUtils.getCurrentUser().getCompanyId();
            List<Integer> comList=Lists.newArrayList();
            if (roleId!=1) {
                comList.add(companyId);
                findAllSubNode(companyId, comList);
            }
            List<Information> inforList=this.infoService.queryByCompanyIds(comList);
          //List<Information> inforList=this.infoService.queryAll(new Information());
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
            Integer roleId=UserUtils.getCurrentUser().getRoleId();
            Integer companyId=UserUtils.getCurrentUser().getCompanyId();
            List<Integer> comList=Lists.newArrayList();
            if (roleId!=1) {
                comList.add(companyId);
                findAllSubNode(companyId, comList);
            }
            infoService.updateAllAudit(comList);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    
    /**
     * 信息资源发布
     * 
     * @param info
     * @return
     */
    @RequestMapping(value = "release", method = RequestMethod.GET)
    public ResponseEntity<String> updateRelease(Information info) {
        try {
            if (null==info.getDepartId()) {
                Company company = this.companyService.queryByInfoId(info.getId());
                if (company != null) {
                    info.setDepartId(company.getId());
                } else {
                    info.setDepartId(info.getCompanyId());
                }
            }
            info.setIsAudit(1);
            this.infoService.updateSelective(info);
            return ResponseEntity.ok(Global.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
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
    
    
    /**
     * 
     * 信息资源-注销审核（未发布状态）
     * 
     * @param infor
     * @return
     */
    @RequestMapping(value ="cancelAudit" , method = RequestMethod.POST)
    public ResponseEntity<String> cancelAudit(Information infor){
        try {
            infor.setIsAudit(Global.RELEASE_NO);
            this.infoService.updateSelective(infor);
            return ResponseEntity.ok(Global.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 根据规则自动生成信息资源代码
     * 
     * @return
     */
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
    
    
  

    @Override
    protected void getFileName() {
        super.chTableName = "信息资源";
        super.enTableName = "信息资源";
        super.templatFile = "informationTemplate.xlsx";
    }

    @Override
    protected void getReadExcelStarLine() {
        super.commitRow = 500;
        super.startRow = 3;
        super.columnIndex = 0;
    }

    @Override
    protected BaseService<Information> getService() {
        return infoService;
    }

    @Override
    protected List<Map<String, Object>> queryDataForExp() {
        List<Information> informationList = infoService.queryForExport();
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String info = "";
        for (Information data : informationList) {
          /*  信息项*/
            String elementIds = "";
            List<Element> elementList = data.getElementList();
            if(elementList.size()>0){
                for(Element element:elementList){
                    elementIds += element.getNameCn()+",";
                }
            };
            if(elementIds.length()>1){
                elementIds = elementIds.substring(0,elementIds.length() - 1);
                data.setElementIds(elementIds);
            }
            /*info字段*/
            info = data.getInfo();
            if(!StringUtils.isBlank(info)){
                infoList.add(MapUtil.infoToMap(MapUtil.beansToMap(data), info));
            }else{
                infoList.add(MapUtil.beansToMap(data));
            }
           
        }
        return infoList;
    }
    
    
}
