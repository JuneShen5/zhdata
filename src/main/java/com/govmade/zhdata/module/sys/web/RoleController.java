package com.govmade.zhdata.module.sys.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.ExcelConstant;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.DateUtils;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.common.utils.excel.ExportExcel;
import com.govmade.zhdata.common.utils.excel.ImportExcel;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.pojo.Role;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.CompanyService;
import com.govmade.zhdata.module.sys.service.RoleService;

@Controller
@RequestMapping(value = "settings/role")
public class RoleController {

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
     * 
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
    
    
    /**
     * 读取Excel中的用户信息插入数据库
     * @param multipart
     * @param session
     * @return
     */
    @RequestMapping(value="import", method = RequestMethod.POST)
    public ResponseEntity<String> importFile(MultipartFile file){
        //定义对应的标题名与对应属性名
    	 Map<String, String> ta=ExcelConstant.getSiteTA();
        
    	 String msg = "";
        try {
        	int successNum = 0;
			int failureNum = 0;
        	 //调用解析工具包
        	ImportExcel testExcel=new ImportExcel(file, 0, 0);
            //解析excel，获取客户信息集合
        	List<Map<String, String>> maps= testExcel.uploadAndRead(ta);
            if(maps != null && !"[]".equals(maps.toString()) && maps.size()>=1){
                
                for (Map<String, String> map : maps) {
                	
                	/*
                	 * 查询对应的机构
                	 */
                	Company company =new Company();
                	String companyName=map.get(ta.get(ExcelConstant.ROLE_COMPANYNAME_TITEL)).trim();
                	company.setName(companyName);
                	company=companyService.queryOne(company);
                	if (company==null) {
						msg+="归属机构:"+companyName+"不存在！";
						failureNum++;
						continue;
					}
                	String useableString=map.get(ExcelConstant.ROLE_USEABLE_AT);
                	Integer useable=0;
                 	if (!StringUtil.isBlank(useableString)) {
                 		if (useableString.endsWith(".0")) {
                 			useableString=useableString.replace(".0", "");
						}
                 		useable=Integer.parseInt(useableString);
					}
                 	/*
                 	 * 获取menuList
                 	 */
                 	
                 	
                	Role role=new Role(company.getId(), map.get(ExcelConstant.ROLE_NAME_AT), map.get(ExcelConstant.ROLE_ENNAME_AT), useable,null,map.get(ExcelConstant.REMARKS_AT));
                	role.preInsert();
                	try {
                		this.roleService.saveRole(role);
                		successNum++;
                		
					} catch (Exception e) {
						failureNum++;
                		msg+="角色名称" + role.getName() + " 导入失败！";
						e.printStackTrace();
					}
				}
                if (successNum==maps.size()) {
                	msg+="批量导入EXCEL成功！";
				}else {
					msg+="\n 导入成功："+successNum+"条数据。\n 导入失败："+failureNum+"条数据。";
				}
            }else{
            	msg+="导入失败！失败信息：导入文档为空!";
            }
        } catch (Exception e) {
        	msg+="读取Excel文件错误！";
        	e.printStackTrace();
        }
        return ResponseEntity.ok(msg);
    }

	/**
	 * 下载导入角色数据模板
	 * 
	 * @return
	 */
	@RequestMapping(value = "import/template", method = RequestMethod.GET)
	public ResponseEntity<String> importFileTemplate(
			HttpServletResponse response) {

		// 配置信息
		String fileName =ExcelConstant.ROLE_FILENAME_TEM;
		String title = ExcelConstant.ROLE_TITLE;
		String[] rowName =ExcelConstant.ROLE_ROWNAME;
		List<Object[]> dataList = new ArrayList<Object[]>();
//		ExportExcel leadingOutExcel = new ExportExcel(fileName, title, rowName,
//				dataList, response);
		String msg = "";
		try {
//			leadingOutExcel.export();
		} catch (Exception e) {
			e.printStackTrace();
			msg="导出用户失败！失败信息：" + e.getMessage();
		}
		return ResponseEntity.ok(msg);
	}

	/**
	 * 导出角色数据
	 * 
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public ResponseEntity<String> exportFile(
			HttpServletResponse response) {
		// Map<String, Object> conditionMap = null; 根据返回的中文 查询nameCn nameEn
		List<Role> roles = null;
		ExportExcel leadingOutExcel = null; // 工具类

		// 配置信息
		String fileName =ExcelConstant.ROLE_TITLE+ DateUtils.getDate("yyyyMMddHHmmss");
		String title =ExcelConstant.ROLE_TITLE;
		String[] rowName =ExcelConstant.ROLE_ROWNAME;

		// 查询条件
		roles = roleService.findAll();
		List<Object[]> dataList = new ArrayList<Object[]>();
		Object[] objs = null;
		for (int i = 0; i < roles.size(); i++) {
			Role role = roles.get(i);
			Company company=companyService.queryById(role.getCompanyId());
			objs = new Object[rowName.length];
			objs[0] = i;
			objs[1] =company.getName();
			objs[2] = role.getName();
			objs[3] = role.getEnname();
			objs[4] =role.getUseable();
			objs[4]="";
			objs[6] = role.getRemarks();
			dataList.add(objs);
		}

//		leadingOutExcel = new ExportExcel(fileName, title, rowName,
//				dataList, response);
		String msg="";
		try {
			leadingOutExcel.export();
		} catch (Exception e) {
			e.printStackTrace();
			msg="导出用户失败！失败信息：" + e.getMessage();
		}
		return ResponseEntity.ok(msg);
	}
}
