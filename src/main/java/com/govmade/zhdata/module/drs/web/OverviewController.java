package com.govmade.zhdata.module.drs.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.govmade.zhdata.module.drs.dao.ElementDao;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.InfoSearch;
import com.govmade.zhdata.module.drs.service.InfoSearchService;


@Controller
@RequestMapping(value="/panel/overview")
public class OverviewController {

    @Autowired
    private InfoSearchService infoSearchService;
    
    @Autowired
    private ElementDao elementDao;

    @RequestMapping(method = RequestMethod.GET)
    public String toOverview() {

        return "modules/panel/overview";
    }

    
    /**
     * 查找热门信息搜索资源
     * 
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<List<InfoSearch>> queryHotInfo() {
        List<InfoSearch> hotInfo = infoSearchService.queryHotInfo();

        return ResponseEntity.ok(hotInfo);
    }
    
    
    /**
     * 查找热门数据元
     * 
     */
    @RequestMapping(value="hotItem",method=RequestMethod.GET)
    public ResponseEntity<List<Element>> queryHotItem(){
        List<Element> elements=this.elementDao.queryHotItem();
        return ResponseEntity.ok(elements);
    }
    
}
