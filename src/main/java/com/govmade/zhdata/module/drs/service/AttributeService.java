package com.govmade.zhdata.module.drs.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.AttributeDao;
import com.govmade.zhdata.module.drs.mapper.AttributeMapper;
import com.govmade.zhdata.module.drs.pojo.Attribute;

@Service
public class AttributeService extends BaseService<Attribute> {

    @Autowired
    private AttributeDao attributeDao;
    
    @Autowired
    private AttributeMapper attributeMapper;

    public Attribute get(int id) {
        Attribute attribute = attributeDao.get(id);
        return attribute;
    }

    public PageInfo<Attribute> queryList(Page<Attribute> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());

        Attribute attribute = JsonUtil.readValue(page.getObj(), Attribute.class);
        try {
   			String str= new String(attribute.getNameCn().getBytes("ISO-8859-1"), "UTF-8");
            attribute.setNameCn(str);
   		 
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        List<Attribute> list = attributeDao.queryList(attribute);
        return new PageInfo<Attribute>(list);
    }
    
    public List<Attribute> querAllyList(Attribute attribute) {
        return attributeDao.queryList(attribute);
     }
    
    
    public Attribute queryOneu(Attribute entity) {

        Attribute attribute = attributeDao.get(entity);

        return attribute;
    }
    
    /**
     * 删除属性信息
     * 
     * @param ids
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Attribute attribute = new Attribute();
        attribute.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Attribute.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(attribute, example);
    }

}
