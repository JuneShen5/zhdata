package com.govmade.zhdata.module.sys.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseController;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.pojo.Role;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.CompanyService;
import com.govmade.zhdata.module.sys.service.RoleService;

@Controller
@RequestMapping(value = "settings/role")
public class RoleController extends BaseController<Role>{

    @Autowired
    private RoleService roleService;
    
    @Autowired
    private CompanyService companyService;

    @RequestMapping(method = RequestMethod.GET)
    public String toRole() {
        return "modules/settings/roleIndex";
    }

    /**
     * 查询角色列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Role>> list(Page<Role> page) {
        try {
            Long total = roleService.getTotal(page,new Role());
            /* if (total <= 0) {
                return ResponseEntity.status(HttpStatus.NO_CONTENT).body(null);
            } */
            List<Role> roleList = roleService.findList(page);

            Page<Role> resPage = new Page<Role>();
            resPage.setTotal(total);
            resPage.setRows(roleList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 保存角色
     * 
     * @param role
     * @param menuIds
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(Role role) throws Exception {
        try {
            
            List<Menu> menus = Lists.newArrayList();
            String jsonArray = role.getMenuIds();
            
            User user = UserUtils.getCurrentUser();
            role.setCompanyId(user.getCompanyId());
            
            if (StringUtil.isNotBlank(jsonArray)) {
                // json数组转List对象
                menus = (List<Menu>) JsonUtil.jsonArray2List(jsonArray, Menu.class);
                role.setMenuList(menus);
            }

            if (null == role.getId()) {
                role.preInsert();
                roleService.saveRole(role);
            } else {
                role.preUpdate();
                roleService.updateRole(role);
            }
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }


    /**
     * 删除角色
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            roleService.deleteByIds(ids);
            this.roleService.deletByRoleId(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    @Override
    protected void getFileName() {
        super.chTableName = "角色管理";
        super.chTableName = "角色管理";
    }

    @Override
    protected void getReadExcelStarLine() {
        super.commitRow = 500;
        super.startRow = 3;
        super.columnIndex = 0;
    }

    @Override
    protected BaseService<Role> getService() {
        return roleService;
    }

    @Override
    protected List<Map<String, Object>> queryDataForExp(Page<Role> page) {
        List<Role> role = roleService.queryForExport();
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for (Role data : role) {
            infoList.add(MapUtil.beansToMap(data));
        }
        return infoList;
    }
    
}
