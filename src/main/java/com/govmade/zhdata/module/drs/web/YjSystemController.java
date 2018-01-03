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
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;
import com.govmade.zhdata.module.drs.service.NjSystemService;
import com.govmade.zhdata.module.drs.service.YjSystemService;
import com.govmade.zhdata.module.drs.service.ZjSystemService;

@Controller
@RequestMapping(value = "assets/yjSystem")
public class YjSystemController extends BaseController<YjSystems>{

    @RequestMapping(method = RequestMethod.GET)
    public String toYjSystem() {
        return "modules/assets/yjSystemIndex";
    }

    @Autowired
    private YjSystemService yjSystemService;
    
    @Autowired
    private NjSystemService njSystemService;
    
    @Autowired
    private ZjSystemService zjSystemService;

    @Override
    protected void getFileName(){
        super.chTableName = "已建信息系统";
        super.enTableName = "已建信息系统";
        super.templatFile = "yjTemplate.xlsx";
    }
    
    @Override
    protected void getReadExcelStarLine(){
        super.commitRow = 500;
        super.startRow = 6;
        super.columnIndex = 1;
    }       
    
    @Override
    protected BaseService<YjSystems> getService() {
       return yjSystemService;
    }
    /**
     * 导出数据时查询所有数据
     */
    @Override
    public  List<Map<String, Object>> queryDataForExp() {
        
        List<YjSystems> yjSystemsList = yjSystemService.queryForExport();
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for (YjSystems data : yjSystemsList) {
            infoList.add(MapUtil.beansToMap(data));
        }
        return infoList;
    }
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
            String name=yjSystems.getName();
            Integer companyId=yjSystems.getCompanyId();
            NjSystems record1=new NjSystems();
            record1.setName(name);
            record1.setCompanyId(companyId);
            NjSystems njSystems=this.njSystemService.queryOne(record1);
            ZjSystems record2=new ZjSystems();
            record2.setName(name);
            record2.setCompanyId(companyId);
            ZjSystems zjSystems=this.zjSystemService.queryOne(record2);
            YjSystems record3=new YjSystems();
            record3.setName(name);
            record3.setCompanyId(companyId);
            YjSystems yjSystems1=this.yjSystemService.queryOne(record3);
            
            if (yjSystems.getId() == null) {
                yjSystems.preInsert();
                if (null==njSystems && null==zjSystems && null==yjSystems1) {
                    this.yjSystemService.saveSelective(yjSystems);
                    return ResponseEntity.ok(Global.INSERT_SUCCESS);
                }else {
                    return ResponseEntity.ok("系统名称已经存在，请重新填写！");
                }
                
            } else {
                yjSystems.preUpdate();
                if (null==njSystems && null==zjSystems && null==yjSystems1) {
                    this.yjSystemService.updateSelective(yjSystems);
                    return ResponseEntity.ok(Global.UPDATE_SUCCESS);
                }else if (yjSystems1!=null&&yjSystems1.getId().intValue()==yjSystems.getId().intValue()) {
                    this.yjSystemService.updateSelective(yjSystems);
                    return ResponseEntity.ok(Global.UPDATE_SUCCESS);
                } else {
                    return ResponseEntity.ok("系统名称已经存在，请重新填写！");
                }
               
            }
            
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
