package com.govmade.zhdata.module.sys.service;

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
import com.govmade.zhdata.module.sys.dao.DictDao;
import com.govmade.zhdata.module.sys.pojo.Dict;

@Service
public class DictService extends BaseService<Dict> {

    @Autowired
    private DictDao dictDao;

    
   
    public PageInfo<Dict> findAll(Page<Dict> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());

        Dict dict = JsonUtil.readValue(page.getObj(), Dict.class);
        try {
            String label= new String(dict.getLabel().getBytes("ISO-8859-1"), "UTF-8");
            dict.setLabel(label);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Dict> list = dictDao.findAll(dict);
     /*   System.out.println(list.size());*/

        return new PageInfo<Dict>(list);
    }
    
    /**
     * 删除字典信息
     * 
     * @param ids
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Dict dict = new Dict();
        dict.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Dict.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(dict, example);
    }
    
    public List<Map<String, String>> getDictsForElement(String param){
    	List<Map<String, String>> dicts = null;
        switch (param) {
        case "open_type":
        	dicts =dictDao.getOpenType();
            break;
        case "share_type":
        	dicts =dictDao.getShareType();
            break;
        case "data_type":
        	dicts =dictDao.getDataType();
            break;
        case "object_type":
        	dicts =dictDao.getObjectType();
            break;
        case "site_level":
                dicts =dictDao.getSiteLevel();
            break;
        default:
            break;
        }
        return dicts;
        
    }

    public Dict queryDictByValue(Integer value) {
       return this.dictDao.queryDictByValue(value);
   
    }


}
