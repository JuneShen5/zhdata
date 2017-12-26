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
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.drs.dao.ZjSystemDao;
import com.govmade.zhdata.module.drs.mapper.ZjSystemMapper;
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.drs.pojo.ZjSystems;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Service
public class ZjSystemService extends BaseService<ZjSystems> {

    @Autowired
    private ZjSystemDao zjSystemDao;

    @Autowired
    private ZjSystemMapper zjSystemMapper;
    
    @Autowired
    private CompanyService companyService;

    public PageInfo<ZjSystems> queryAllList(Page<ZjSystems> page) {
        Integer roleId=UserUtils.getCurrentUser().getRoleId();
        Integer companyId=UserUtils.getCurrentUser().getCompanyId();
        List<Integer> comList=Lists.newArrayList();
        comList.add(companyId);
        findAllSubNode(companyId, comList);
        if (roleId!=1) {
            Map<String, Object> map=Maps.newHashMap();
            map=page.getParams();
            map.put("companyIds", comList);
            page.setParams(map);
        }
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        ZjSystems zjSystems = JsonUtil.readValue(page.getObj(), ZjSystems.class);
        try {
            String str = new String(zjSystems.getXtmc().getBytes("ISO-8859-1"), "UTF-8");
            zjSystems.setXtmc(str);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<ZjSystems> list = zjSystemDao.queryListByCompanyId(zjSystems,page);
        //List<ZjSystems> list = zjSystemDao.queryAllList(zjSystems);
        return new PageInfo<ZjSystems>(list);
    }

    
    /**
     * 根据父级查询子级
     * 
     * @param parentId
     * @param list
     */
    public void findAllSubNode(Integer companyId, List<Integer> comList) {
        Company record =new Company();
        record.setParentId(Integer.valueOf(companyId));
        List<Company> companies=this.companyService.queryListByWhere(record);
        if (companies!=null) {
            for (Company c : companies) {
                comList.add(c.getId());
                 findAllSubNode(c.getId(),comList);
            }
        }
        
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

    public List<ZjSystems> queryForExport() {
        ZjSystems zjSystems = new ZjSystems();
        return zjSystemDao.queryAllList(zjSystems);
    }

    // 保存多条数据
    @Override
    public void saveAll(List<Map<String, String>> dataList) {
        zjSystemDao.saveAll(dataList);
    }
}
