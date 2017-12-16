package com.govmade.zhdata.module.sys.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.config.ExcelConstant;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.DateUtils;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.sys.pojo.Dict;
import com.govmade.zhdata.module.sys.service.DictService;

@Controller
@RequestMapping(value = "settings/dict")
public class DictController {

    @Autowired
    private DictService dictService;

    @RequestMapping(method = RequestMethod.GET)
    public String toDict() {
        return "modules/settings/dictIndex";
    }

    /**
     * 查询字典列表数据
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Dict>> list(Page<Dict> page) {
        try {
            PageInfo<Dict> pageInfo = dictService.findAll(page);
            List<Dict> dictList = pageInfo.getList();
            /*if (dictList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }*/
            Page<Dict> resPage = new Page<Dict>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(dictList);
            
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 新增或修改字典数据
     * 
     * @param dict
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Dict dict){
        try {
            if (null == dict.getId()) {
            	dict.preInsert();
            	this.dictService.saveSelective(dict);
            }else {
            	dict.preUpdate();
                this.dictService.updateSelective(dict);
			}
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    /**
     * 删除字典数据
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids){
        try {
           dictService.deleteByIds(ids);
           return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 根据字段的value获取label值
     * 
     * @param value
     * @return
     */
    @RequestMapping(value = "queryDictByValue", method = RequestMethod.GET)
    public ResponseEntity<String> queryDictByValue(Integer value) {
        
        try {
            Dict dict=this.dictService.queryDictByValue(value);
            String val=dict.getLabel();
            return ResponseEntity.ok(val);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    

    
}
