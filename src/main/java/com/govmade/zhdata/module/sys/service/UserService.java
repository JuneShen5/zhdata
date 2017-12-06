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
import com.govmade.zhdata.module.sys.dao.UserDao;
import com.govmade.zhdata.module.sys.pojo.User;

@Service
public class UserService extends BaseService<User> {

    @Autowired
    private UserDao userDao;

    public PageInfo<User> findAll(Page<User> page) {
        PageHelper.startPage(page.getPageNum(), page.getPageSize());

        User user = JsonUtil.readValue(page.getObj(), User.class);
        try {
            String name= new String(user.getName().getBytes("ISO-8859-1"), "UTF-8");
            user.setName(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        List<User> list = userDao.findAll(user);
        
        return new PageInfo<User>(list);
    }
    
    /**
     * 删除用户信息
     * 
     * @param ids
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        User user = new User();
        user.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(User.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(user, example);
    }

    /*批量添加用户（excel导入）*/
    public void saveAll(List<Map<String,String>> dataList) {
        userDao.saveAll(dataList);
    }
}
