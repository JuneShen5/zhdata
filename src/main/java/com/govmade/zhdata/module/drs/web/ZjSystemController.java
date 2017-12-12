package com.govmade.zhdata.module.drs.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;
import com.govmade.zhdata.module.drs.service.ZjSystemService;


@Controller
@RequestMapping(value = "assets/zjSystem")
public class ZjSystemController {

	@RequestMapping(method = RequestMethod.GET)
	public String toZjSystem() {
		return "modules/assets/zjSystemIndex";
	}
	
	@Autowired
	private ZjSystemService zjSystemService;
	
	/**
	 * 在建系统查询
	 * @param page
	 * @return
	*/
	@RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<ZjSystems>> queryAllList(Page<ZjSystems> page) {
    	
    	
        try {
            PageInfo<ZjSystems> pageInfo = zjSystemService.queryAllList(page);
            
            List<ZjSystems> zjSystemsList = pageInfo.getList();
            
            Page<ZjSystems> resPage = new Page<ZjSystems>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(zjSystemsList);
            
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        
    }
	
	/**
	 * 在建系统保存，修改
	 * @param zjSystems
	 * @return
	*/
	@RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(ZjSystems zjSystems){
        try {
            if (zjSystems.getId()==null) {
               zjSystems.preInsert();
               this.zjSystemService.saveSelective(zjSystems);
           }else {
                zjSystems.preUpdate();
                this.zjSystemService.updateSelective(zjSystems);
            }
            return ResponseEntity.ok(Global.INSERT_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
	
	/**
	 * 在建系统删除
	 * @param ids
	 * @return 
	*/
	@RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids){
        try {
            this.zjSystemService.deleteByIds(ids);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
}