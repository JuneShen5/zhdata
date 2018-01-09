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
import com.govmade.zhdata.common.persistence.Message;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.module.drs.pojo.NjSystems;
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;
import com.govmade.zhdata.module.drs.service.NjSystemService;
import com.govmade.zhdata.module.drs.service.YjSystemService;
import com.govmade.zhdata.module.drs.service.ZjSystemService;

@Controller
@RequestMapping(value = "assets/zjSystem")
public class ZjSystemController extends BaseController<ZjSystems>{

    @RequestMapping(method = RequestMethod.GET)
    public String toZjSystem() {
        return "modules/assets/zjSystemIndex";
    }

    @Autowired
    private ZjSystemService zjSystemService;
    
    @Autowired
    private NjSystemService njSystemService;
    
    @Autowired
    private YjSystemService yjSystemService;
    
    @Override
    protected void getFileName(){
        super.chTableName = "在建信息系统";
        super.enTableName = "在建信息系统";
        super.templatFile = "zjTemplate.xlsx";
    }
    
    @Override
    protected void getReadExcelStarLine(){
        super.commitRow = 200;
        super.startRow = 7;
        super.columnIndex = 1;
    }       
    
    @Override
    protected BaseService<ZjSystems> getService() {
       return zjSystemService;
    }
    
    /**
     * 导出数据时查询所有数据
     */
    @Override
    public  List<Map<String, Object>> queryDataForExp() {
            
        List<ZjSystems> zjSystemsList = zjSystemService.queryForExport();
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for (ZjSystems data : zjSystemsList) {
            infoList.add(MapUtil.beansToMap(data));
        }
        return infoList;
    }
    /**
     * 在建系统查询
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<ZjSystems>> queryAllList(Page<ZjSystems> page) {

        try {
            PageInfo<ZjSystems> pageInfo = zjSystemService.queryAllList(page);

            List<ZjSystems> zjSystemsList = pageInfo.getList();

            Page<ZjSystems> resPage = new Page<ZjSystems>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(zjSystemsList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);

    }

    /**
     * 在建系统保存，修改
     * 
     * @param zjSystems
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<Message> save(ZjSystems zjSystems) {
        try {
            //String name=new String (njSystems.getName().getBytes("ISO-8859-1"), "UTF-8");
            String name=zjSystems.getName();
            Integer companyId=zjSystems.getCompanyId();
            NjSystems record1=new NjSystems();
            record1.setName(name);
            record1.setCompanyId(companyId);
            NjSystems njSystems=this.njSystemService.queryOne(record1);
            ZjSystems record2=new ZjSystems();
            record2.setName(name);
            record2.setCompanyId(companyId);
            ZjSystems zjSystems1=this.zjSystemService.queryOne(record2);
            YjSystems record3=new YjSystems();
            record3.setName(name);
            record3.setCompanyId(companyId);
            YjSystems yjSystems=this.yjSystemService.queryOne(record3);
            
            Message message1=new Message();
            message1.setStatus(0);
            message1.setMessage("系统名称已经存在，请重新填写！");
            
            if (zjSystems.getId() == null) {
                zjSystems.preInsert();
                if (null==njSystems && null==zjSystems1 && null==yjSystems) {
                    this.zjSystemService.saveSelective(zjSystems);
                    Message message=new Message();
                    message.setStatus(1);
                    message.setMessage(Global.INSERT_SUCCESS);
                    return ResponseEntity.ok(message);
                }else {
                    return ResponseEntity.ok(message1);
                }
                
            } else {
                zjSystems.preUpdate();
                Message message2=new Message();
                message2.setStatus(1);
                message2.setMessage(Global.UPDATE_SUCCESS);
                
                if (null==njSystems && null==zjSystems1 && null==yjSystems) {
                    this.zjSystemService.updateSelective(zjSystems);
                    return ResponseEntity.ok(message2);
                }else if (zjSystems1!=null&&zjSystems1.getId().intValue()==zjSystems.getId().intValue()) {
                    this.zjSystemService.updateSelective(zjSystems);
                    return ResponseEntity.ok(message2);
                } else {
                    return ResponseEntity.ok(message1);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 在建系统删除
     * 
     * @param ids
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) {
        try {
            this.zjSystemService.deleteByIds(ids);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
}
