package com.govmade.zhdata.module.drs.web;

import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.module.drs.pojo.ComputerRoom;
import com.govmade.zhdata.module.drs.service.ComputerRoomService;

@Controller
@RequestMapping(value = "drs/computerRoom")
public class ComputerRoomController {

    @Autowired
    private ComputerRoomService computerRoomService;
    
    @RequestMapping(method = RequestMethod.GET)
    public String toComputerRoom() {
        return "modules/drs/computerRoomIndex";
    }

    /**
     * 新增机房
     * 
     * @param computerRoom
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(ComputerRoom computerRoom, HttpServletRequest request) {

        try {
            Enumeration paramNames = request.getParameterNames();
            String info="{";
            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();
                String paramValue = request.getParameter(paramName);
                if (!(paramName.trim().equals("id") || paramName.trim().equals("companyId"))){
                        info+="\""+paramName+"\":\""+paramValue+"\",";
                }
            }
            info=info.substring(0,info.length()-1);
            info+="}";  
            computerRoom.setInfo(info);   
            if (null == computerRoom.getId()) {
                computerRoom.preInsert();
                this.computerRoomService.saveSelective(computerRoom);
            }else {
                computerRoom.preInsert();
                this.computerRoomService.updateSelective(computerRoom);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ResponseEntity.ok("数据保存成功了，哈哈好");
    }
    
    
    
    /**
     * 查询机房清单
     * 
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Map<String, Object>>> list(Page<ComputerRoom> page) {
        try {
          JSONObject params=JSONObject.fromObject(page.getObj());
          List<ComputerRoom> sList=this.computerRoomService.search(params);
            List<Map<String, Object>> list = Lists.newArrayList();
            for (ComputerRoom c : sList) {
                Map<String, Object> map = Maps.newHashMap();
                map.put("id", c.getId());
                map.put("companyId", c.getCompanyId());
                map.put("companyName", c.getCompanyName());
                map.put("name", c.getName());
                String info=c.getInfo();
                if (!StringUtils.isBlank(info)) 
                 map=MapUtil.infoToMap(map, info);
                list.add(map);
            }
            Page<Map<String, Object>> resPage = new Page<Map<String, Object>>();
            Long total=(long) sList.size();
            resPage.setTotal(total);
            resPage.setRows(list);
            return ResponseEntity.ok(resPage);
           
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
  
    /**
     * 删除机房
     * 
     * @param ids
     * @return
     * @throws Exception
     */
   @RequestMapping(value = "delete", method = RequestMethod.POST)
   public ResponseEntity<String> delete(String ids) throws Exception {
       try {
           this.computerRoomService.deleteByIds(ids);
           return ResponseEntity.ok(Global.HANDLE_SUCCESS);
       } catch (Exception e) {
           e.printStackTrace();
           throw new Exception(Global.HANDLE_ERROR);
       }
   }

   
}
