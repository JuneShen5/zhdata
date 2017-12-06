package com.govmade.zhdata.module.drs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.module.drs.dao.InfoSearchDao;
import com.govmade.zhdata.module.drs.mapper.InfoSearchMapper;
import com.govmade.zhdata.module.drs.pojo.InfoSearch;


@Service
public class InfoSearchService extends BaseService<InfoSearch>{

	@Autowired
	private InfoSearchDao infoSearchDao;
	
	@Autowired
	private InfoSearchMapper infoSearchMapper;
	
	public void saveKeyWord(String keyword){
		
		InfoSearch infoSearch = new InfoSearch();
		infoSearch.setKeyword(keyword);
		        
		infoSearchMapper.insertSelective(infoSearch);
		
	}
	
	public List<InfoSearch> queryHotInfo(){
		List<InfoSearch> hotInfo =infoSearchDao.queryHotInfo();
		return hotInfo;
		
		
	}
}
