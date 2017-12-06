package com.govmade.zhdata.module.drs.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.TablesDao;
import com.govmade.zhdata.module.drs.mapper.TablesMapper;
import com.govmade.zhdata.module.drs.pojo.Tables;

@Service
public class TablesService extends BaseService<Tables> {

    @Autowired
    private TablesMapper tablesMapper;

    @Autowired
    private TablesDao tablesDao;

    public PageInfo<Tables> findAll(Page<Tables> page) {
        
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Tables tables = JsonUtil.readValue(page.getObj(), Tables.class);
        try {
            String nameCn= new String(tables.getNameCn().getBytes("ISO-8859-1"), "UTF-8");
            tables.setNameCn(nameCn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Tables> list = this.tablesDao.findAll(tables);
        return new PageInfo<Tables>(list);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Example example = new Example(Tables.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.tablesMapper.deleteByExample(example);
    }

    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void updateTabs(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Example example = new Example(Tables.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("infoId", idList);
        Tables record=new Tables();
        record.setInfoId(0);
        this.tablesMapper.updateByExampleSelective(record, example);
        
    }


    

}
