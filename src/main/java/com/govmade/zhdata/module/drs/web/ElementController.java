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
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.service.ColumnsService;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.sys.service.DictService;

@Controller
@RequestMapping(value = "/catalog/element")
public class ElementController extends BaseController<Element>{

    @Autowired
    private ElementService elementService;
    
    @Autowired
    private DictService dictService;
    
    
    @Autowired
    private ColumnsService columnsService;

    @RequestMapping(method = RequestMethod.GET)
    public String toAttribute() {
        return "modules/catalog/elementIndex";
    }

    /**
     * 查询信息项列表数据
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Element>> list(Page<Element> page) {
        try {
                
            PageInfo<Element> pageInfo = this.elementService.queryAlList(page);
            List<Element> elementList = pageInfo.getList();
            Page<Element> resPage = new Page<Element>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(elementList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
   /* @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Element>> list(Page<Element> page) {
        try {
        	
            PageInfo<Element> pageInfo = this.elementService.findList(page);
            List<Element> elementList = pageInfo.getList();
            if (elementList.isEmpty()) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            }
            Page<Element> resPage = new Page<Element>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(elementList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }*/

    
    /**
     * 保存信息项
     * 
     * @param element
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Element element) throws Exception {
        try {
            if (element.getId()==null) {
                element.preInsert();
               this.elementService.saveSelective(element);
            }else {
            	element.preUpdate();
            	this.elementService.updateSelective(element);
			}
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    
    /**
     * 删除或批量删除信息项
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
    	try {
    	    if (this.elementService.deleteByIds(ids)>0) {
    	        this.elementService.deleteInfoEle(ids);
    	       this.columnsService.updateColum(ids); //将columns表中的ele_id设置成0
            }
    	   
    	    
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
         } catch (Exception e) {
             e.printStackTrace();
             throw new Exception(Global.HANDLE_ERROR);
         }
    }
    
    
    /**
     * 删除全部-清空所有
     * 
     * @return
     */
    @RequestMapping(value="deleteAll",method=RequestMethod.GET)
    public ResponseEntity<String> deleteAll(){
        try {
            List<Element> eleList=this.elementService.queryAll(new Element());
            List<String> idList = Lists.newArrayList();
            for (Element ele : eleList) {
                idList.add(ele.getId().toString());
            }
           
            this.elementService.deleteAll(idList);
            return ResponseEntity.ok(Global.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    @Override
    protected void getFileName() {
        super.chTableName = "信息项";
        super.enTableName = "信息项";
        super.templatFile = "elementTemplate.xlsx";
        
    }

    @Override
    protected void getReadExcelStarLine() {
        super.commitRow = 200;
        super.startRow = 3;
        super.columnIndex = 0;
    }

    @Override
    protected BaseService<Element> getService() {
        return elementService;
    }

    @Override
    protected List<Map<String, Object>> queryDataForExp(Page<Element> page) {
        List<Element> elementList = elementService.queryForExport();
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for (Element data : elementList) {
            infoList.add(MapUtil.beansToMap(data));
        }
        return infoList;
    }
    
    
}
