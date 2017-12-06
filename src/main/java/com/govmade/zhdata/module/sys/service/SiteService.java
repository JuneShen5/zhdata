package com.govmade.zhdata.module.sys.service;

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
import com.govmade.zhdata.module.sys.dao.SiteDao;
import com.govmade.zhdata.module.sys.pojo.Site;

@Service
public class SiteService extends BaseService<Site> {

    @Autowired
    private SiteDao siteDao;

    public Site get(int id) {
        Site site = this.siteDao.get(id);
        return site;
    }

    /**
     * 删除班子信息
     * 
     * @param ids
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Site site = new Site();
        site.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Site.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(site, example);
    }

    public PageInfo<Site> queryList(Page<Site> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Site site = JsonUtil.readValue(page.getObj(), Site.class);
        try {
            String name= new String(site.getName().getBytes("ISO-8859-1"), "UTF-8");
            site.setName(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        List<Site> list = siteDao.queryAllList(site);
        return new PageInfo<Site>(list);
    }
}
