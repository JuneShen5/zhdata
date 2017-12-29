package test;

import java.util.List;
import java.util.Map;

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
public class treeExcel {
    
    @Autowired
    private InfoSortService infosortservice;
    
    @Test
    @Transactional   //标明此方法需使用事务  
    @Rollback(true)  //标明使用完此方法后事务不回滚,true时为回滚  
    public void insert() {
        try {
            List<InfoSort> infoSortList= infosortservice.findAll();
            TreeUtil treeUtil = new TreeUtil();
            List<InfoSort> infoSortTree = treeUtil.buildListToTree(infoSortList);
            System.out.println("infoSortTree:"+infoSortTree);
            
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
}
