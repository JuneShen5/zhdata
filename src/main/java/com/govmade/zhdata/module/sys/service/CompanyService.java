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
import com.govmade.zhdata.module.drs.mapper.InformationMapper;
import com.govmade.zhdata.module.sys.dao.CompanyDao;
import com.govmade.zhdata.module.sys.mapper.CompanyMapper;
import com.govmade.zhdata.module.sys.pojo.Company;

@Service
public class CompanyService extends BaseService<Company>{

    @Autowired
    private CompanyDao companyDao;
    
    @Autowired
    private CompanyMapper companyMapper;
    
    @Autowired
    private InformationMapper infoMapper;

    
    public Company get(int id) {
        Company company = this.companyDao.get(id);
        return company;
    }
    
    public PageInfo<Company> findAll(Page<Company> page) {

    	 PageHelper.startPage(page.getPageNum(), page.getPageSize());
    	 Company company = JsonUtil.readValue(page.getObj(), Company.class);
    	 try {
             String name= new String(company.getName().getBytes("ISO-8859-1"), "UTF-8");
             company.setName(name);
         } catch (Exception e) {
             e.printStackTrace();
         }
    	 List<Company> list = companyDao.findAll(company);
    	 
    	 return new PageInfo<Company>(list);
    }
    
    /**
     * 删除机构信息
     * 
     * @param ids
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Company company = new Company();
        company.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Company.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(company, example);
    }

    public List<Company> queryCompany(Integer isAudit) {
        List<Company> companies=this.companyDao.queryCompany(new Company(),isAudit);
        return companies;
    }

    /*批量添加用户（excel导入）*/
    public void saveAll(List<Map<String,String>> dataList) {
        companyDao.saveAll(dataList);
    }
    
}
