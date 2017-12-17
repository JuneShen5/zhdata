package com.govmade.zhdata.module.drs.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseController;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.module.drs.pojo.NjSystems;
import com.govmade.zhdata.module.drs.service.NjSystemService;

@Controller
@RequestMapping(value = "assets/njSystem")
public class NjSystemController  extends BaseController<NjSystems>{

    @RequestMapping(method = RequestMethod.GET)
    public String toNjSystem() {
        return "modules/assets/njSystemIndex";
    }

    @Autowired
    private NjSystemService njSystemService;
    @Override
    protected void getFileName(){
        super.chTableName = "拟建信息系统";
        super.chTableName = "拟建信息系统";
        super.templatFile = "njTemplate.xlsx";
    }
    
    @Override
    protected void getReadExcelStarLine(){
        super.commitRow = 500;
        super.startRow = 7;
        super.columnIndex = 1;
    }       
    @Override
    protected Integer getattributeType(){
        return 3;
    }
    
    @Override
    protected BaseService<NjSystems> getService() {
       return njSystemService;
    }
    
    /**
     * 导出数据时查询所有数据
     */
    @Override
    public  List<Map<String, Object>> queryDataForExp() {
        
        List<NjSystems> njSystemsList = njSystemService.queryForExport();
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for (NjSystems data : njSystemsList) {
            infoList.add(MapUtil.beansToMap(data));
        }
        return infoList;
    }       
    /**
     * 拟建系统查询
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<NjSystems>> queryAllList(Page<NjSystems> page) {

        try {
            PageInfo<NjSystems> pageInfo = njSystemService.queryAllList(page);

            List<NjSystems> njSystemsList = pageInfo.getList();

            Page<NjSystems> resPage = new Page<NjSystems>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(njSystemsList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);

    }

    /**
     * 拟建系统保存，修改
     * 
     * @param njSystems
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(NjSystems njSystems) {
        try {
            if (njSystems.getId() == null) {
                njSystems.preInsert();
                this.njSystemService.saveSelective(njSystems);
            } else {
                njSystems.preUpdate();
                this.njSystemService.updateSelective(njSystems);
            }
            return ResponseEntity.ok(Global.INSERT_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 拟建系统删除
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) {
        try {
            this.njSystemService.deleteByIds(ids);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
}
