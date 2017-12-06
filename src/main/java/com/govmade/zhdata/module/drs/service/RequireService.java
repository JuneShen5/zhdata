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
import com.govmade.zhdata.module.drs.dao.RequireDao;
import com.govmade.zhdata.module.drs.mapper.RequireMapper;
import com.govmade.zhdata.module.drs.pojo.Require;


@Service
public class RequireService extends BaseService<Require> {
	
       @Autowired
       private RequireMapper requireMapper;
       
       @Autowired
       private RequireDao requireDao;

       
       
    public PageInfo<Require> queryAllList(Page<Require> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());

      Require require = JsonUtil.readValue(page.getObj(), Require.class);
        try {
            String name= new String(require.getName().getBytes("ISO-8859-1"), "UTF-8");
            require.setName(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        List<Require> list = requireDao.queryAllList(require);

        return new PageInfo<Require>(list);
    }



    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Require require =new Require();
        require.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Require.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(require, example);
    }
       
}
