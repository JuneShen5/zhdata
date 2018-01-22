package com.govmade.zhdata.module.drs.web;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;
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
        super.startRow = 6;
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
    public  List<Map<String, Object>> queryDataForExp(Page<ZjSystems> page) {
            
        List<ZjSystems> zjSystemsList = zjSystemService.queryForExport(page);
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
            
            //自动根据已付合同金额/系统建设预算、合同金额计算已付合同金额比例
           /* Double xtjsys=zjSystems.getXtjsys();   
            Double yfhtje =zjSystems.getYfhtje();   
            
            DecimalFormat df = new DecimalFormat("0.##");
            String yfhtjebl=df.format(yfhtje/xtjsys *100) +"%";  
            zjSystems.setYfhtjebl(yfhtjebl);
*/
            
            //String name=new String (njSystems.getName().getBytes("ISO-8859-1"), "UTF-8");
            String name=zjSystems.getName();
            Integer companyId=zjSystems.getCompanyId();
            NjSystems record1=new NjSystems();
            record1.setName(name);
            record1.setCompanyId(companyId);
            List<NjSystems> njList=this.njSystemService.queryAll(record1);
            ZjSystems record2=new ZjSystems();
            record2.setName(name);
            record2.setCompanyId(companyId);
            List<ZjSystems> zjList=this.zjSystemService.queryAll(record2);
            YjSystems record3=new YjSystems();
            record3.setName(name);
            record3.setCompanyId(companyId);
            List<YjSystems> yjList=this.yjSystemService.queryAll(record3);
            
            Message message1=new Message();
            message1.setStatus(0);
            message1.setMessage("系统名称已经存在，请重新填写！");
            
            if (zjSystems.getId() == null) {
                zjSystems.preInsert();
                if (njList.isEmpty() && zjList.isEmpty() && yjList.isEmpty()) {
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
                
            
                if (njList.isEmpty()&& zjList.isEmpty() && yjList.isEmpty()) {
                    this.zjSystemService.updateSelective(zjSystems);
                    return ResponseEntity.ok(message2);
                }else if (zjList.size()>0) {
                   ZjSystems  zjSystems1=zjList.get(0);
                    if (zjList.size()==1&&zjSystems1.getId().intValue()==zjSystems.getId().intValue()) {
                        this.zjSystemService.updateSelective(zjSystems);
                        return ResponseEntity.ok(message2);
                    }else{
                        return ResponseEntity.ok(message1);
                    }
                }else {
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
    
    
    public static void main(String[] args){
        String x="20.245795";
        DecimalFormat df = new DecimalFormat("0.##");
        String yfhtjebl=df.format(Double.valueOf(x)) +"%";
        System.out.println("x===="+yfhtjebl);
    }
    
}
