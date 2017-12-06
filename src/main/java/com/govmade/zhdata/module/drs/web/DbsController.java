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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.DBMSMetaUtil;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelData;
import com.govmade.zhdata.module.drs.pojo.Columns;
import com.govmade.zhdata.module.drs.pojo.Dbs;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.pojo.Tables;
import com.govmade.zhdata.module.drs.service.ColumnsService;
import com.govmade.zhdata.module.drs.service.DbsService;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.drs.service.InformationService;
import com.govmade.zhdata.module.drs.service.TablesService;
import com.govmade.zhdata.module.sys.pojo.User;

@Controller
@RequestMapping(value="/assets")
public class DbsController {

    @Autowired
    private DbsService dbsService;
    
    @Autowired
    private TablesService tablesService;
    
    @Autowired
    private ColumnsService columnsService;

    @Autowired
    private ElementService elementService;

    @Autowired
    private InformationService infoService;
    
    private static Dbs dbss=new Dbs();
    
    
    @RequestMapping(value="{name}",method = RequestMethod.GET)
    public String toPage(@PathVariable("name") String name) {
        switch (name) {
        case "dbs":
            return "modules/assets/dbsIndex";
        case "tables":
            return "modules/assets/tablesIndex";
        case "columns":
            return "modules/assets/columnsIndex";
        default:
            return null;
        }
       
    }
    
    
    /**
     * 连接数据库
     * 
     * @param dbs
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "dbs/importDb", method = RequestMethod.POST)
    public ResponseEntity <List<Map<String,Object>>>importDb(Dbs dbs, HttpServletRequest request) throws Exception {

        /*Integer type = 1;
        String host = "183.245.210.26";
        String port = "3310";
        String user = "root";
        String password = "root";
        String dbName = "qxdata";
        
        dbs.setType(type);
        dbs.setHost(host);
        dbs.setPort(port);
        dbs.setUser(user);
        dbs.setPassword(password);
        dbs.setNameEn(dbName);
        */
        try {
        	boolean testLink = DBMSMetaUtil.TryLink(dbs.getType(), dbs.getHost(), dbs.getPort(), 
    				dbs.getNameEn(), dbs.getUser(), dbs.getPassword());
			if (testLink == true) {
				dbss=dbs;
				List<Map<String, Object>> dbList=dbsService.importDB(dbs);
				
				return ResponseEntity.ok(dbList);
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 测试数据库连接
     * 
     * @param dbs
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "dbs/testLink", method = RequestMethod.POST)
    public ResponseEntity<String> testLink (Dbs dbs, HttpServletRequest request) throws Exception {

        try {
        	boolean testLink = DBMSMetaUtil.TryLink(dbs.getType(), dbs.getHost(), dbs.getPort(), 
    				dbs.getNameEn(), dbs.getUser(), dbs.getPassword());
			if (testLink == true) {
				return ResponseEntity.ok("连接成功");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 新增数据库、数据表、数据字段
     * 
     * @param sys
     * @param request
     * @return
     */
    @RequestMapping(value = "dbs/saveAll", method = RequestMethod.POST)
    public ResponseEntity<String> saveAll(HttpServletRequest request) {
        try {
            String tbEns=request.getParameter("nameEn"); 
            String tbCns=request.getParameter("nameCn");
            dbsService.saveAll(dbss,tbEns,tbCns);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.ok("数据保存成功");
    }
    
    /**
     * 数据库-查询数据库列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "dbs/list", method = RequestMethod.GET)
    public ResponseEntity<Page<Dbs>> dList(Page<Dbs> page){
        try {
            
            PageInfo<Dbs> pageInfo = this.dbsService.findAll(page);
            List<Dbs> attributeList = pageInfo.getList();
            /*if (attributeList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            Page<Dbs> resPage = new Page<Dbs>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(attributeList);

       
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据库-数据库修改保存
     * 
     * @param dbs
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "dbs/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveDbs(Dbs dbs) throws Exception {
    	Integer i = dbs.getId();
        try {
            if (i == null) {
                dbs.preInsert();
               this.dbsService.saveSelective(dbs);
            }else {
                dbs.preUpdate();
                this.dbsService.updateSelective(dbs);
                        }
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    /**
     * 数据表-查询数据表列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "tables/list", method = RequestMethod.GET)
    public ResponseEntity<Page<Tables>> tList(Page<Tables> page){
        try {
            PageInfo<Tables> pageInfo = this.tablesService.findAll(page);
            List<Tables> attributeList = pageInfo.getList();
            /*if (attributeList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            Page<Tables> resPage = new Page<Tables>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(attributeList);
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 数据表-修改数据表
     * 
     * @param tables
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "tables/save", method = RequestMethod.POST)
    public ResponseEntity<String> updateTbs(Tables tables) throws Exception {
        try {
            tables.preUpdate();
            this.tablesService.updateSelective(tables);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    /**
     * 数据表-生成信息资源
     * 
     * @param element
     * @return
     */
    @RequestMapping(value = "tables/generate", method = RequestMethod.POST)
    public ResponseEntity<String> generate(Element element) {
        try {
        	this.dbsService.generate(element);
            return ResponseEntity.ok(Global.INSERT_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据表-生成信息资源-根据关联id获取单条数据
     * @param id
     * @return
     */
    @RequestMapping(value = "tables/eleList", method = RequestMethod.GET)
    public ResponseEntity<Element> eleList(Integer id) {
        try {
        	Element element=this.elementService.queryById(id);
            return ResponseEntity.ok(element);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据表-生成信息资源-获取所有的数据，不做分页效果,及已经勾选的信息项
     * @param columns
     * @return
     */
    @RequestMapping(value = "tables/columns", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> columns(Columns columns,Integer infoId) {
        try {
            Map<String, Object> map = Maps.newHashMap();
            List<Columns> colList1 = this.columnsService.queryAll(columns);
            List<Columns> colList2 =this.columnsService.queryCheckList(infoId);
            map.put("colList1", colList1);
            map.put("colList2", colList2);
            return ResponseEntity.ok(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据表-生成信息资源-信息、修改生成信息资源
     * 
     * @param info
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "tables/infoSave", method = RequestMethod.POST)
    public ResponseEntity<String> infoSave(Information info, HttpServletRequest request) {
        try {
        	Enumeration paramNames = request.getParameterNames(); 
        	String infos = "{";
            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
               
            if (!(paramName.trim().equals("id") || paramName.trim().equals("companyId")
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
            
            this.infoService.relationSave(info);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据表-生成信息资源-查询单条信息资源数据
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "tables/infoDetail", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> infoDetail(Information infor) {
        try {
            Map<String, Object> map = Maps.newHashMap();
            if (infor.getId() != 0) {
                Information infoDetail = this.infoService.queryById(infor.getId());
                map.put("id", infoDetail.getId());
                map.put("companyId", infoDetail.getCompanyId());
                map.put("companyName", infoDetail.getCompanyName());
                map.put("nameEn", infoDetail.getNameEn());
                map.put("nameCn", infoDetail.getNameCn());
                map.put("tbName", infoDetail.getTbName());
                map.put("code", infoDetail.getCode());
                map.put("isOpen", infoDetail.getIsOpen());
                map.put("openType", infoDetail.getOpenType());
                map.put("shareType", infoDetail.getShareType());
                map.put("shareMode", infoDetail.getShareMode());
                map.put("shareCondition", infoDetail.getShareCondition());
                map.put("infoType1", infoDetail.getInfoType1());
                map.put("infoType2", infoDetail.getInfoType2());
                map.put("remarks", infoDetail.getRemarks());
                map.put("isAudit", infoDetail.getIsAudit());
                map.put("systemId", infoDetail.getSystemId());
                map.put("reason", infoDetail.getReason());
                if (infoDetail.getIsAudit() == 0) {
                    map.put("auditName", "待审核");
                } else {
                    map.put("auditName", "已审核");
                }
                String info = infoDetail.getInfo();
                if (!StringUtils.isBlank(info)) {
                    String info1=new String (info.getBytes("ISO-8859-1"), "UTF-8");
                    map = MapUtil.infoToMap(map, info1);
                }
            }
            List<Element> elementList = this.elementService.queyListById(infor.getElementIds());
            map.put("elementList", elementList);
            return ResponseEntity.ok(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 数据字段-查询数据字段列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "columns/list", method = RequestMethod.GET)
    public ResponseEntity<Page<Columns>> cList(Page<Columns> page){
        try {
            PageInfo<Columns> pageInfo = this.columnsService.findAll(page);
            List<Columns> attributeList = pageInfo.getList();
           /* if (attributeList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            Page<Columns> resPage = new Page<Columns>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(attributeList);
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据字段-修改数据字段
     * 
     * @param CleanTask
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "columns/save", method = RequestMethod.POST)
    public ResponseEntity<String> updateCols(Columns columns) throws Exception {
        try {
            columns.preUpdate();
            this.columnsService.updateSelective(columns);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    /**
     * 数据字段-同步数据字段到信息项
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "columns/columsToElement", method = RequestMethod.GET)
    public ResponseEntity<String> columsToElement(Columns columns) {
    	try {
			this.columnsService.columsToElement(columns);
			this.columnsService.setToElement(columns);
			return ResponseEntity.ok(Global.HANDLE_SUCCESS);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	       return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Global.HANDLE_ERROR);
	    }
    
    /**
     * 删除数据库、表、字段
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "{name}/delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(@PathVariable("name")String name,String ids) throws Exception {
        try {
            switch (name) {
            case "dbs":
                this.dbsService.deleteByIds(ids);
                break;
            case "tables":
                this.tablesService.deleteByIds(ids);
                break;
            case "columns":
                this.columnsService.deleteByIds(ids);
                break;
            default:
                break;
            }
            
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
         } catch (Exception e) {
             e.printStackTrace();
             throw new Exception(Global.HANDLE_ERROR);
         }
    }
    
    /**
     * 导出数据模板
     * @param id 
     * @param name 文件中文名
     * @param request
     * @param response
     */
    @RequestMapping(value = "dbs/downloadTemplate", method = RequestMethod.POST)
    public void downloadTemplate(Page<User> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="数据库模板";
            String enTableName ="数据库模板";
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
            ExportExcelTemplate exportExcel = new ExportExcelTemplate(chTableName,enTableName,rowName,infoList,response);
           exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    /**
     * 导出数据
     * @param page
     * @param request
     * @param response
     */
    @RequestMapping(value = "dbs/exportData", method = RequestMethod.POST)
    public void exportData(Page<Dbs> page,HttpServletRequest request,HttpServletResponse response){
        String [] rowName =  page.getObj().split(",");; //头部
        page.setIsPage(false);
        page.setObj("{\"nameCn\":\"\",\"companyId\":\"\"}"); //查询的时候有用所以这样整了一下{"name":"","nameCn":"","companyId":""}
        PageInfo<Dbs> pageInfo = this.dbsService.findAll(page);
        List<Dbs> attributeList = pageInfo.getList();
       //将info 的json格式改为map格式
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for(Dbs dbs :attributeList){
            infoList.add(MapUtil.beanToMap(dbs));
        }
        //获取实体数据
        System.out.println("infoList:"+infoList);
        try {
            String chTableName ="数据库";
            String enTableName ="数据库";
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
            ExportExcelData exportExcel = new ExportExcelData(chTableName,enTableName,rowName,infoList,response);
           exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    
    //导入数据
    @RequestMapping(value ="dbs/importData" , method = RequestMethod.POST)
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
                    
                    this.dbsService.saveAll(resolurdDtaList); 
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
