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
import com.govmade.zhdata.module.drs.dao.ZjSystemDao;
import com.govmade.zhdata.module.drs.mapper.ZjSystemMapper;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;


@Service
public class ZjSystemService extends BaseService<ZjSystems>{
	
	@Autowired
	private ZjSystemDao zjSystemDao;
	
	@Autowired
	private ZjSystemMapper zjSystemMapper;
	
	public PageInfo<ZjSystems> queryAllList(Page<ZjSystems> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        ZjSystems zjSystems = JsonUtil.readValue(page.getObj(), ZjSystems.class);
        try {
            String str = new String(zjSystems.getXtmc().getBytes("ISO-8859-1"), "UTF-8");
            zjSystems.setXtmc(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<ZjSystems> list = zjSystemDao.queryAllList(zjSystems);
        return new PageInfo<ZjSystems>(list);
    }

	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        ZjSystems zjSystems = new ZjSystems();
        zjSystems.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(ZjSystems.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(zjSystems, example);
    }
}
