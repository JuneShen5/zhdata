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
import com.govmade.zhdata.module.drs.dao.ColumnsDao;
import com.govmade.zhdata.module.drs.mapper.ColumnsMapper;
import com.govmade.zhdata.module.drs.pojo.Columns;

@Service
public class ColumnsService extends BaseService<Columns> {

    @Autowired
    private ColumnsMapper columnsMapper;

    @Autowired
    private ColumnsDao columnsDao;
    
    public PageInfo<Columns> findAll(Page<Columns> page) {
        
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Columns columns = JsonUtil.readValue(page.getObj(), Columns.class);
        try {
            String nameCn= new String(columns.getNameCn().getBytes("ISO-8859-1"), "UTF-8");
            String nameEn= new String(columns.getNameEn().getBytes("ISO-8859-1"), "UTF-8");
            columns.setNameCn(nameCn);
            columns.setNameEn(nameEn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Columns> list = this.columnsDao.findAll(columns);
        return new PageInfo<Columns>(list);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Example example = new Example(Columns.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.columnsMapper.deleteByExample(example);
    }

    public void columsToElement(Columns columns) {
        this.columnsDao.columsToElement(columns);
    }

    public void setToElement(Columns columns) {
       
        columns.setToElement(1);
        if(columns.getId()==null){
            Example example = new Example(Columns.class);
            Criteria  criteria = example.createCriteria();
            criteria.andEqualTo("toElement", 0);
            criteria.andEqualTo("delFlag", 0);
            super.updateByExampleSelective(columns,example);
        }else{
            super.updateSelective(columns); 
        }
        
    }


    public List<Columns> queryCheckList(Integer infoId) {
        return this.columnsDao.queryCheckList(infoId);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void updateColum(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Example example = new Example(Columns.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("eleId", idList);
        Columns record=new Columns();
        record.setEleId(0);
        this.columnsMapper.updateByExampleSelective(record, example);
        
    }
}
