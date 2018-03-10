package com.govmade.zhdata.module.drs.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.drs.dao.ColumnsDao;
import com.govmade.zhdata.module.drs.dao.ElementDao;
import com.govmade.zhdata.module.drs.dao.InformationDao;
import com.govmade.zhdata.module.drs.mapper.ElementMapper;
import com.govmade.zhdata.module.drs.mapper.InformationMapper;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;

@Service
public class ElementService extends BaseService<Element> {

    @Autowired
    private ElementDao elementDao;
    
    
    @Autowired
    private ElementMapper elementMapper;
    
    @Autowired
    private InformationMapper informationMapper;
    
    @Autowired
    private InformationDao informationDao;

    @Autowired
    private ColumnsDao columnsDao;
    
    public Element get(int id) {
        Element Element = elementDao.get(id);
        return Element;
    }

    public PageInfo<Element> findAll(Page<Element> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<Element> list;
        if (page.getObj()!=null) {
        	Element Element = JsonUtil.readValue(page.getObj(), Element.class);
        	list = elementDao.findAll(Element);
		}else {
			list = elementDao.findAll(new Element());
		}
        
        return new PageInfo<Element>(list);
    }
    
	public PageInfo<Element> findList(Page<Element> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Map<String, Object> params = Maps.newHashMap();
        Element element = JsonUtil.readValue(page.getObj(), Element.class);
            try {
                String nameCn = new String(element.getNameCn().toString().getBytes("ISO-8859-1"), "UTF-8");
                element.setNameCn(nameCn);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
        }
        params.put("delFlag", Global.DEL_FLAG_NORMAL);
        params.put("orderByClause", "id DESC");  
        page.startPage();
        page.setParams(params);
        
        
       /* Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        if (roleId!=1) {
           element.setCompanyId(companyId);
        }*/
        
        List<Element> list=elementDao.findList(page,element);    
        return new PageInfo<Element>(list);
    }

    public Element queryOneu(Element entity) {

        Element Element = elementDao.get(entity);

        return Element;
    }
    
    /**
     * 删除属性信息
     * 
     * @param ids
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Element Element = new Element();
        Element.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Element.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(Element, example);
    }

    public List<Element> queryList(Integer id) {
        return this.elementDao.queryList(id);
    }
    
    public List<Element> queryAll(Page<Element> page) {
        Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        Element element =new Element();
        if (roleId!=1) {
           element.setCompanyId(companyId);
        }
        return elementDao.queryAll(page,element);
    }
    
    public void saveAll(List<Map<String,String>> dataList) {
        List<Map<String,String>> relationList = new ArrayList<Map<String,String>>();
        for(Map<String,String> infoMap :dataList){
            Map<String,String>  relationMap = new HashMap<String,String>();
            Element element = new Element();
            element.setCode(infoMap.get("code"));
            element.setNameCn(infoMap.get("name_cn"));
            element.setNameEn(infoMap.get("name_en"));
            element.setDes(infoMap.get("des"));
            element.setDataType(Integer.valueOf(infoMap.get("data_type")));
            element.setLen(infoMap.get("len"));
            element.setCompanyId(Integer.valueOf(infoMap.get("company_id")));
            element.setDataLabel(Integer.valueOf(infoMap.get("data_label")));
            element.setObjectType(Integer.valueOf(infoMap.get("object_type")));
            Integer isSave = saveSelective(element);
            if(isSave == 1){
                relationMap.put("element_id", String.valueOf(element.getId()));
                relationMap.put("info_id", infoMap.get("info_id"));
                relationList.add(relationMap);
            }
        }
        elementDao.saveAll(relationList);
    }

    public Map<String, Object> queryAnalyList() {
        Integer eleCount=this.elementMapper.selectCount(new Element());
        Integer infoCount= this.informationMapper.selectCount(new Information());
        List<Map<String, Object>> maps=Lists.newArrayList();
        List<Element> elList=this.elementDao.queryAnalyList(new Element());
        for (Element e : elList) {
            Map<String, Object> map1=Maps.newHashMap();
            map1.put("id",e.getId());
            map1.put("nameCn", e.getNameCn());
            map1.put("infoCount", e.getCount());
            List<Information> infors=this.informationDao.queryCompCount(e.getId());   
            map1.put("compCount", infors.size());
            maps.add(map1);
        }
        Map<String, Object> map2=Maps.newHashMap();
        map2.put("eleCount", eleCount);
        map2.put("infoCount", infoCount);
        map2.put("data", maps);
        return map2;
    }


    public PageInfo<Element> queryEleByInfoId(Page<Element> page, Integer id) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<Element> list=elementDao.queryEleByInfoId(id);    
        return new PageInfo<Element>(list);
    }

	public List<Element> queyListById(String elementIds) {
		String[] eleIds = StringUtil.split(elementIds, ',');
        List<String> eleIdList = Arrays.asList(eleIds);
		return this.elementDao.queyListById(eleIdList);
	}

    public void deleteInfoEle(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List<String> idList = Arrays.asList(array);
        this.elementDao.deleteInfoEle(idList);
        
    }

    public void deleteAll(List<String> idList) {
       if ( this.elementMapper.delete(null)>0) {
           this.elementDao.deleteInfoEle(idList);
           this.columnsDao.updateCol(idList);  //将columns表中的ele_id设置为0
    }
        
    }

    public List<Element> queryForExport() {
        Element element = new Element();
        return elementDao.findAll(element);
    }

    public PageInfo<Element> queryAlList(Page<Element> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Element element = JsonUtil.readValue(page.getObj(), Element.class);
            try {
                String nameCn = new String(element.getNameCn().toString().getBytes("ISO-8859-1"), "UTF-8");
                element.setNameCn(nameCn);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
        }
        
        List<Element> list=elementDao.queryAlList(element);    
        return new PageInfo<Element>(list);
    }

}
