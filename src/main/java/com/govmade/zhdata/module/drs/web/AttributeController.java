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
import com.govmade.zhdata.common.utils.ChineseTo;
import com.govmade.zhdata.module.drs.pojo.Attribute;
import com.govmade.zhdata.module.drs.service.AttributeService;

@Controller
@RequestMapping(value = "/settings/attribute")
public class AttributeController {

    @Autowired
    private AttributeService attributeService;

    @RequestMapping(method = RequestMethod.GET)
    public String toAttribute() {
        return "modules/settings/attributeIndex";
    }

    /**
     * 查询属性配置列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Attribute>> list(Page<Attribute> page) {
        try {
            PageInfo<Attribute> pageInfo = this.attributeService.queryList(page);
            List<Attribute> attributeList = pageInfo.getList();
            /*if (attributeList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            Page<Attribute> resPage = new Page<Attribute>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(attributeList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    
    /**
     * 新增或修改属性
     * 
     * @param attribute
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Attribute attribute) throws Exception {
        try {
            if (attribute.getId() == null) {
                attribute.preInsert();
                String pinyin = ChineseTo.getPingYin(attribute.getNameCn());
                attribute.setNameEn(pinyin);
                this.attributeService.save(attribute);
            } else {
                attribute.preUpdate();
                String pinyin = ChineseTo.getPingYin(attribute.getNameCn());
                attribute.setNameEn(pinyin);
                this.attributeService.updateSelective(attribute);
            }
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    
    /**
     * 删除或批量删除属性数据
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            attributeService.deleteByIds(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

}
