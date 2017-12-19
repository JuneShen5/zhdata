package com.govmade.zhdata.module.sys.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.sys.dao.RoleDao;
import com.govmade.zhdata.module.sys.pojo.Role;

@Service
public class RoleService extends BaseService<Role> {

    @Autowired
    private RoleDao roleDao;

    public Long getTotal(Page<Role> page,Role role) {
        role = JsonUtil.readValue(page.getObj(), Role.class);
        try {
            String name= new String(role.getName().getBytes("ISO-8859-1"), "UTF-8");
            role.setName(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roleDao.getCount(role);
    }

    /**
     * 根据分页查询角色列表
     * 
     * @param page
     * @return
     */
    public List<Role> findList(Page<Role> page) {

        Role role = JsonUtil.readValue(page.getObj(), Role.class);
        try {
            String name= new String(role.getName().getBytes("ISO-8859-1"), "UTF-8");
            role.setName(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String, Object> params = Maps.newHashMap();
        params.put("delFlag", Global.DEL_FLAG_NORMAL);
        params.put("orderByClause", "id desc");
        page.startPage();
        page.setParams(params);

        List<Role> roleList = roleDao.findList(page,role);

        return roleList;
    }

    /**
     * 保存解决信息
     * 
     * @param role
     */
    public void saveRole(Role role) {
        try {
            if (this.saveSelective(role) > 0) {
                this.roleDao.saveRelation(role);
            }
        } catch (Exception e) {
            // 保存失败
            e.printStackTrace();
        }
    }

    /**
     * 更新角色信息
     * 
     * @param role
     */
    public void updateRole(Role role) {
        try {
            if (this.updateSelective(role) > 0) {
                this.roleDao.deleteRelation(role);
                this.roleDao.saveRelation(role);
            }
        } catch (Exception e) {
            // 保存失败
            e.printStackTrace();
        }
    }

    /**
     * 删除角色信息
     * 
     * @param ids
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Role role = new Role();
        role.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Role.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.updateByExampleSelective(role, example);
    }

    public void deletByRoleId(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List<String> idList = Arrays.asList(array);
        this.roleDao.deletByRoleId(idList);
    }

    
    public List<Role> findAll() {
		
        return roleDao.findAll();
    }

     public List<Role> queryForExport() {
         Role role = new Role();
         return roleDao.findAllList(role);
     }
    
}
