package test;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelImpl;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.drs.service.InfoSortService;
import com.govmade.zhdata.module.drs.service.ZjSystemService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= 
{"classpath:spring/applicationContext.xml","classpath:spring/applicationContext-mybatis.xml","classpath:spring/applicationContext-transaction.xml","classpath:spring/spring-mvc.xml","classpath:spring/applicationContext-shiro.xml"})
public class serTest  {
  
    @Autowired
    ElementService elementService;
    
    @Test
    @Transactional   //标明此方法需使用事务  
    @Rollback(true)  //标明使用完此方法后事务不回滚,true时为回滚  
    public void insert() {
        long startTime=System.currentTimeMillis();   //获取开始时间
        String obj = "信息项名称_nameCn_input_,英文名称_nameEn_input_,描述说明_remarks_input_,数据类型_dataType_dictselect_dataType,数据长度_len_input_,备注_remarks_input_";//,来源部门_companyId_companyselect_company
        HttpServletResponse response = null;
        List<Element> elementList = elementService.queryForExport();
        List<Map<String, Object>> DataList = Lists.newArrayList();
        for (Element data : elementList) {
            DataList.add(MapUtil.beansToMap(data));
        }
//        long endTime1=System.currentTimeMillis(); //获取结束时间
//        System.out.println("程序运行时间1： "+(endTime1-startTime)+"ms");
        try {
            
            String _chTableName = "信息项数据";
            String _enTableName = "信息项数据";
            String templatFile = "elementTemplate.xlsx";
            String [] rowName =  obj.split(","); //头部
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
               ExportExcelImpl  exportExcel = new ExportExcelData(_chTableName,_enTableName,templatFile,rowName,DataList,response);
               exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
        long endTime2=System.currentTimeMillis(); //获取结束时间
        System.out.println("程序运行时间： "+(endTime2-startTime)+"ms");
    }
   
    
}

    
   
        