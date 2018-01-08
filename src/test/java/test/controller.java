package test;

import org.apache.shiro.SecurityUtils;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= 
{"classpath:spring/applicationContext.xml","classpath:spring/applicationContext-mybatis.xml","classpath:spring/applicationContext-transaction.xml","classpath:spring/spring-mvc.xml","classpath:spring/applicationContext-shiro.xml"})
//配置事务的回滚,对数据库的增删改都会回滚,便于测试用例的循环利用
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = true)
@Transactional

@WebAppConfiguration
public class controller {
 
    
    //记得配置log4j.properties ,的命令行输出水平是debug
//    protected Log logger= LogFactory.getLog(TestBase.class);
    @Autowired
    org.apache.shiro.mgt.SecurityManager securityManager;
    
    protected MockMvc mockMvc;

    @Autowired
    protected WebApplicationContext wac;

    @Before()  //这个方法在每个方法执行之前都会执行一遍
    public void setup() {
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();  //初始化MockMvc对象
        SecurityUtils.setSecurityManager(securityManager);
    }

    @Test
    public void dou() {
        try {
            String obj = "信息资源分类1_infoType1_linkageSelect_infoSort,信息资源分类2_infoType2_linkageSelect_infoSort,信息资源分类3_infoType3_linkageSelect_infoSort,信息资源分类4_infoType4_linkageSelect_infoSort,信息资源名称_nameCn_input_,信息资源格式_resourceFormat_dictselect_resourceFormat,信息资源提供方代码_code_input_,信息资源代码_nameEn_input_,共享类型_shareType_dictselect_shareType,共享条件_shareCondition_input_,共享方式_shareMode_dictselect_shareMode,发布日期_releaseDate_dateselect_,是否向社会开放_isOpen_dictselect_yesNo,开放类型_openType_dictselect_openType,管理方式_manageStyle_dictselect_manageStyle,所属系统名称_systemId_select_sys,权属关系_rightRelation_dictselect_rightRelation,信息资源摘要_xinxiziyuanzhaiyao_input_,在线资源链接地址_zaixianziyuanlianjiedizhi_input_,更新周期_gengxinzhouqi_dictselect_updateCycle,关联资源代码_guanlianziyuandaima_input_,信息资源生成方式_xinxiziyuanshengchengfangshi_dictselect_informationProduct,涉密属性_shemizhuxing_dictselect_yesNo";
            System.out.println("111");
        
            String responseString = mockMvc.perform(
                    post("/catalog/information/downloadTemplate")    //请求的url,请求的方法是get
                            .contentType(MediaType.APPLICATION_FORM_URLENCODED)  //数据的格式
                            .param("obj",obj)         //添加参数
            ).andExpect(status().isOk())    //返回的状态是200
//                    .andDo(print())         //打印出请求和相应的内容
                    .andReturn().getResponse().getContentAsString();   //将相应的数据转换为字符串
            
            System.out.println("--------返回的json = " + responseString);
            
            
        } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
    }
}

    
   
        