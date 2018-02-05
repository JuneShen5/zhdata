package com.govmade.zhdata.module.sys.web;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.service.MenuService;

@Controller
@RequestMapping(value = "settings/menu")
public class MenuController {
    
    @Autowired
    private MenuService menuService;

    @RequestMapping(method = RequestMethod.GET)
    public String toMenu() {
        return "modules/settings/menuIndex";
    }
    
    /**
     * 查询菜单
     * 
     * @param menu
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<List<Menu>> queryList(Menu menu) {
        
        List<Menu> list = menuService.findAll(menu);
        
        return ResponseEntity.ok(list);
    }
    
    
    /**
     * 新增菜单
     * 
     * @param menu
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Menu menu) throws Exception {
        try {
            if (null == menu.getId()) {
                menu.preInsert();
                this.menuService.saveSelective(menu);
            }
            else {
            	menu.preUpdate();
            	this.menuService.updateSelective(menu);
			}
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    
    
    /**
     * 删除菜单
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            String[] array = StringUtil.split(ids, ',');
          /*  List<String> idList = Arrays.asList(array);*/
            List<String> idList = new ArrayList<String>(Arrays.asList(array));
            List<String> list=Lists.newArrayList();
            for (int i = 0; i < array.length; i++) {
               /* Menu record =new Menu();
                record.setParentId(Integer.valueOf(array[i]));
                if (this.menuService.queryListByWhere(record)!=null) {
                    List<Menu> menus=this.menuService.queryListByWhere(record);
                    for (Menu m : menus) {
                        list.add(m.getId().toString());
                    }
                }*/
                findAllSubNode(Integer.valueOf(array[i]), list);
            }
            idList.addAll(list);
            
            if (this.menuService.deleteByIds(idList) > 0) {
                this.menuService.deletByMenuId(idList);
            }
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.DELETE_ERROR);
        }
    }
    
    
    
    /**
     * 根据父级查询子级
     * 
     * @param parentId
     * @param list
     */
    private void findAllSubNode(Integer parentId,List<String> list){
        Menu record =new Menu();
        record.setParentId(Integer.valueOf(parentId));
        List<Menu> menus=this.menuService.queryListByWhere(record);
        if (menus!=null) {
          //  List<Menu> menus=this.menuService.queryListByWhere(record);
            for (Menu m : menus) {
                list.add(m.getId().toString());
                 findAllSubNode(m.getId(),list);
            }
        }
    }
    
}
