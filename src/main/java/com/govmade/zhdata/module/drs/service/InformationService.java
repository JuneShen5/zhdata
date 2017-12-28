package com.govmade.zhdata.module.drs.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.InformationDao;
import com.govmade.zhdata.module.drs.dao.TablesDao;
import com.govmade.zhdata.module.drs.mapper.InformationMapper;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.pojo.Tables;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Service
public class InformationService extends BaseService<Information> {

    @Autowired
    private InformationDao infoDao;

    @Autowired
    private InformationMapper infoMapper;

    @Autowired
    private TablesService tablesService;
    
    @Autowired
    private CompanyService companyService;
    
    @Autowired
    private TablesDao tablesDao;

    public PageInfo<Information> findAll(Page<Information> page) {

        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        List<Information> list = infoDao.findAll(new Information());

        return new PageInfo<Information>(list);
    }

    public List<Information> search(Page<Information> page) {
        List<Information> sysList = infoDao.search(page);
        return sysList;
    }

    public Long getTotal(Page<Information> page) {
        return infoDao.getSearchCount(page);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Information info = new Information();
        info.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Information.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(info, example);
    }

    public void deleteInfoEle(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List<String> idList = Arrays.asList(array);
        this.infoDao.deleteInfoEle(idList);

    }

    public void saveInformation(Information info) {
        try {
            if (this.saveSelective(info) > 0 && info.getElementList().size() > 0) {
                this.infoDao.saveRelation(info);
            }
        } catch (Exception e) {
            // 保存失败
            e.printStackTrace();
        }
    }

    public void updateInformation(Information info) {
        try {
            if (this.updateSelective(info) > 0) {
                this.infoDao.deleteRelation(info);
                this.infoDao.saveRelation(info);
            }
        } catch (Exception e) {
            // 保存失败
            e.printStackTrace();
        }
    }

    public Information getInfoElementById(Integer id) {
        return infoDao.getInfoElementById(id);
    }

    public Long queryInfoListTotal(Page<Information> page) {
        Information info = JsonUtil.readValue(page.getObj(), Information.class);
        return this.infoDao.queryCount(info);
    }

    public PageInfo<Information> findByCompanyId(Page<Information> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Information info = JsonUtil.readValue(page.getObj(), Information.class);
        List<Information> list = infoDao.findByCompanyId(info);

        return new PageInfo<Information>(list);
    }

    /*
     * public Long getListTotal(Page<Information> page) { Information info =
     * JsonUtil.readValue(page.getObj(), Information.class); info.setDelFlag(0); return (long)
     * this.infoMapper.selectCount(info); }
     */

    public PageInfo<Information> queryInfoList(Page<Information> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Information info = JsonUtil.readValue(page.getObj(), Information.class);
        List<Information> list = infoDao.queryInfoList(info);
        return new PageInfo<Information>(list);
    }

    public void saveTab(String tableSQL) {
        this.infoDao.saveTable(tableSQL);

    }

    public void delTab(String dropSQL) {
        this.infoDao.delTab(dropSQL);
    }

    public List<Element> findElementById(Integer id) {

        return infoDao.findElementById(id);
    }

    public List<Information> queryList(Page<Information> page) {
        return infoDao.queryListByPage(page);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer updateAuditByids(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Information info = new Information();
        info.setIsAudit(Global.AUDIT_FLAG_YES);
        Example example = new Example(Information.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(info, example);
    }

    public int findMAX(Information info) {
        return this.infoDao.findMAX(info);
    }

    public void deleteAll(List<String> idList) {
       
        if ( this.infoDao.delete(idList)>0) {
            this.infoDao.deleteInfoEle(idList);
            this.tablesDao.updateTabs(idList); //将table表中的info_id设置为0
        }

    }

    public Integer shareCount() {
        Integer shareCount = infoDao.shareCount();
        return shareCount;
    }

    public Integer openCount() {
        Integer openCount = infoDao.openCount();
        return openCount;
    }

    public PageInfo<Information> queryElePoolById(Page<Information> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        String eleId = page.getQueryParams();
        String[] array = StringUtil.split(eleId, ",");
        List<String> elIds = Arrays.asList(array);

        List<Information> list = infoDao.queryElePoolById(elIds);
        return new PageInfo<Information>(list);
    }

    
    public void relationSave(Information information) {

        if (null == information.getId()) {
            information.preInsert();
            Company company=this.companyService.queryById(information.getCompanyId());
            information.setCode(company.getCode());
            if (this.saveSelective(information) > 0) {
                Integer id = information.getId();
                String eleIds = information.getElementIds();
                String[] array = StringUtil.split(eleIds, ",");
                List<String> elIds = Arrays.asList(array);
                this.infoDao.relationSave(id, elIds);
                Tables table = new Tables();
                table.setId(information.getCount());
                table.setInfoId(information.getId());
                this.tablesService.updateSelective(table);
            }
        } else {
            information.preUpdate();
            Company company=this.companyService.queryById(information.getCompanyId());
            information.setCode(company.getCode());
            if (this.updateSelective(information) > 0) {
                this.infoDao.deleteRelation(information);
                Integer id = information.getId();
                String eleIds = information.getElementIds();
                String[] array = StringUtil.split(eleIds, ",");
                List<String> elIds = Arrays.asList(array);
                this.infoDao.relationSave(id, elIds);

            }
        }
    }

    public void updateAllAudit(List<Integer> comList) {
        this.infoDao.updateAllAudit(comList);
    }

    public Integer queryAuditCount(Integer isAudit) {
        Information record=new Information();
        record.setIsAudit(isAudit);
        return this.infoMapper.selectCount(record);
    }

    public void saveAll(List<Map<String,String>> dataList) {
        try {
           for(Map<String,String> infoMap :dataList){
                Information information = MapUtil.map2bean(infoMap,Information.class);
                String jsonArray = information.getElementIds();
                List<Element> elements = Lists.newArrayList();
                if (StringUtils.isNotBlank(jsonArray)) {
                    // json数组转List对象
                    elements = (List<Element>) JsonUtil.jsonArray2List(jsonArray, Element.class);
                    information.setElementList(elements);
                }
                
                Company company=this.companyService.queryById(information.getCompanyId());
                information.setCode(company.getCreditCode());
                this.saveInformation(information);
           }
        
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
    }

    public List<Information> queryForExport() {
        Page<Information> page = new Page<Information>();
        page.setIsPage(false);
        return infoDao.queryListByPage(page);
    }

    public List<Information> queryByCompanyIds(List<Integer> comList) {
        return this.infoDao.queryByCompanyIds(comList);
    }

}
