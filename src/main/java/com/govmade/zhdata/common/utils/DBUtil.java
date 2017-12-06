package com.govmade.zhdata.common.utils;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;

/**
 * @author 舒洪吉
 *
 */
public class DBUtil {

    private static String url = "";

    private static String driver = "";

    /**
     * 根据传入的参数，验证连接是否可用
     * 
     * @return true:数据库连接正常 false:数据库连接异常
     */
    public static boolean checkConnConfig(Connection conn) {
        try {
            return conn != null;
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static void setValue(Integer type, String host, String post, String dbName) {
        switch (type) {
        case 1:
            url = String.format(Global.MYSQL_URL, host, post, dbName);
            driver = Global.MYSQL_DRIVER;
            break;
        case 2:
            url = String.format(Global.ORACLE_URL, host, post, dbName);
            driver = Global.ORACLE_DRIVER;
            break;
        default:
            break;
        }
    }

    /**
     * 获得Connection
     * 
     * @return
     */
    public static Connection getConn(Integer type, String host, String post, String dbName, String user,
            String password) throws Exception {
        Connection conn = null;
        setValue(type, host, post, dbName);
        try {
            // 创建连接（通过反射机制）
            Driver d = (Driver) Class.forName(driver).newInstance();
            // 配置账号密码
            Properties prop = new Properties();
            prop.put("user", user);
            prop.put("password", password);
            // 获取连接
            conn = d.connect(url, prop);
            return conn;
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(Global.HANDLE_ERROR);
        }
    }

    /**
     * 获取数据库 表 的 名称 和 注释
     * 
     * @param connection 数据库连接
     * @return
     */
    public static List<Map<String, Object>> getTables(Connection conn) throws Exception {
        List<Map<String, Object>> result = Lists.newArrayList();
        ResultSet rs = null;
        try {
            rs = conn.getMetaData().getTables(null, "%", "%", new String[] { "TABLE" });
            while (rs.next()) {
                Map<String, Object> map = Maps.newLinkedHashMap();
                String nameEn=rs.getString("TABLE_NAME");
                String nameCn=rs.getString("REMARKS");
                map.put("nameEn", nameEn);
                if (nameCn ==null || "".equals(nameCn)) {
                    map.put("nameCn", nameEn);
                }else {
                    map.put("nameCn", nameCn);
                }
                result.add(map);
            }
            return result;
        } finally {
            if (conn != null) {
                try {
                    rs.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 获取数据库字段
     * 
     * @param connection 数据库连接
     * @param tableName 数据库的表名
     * @return
     */
    public static List<Map<String, Object>> getColumns(Connection conn, String tableName) throws Exception {
        List<Map<String, Object>> result = Lists.newArrayList();
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            pst = conn.prepareStatement("select * from " + tableName + " where 1=2");
            ResultSetMetaData rsd = pst.executeQuery().getMetaData();
            rs = conn.getMetaData().getColumns(null, "%", tableName, "%");
            for (int i = 0; i < rsd.getColumnCount(); i++) {

                Map<String, Object> map = Maps.newLinkedHashMap();
                rs.next();
                String nameEn=rsd.getColumnName(i + 1);
                String nameCn=rs.getString("REMARKS");
                map.put("type", formateType(rsd.getColumnClassName(i + 1)));
                map.put("nameEn", nameEn);
                if (nameCn.isEmpty()) {
                    map.put("nameCn", nameEn);
                }else {
                    map.put("nameCn", nameCn);
                }
                map.put("length", rsd.getColumnDisplaySize(i + 1));

                result.add(map);
            }
            return result;
        } finally {
            if (conn != null) {
                try {
                    rs.close();
                    pst.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static Integer formateType(String javaType) {
        switch (javaType) {
        case "java.lang.Integer":
        case "java.lang.Long":
        case "java.math.BigInteger":
            return 1;
        case "java.lang.String":
            return 2;
        case "java.lang.Boolean":
            return 3;
        case "java.sql.Float":
            return 4;
        case "java.sql.Double":
            return 5;
        case "java.math.BigDecimal":
            return 6;
        case "java.sql.Timestamp":
            return 7;
        case "java.sql.Date":
            return 8;
        case "java.sql.Time":
            return 9;
        default:
            return 0;
        }
    }

}
