package test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.utils.TreeUtil;
import com.govmade.zhdata.common.utils.excel.ExportExcelImpl;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.service.InfoSortService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= 
{"classpath:spring/applicationContext.xml","classpath:spring/applicationContext-mybatis.xml","classpath:spring/applicationContext-transaction.xml","classpath:spring/spring-mvc.xml","classpath:spring/applicationContext-shiro.xml"})
public class maptree {
    
    @Autowired
    private InfoSortService infosortservice;
    
    @Test
    @Transactional   //标明此方法需使用事务  
    @Rollback(true)  //标明使用完此方法后事务不回滚,true时为回滚  
    public void insert() {
        try {
            List<InfoSort> infoSortList= infosortservice.findAll();
            List<Map<String, Object>> list = new ArrayList<>(); 
//            TreeUtil treeUtil = new TreeUtil();
//            List<InfoSort> infoSortTree = treeUtil.buildListToTree(infoSortList);
//            System.out.println("infoSortTree:"+infoSortTree);
            for(InfoSort infoSort:infoSortList){
                Map<String, Object> infoSortMap = new HashMap<String, Object>();
                infoSortMap.put("id", "id"+infoSort.getId());  
                infoSortMap.put("name", infoSort.getName());  
                infoSortMap.put("pid", "id"+infoSort.getParentId());  
                list.add(infoSortMap);  
            }
            System.out.println( getTree(list, "id0", "id"));
            String _chTableName ="信息资源模板";
            String _enTableName ="信息资源模板";
            String templatFile = "informationTemplate.xlsx";
            List<Map<String, Object>> infoList = Lists.newArrayList();
            String [] rowName =  "信息资源分类_infoType_linkageSelect_infoSort,信息资源名称_nameCn_input_".split(",");
            ExportExcelImpl   exportExcel = new ExportExcelTemplate(_chTableName,_enTableName,templatFile,rowName,infoList);
            exportExcel.export();
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    
    public static List<Map<String, Object>> getTree(List<Map<String, Object>> list, String pid, String idName) {  
        List<Map<String, Object>> res = new ArrayList<Map<String,Object>>();  
        if (CollectionUtils.isNotEmpty(list))  
            for (Map<String, Object> map : list) {  
                if(pid == "id0" && map.get("p"+idName) == "id0" || map.get("p"+idName) != "id0" && map.get("p"+idName).equals(pid)){  
                    String id = (String) map.get(idName);  
                    map.put("children", getTree(list, id, idName));  
                    res.add(map);  
                }  
            }  
        return res;  
    }
}
