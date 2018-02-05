package com.govmade.zhdata.module.sys.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.sys.pojo.Log;
import com.govmade.zhdata.module.sys.service.LogService;

@Controller
@RequestMapping(value = "/sys/logIndex")
public class LogController {

    @Autowired
    private LogService logService;

    @RequestMapping(method = RequestMethod.GET)
    public String toLog() {

        return "modules/sys/logIndex";
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Log>> queryList(Page<Log> page) {
        try {
            PageInfo<Log> pageInfo = logService.findAll(page);

            List<Log> logList = pageInfo.getList();

            Page<Log> resPage = new Page<Log>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(logList);

            System.out.println(logList);
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);

    }

}