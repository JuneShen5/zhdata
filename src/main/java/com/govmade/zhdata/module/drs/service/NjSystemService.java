package com.govmade.zhdata.module.drs.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

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
import com.govmade.zhdata.module.drs.dao.NjSystemDao;
import com.govmade.zhdata.module.drs.mapper.NjSystemMapper;
import com.govmade.zhdata.module.drs.pojo.NjSystems;



@Service
public class NjSystemService extends BaseService<NjSystems>{
	
	@Autowired
	private NjSystemDao njSystemDao;
	
	@Autowired
	private NjSystemMapper njSystemMapper;
	
	
	public PageInfo<NjSystems> queryAllList(Page<NjSystems> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        NjSystems njSystems = JsonUtil.readValue(page.getObj(), NjSystems.class);
        try {
            String str = new String(njSystems.getXtmc().getBytes("ISO-8859-1"), "UTF-8");
            njSystems.setXtmc(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<NjSystems> list = njSystemDao.queryAllList(njSystems);
        return new PageInfo<NjSystems>(list);
    }
	
        public List<NjSystems> queryForExport() {
            NjSystems njSystems = new NjSystems();
            return njSystemDao.queryAllList(njSystems);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        NjSystems njSystems = new NjSystems();
        njSystems.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(NjSystems.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(njSystems, example);
    }
        //保存多条数据
        @Override
        public void saveAll(List<Map<String,String>> dataList) {
            njSystemDao.saveAll(dataList);
        }
}
