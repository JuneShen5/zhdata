package com.govmade.zhdata.module.drs.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.abel533.entity.Example;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.drs.dao.InformationDao;
import com.govmade.zhdata.module.drs.dao.SystemDao;
import com.govmade.zhdata.module.drs.dao.YjSystemDao;
import com.govmade.zhdata.module.drs.mapper.ElementMapper;
import com.govmade.zhdata.module.drs.mapper.InformationMapper;
import com.govmade.zhdata.module.drs.mapper.SystemMapper;
import com.govmade.zhdata.module.drs.mapper.YjSystemMapper;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.pojo.Systems;
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.drs.service.YjSystemService;
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
    
    @Autowired
    private YjSystemMapper yjSystemMapper;
     
    @Autowired
    private YjSystemDao yjSystemDao;
    
    @Autowired
    private YjSystemService yjSystemService;
    
    /**
     * 跳转至系统统计页面
     * 
     * @return
     */
    @RequestMapping(value = "ass",method = RequestMethod.GET)
    public String toLink() {
        return "modules/panel/assetsStatIndex";
    }

    
    /*@RequestMapping(value = "overview", method = RequestMethod.GET)
    public String toOverview() {
        return "modules/panel/overview";
    }*/
    
    /**
     * 跳转至部门基本信息页面
     * 
     * @return
     */
    @RequestMapping(value = "companyInfo",method = RequestMethod.GET)
    public String toCompanyInfo() {
        return "modules/panel/companyInfo";
    }

    
    /**
     * 系统统计-已建系统、年度系统运维总金额等的统计--根据部门权限查询
     * 
     * @return
     */
    /*@RequestMapping(value="ass/querySum",method=RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> querySum(){
        
        Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        List<Integer> comList=Lists.newArrayList();
        if (roleId!=1) {
            comList.add(companyId);
            findAllSubNode(companyId, comList);
        }
        
        Map<String, Object> map=Maps.newHashMap();
        Integer ysCount=0;
        Integer ysCount1=this.yjSystemDao.querySysCount(new YjSystems(),comList);
        if (ysCount1 >0) {
            ysCount=ysCount1;
        }
        Double ywjSum=0.0000;
        Double ywjSum1=this.yjSystemDao.queryYwjSum(new YjSystems(),comList);
        if (ywjSum1!=null) {
            ywjSum=ywjSum1;
        }
        
        Double ygywSum=0.0000;
        Double ygywSum1=this.yjSystemDao.queryYgywSum(new YjSystems(),comList);
        if (ygywSum1!=null) {
            ygywSum=ygywSum1;
        }
        
        map.put("ysCount", ysCount);
        map.put("ywjSum", ywjSum);
        map.put("ygywSum", ygywSum);
        
        return ResponseEntity.ok(map);
        
        
        
    }*/
    
    
    @RequestMapping(value="ass/querySum",method=RequestMethod.GET)
    public ResponseEntity<YjSystems> querySum(Page<YjSystems> page){
      
       YjSystems yjSystems= JsonUtil.readValue(page.getObj(), YjSystems.class);
       
       
       Integer roleId=UserUtils.getCurrentUser().getRoleId();
       Integer companyId=UserUtils.getCurrentUser().getCompanyId();
       List<Integer> comList=Lists.newArrayList();
        if (roleId!=1&&yjSystems.getIsAuthorize()==1) {
            comList.add(companyId);
            findAllSubNode(companyId, comList);
        }
        YjSystems yjSystems2=this.yjSystemService.querySum(yjSystems,comList);
        
        
        
        /*Map<String, Object> map=Maps.newHashMap();
        Integer ysCount=0;
        Integer ysCount1=this.yjSystemDao.querySysCount(new YjSystems(),comList);
        if (ysCount1 >0) {
            ysCount=ysCount1;
        }
        Double ywjSum=0.0000;
        Double ywjSum1=this.yjSystemDao.queryYwjSum(new YjSystems(),comList);
        if (ywjSum1!=null) {
            ywjSum=ywjSum1;
        }
        
        Double ygywSum=0.0000;
        Double ygywSum1=this.yjSystemDao.queryYgywSum(new YjSystems(),comList);
        if (ygywSum1!=null) {
            ygywSum=ygywSum1;
        }
        
        map.put("ysCount", ysCount);
        map.put("ywjSum", ywjSum);
        map.put("ygywSum", ygywSum);*/
        
        return ResponseEntity.ok(yjSystems2);
        
        
        
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
            for (Company c : companies) {
                comList.add(c.getId());
                 findAllSubNode(c.getId(),comList);
            }
        }
        
    }
    
    
    
    /**
     * 资源概览-每个部门下信息资源、信息项等的统计
     * 
     * @param page
     * @param companyIds
     * @return
     */
    @RequestMapping(value="ass/queryCountList",method=RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> queryCountList(Page<Company> page,String companyIds) {
        
        page = this.companyService.getPageForSearch(page);
        
        Integer total=this.companyService.queryTotal(page,companyIds);
        List<Company> companylList=this.companyService.queryListById(page,companyIds);
        List<Map<String, Object>> list=Lists.newArrayList();
        
        for (Company c : companylList) {
            Integer companyId=c.getId();
            Map<String, Object> map2=Maps.newHashMap();
           /* Systems sys=new Systems();
            sys.setCompanyId(companyId);
            sys.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer sCount=0;
            Integer sCount1=this.systemMapper.selectCount(sys);
            if (sCount1 >0) {
                sCount=sCount1;
            }*/
            
            YjSystems yjSystems =new YjSystems();
            yjSystems.setCompanyId(companyId);
            yjSystems.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer sCount=0;
            Integer sCount1=this.yjSystemMapper.selectCount(yjSystems);
            if (sCount1>0) {
                sCount=sCount1;
            }
            
            
            Element ele=new Element();
            ele.setCompanyId(companyId);
            ele.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer eCount=0;
            Integer eCount1=this.elementMapper.selectCount(ele);
            if (eCount1>0) {
                eCount=eCount1;
            }
            Information info=new Information();
            info.setCompanyId(companyId);
            info.setDelFlag(Global.DEL_FLAG_NORMAL);
            info.setIsAudit(Global.AUDIT_FLAG_YES);
            Integer iCount=0;
            Integer inCount=this.informationMapper.selectCount(info);
            if (inCount >0) {
                iCount=inCount;
            }
            Information info1=new Information();
            info1.setCompanyId(companyId);
            info1.setInfoType1(1);
            info1.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount1=0;
            Integer infCount1=this.informationMapper.selectCount(info1);
            if (infCount1>0) {
                iCount1=infCount1;
            }
            Information info2=new Information();
            info2.setCompanyId(companyId);
            info2.setInfoType1(51);
            info2.setDelFlag(Global.DEL_FLAG_NORMAL);
            Integer iCount2=0;
            Integer inforCount2=this.informationMapper.selectCount(info2);
            if (inforCount2>0) {
                iCount2=inforCount2;
            }
            
            
            Integer iCount3=0;
            String shareType="1";
            Integer isCount1=this.informationDao.queryInfoByshareType(companyId,shareType);
            if (isCount1>0) {
                iCount3=isCount1;
            }
            
            Integer iCount4=0;
            shareType="2";
            Integer isCount2=this.informationDao.queryInfoByshareType(companyId,shareType);
            if (isCount2>0) {
                iCount4=isCount2;
            }
            
            Integer iCount5=0;
            shareType="3";
            Integer isCount3=this.informationDao.queryInfoByshareType(companyId,shareType);
            if (isCount3 >0) {
                iCount5=isCount3;
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
