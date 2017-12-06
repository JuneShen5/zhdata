package com.govmade.zhdata.module.sys.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.sys.dao.MenuDao;
import com.govmade.zhdata.module.sys.pojo.Menu;

@Service
public class MenuService extends BaseService<Menu> {
    @Autowired
    private MenuDao menuDao;

    public PageInfo<Menu> selectByUserId1(int userId) {
        // 测试通用mapper，结果可用
        PageHelper.startPage(1, 20);
        List<Menu> list = menuDao.selectByUserId(userId);
        return new PageInfo<Menu>(list);
    }

    public List<Menu> selectByUserId(int userId) {
        List<Menu> list = menuDao.selectByUserId(userId);
        return bulid(list);
    }

    public List<Menu> findAll(Menu entity) {
        List<Menu> list = menuDao.findAll(entity);
        return list;
    }

    public List<Menu> bulid(List<Menu> menus) {
        List<Menu> trees = Lists.newArrayList();
        for (int i = 0; i < menus.size(); i++) {
            Menu e = menus.get(i);
            if (e.getIsShow() == 1) {
                if (e.getParentId().intValue() == 1) {
                    trees.add(e);
                }
                for (int j = 0; j < menus.size(); j++) {
                    Menu m = menus.get(j);
                    if (m.getParentId().intValue() == e.getId().intValue()) {
                        if (e.getChildren() == null) {
                            List<Menu> mychildrens = Lists.newArrayList();
                            mychildrens.add(m);
                            e.setChildren(mychildrens);
                        } else {
                            e.getChildren().add(m);
                        }
                    }
                }
            }
        }
        return trees;
    }

    public Integer deleteByIds(List<String> idList) {
       return this.menuDao.deleteByIds(idList);
    }

    public void deletByMenuId(List<String> idList) {
        this.menuDao.deletByMenuId(idList);
        
    }

    public void saveRoleMenuRation(Integer roleId, Integer menuId) {
       this.menuDao.saveRoleMenuRation(roleId,menuId);
        
    }

    public void deleteMenuByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List<String> idList = new ArrayList<String>(Arrays.asList(array));
        this.menuDao.deleteByIds(idList);
    }

    public void deletRationByMenuId(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List<String> idList = new ArrayList<String>(Arrays.asList(array));
        this.menuDao.deletByMenuId(idList);
        
    }

    public void deleteRationByMenuId(Integer id) {
       this.menuDao.deleteRationByMenuId(id);
        
    }

   /* @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');

        List idList = Arrays.asList(array);
        Menu menu=new Menu();
        menu.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(Menu.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);

        return this.updateByExampleSelective(menu, example);
    }

    public void deletByMenuId(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List<String> idList = Arrays.asList(array);
        this.menuDao.deletByMenuId(idList);
    }
*/
    

}
