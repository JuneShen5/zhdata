package com.govmade.zhdata.module.sys.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.sys.pojo.Site;
import com.govmade.zhdata.module.sys.service.DictService;
import com.govmade.zhdata.module.sys.service.SiteService;

@Controller
@RequestMapping(value = "settings/site")
public class SiteController {

    @Autowired
    private DictService dictService;
    
    @Autowired
    private SiteService siteService;

    @RequestMapping(method = RequestMethod.GET)
    public String toSite() {
        return "modules/settings/siteIndex";
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Site>> list(Page<Site> page) {
        try {
            /*EhcacheUtil.getInstance().put(EhcacheUtil.DICT_CACHE, "site_level", dictService.getDictsForElement("site_level"));*/
            PageInfo<Site> pageInfo = this.siteService.queryList(page);
            
            Page<Site> resPage = new Page<Site>();
            
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(pageInfo.getList());

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Site site) throws Exception {
        try {
            if (null == site.getId()) {
                site.preInsert();
                this.siteService.saveSelective(site);
            } else {
                site.preUpdate();
                this.siteService.updateSelective(site);
            }
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            siteService.deleteByIds(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    

}
