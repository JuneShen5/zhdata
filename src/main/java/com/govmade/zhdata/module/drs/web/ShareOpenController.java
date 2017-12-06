package com.govmade.zhdata.module.drs.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.govmade.zhdata.module.drs.service.InformationService;




@Controller
@RequestMapping(value="/catalogset/shareOpen")
public class ShareOpenController {

    @Autowired
    private InformationService infoService;


    @RequestMapping(method = RequestMethod.GET)
    public String toShareOpen() {

        return "modules/catalogset/shareOpenIndex";
    }

    
    
    /**
     * 查询共享开放数据
     * 
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Map<String, Integer>> count() {
        Integer count1 = infoService.shareCount();
        Integer count2 = infoService.openCount();

        Map<String, Integer> map = new HashMap<String, Integer>();
        map.put("shareCount", count1);
        map.put("openCount", count2);

        return ResponseEntity.ok(map);
    }

    
    
   
    
}
