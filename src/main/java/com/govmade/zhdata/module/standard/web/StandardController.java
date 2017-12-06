package com.govmade.zhdata.module.standard.web;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.module.drs.dao.InformationDao;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.drs.service.InformationService;
import com.govmade.zhdata.module.standard.pojo.ElementPool;
import com.govmade.zhdata.module.standard.pojo.ElementSame;
import com.govmade.zhdata.module.standard.service.ElementPoolService;
import com.govmade.zhdata.module.standard.service.ElementSameService;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Controller
@RequestMapping(value = "standard")
public class StandardController {

    @Autowired
    private ElementPoolService elementPoolService;
    
    @Autowired
    private ElementSameService elementSameService;
    
    @Autowired
    private ElementService elementService;
    
    
    @Autowired
    private CompanyService companyService;
    
    @Autowired
    private InformationDao informationDao;
    
    
    @Autowired
    private InformationService informationService;

    /**
     * 跳转至频率分析页面
     * 
     * @return
     */
    @RequestMapping(value = "analy", method = RequestMethod.GET)
    public String toAnaly() {
        return "modules/standard/analysisIndex";
    }

    /**
     * 跳转至数据元同义清洗页面
     * 
     * @return
     */
    @RequestMapping(value = "equal", method = RequestMethod.GET)
    public String toEqual() {
        return "modules/standard/equalIndex";
    }

    /**
     * 跳转至数据元管理页面
     * 
     * @return
     */
    @RequestMapping(value = "manage", method = RequestMethod.GET)
    public String toManage() {
        return "modules/standard/manageIndex";
    }

    /**
     * 跳转至公共数据元池页面
     * 
     * @return
     */
    @RequestMapping(value = "public", method = RequestMethod.GET)
    public String toPublic() {
        return "modules/standard/publicIndex";
    }

    /**
     * 跳转至数据元重复清洗页面
     * 
     * @return
     */
    @RequestMapping(value = "repeat", method = RequestMethod.GET)
    public String toRepeat() {
        return "modules/standard/repeatIndex";
    }
    
    
    
    /**
     * 频率分析-查询数据
     * 
     * @return
     */
    @RequestMapping(value = "analy/list", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Object>>aList() {
        
        try {
            Map<String, Object> map=this.elementService.queryAnalyList();
            return ResponseEntity.ok(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
   
    
    
    
    /**
     * 频率分析-关系图
     * 
     * @param element
     * @return
     */
    @RequestMapping(value = "analy/relation", method = RequestMethod.GET)
    public ResponseEntity<JSONObject> toRelation(Element element) {

         int num=0;
         int num1=0;
         
        JSONObject resultJson = new JSONObject();
        JSONArray nodeArray = new JSONArray();
        JSONArray linkArray = new JSONArray();
        JSONObject nodeJson = new JSONObject();
        JSONObject linkJson = new JSONObject();

        // 存入信息项
        try {
            String nameCn = new String(element.getNameCn().toString().getBytes("ISO-8859-1"), "UTF-8");
            nodeJson.put("name",nameCn);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        nodeJson.put("category", 0);
        nodeJson.put("value", 60);
        nodeJson.put("num", num);
        nodeArray.add(nodeJson);

        // 存入信息资源
        List<Information> informations=this.informationDao.queryInfoByEleId(element.getId());
    
        if (informations.size() > 0) {
            for (Information info : informations) {
                nodeJson.put("name", info.getNameCn());
                nodeJson.put("category", 1);
                nodeJson.put("value", 55);
                nodeJson.put("num", ++num);
                nodeArray.add(nodeJson);
                linkJson.put("source", 0);
                linkJson.put("target", num);
                linkArray.add(linkJson);
                
                //存入信息资源关联的部门
                Company company=new Company();
                company.setId(info.getCompanyId());
                List<Company> companies=this.companyService.queryListByWhere(company);
                if (companies.size()>0) {
                    num1=num;
                    for (Company c : companies) {
                        nodeJson.put("name", c.getName());
                        nodeJson.put("category", 2);
                        nodeJson.put("value", 45);
                        nodeJson.put("num", ++num);
                        nodeArray.add(nodeJson);
                        linkJson.put("source", num1);
                        linkJson.put("target", num);
                        linkArray.add(linkJson);
                        
                    }
                }
            }
        }

        resultJson.put("node", nodeArray);
        resultJson.put("link", linkArray);

        return ResponseEntity.ok(resultJson);
    }
    
    
    
    
    
    /**
     * 数据元池管理-数据列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "manage/list", method = RequestMethod.GET)
    public ResponseEntity<Page<ElementPool>> dList(Page<ElementPool> page) {
        try {

            PageInfo<ElementPool> pageInfo = this.elementPoolService.findAll(page);
            List<ElementPool> attributeList = pageInfo.getList();
            Page<ElementPool> resPage = new Page<ElementPool>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(attributeList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    
    
    /**
     * 数据元池管理-数据修改
     * 
     * @param elementPool
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "manage/save", method = RequestMethod.POST)
    public ResponseEntity<String> update(ElementPool elementPool) throws Exception {
        try {
            elementPool.preUpdate();
            this.elementPoolService.updateSelective(elementPool);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

  

    /**
     * 数据元池管理-数据元池添加为公共
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "manage/addPublic", method = RequestMethod.GET)
    public ResponseEntity<String> addPublic(ElementPool ele) {
        try {
            ElementPool record = new ElementPool();
            record.setId(ele.getId());
            record.setPublicId(1);
            elementPoolService.updateSelective(record);
            return ResponseEntity.ok("操作成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    
    /**
     * 数据元池管理-数据元池导入信息项（包括选择、全部导入）
     * 
     * @param params
     * @return
     */
    @RequestMapping(value = "manage/import", method = RequestMethod.POST)
    public ResponseEntity<String> importEle(String params) {
        try {
            this.elementPoolService.importEle(params);
            return ResponseEntity.ok("导入成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        
    }
    
    
    /**
     * 数据元池管理-数据删除
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "manage/delete", method = RequestMethod.POST)
    public ResponseEntity<String> deleteElePool(Integer id){
        try {
            this.elementPoolService.deleteElePool(id);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据元池管理-删除所有
     * 
     * @return
     */
    @RequestMapping(value = "manage/deleteAll", method = RequestMethod.POST)
    public ResponseEntity<String> deleteAllList(){
        try {
            List<ElementPool> elePools=this.elementPoolService.queryAll(new ElementPool());
            List<String> idList=Lists.newArrayList();
            for (ElementPool ep : elePools) {
                idList.add(ep.getEleId().toString());
            }
            this.elementPoolService.deleteAllList(idList);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    /**
     * 数据元重复-数据
     * 
     * @return
     */
    @RequestMapping(value = "repeat/list", method = RequestMethod.GET)
    public ResponseEntity<List<ElementPool>> queryRepeatList(ElementPool elepool){
        try {
            List<ElementPool> elPools=this.elementPoolService.queryRepeatList(elepool);
            return ResponseEntity.ok(elPools);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据元重复-重复数据查询
     * 
     * @param nameCn
     * @return
     */
    @RequestMapping(value = "repeat/repeatList", method = RequestMethod.GET)
    public ResponseEntity<List<ElementPool>> repeatList(String nameCn){
        try {
        	ElementPool record = new ElementPool();
        	String name = new String(nameCn.getBytes("ISO-8859-1"), "UTF-8");
        	record.setNameCn(name);
            List<ElementPool> elPools = this.elementPoolService.queryListByWhere(record);
            return ResponseEntity.ok(elPools);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 数据元重复清洗-数据的修改
     * 
     * @param elementPool
     * @return
     */
    @RequestMapping(value = "repeat/save", method = RequestMethod.POST)
    public ResponseEntity<String> updateRepeat(ElementPool elementPool){
        try {
            elementPool.preUpdate();
            this.elementPoolService.updateSelective(elementPool);
            return ResponseEntity.ok(Global.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据元同义清洗-同义词配置弹框表格
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "equal/list", method = RequestMethod.GET)
    public ResponseEntity<Page<ElementSame>> equalList(Page<ElementSame> page) {
    	try {

            PageInfo<ElementSame> pageInfo = this.elementSameService.findAll(page);
            List<ElementSame> attributeList = pageInfo.getList();
            Page<ElementSame> resPage = new Page<ElementSame>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(attributeList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 数据元同义清洗-同义词配置保存
     * 
     * @param ceshi
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "equal/save", method = RequestMethod.POST)
    public ResponseEntity<String> save(ElementSame elementSame) {
        try {
        	if (null == elementSame.getId()) {
        		elementSame.preInsert();
            	this.elementSameService.saveSelective(elementSame);
            }
            else {
            	elementSame.preUpdate();
            	this.elementSameService.updateSelective(elementSame);
			}
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    /**
     * 数据元同义清洗-同义词的删除
     * @param id
     * @return
     */
    @RequestMapping(value = "equal/delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(Integer id) {
        try {
            this.elementSameService.deleteById(id);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    
    /**
     * 数据元同义清洗-根据同义词去数据元池查找同义词
     * 
     * @return
     */
    @RequestMapping(value = "equal/allList", method = RequestMethod.GET)
    public ResponseEntity<List<Map<String, Object>>> equalAllList() {
    	try {
    	List<Map<String, Object>> allList = this.elementSameService.queryEqualList();
            return ResponseEntity.ok(allList);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
   /**
    * 数据元同义清洗-根据同义词ID查询数据元池中的信息项数据
    * 
    * @param page
    * @return
    */
    @RequestMapping(value = "equal/listById", method = RequestMethod.GET)
    public ResponseEntity<Page<ElementPool>> queryElePoolById(Page<ElementPool> page) {
        try {
            PageInfo<ElementPool> eleInfo=this.elementPoolService.queryElePoolById(page);
            List<ElementPool> elPools=eleInfo.getList();
            Page<ElementPool> elPage=new Page<ElementPool>();
            
            elPage.setTotal(eleInfo.getTotal());
            elPage.setRows(elPools);
            return ResponseEntity.ok(elPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    /**
     * 数据元同义清洗-根据数据元池的信息项ID查找关联的信息资源
     * 
     * @param page
     * @return
     */
   /* @RequestMapping(value = "equal/infoListByEleId", method = RequestMethod.GET)
    public ResponseEntity<Page<Information>> queryInfoListByEleId(Page<Information> page){
        
        try {
            PageInfo<Information> infos=this.informationService.queryElePoolById(page);
            List<Information> infList=infos.getList();
            Page<Information> iPage =new Page<Information>();
            
            iPage.setTotal(infos.getTotal());
            iPage.setRows(infList);
            
            return ResponseEntity.ok(iPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }*/
    
    @RequestMapping(value = "equal/infoListByEleId", method = RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> queryInfoListByEleId(Page<Information> page){
        
        try {
            PageInfo<Information> infos=this.informationService.queryElePoolById(page);
            List<Information> iList=infos.getList();
            List<Map<String, Object>> list = Lists.newArrayList();
            for (Information s : iList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", s.getId());
                map.put("companyId", s.getCompanyId());
                map.put("companyName", s.getCompanyName());
                map.put("nameEn", s.getNameEn());
                map.put("nameCn", s.getNameCn());
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
                map.put("tbName", s.getTbName());
                if(s.getIsAudit()==0){
                    map.put("auditName", "待审核");
                }else{
                    map.put("auditName", "已审核");
                }
                String info = s.getInfo();
                if (!StringUtils.isBlank(info))
                    map = MapUtil.infoToMap(map, info);
                list.add(map);
            }
            Page<Map<String, Object>> resPage = new Page<Map<String, Object>>();
            resPage.setTotal((long) iList.size());
            resPage.setRows(list);
            return ResponseEntity.ok(resPage);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
  
    
    
    /**
     * 数据元同义清洗-查看-数据元池的信息项ID查找关联的信息资源
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "equal/eleByInfoId", method = RequestMethod.GET)
    public ResponseEntity<Page<Element>> queryEleByInfoId(Page<Element> page,Integer id){
        
        try {
            PageInfo<Element> pageInfo = this.elementService.queryEleByInfoId(page,id);
            List<Element> elementList = pageInfo.getList();
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
     * 数据元同义清洗-清洗数据元池数据
     * 
     * @param elementPool
     * @return
     */
    @RequestMapping(value = "equal/cleanElePool", method = RequestMethod.POST)
    public ResponseEntity<String> cleanElePool(ElementPool elementPool) {
        try {
            if (null == elementPool.getId()) {
                elementPool.preInsert();
                if (this.elementPoolService.saveSelective(elementPool)>0) {
                    this.elementPoolService.deleteByIds(elementPool.getDelId());
                }
            } else {
                elementPool.preUpdate();
                this.elementPoolService.updateSelective(elementPool);
            }
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    
    
    
    /**
     * 公共数据元池数据删除
     * 
     * @param elementPool
     * @return
     */
    @RequestMapping(value = "public/delete", method = RequestMethod.POST)
    public ResponseEntity<String> deletePub(ElementPool elementPool) {
        try {
            elementPool.preUpdate();
            elementPool.setPublicId(0);
            this.elementPoolService.updateSelective(elementPool);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 公共数据元池-添加公共信息
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "public/toPub", method = RequestMethod.POST)
    public ResponseEntity<String> updateToPub(String ids){
        try {
            this.elementPoolService.updateToPub(ids);
            return ResponseEntity.ok(Global.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
}
