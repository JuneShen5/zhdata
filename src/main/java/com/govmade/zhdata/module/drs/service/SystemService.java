package com.govmade.zhdata.module.drs.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.SystemDao;
import com.govmade.zhdata.module.drs.pojo.Systems;

@Service
public class SystemService extends BaseService<Systems> {

    @Autowired
    private SystemDao systemDao;

    public Long getTotal(Page<Systems> page) {
        return systemDao.getSearchCount(page);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Systems systems = new Systems();
        systems.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Systems.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(systems, example);
    }

    public List<Systems> queryList(Page<Systems> page) {
        return systemDao.queryListByPage(page);
    }

    public Integer updateAuditByids(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Systems systems = new Systems();
        systems.setIsAudit(Global.AUDIT_FLAG_YES);
        Example example = new Example(Systems.class);
 
        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(systems, example);
    }
    
    public void saveAll(List<Map<String,String>> dataList) {
        systemDao.saveAll(dataList);
    }

    /*public List<Systems> queryLists(Page<Systems> page, Integer companyId) {
        return systemDao.queryListByPages(page,companyId);
    }*/
}
