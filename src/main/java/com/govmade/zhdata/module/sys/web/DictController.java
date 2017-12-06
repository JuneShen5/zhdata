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
import com.govmade.zhdata.common.utils.excel.ExportExcel;
import com.govmade.zhdata.common.utils.excel.ImportExcel;
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
    
    
    
    
    
    /**
     * 读取Excel中的用户信息插入数据库
     * @param multipart
     * @param session
     * @return
     */
    @RequestMapping(value="import", method = RequestMethod.POST)
    public ResponseEntity<String> importFile(MultipartFile file){
        //定义对应的标题名与对应属性名
    	 Map<String, String> ta=ExcelConstant.getDictTA();
        
    	 String msg = "";
        try {
        	int successNum = 0;
			int failureNum = 0;
        	 //调用解析工具包
        	ImportExcel testExcel=new ImportExcel(file, 0, 0);
            //解析excel，获取客户信息集合
        	List<Map<String, String>> maps= testExcel.uploadAndRead(ta);
            if(maps != null && !"[]".equals(maps.toString()) && maps.size()>=1){
                
                for (Map<String, String> map : maps) {
                	
                 	String sortString=map.get(ExcelConstant.DICT_SORT_TITEL);
                 	Integer sort=0;
                 	if (!StringUtil.isBlank(sortString)) {
                 		if (sortString.endsWith(".0")) {
                 			sortString=sortString.replace(".0", "");
						}
                 		sort=Integer.parseInt(sortString);
					}
                 	Dict dict=new Dict(map.get(ExcelConstant.DICT_VALUE_AT), map.get(ExcelConstant.DICT_LABEL_AT),map.get(ExcelConstant.DICT_TYPE_AT),sort,map.get(ExcelConstant.REMARKS_AT));
                 	dict.preInsert();
                 	try {
                 		this.dictService.saveSelective(dict);
                 		successNum++;
                 		
 					} catch (Exception e) {
 						failureNum++;
                 		msg+="标签名" + dict.getLabel() + " 导入失败！";
 						e.printStackTrace();
 					}
 				}
                 if (successNum==maps.size()) {
                 	msg+="批量导入EXCEL成功！";
 				}else {
 					msg+="\n 导入成功："+successNum+"条数据。\n 导入失败："+failureNum+"条数据。";
 				}
             }else{
             	msg+="导入失败！失败信息：导入文档为空!";
             }
         } catch (Exception e) {
         	msg+="读取Excel文件错误！";
         	e.printStackTrace();
         }
        return ResponseEntity.ok(msg);
    }

	/**
	 * 下载导入字典数据模板
	 * 
	 * @return
	 */
	@RequestMapping(value = "import/template", method = RequestMethod.GET)
	public ResponseEntity<String> importFileTemplate(
			HttpServletResponse response) {

		// 配置信息
		String fileName =ExcelConstant.DICT_FILENAME_TEM;
		String title = ExcelConstant.DICT_TITLE;
		String[] rowName =ExcelConstant.DICT_ROWNAME;
		List<Object[]> dataList = new ArrayList<Object[]>();
//		ExportExcel leadingOutExcel = new ExportExcel(fileName, title, rowName,
//				dataList, response);
		String msg = "";
		try {
//			leadingOutExcel.export();
		} catch (Exception e) {
			e.printStackTrace();
			msg="导出用户失败！失败信息：" + e.getMessage();
		}
		return ResponseEntity.ok(msg);
	}

	/**
	 * 导出字典数据
	 * 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public ResponseEntity<String> exportFile(
			HttpServletResponse response) {
		// Map<String, Object> conditionMap = null; 根据返回的中文 查询nameCn nameEn
		List<Dict> dicts = null;
		ExportExcel leadingOutExcel = null; // 工具类

		// 配置信息
		String fileName =ExcelConstant.DICT_TITLE+ DateUtils.getDate("yyyyMMddHHmmss");
		String title =ExcelConstant.DICT_TITLE;
		String[] rowName =ExcelConstant.DICT_ROWNAME;

		// 查询条件
		dicts = dictService.queryAll(new Dict());
		List<Object[]> dataList = new ArrayList<Object[]>();
		Object[] objs = null;
		for (int i = 0; i < dicts.size(); i++) {
			Dict dict = dicts.get(i);
			objs = new Object[rowName.length];
			objs[0] = i;
			objs[1] =dict.getValue();
			objs[2] =dict.getLabel();
			objs[3] =dict.getType();
			objs[4] =dict.getSort();
			objs[5] =dict.getRemarks();
			dataList.add(objs);
		}

//		leadingOutExcel = new ExportExcel(fileName, title, rowName,
//				dataList, response);
		String msg="";
		try {
			leadingOutExcel.export();
		} catch (Exception e) {
			e.printStackTrace();
			msg="导出用户失败！失败信息：" + e.getMessage();
		}
		return ResponseEntity.ok(msg);
	}
    
}
