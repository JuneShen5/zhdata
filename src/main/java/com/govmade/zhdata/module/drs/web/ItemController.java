package com.govmade.zhdata.module.drs.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.Item;
import com.govmade.zhdata.module.drs.service.ItemService;

@Controller
@RequestMapping(value = "catalog/item")
public class ItemController {
    
    @Autowired
    private ItemService itemService;

    @RequestMapping(method = RequestMethod.GET)
    public String toItem() {
        return "modules/catalog/itemIndex";
    }

    
    /**
     * 查询数据元
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Item>> list(Page<Item> page) {
        try {
            
            PageInfo<Item> pageInfo = this.itemService.queryAlList(page);
            List<Item> items = pageInfo.getList();
            Page<Item> resPage = new Page<Item>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(items);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        
    }
    
    
}
