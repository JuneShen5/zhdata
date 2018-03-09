package com.govmade.zhdata.module.drs.service;

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
import com.govmade.zhdata.module.drs.dao.CodeDao;
import com.govmade.zhdata.module.drs.mapper.CodeMapper;
import com.govmade.zhdata.module.drs.pojo.Code;

@Service
public class CodeService extends BaseService<Code>{
    
	@Autowired
	private CodeDao codeDao;
	
	@Autowired
	private CodeMapper codeMapper;
	
	public PageInfo<Code> findAll(Page<Code> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Code code = JsonUtil.readValue(page.getObj(), Code.class);
        try {
            if(code.getPname()!=null){
                String pname= new String(code.getPname().getBytes("ISO-8859-1"), "UTF-8");
                code.setPname(pname);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Code> list = this.codeDao.findAll(code);
        return new PageInfo<Code>(list);
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Code code = new Code();
        code.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Code.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(code, example);
    }
}
