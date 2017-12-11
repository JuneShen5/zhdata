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
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.drs.service.YjSystemService;

@Controller
@RequestMapping(value = "assets/yjSystem")
public class YjSystemController {

    @RequestMapping(method = RequestMethod.GET)
    public String toYjSystem() {
        return "modules/assets/yjSystemIndex";
    }

    @Autowired
    private YjSystemService yjSystemService;

    /**
     * 已建系统查询
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<YjSystems>> queryAllList(Page<YjSystems> page) {

        try {
            PageInfo<YjSystems> pageInfo = yjSystemService.queryAllList(page);

            List<YjSystems> yjSystemsList = pageInfo.getList();

            Page<YjSystems> resPage = new Page<YjSystems>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(yjSystemsList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);

    }

    /**
     * 已建系统保存，修改
     * 
     * @param yjSystems
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(YjSystems yjSystems) {
        try {
            if (yjSystems.getId() == null) {
                yjSystems.preInsert();
                this.yjSystemService.saveSelective(yjSystems);
            } else {
                yjSystems.preUpdate();
                this.yjSystemService.updateSelective(yjSystems);
            }
            return ResponseEntity.ok(Global.INSERT_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 已建系统删除
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) {
        try {
            this.yjSystemService.deleteByIds(ids);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
}
