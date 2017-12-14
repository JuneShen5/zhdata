package com.govmade.zhdata.module.drs.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.dao.InformationDao;
import com.govmade.zhdata.module.drs.dao.SystemDao;
import com.govmade.zhdata.module.drs.mapper.ElementMapper;
import com.govmade.zhdata.module.drs.mapper.InformationMapper;
import com.govmade.zhdata.module.drs.mapper.SystemMapper;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.pojo.Systems;
import com.govmade.zhdata.module.sys.mapper.CompanyMapper;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Controller
@RequestMapping(value = "panel")
public class AssetsStatController {

    @Autowired
    private SystemMapper systemMapper;
    
    @Autowired
    private SystemDao systemDao;
    
    @Autowired
    private ElementMapper elementMapper;
    
    @Autowired
    private InformationMapper informationMapper;
    
    @Autowired
    private InformationDao informationDao;
    
    @Autowired
    private CompanyMapper companyMapper;
    
    
    @Autowired
    private CompanyService companyService;
    
    
    
    @RequestMapping(value = "ass",method = RequestMethod.GET)
    public String toLink() {
        return "modules/panel/assetsStatIndex";
    }

    
    /*@RequestMapping(value = "overview", method = RequestMethod.GET)
    public String toOverview() {
        return "modules/panel/overview";
    }*/
    
    
    /**
     * 获取数据统计
     * 
     * @return
     */
    /*@RequestMapping(value="ass/queryCountList",method=RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> queryCountList(){
        Map<String, Object> map1=Maps.newHashMap();
        
        Company comp =new Company();
        comp.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer compCount=0;
        if (this.companyMapper.selectCount(comp)>0) {
            compCount=this.companyMapper.selectCount(comp);
        }
        
        Element elee=new Element();
        elee.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer eleCount=0;
        if (this.elementMapper.selectCount(elee)>0) {
            eleCount=this.elementMapper.selectCount(elee);
        }
        Information infoo=new Information();
        infoo.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer infoCount=0;
        if (this.informationMapper.selectCount(infoo)>0) {
            infoCount=this.informationMapper.selectCount(infoo);
        }
        map1.put("compCount", compCount);
        map1.put("eleCount", eleCount);
        map1.put("infoCount", infoCount);
        
        Company company=new Company();
        company.setDelFlag(Global.DEL_FLAG_NORMAL);
        List<Company> companylList=this.companyMapper.select(company);
        List<Map<String, Object>> list=Lists.newArrayList();
        
        for (Company c : companylList) {
            Integer companyId=c.getId();
            Map<String, Object> map2=Maps.newHashMap();
            Systems sys=new Systems();
            sys.setCompanyId(companyId);
            sys.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer sCount=0;
            if (this.systemMapper.selectCount(sys)>0) {
                sCount=this.systemMapper.selectCount(sys);
            }
            Element ele=new Element();
            ele.setCompanyId(companyId);
            ele.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer eCount=0;
            if (this.elementMapper.selectCount(ele)>0) {
                eCount=this.elementMapper.selectCount(ele);
            }
            Information info=new Information();
            info.setCompanyId(companyId);
            info.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount=0;
            if (this.informationMapper.selectCount(info)>0) {
                iCount=this.informationMapper.selectCount(info);
            }
            Information info1=new Information();
            info1.setCompanyId(companyId);
            info1.setInfoType1(1);
            info1.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount1=0;
            if (this.informationMapper.selectCount(info1)>0) {
                iCount1=this.informationMapper.selectCount(info1);
            }
            Information info2=new Information();
            info2.setCompanyId(companyId);
            info2.setInfoType1(51);
            info2.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount2=0;
            if (this.informationMapper.selectCount(info2)>0) {
                iCount2=this.informationMapper.selectCount(info2);
            }
            
            
            Integer iCount3=0;
            String shareType="1";
            if (this.informationDao.queryInfoByshareType(companyId,shareType)>0) {
                iCount3=this.informationDao.queryInfoByshareType(companyId,shareType);
            }
            
            Integer iCount4=0;
            shareType="2";
            if (this.informationDao.queryInfoByshareType(companyId,shareType)>0) {
                iCount4=this.informationDao.queryInfoByshareType(companyId,shareType);
            }
            
            Integer iCount5=0;
            shareType="3";
            if (this.informationDao.queryInfoByshareType(companyId,shareType)>0) {
                iCount5=this.informationDao.queryInfoByshareType(companyId,shareType);
            }
            
            map2.put("companyId", c.getId());
            map2.put("companyName", c.getName());
            map2.put("sCount", sCount);
            map2.put("eCount", eCount);
            map2.put("iCount", iCount);
            map2.put("iCount1", iCount1);
            map2.put("iCount2", iCount2);
            map2.put("iCount3", iCount3);
            map2.put("iCount4", iCount4);
            map2.put("iCount5", iCount5);
            list.add(map2);
        }
        map1.put("data", list);
        return ResponseEntity.ok(map1);
        
    }*/
    
    
    /**
     * 资源统计-信息资源、信息项等的总数统计
     * 
     * @return
     */
    @RequestMapping(value="ass/queryCount",method=RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> queryCountList(){
        Map<String, Object> map1=Maps.newHashMap();
        
        Company comp =new Company();
        comp.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer compCount=0;
        if (this.companyMapper.selectCount(comp)>0) {
            compCount=this.companyMapper.selectCount(comp);
        }
        
        Element elee=new Element();
        elee.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer eleCount=0;
        if (this.elementMapper.selectCount(elee)>0) {
            eleCount=this.elementMapper.selectCount(elee);
        }
        Information infoo=new Information();
        infoo.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer infoCount=0;
        if (this.informationMapper.selectCount(infoo)>0) {
            infoCount=this.informationMapper.selectCount(infoo);
        }
        map1.put("compCount", compCount);
        map1.put("eleCount", eleCount);
        map1.put("infoCount", infoCount);
        
        
        return ResponseEntity.ok(map1);
        
    }
    
    
    
    /**
     * 资源统计-每个部门下信息资源、信息项等的统计
     * 
     * @param page
     * @param companyIds
     * @return
     */
    @RequestMapping(value="ass/queryCountList",method=RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> list(Page<Company> page,String companyIds) {
        
       // page = this.companyService.getPageForSearch(page);
        
       /* Map<String, Object> map1=Maps.newHashMap();
        
        Company comp =new Company();
        comp.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer compCount=0;
        if (this.companyMapper.selectCount(comp)>0) {
            compCount=this.companyMapper.selectCount(comp);
        }
        
        Element elee=new Element();
        elee.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer eleCount=0;
        if (this.elementMapper.selectCount(elee)>0) {
            eleCount=this.elementMapper.selectCount(elee);
        }
        Information infoo=new Information();
        infoo.setDelFlag(Global.DEL_FLAG_NORMAL);
        Integer infoCount=0;
        if (this.informationMapper.selectCount(infoo)>0) {
            infoCount=this.informationMapper.selectCount(infoo);
        }
        map1.put("compCount", compCount);
        map1.put("eleCount", eleCount);
        map1.put("infoCount", infoCount);
        */
        
        
        /*Company company=new Company();
        company.setDelFlag(Global.DEL_FLAG_NORMAL);*/
        //List<Company> companylList=this.companyMapper.select(company);
        
        page.startPage();
        Integer total=this.companyService.queryTotal(page,companyIds);
        List<Company> companylList=this.companyService.queryListById(page,companyIds);
        List<Map<String, Object>> list=Lists.newArrayList();
        
        for (Company c : companylList) {
            Integer companyId=c.getId();
            Map<String, Object> map2=Maps.newHashMap();
            Systems sys=new Systems();
            sys.setCompanyId(companyId);
            sys.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer sCount=0;
            if (this.systemMapper.selectCount(sys)>0) {
                sCount=this.systemMapper.selectCount(sys);
            }
            Element ele=new Element();
            ele.setCompanyId(companyId);
            ele.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer eCount=0;
            if (this.elementMapper.selectCount(ele)>0) {
                eCount=this.elementMapper.selectCount(ele);
            }
            Information info=new Information();
            info.setCompanyId(companyId);
            info.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount=0;
            if (this.informationMapper.selectCount(info)>0) {
                iCount=this.informationMapper.selectCount(info);
            }
            Information info1=new Information();
            info1.setCompanyId(companyId);
            info1.setInfoType1(1);
            info1.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount1=0;
            if (this.informationMapper.selectCount(info1)>0) {
                iCount1=this.informationMapper.selectCount(info1);
            }
            Information info2=new Information();
            info2.setCompanyId(companyId);
            info2.setInfoType1(51);
            info2.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount2=0;
            if (this.informationMapper.selectCount(info2)>0) {
                iCount2=this.informationMapper.selectCount(info2);
            }
            
            
            Integer iCount3=0;
            String shareType="1";
            if (this.informationDao.queryInfoByshareType(companyId,shareType)>0) {
                iCount3=this.informationDao.queryInfoByshareType(companyId,shareType);
            }
            
            Integer iCount4=0;
            shareType="2";
            if (this.informationDao.queryInfoByshareType(companyId,shareType)>0) {
                iCount4=this.informationDao.queryInfoByshareType(companyId,shareType);
            }
            
            Integer iCount5=0;
            shareType="3";
            if (this.informationDao.queryInfoByshareType(companyId,shareType)>0) {
                iCount5=this.informationDao.queryInfoByshareType(companyId,shareType);
            }
            
            map2.put("companyId", c.getId());
            map2.put("companyName", c.getName());
            map2.put("sCount", sCount);
            map2.put("eCount", eCount);
            map2.put("iCount", iCount);
            map2.put("iCount1", iCount1);
            map2.put("iCount2", iCount2);
            map2.put("iCount3", iCount3);
            map2.put("iCount4", iCount4);
            map2.put("iCount5", iCount5);
            list.add(map2);
        }
        //map1.put("data", list);
        Page<Map<String, Object>> resPage = new Page<Map<String, Object>>();
        resPage.setTotal((long) total);
        resPage.setRows(list);
        return ResponseEntity.ok(resPage);
        
    }
    
    
}
