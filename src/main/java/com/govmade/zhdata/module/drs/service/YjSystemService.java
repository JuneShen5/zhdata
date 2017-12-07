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
import com.govmade.zhdata.module.drs.dao.YjSystemDao;
import com.govmade.zhdata.module.drs.mapper.YjSystemMapper;
import com.govmade.zhdata.module.drs.pojo.YjSystems;

@Service
public class YjSystemService extends BaseService<YjSystems>{
	
	@Autowired
	private YjSystemDao yjSystemDao;
	
	@Autowired
	private YjSystemMapper yjSystemMapper;
	
	
	
	public PageInfo<YjSystems> queryAllList(Page<YjSystems> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        YjSystems yjSystems = JsonUtil.readValue(page.getObj(), YjSystems.class);
        try {
            String str = new String(yjSystems.getXtmc().getBytes("ISO-8859-1"), "UTF-8");
            yjSystems.setXtmc(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<YjSystems> list = yjSystemDao.queryAllList(yjSystems);
        return new PageInfo<YjSystems>(list);
    }
    
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        YjSystems yjSystems = new YjSystems();
        yjSystems.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(YjSystems.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(yjSystems, example);
    }
}
