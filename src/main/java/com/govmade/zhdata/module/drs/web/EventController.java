package com.govmade.zhdata.module.drs.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.govmade.zhdata.module.drs.service.SystemService;

@Controller
@RequestMapping(value = "event/")
public class EventController {

    @Autowired
    private SystemService systemService;

    @RequestMapping(value="neaten",method = RequestMethod.GET)
    public String toNeaten() {
        return "modules/event/neatenIndex";
    }
    
    // @RequestMapping(value="check",method = RequestMethod.GET)
    // public String toInfoCheck() {
    //     return "modules/assets/systemCheck";
    // }

    
}
