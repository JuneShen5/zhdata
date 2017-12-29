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
            String [] rowName =  "信息资源分类_infoType_linkageSelect_infosort,信息资源名称_nameCn_input_,信息资源格式_resourceFormat_dictselect_resourceFormat,信息资源提供方_companyId_companyselect_,信息资源提供方代码_code_input_,信息资源代码_nameEn_input_,共享类型_shareType_dictselect_shareType,共享条件_shareCondition_input_,共享方式_shareMode_dictselect_shareMode,发布日期_releaseDate_dateselect_,是否向社会开放_isOpen_dictselect_yesNo,开放类型_openType_dictselect_openType,管理方式_manageStyle_dictselect_manageStyle,所属系统名称_systemId_select_sys,权属关系_rightRelation_dictselect_rightRelation,信息资源摘要_xinxiziyuanzhaiyao_input_,在线资源链接地址_zaixianziyuanlianjiedizhi_input_,更新周期_gengxinzhouqi_dictselect_updateCycle,关联资源代码_guanlianziyuandaima_input_,信息资源生成方式_xinxiziyuanshengchengfangshi_dictselect_informationProduct,涉密属性_shemizhuxing_dictselect_yesNo".split(",");
            ExportExcelImpl   exportExcel = new ExportExcelTemplate(_chTableName,_enTableName,templatFile,rowName,infoList);
            exportExcel.export();
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
