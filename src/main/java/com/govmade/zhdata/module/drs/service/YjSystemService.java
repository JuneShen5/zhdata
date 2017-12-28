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
import com.govmade.zhdata.module.drs.dao.YjSystemDao;
import com.govmade.zhdata.module.drs.mapper.YjSystemMapper;
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Service
public class YjSystemService extends BaseService<YjSystems> {

    @Autowired
    private YjSystemDao yjSystemDao;

    @Autowired
    private YjSystemMapper yjSystemMapper;
    
    @Autowired
    private CompanyService companyService;

    public PageInfo<YjSystems> queryAllList(Page<YjSystems> page) {
        User user=UserUtils.getCurrentUser();
        Integer roleId=user.getRoleId();
        if (roleId!=1) {
            Integer companyId=user.getCompanyId();
            List<Integer> comList=Lists.newArrayList();
            comList.add(companyId);
            findAllSubNode(companyId, comList);
            Map<String, Object> map=Maps.newHashMap();
            map=page.getParams();
            map.put("companyIds", comList);
            page.setParams(map);
        }
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        YjSystems yjSystems = JsonUtil.readValue(page.getObj(), YjSystems.class);
        try {
            String str = new String(yjSystems.getName().getBytes("ISO-8859-1"), "UTF-8");
            yjSystems.setName(str);
        } catch (Exception e) {
            e.printStackTrace();
        }

        List<YjSystems> list = yjSystemDao.queryListByCompanyId(yjSystems,page);
        return new PageInfo<YjSystems>(list);
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
          //  List<Menu> menus=this.menuService.queryListByWhere(record);
            for (Company c : companies) {
                comList.add(c.getId());
                 findAllSubNode(c.getId(),comList);
            }
        }
        
    }
    
    
    public List<YjSystems> queryForExport() {
        YjSystems yjSystems = new YjSystems();
        return yjSystemDao.queryAllList(yjSystems);
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

    
    
    // 保存多条数据
    @Override
    public void saveAll(List<Map<String, String>> dataList) {
        yjSystemDao.saveAll(dataList);
    }
}
