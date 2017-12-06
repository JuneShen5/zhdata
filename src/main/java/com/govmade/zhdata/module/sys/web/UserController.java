package com.govmade.zhdata.module.sys.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.CipherUtil;
import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.common.utils.excel.ExportExcelData;
import com.govmade.zhdata.common.utils.excel.ExportExcelTemplate;
import com.govmade.zhdata.common.utils.excel.ImportExcelData;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.UserService;

@Controller
@RequestMapping(value = "settings/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 跳转至用户管理页面
     * 
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String toUser() {
        return "modules/settings/userIndex";
    }
    
    /**
     * 
     * 跳转至我的面板-密码修改页面
     * @return
     */
    @RequestMapping(value = "toPwd", method = RequestMethod.GET)
    public String toPwd() {
        return "modules/panel/passwordIndex";
    }

    
    /**
     * 查询用户列表
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<User>> list(Page<User> page) {
        try {
            PageInfo<User> pageInfo = userService.findAll(page);
            List<User> userList = pageInfo.getList();
            Page<User> resPage = new Page<User>();
            resPage.setTotal(pageInfo.getTotal());
            resPage.setRows(userList);

            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    /**
     * 新增或修改用户
     * 
     * @param user
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public ResponseEntity<String> save(User user) throws Exception {
        try {
       
            if (null == user.getId()) {
                user.preInsert();
                String salt=CipherUtil.createSalt();
                user.setPassword(CipherUtil.createPwdEncrypt("abc123456", salt));
                user.setSalt(salt);
                this.userService.saveSelective(user);
            } else {
                user.preUpdate();
                this.userService.updateSelective(user);
            }
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    
    /**
     * 删除用户
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) throws Exception {
        try {
            userService.deleteByIds(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    @RequestMapping(value = "loginCheck", method = RequestMethod.GET)
    public ResponseEntity<Boolean> loginCheck(User user) {
        int count = userService.queryConut(user);
        if (count >= 1) {
            return ResponseEntity.ok(false);
        } else {
            return ResponseEntity.ok(true);
        }
    }

    
   

    /**
     * 修改密码
     * 
     * @param oldPwd
     * @param newPwd
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "updatePwd", method = RequestMethod.POST)
    public ResponseEntity<String> updatePwd(String oldPwd, String newPwd) throws Exception {
        try {
            User user = UserUtils.getCurrentUser();
            String pwdEncrypt = CipherUtil.createPwdEncrypt(oldPwd, user.getSalt()); 
            String password = user.getPassword();
            if (!password.equals(pwdEncrypt)) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("旧密码输入有误");
            } else {
                user.setPassword(CipherUtil.createPwdEncrypt(newPwd, user.getSalt()));
                this.userService.updateSelective(user);
                return ResponseEntity.ok("密码修改成功");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }
    
    
    /**
     * 导出数据
     * @param page
     * @param request
     * @param response
     */
    @RequestMapping(value = "exportData", method = RequestMethod.POST)
    public void exportData(Page<User> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        String [] rowName =  page.getObj().split(",");; //头部
        
        page.setObj("{\"name\":\"\"}"); //查询的时候有用所以这样整了一下
        PageInfo<User> pageInfo = userService.findAll(page);
        List<User> userList = pageInfo.getList();
        
//        List<Systems> sList=this.systemService.queryList(page);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        for(User user:userList){
            infoList.add(MapUtil.beanToMap(user));
        }
        
        //获取实体数据
        try {
            String chTableName ="用户管理";
            String enTableName ="用户管理";
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
            ExportExcelData exportExcel = new ExportExcelData(chTableName,enTableName,rowName,infoList,response);
           exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    
    /**
     * 导出数据模板
     * @param id 
     * @param name 文件中文名
     * @param request
     * @param response
     */
    @RequestMapping(value = "downloadTemplate", method = RequestMethod.POST)
    public void downloadTemplate(Page<User> page,HttpServletRequest request,HttpServletResponse response){
        page.setIsPage(false);
        List<Map<String, Object>> infoList = Lists.newArrayList();
        String [] rowName =  page.getObj().split(",");; //头部
        //获取实体数据
        try {
            String chTableName ="用户管理模板";
            String enTableName ="用户管理模板";
//           String chTableName = new String( name.getBytes("ISO8859-1"), "UTF-8" );
            ExportExcelTemplate exportExcel = new ExportExcelTemplate(chTableName,enTableName,rowName,infoList,response);
           exportExcel.export();
           } catch (Exception e1) {
               e1.printStackTrace();
           }
    }
    
    //导入数据
    @RequestMapping(value ="importData" , method = RequestMethod.POST)
    public ResponseEntity<String> importData(@RequestParam(value = "file", required = false) MultipartFile file,HttpServletRequest request,String code) {
        try {
            ImportExcelData importExcel = new ImportExcelData(file,0,0);
            Map<String, String> titleAndAttribute = new HashMap<String, String>();
            List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
            List<Map<String, String>> resolurdDtaList = new ArrayList<Map<String,String>>();
            boolean is = true;
            int commitRow = 500; //读取多少返回一次
            int startRow = 3;  //开始读取的行
            while(is){
                dataList = importExcel.uploadAndRead(titleAndAttribute,startRow,commitRow);
                startRow = startRow+commitRow;
                if(dataList.size()!=0){
                    for(Map<String, String> map :dataList){
                        Map<String, String> dataMap = new HashMap<String, String>();
                        for (String k : map.keySet())
                        {
                            System.out.println("k:"+k);
                            System.out.println( map.get(k));
                           String _k = StringUtil.toUnderScoreCase(k);
                           dataMap.put(_k, map.get(k));
                        }
                        String salt=CipherUtil.createSalt();
                        dataMap.put("password", CipherUtil.createPwdEncrypt("abc123456", salt));
                        dataMap.put("salt",salt);
                        resolurdDtaList.add(dataMap);
                    }
                    
                    this.userService.saveAll(resolurdDtaList); 
                }
                if(dataList.size()<commitRow || dataList.size()==0){
                    is=false; 
                }
            }
            return ResponseEntity.ok(Global.IMPORT_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Global.IMPORT_ERROR);
    }
}
