package com.govmade.zhdata.module.drs.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
@RequestMapping(value = "assets/yjSystem")
public class YjSystemController {

	@RequestMapping(method = RequestMethod.GET)
	public String toYjSystem() {
		return "modules/assets/yjSystemIndex";
	}
}
