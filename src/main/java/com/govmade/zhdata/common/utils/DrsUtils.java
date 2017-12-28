package com.govmade.zhdata.common.utils;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.github.abel533.entity.Example;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.Attribute;
import com.govmade.zhdata.module.drs.pojo.Dbs;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.Tables;
import com.govmade.zhdata.module.drs.service.AttributeService;
import com.govmade.zhdata.module.drs.service.DbsService;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.drs.service.InfoSortService;
import com.govmade.zhdata.module.drs.service.TablesService;

@Component
public class DrsUtils {
    
    @Autowired
    private AttributeService attService;
    
    @Autowired
    private DbsService dbsService;
    
    @Autowired
    private TablesService tablesService;

    private static DrsUtils drsUtils;
    
    @Autowired
    private HttpServletRequest request;
    
    @Autowired
    private ElementService elementService;
    
  /*  @Autowired
    private ModelConfigService modelConfigService;*/

    @Autowired
    private InfoSortService infoSortService;
    /**
     * 初始化注解
     */
    @PostConstruct
    public void init() {
        drsUtils = this;
        drsUtils.attService = this.attService;
        drsUtils.request = this.request;
        drsUtils.dbsService=this.dbsService;
        drsUtils.tablesService=this.tablesService;
        drsUtils.elementService=this.elementService;
      /*  drsUtils.modelConfigService=this.modelConfigService;*/
        drsUtils.infoSortService=this.infoSortService;
    }
    
    /**
     * 获取通用对象列表
     * 
     * @return
     */
    @SuppressWarnings({ "rawtypes", "static-access" })
    public static List getDrList(String type) {
        List list = Lists.newArrayList();
        if (!StringUtil.isEmpty(type)) {
            switch (type.trim().toLowerCase()) {
            case "dbs":
                list = drsUtils.getDbList();
                break;
            case "tables":
                list = drsUtils.getTableList();
                break;
            default:
                break;
            }
        }
        return list;
    }


    /**
     * 获取自定义表单属性(非核心字段)列表
     * 
     * @return
     */
    public static List<Attribute> getAttList(Integer typeId,Integer isCore) {
        List<Attribute> attList = Lists.newArrayList();
        
        Example example = new Example(Attribute.class);
        Example.Criteria criteria=example.createCriteria();
        criteria.andEqualTo("type", typeId).andEqualTo("delFlag", 0);
        if(isCore>0){
            criteria.andEqualTo("isCore", isCore);
        }
        
        example.setOrderByClause("sort asc,id asc");
        attList = drsUtils.attService.queryByExample(example);
        return attList;
    }
    
    /**
     * 获取URL参数
     * 
     * @param type
     * @return
     */
   public static Integer getParam(String type) {
        Integer typeId=Integer.valueOf(drsUtils.request.getParameter(type));
        return typeId;
    }
    
    /**
     * 获取数据库
     * 
     * @return
     */
    public static List<Dbs> getDbList() {
        List<Dbs> dbList = Lists.newArrayList();
        dbList = drsUtils.dbsService.queryAll(new Dbs());
        return dbList;
    }
    
    /**
     * 获取数据表
     * 
     * @return
     */
    public static List<Tables> getTableList() {
        List<Tables> tbList = Lists.newArrayList();
        tbList =drsUtils.tablesService.queryAll(new Tables());
        return tbList;
    }
    
    /**
     * 获取数据元信息
     * 
     * @return
     */
    public static List<Map<String, Object>> getElementList() {
        Page<Element> page = new Page<Element>();
        page.setIsPage(false);
        List<Element> eList=drsUtils.elementService.queryAll(page);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        //将info 的json格式改为map格式
        for(Element element :eList){
            Map<String, Object> beanMap = MapUtil.beanToMap(element);
            infoList.add(beanMap);
        }
        return infoList;
    }
    
    
    
    
    /**
     * 根据父级ID查询子级模型配置数据
     * 
     * @param modelId
     * @return
     */
   /* public static List<ModelConfig> getModelConfigs(Integer modelId){
        ModelConfig record=new ModelConfig();
        record.setParentId(modelId);
        List<ModelConfig> modConfigs=drsUtils.modelConfigService.queryListByWhere(record);
       return modConfigs;
    }*/
    
    
    /**
     * 获取联系信息
     */
    public static List<InfoSort> findAllInfo() {
        List<InfoSort> infolist = drsUtils.infoSortService.findAll();
        return infolist;
    }
}
