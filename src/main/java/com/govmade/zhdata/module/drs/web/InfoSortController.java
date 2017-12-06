package com.govmade.zhdata.module.drs.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.service.InfoSortService;

@Controller
@RequestMapping(value = "catalogset/infoSort")
public class InfoSortController {
	
    @Autowired
    private InfoSortService infosortservice;
    
	
    @RequestMapping(method = RequestMethod.GET)
    public String toInfoSort() {
        return "modules/catalogset/infoSortIndex";
    }
    
    /**
     * 查询
     * 
     * @param infosort
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<List<InfoSort>> list(InfoSort infosort) {
        
        try {
          /*  List<InfoSort> infolist = this.infosortservice.queryListByWhere(new InfoSort());*/
            List<InfoSort> infolist = this.infosortservice.findAll();
            return ResponseEntity.ok(infolist);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    /**
     * 新增
     * 
     * @param infoSort
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(InfoSort infoSort) throws Exception {
        try {
            if (null == infoSort.getId()) {
            	infoSort.preInsert();
            	if (null == infoSort.getParentId()) {
            		infoSort.setParentId(0);
            	}
                this.infosortservice.saveSelective(infoSort);
            }
            else {
            	infoSort.preUpdate();
            	this.infosortservice.updateSelective(infoSort);
			}
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    
    /**
     * 删除
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            String[] array = StringUtil.split(ids, ',');
              List<String> idList = new ArrayList<String>(Arrays.asList(array));
              List<String> list=Lists.newArrayList();
              for (int i = 0; i < array.length; i++) {
                  findAllSubNode(Integer.valueOf(array[i]), list);
              }
              idList.addAll(list);
            this.infosortservice.deleteByIds(idList);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    /**
     * 根据父级查询子级
     * 
     * @param parentId
     * @param list
     */
    private void findAllSubNode(Integer parentId,List<String> list){
        InfoSort record=new InfoSort();
        record.setParentId(Integer.valueOf(parentId));
        if (this.infosortservice.queryListByWhere(record)!=null) {
            List<InfoSort> infoSorts=this.infosortservice.queryListByWhere(record);
            for (InfoSort s : infoSorts) {
                list.add(s.getId().toString());
                 findAllSubNode(s.getId(),list);
            }
        }
    }
    
    
    /**
     * 查询四级联动的信息
     * 
     * @param id
     * @return
     */
    @RequestMapping(value="queryList",method=RequestMethod.GET)
    public ResponseEntity<Map<String, Object>> queryList(@RequestParam("id") Integer id){
        try {
            List<InfoSort> infoSorts= this.infosortservice.queryList(id);
            if (infoSorts.isEmpty()) {
                return ResponseEntity.ok(null);
            }
            Map<String, Object> map1=Maps.newHashMap();
            Map<String, Object> map2=Maps.newHashMap();
            for (InfoSort info : infoSorts) {
                map2.put(info.getId().toString(), info);
            }
            map1.putAll(map2);
            return ResponseEntity.ok(map1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
                
    }
    
    
  
    
    
    
   
}
