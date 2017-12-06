package com.govmade.zhdata.module.drs.web;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.service.InfoSortService;
import com.govmade.zhdata.module.drs.service.InformationService;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Controller
@RequestMapping(value = "/catalogset/res")
public class ResController {

    @Autowired
    private CompanyService companyService;
    
    @Autowired
    private InformationService infoService;
    
    @Autowired
    private InfoSortService infoSortService;

    @RequestMapping(method = RequestMethod.GET)
    public String toAttribute() {
        return "modules/catalogset/resourceIndex";
    }

    @RequestMapping(value="shareOpen",method = RequestMethod.GET)
    public String toShareOpen() {
        return "modules/catalogset/shareOpenIndex";
    }

    @RequestMapping(value="demand",method = RequestMethod.GET)
    public String toDemand() {
        return "modules/catalogset/demandIndex";
    }
    /**
     * 查询机构目录
     * 
     * @return
     */
    @RequestMapping(value="companyList",method=RequestMethod.GET)
    public ResponseEntity<List<Company>> queryCompany(Integer isAudit){
        try {
            List<Company> companyList=this.companyService.queryCompany(isAudit);
            return ResponseEntity.ok(companyList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    /**
     * 根据机构查询信息资源
     * 
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> list(Page<Information> page) {
        try {
           /* Long total = infoService.getListTotal(page);*/
            Long total = infoService.queryInfoListTotal(page);
            PageInfo<Information> pageInfo= this.infoService.findByCompanyId(page);
            List<Information> iList=pageInfo.getList();
            List<Map<String, Object>> list = Lists.newArrayList();
            for (Information s : iList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", s.getId());
                map.put("companyId", s.getCompanyId());
                map.put("name", s.getNameCn());
                String info=s.getInfo();
                if (!StringUtils.isBlank(info)) 
                 map=MapUtil.infoToMap(map, info);
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
     * 动态展示tap标题
     * 
     * @param id
     * @return
     */
    @RequestMapping(value="queryByPid",method=RequestMethod.GET)
    public ResponseEntity<List<InfoSort>> queryByPid(@RequestParam("id") Integer id){
        try {
            List<InfoSort> infoSorts= this.infoSortService.queryList(id);
            return ResponseEntity.ok(infoSorts);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
                
    }
    
    /**
     * 资源目录-根据父级ids查询
     * 
     * @param id
     * @return
     */
    @RequestMapping(value="queryListByPid",method=RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> queryListByPid(@RequestParam("ids") String ids){
        try {
            Map<String, Object> map=Maps.newHashMap();
            String[] idstr=ids.split(",");
            for (int i = 0; i < idstr.length; i++) {
                List<InfoSort> infoSorts= this.infoSortService.queryListByPid(Integer.valueOf(idstr[i]),Integer.valueOf(i+1));
                
                map.put(String.valueOf(i), infoSorts);
            }
            return ResponseEntity.ok(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
                
    }
    
    
    /**
     * 根据部门类查询
     * 
     * @param page
     * @param id
     * @return
     */
    @RequestMapping(value = "listByType", method = RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> listByType(Page<Information> page) {
        try {
           /* Long total = infoService.getListTotal(page);*/
            Long total = infoService.queryInfoListTotal(page);
            /*if (total <= 0) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            PageInfo<Information> pageInfo= this.infoService.findByCompanyId(page);
            List<Information> iList=pageInfo.getList();
            List<Map<String, Object>> list = Lists.newArrayList();
            for (Information s : iList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", s.getId());
                map.put("companyId", s.getCompanyId());
                map.put("name", s.getNameCn());
                String info=s.getInfo();
                if (!StringUtils.isBlank(info)) 
                 map=MapUtil.infoToMap(map, info);
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
     * 根据基础类查询信息
     * 
     * @param page
     * @return
     */
    @RequestMapping(value="queryInfoList",method=RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> queryInfoList(Page<Information> page) {
        try {
            Long total = infoService.queryInfoListTotal(page);
            PageInfo<Information> pageInfo= this.infoService.queryInfoList(page);
            List<Information> iList=pageInfo.getList();
            List<Map<String, Object>> list = Lists.newArrayList();
            for (Information s : iList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", s.getId());
                map.put("companyId", s.getCompanyId());
                map.put("name", s.getNameCn());
                String info=s.getInfo();
                if (!StringUtils.isBlank(info)) 
                 map=MapUtil.infoToMap(map, info);
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
}
