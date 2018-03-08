package com.govmade.zhdata.module.drs.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "catalog/code")
public class CodeController <Code>{

    @RequestMapping(method = RequestMethod.GET)
    public String toCode() {
        return "modules/catalog/codeIndex";
    }

    
    
}
