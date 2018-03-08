package com.govmade.zhdata.module.drs.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "catalog/item")
public class ItemController {

    @RequestMapping(method = RequestMethod.GET)
    public String toCItem() {
        return "modules/catalog/itemIndex";
    }

    
    
}
