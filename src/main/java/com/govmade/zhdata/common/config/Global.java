/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.govmade.zhdata.common.config;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.springframework.core.io.DefaultResourceLoader;

import com.google.common.collect.Maps;
import com.govmade.zhdata.common.utils.PropertiesLoader;
import com.govmade.zhdata.common.utils.StringUtil;

/**
 * 全局配置类
 * 
 * @author ThinkGem
 * @version 2014-06-25
 */
public class Global {

    /**
     * 当前对象实例
     */
    private static Global global = new Global();

    /**
     * 保存全局属性值
     */
    private static Map<String, String> map = Maps.newHashMap();

    /**
     * 属性文件加载对象
     */
    private static PropertiesLoader loader = new PropertiesLoader("env.properties");

    public static final String SESSION_SECURITY_CODE = "sessionSecCode";

    /**
     * 显示/隐藏
     */
    public static final String SHOW = "1";

    public static final String HIDE = "0";

    /**
     * 是/否
     */
    public static final String YES = "1";

    public static final String NO = "0";

    /**
     * 对/错
     */
    public static final String TRUE = "true";

    public static final String FALSE = "false";

    /**
     * 删除标记（0：正常；1：删除；）
     */
    public static final int DEL_FLAG_NORMAL = 0;

    public static final int DEL_FLAG_DELETE = 1;

    /**
     * 审核标记（0：未审核；1：审核；）
     */
    public static final int AUDIT_FLAG_NO = 0;
    
    public static final int AUDIT_FLAG_YES = 1;
    
    /**
     * 增/删/改
     */
    public static final String INSERT_SUCCESS = "保存成功！";

    public static final String INSERT_ERROR = "保存失败！";
    
    public static final String UPDATE_SUCCESS = "更新成功！";

    public static final String UPDATE_ERROR = "更新失败！";
    
    public static final String DELETE_SUCCESS = "删除成功！";

    public static final String DELETE_ERROR = "删除失败！";
    
    public static final String HANDLE_SUCCESS = "数据操作成功！";
    
    public static final String HANDLE_ERROR = "数据操作失败！";
    
    public static final String IMPORT_ERROR = "上传失败！";
    public static final String IMPORT_SUCCESS = "上传成功！";
    
    
    public static final String REDIS_KEY = "qxdata_REDIS_"; 
    
    public static final Integer REDIS_TIME = 60*30;
    
    /**
     * 数据库连接信息    
     */
    public static final String ORACLE_DRIVER = "oracle.jdbc.driver.OracleDriver";

    public static final String ORACLE_URL = "jdbc:oracle:thin:@%s:%s:%s";

    public static final String MYSQL_DRIVER = "com.mysql.jdbc.Driver";

    public static final String MYSQL_URL = "jdbc:mysql://%s:%s/%s?useInformationSchema=true&useUnicode=true&characterEncoding=utf-8";
    
    /**
     * 上传文件基础虚拟路径
     */
    public static final String USERFILES_BASE_URL = "/userfiles/";

    public static final String SESSION_USER = "sessionUser";       
    
    /**
     * 获取当前对象实例
     */
    public static Global getInstance() {
        return global;
    }

    /**
     * 获取配置
     * 
     * @see ${fns:getConfig('adminPath')}
     */
    public static String getConfig(String key) {
        String value = map.get(key);
        if (value == null) {
            value = loader.getProperty(key);
            map.put(key, value != null ? value : StringUtil.EMPTY);
        }
        return value;
    }

    /**
     * 获取管理端根路径
     */
    public static String getAdminPath() {
        return getConfig("adminPath");
    }

    /**
     * 获取前端根路径
     */
    public static String getFrontPath() {
        return getConfig("frontPath");
    }

    /**
     * 获取URL后缀
     */
    public static String getUrlSuffix() {
        return getConfig("urlSuffix");
    }

    /**
     * 是否是演示模式，演示模式下不能修改用户、角色、密码、菜单、授权
     */
    public static Boolean isDemoMode() {
        String dm = getConfig("demoMode");
        return "true".equals(dm) || "1".equals(dm);
    }

    /**
     * 页面获取常量
     * 
     * @see ${fns:getConst('YES')}
     */
    public static Object getConst(String field) {
        try {
            return Global.class.getField(field).get(null);
        } catch (Exception e) {
            // 异常代表无配置，这里什么也不做
        }
        return null;
    }

    /**
     * 获取工程路径
     * 
     * @return
     */
    public static String getProjectPath() {
        // 如果配置了工程路径，则直接返回，否则自动获取。
        String projectPath = Global.getConfig("projectPath");
        if (StringUtil.isNotBlank(projectPath)) {
            return projectPath;
        }
        try {
            File file = new DefaultResourceLoader().getResource("").getFile();
            if (file != null) {
                while (true) {
                    File f = new File(file.getPath() + File.separator + "src" + File.separator + "main");
                    if (f == null || f.exists()) {
                        break;
                    }
                    if (file.getParentFile() != null) {
                        file = file.getParentFile();
                    } else {
                        break;
                    }
                }
                projectPath = file.toString();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return projectPath;
    }

}
