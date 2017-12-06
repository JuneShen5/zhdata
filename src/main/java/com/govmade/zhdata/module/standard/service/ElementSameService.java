package com.govmade.zhdata.module.standard.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.module.standard.dao.ElementPoolDao;
import com.govmade.zhdata.module.standard.dao.ElementSameDao;
import com.govmade.zhdata.module.standard.mapper.ElementSameMapper;
import com.govmade.zhdata.module.standard.pojo.ElementSame;

@Service
public class ElementSameService extends BaseService<ElementSame> {

	@Autowired
    private ElementSameDao elementSameDao;
	
	@Autowired
	private ElementSameMapper elementSameMapper;
	
	@Autowired
        private ElementPoolDao elementPoolDao;
	
	
	
	public PageInfo<ElementSame> findAll(Page<ElementSame> page) {
		PageHelper.startPage(page.getPageNum(), page.getPageSize());
		ElementSame elementSame = JsonUtil.readValue(page.getObj(), ElementSame.class);
	    try {
	        String name= new String(elementSame.getName().getBytes("ISO-8859-1"), "UTF-8");
	        elementSame.setName(name);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    List<ElementSame> list = this.elementSameDao.findAll(elementSame);
	    return new PageInfo<ElementSame>(list);
	}

	
	
	public List<Map<String, Object>> queryEqualList( ) {
		
		List<ElementSame> list = this.elementSameDao.queryAllList(new ElementSame());
		
		List<ElementSame> trees = Lists.newArrayList();
	        for (int i = 0; i < list.size(); i++) {
	            ElementSame e = list.get(i);
	                if (e.getLevels().intValue() == 1) {
	                    trees.add(e);
	                }
	                for (int j = 0; j < list.size(); j++) {
	                    ElementSame m = list.get(j);
	                    if (m.getParentId().intValue() == e.getId().intValue()) {
	                        if (e.getChildList() == null) {
	                            List<ElementSame> mychildrens = Lists.newArrayList();
	                            mychildrens.add(m);
	                            e.setChildList(mychildrens);
	                        } else {
	                            e.getChildList().add(m);
	                        }
	                    }
	                }
	            
	        }
	    

		List<Map<String,Object>> maplist=Lists.newArrayList();
		for(ElementSame es : trees){
			Map<String,Object> map=Maps.newHashMap();
			Integer count=0;
			if (es.getChildList()!=null && es.getChildList().size()>0) {
			    count=this.elementPoolDao.queryCount(es.getChildList());
                        }
			
			map.put("id", es.getId());
			map.put("name", es.getName());
			map.put("count", count);
			maplist.add(map);
		}
			
		return maplist;
	}



   

   
	
	
}
