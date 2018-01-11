package test;

import org.apache.shiro.SecurityUtils;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;


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
}

    
   
        