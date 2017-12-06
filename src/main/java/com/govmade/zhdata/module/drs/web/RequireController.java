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
import com.govmade.zhdata.module.drs.pojo.Require;
import com.govmade.zhdata.module.drs.service.RequireService;




@Controller
@RequestMapping(value="/catalogset/require")
public class RequireController {

    @Autowired
    private RequireService requireService;

    
    /**
     * 跳转至需求目录页面
     * 
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String toShareOpen() {

        return "modules/catalogset/requireIndex";
    }

    
    
    
    /**
     * 新增、修改需求目录
     * 
     * @param requires
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Require require){
        try {
            if (require.getId()==null) {
               require.preInsert();
               this.requireService.saveSelective(require);
           }else {
                require.preUpdate();
                this.requireService.updateSelective(require);
            }
            return ResponseEntity.ok(Global.INSERT_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    
    /**
     * 查询需求目录列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Require>> list(Page<Require> page) {
        try {
            PageInfo<Require> pageInfo = requireService.queryAllList(page);
            List<Require> reList = pageInfo.getList();
            Page<Require> resPage = new Page<Require>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(reList);
            
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    
    /**
     * 删除需求目录
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids){
        try {
            this.requireService.deleteByIds(ids);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
}
