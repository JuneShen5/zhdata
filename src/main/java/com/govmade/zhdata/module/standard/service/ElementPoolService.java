package com.govmade.zhdata.module.standard.service;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.ElementDao;
import com.govmade.zhdata.module.drs.mapper.ElementMapper;
import com.govmade.zhdata.module.drs.pojo.Dbs;
import com.govmade.zhdata.module.standard.dao.ElementPoolDao;
import com.govmade.zhdata.module.standard.dao.ElementSameDao;
import com.govmade.zhdata.module.standard.mapper.ElementPoolMapper;
import com.govmade.zhdata.module.standard.pojo.ElementPool;
import com.govmade.zhdata.module.standard.pojo.ElementSame;

@Service
public class ElementPoolService extends BaseService<ElementPool> {

    @Autowired
    private ElementPoolDao elementPoolDao;

    @Autowired
    private ElementPoolMapper elementPoolMapper;

    @Autowired
    private ElementMapper elementMapper;

    @Autowired
    private ElementDao elementDao;

    @Autowired
    private ElementSameDao elementSameDao;

    public PageInfo<ElementPool> findAll(Page<ElementPool> page) {

        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        ElementPool elementPool = JsonUtil.readValue(page.getObj(), ElementPool.class);
        try {
            String nameCn = new String(elementPool.getNameCn().getBytes("ISO-8859-1"), "UTF-8");
            elementPool.setNameCn(nameCn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<ElementPool> list = this.elementPoolDao.findAll(elementPool);
        return new PageInfo<ElementPool>(list);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Example example = new Example(Dbs.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.elementPoolMapper.deleteByExample(example);
    }

    public List<ElementPool> queryRepeatList(ElementPool elepool) {

        try {
            String nameCn = new String(elepool.getNameCn().getBytes("ISO-8859-1"), "UTF-8");
            elepool.setNameCn(nameCn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return this.elementPoolDao.queryRepeatList(elepool);
    }

    public void importEle(String params) {
        Integer toPool=1;
        if (params.length() == 2) {
            List<String> idList = Lists.newArrayList();
            if (this.elementPoolDao.importEle(idList) > 0) {
                this.elementDao.updateEle(idList,toPool);
            }
        } else {
            params = params.substring(1, params.length() - 1);
            String[] array = StringUtil.split(params, ",");
            List<String> idList = Arrays.asList(array);
            if (this.elementPoolDao.importEle(idList) > 0) {
                this.elementDao.updateEle(idList,toPool);
            }
        }

    }

    public void deleteElePool(Integer id) {
        if (id == 0) {
            List<Integer> eleIds = this.elementPoolDao.queryEleIds(id);
            if (this.elementPoolMapper.delete(null) > 0) {
                this.elementDao.updateEleByPool(eleIds);
            }

        } else {
            List<Integer> eleIds = this.elementPoolDao.queryEleIds(id);
            if (this.elementPoolMapper.deleteByPrimaryKey(id) > 0) {
                this.elementDao.updateEleByPool(eleIds);
            }

        }
    }
    
    public PageInfo<ElementPool> queryElePoolById(Page<ElementPool> page) {
        ElementPool elementPool = JsonUtil.readValue(page.getObj(), ElementPool.class);
        Integer id = elementPool.getId();
        List<ElementSame> eslList = this.elementSameDao.queryListById(id);
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<ElementPool> list = this.elementPoolDao.queryEleListById(eslList);
        return new PageInfo<ElementPool>(list);
    }

    public void updateToPub(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List<String> idList = Arrays.asList(array);
        this.elementPoolDao.updateToPub(idList);
    }

    public void deleteAllList(List<String> idList) {
        Integer toPool=0;
       if (this.elementPoolMapper.delete(null)>0) {
        this.elementDao.updateEle(idList,toPool);
    }
        
    }

}
