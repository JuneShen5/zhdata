package com.govmade.zhdata.common.utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.alibaba.fastjson.JSONArray;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.mysql.jdbc.Statement;

public class DBMSMetaUtil {

    /**
     * 数据库类型,枚举
     * 
     */
    public static enum DATABASETYPE {
        ORACLE, MYSQL, SQLSERVER, DB2, INFORMIX, SYBASE, OTHER, EMPTY
    }

    /**
     * 列出所有表信息
     * 
     */
    public static List<Map<String, Object>> listTables(String databasetype, String ip, String port, String dbname,  
            String username, String password) {
        // 去除首尾空格  
        databasetype = trim(databasetype);  
        ip = trim(ip);  
        port = trim(port);
        dbname = trim(dbname);
        username = trim(username);  
        password = trim(password);  

        DATABASETYPE dbtype = parseDATABASETYPE(databasetype);  
      /*  System.out.println("dbtype:"+dbtype);*/
        
        List<Map<String, Object>> result = null;  
        String url = concatDBURL(dbtype, ip, port, dbname);  
      /*  System.out.println("url:"+url);*/
        Connection conn = getConnection(url, username, password);  
//        try {
//            String querySQL = "SELECT * FROM YOU";
//            PreparedStatement ps1 = conn.prepareStatement(querySQL);
//            ResultSet rs1 = ps1.executeQuery();
//            while(rs1.next()){
//                System.out.println("ID："+rs1.getString("ID")+" 名 称 ："
//                        + ""+rs1.getString("USERNAME")+" 性别："+rs1.getString("PASSWORD")); 
//            }
//            
//        } catch (SQLException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//        return null; 
        
        
        
        // Statement stmt = null; 
        ResultSet rs = null;  
        //
        try {  
            conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);  
            // 获取Meta信息对象  
            DatabaseMetaData meta = conn.getMetaData();  
            // 数据库  
            String catalog = null;  
            // 数据库的用户  
            String schemaPattern = null;// meta.getUserName();  
            // 表名  
            String tableNamePattern = null;//  
            // types指的是table、view  
            String[] types = { "TABLE" };  
            // Oracle  
            if (DATABASETYPE.ORACLE.equals(dbtype)) {  
                schemaPattern = username;  
                if (null != schemaPattern) {  
                    schemaPattern = schemaPattern.toUpperCase();  
                }  
                // 查询  
                rs = meta.getTables(catalog, schemaPattern, tableNamePattern, types);  
            } else if (DATABASETYPE.MYSQL.equals(dbtype)) {  
                // Mysql查询  
                // MySQL 的 table 这一级别查询不到备注信息  
                schemaPattern = dbname;
                rs = meta.getTables(catalog, schemaPattern, tableNamePattern, types);  
            }  else if (DATABASETYPE.SQLSERVER.equals(dbtype)) {  
                // SqlServer  
                tableNamePattern = "%";
                rs = meta.getTables(catalog, schemaPattern, tableNamePattern, types);  
            }  else if (DATABASETYPE.DB2.equals(dbtype)) {
                // DB2查询  
//                schemaPattern = dbname;
                tableNamePattern = "%";
                rs = meta.getTables(catalog, schemaPattern, tableNamePattern, types);  
            } else if (DATABASETYPE.INFORMIX.equals(dbtype)) {  
                // InforMix  
                tableNamePattern = "%";  
                rs = meta.getTables(catalog, schemaPattern, tableNamePattern, types);  
            } else if (DATABASETYPE.SYBASE.equals(dbtype)) {  
                // SyBase  
                tableNamePattern = "%";  
                rs = meta.getTables(catalog, schemaPattern, tableNamePattern, types);  
            }  else {  
                throw new RuntimeException("不认识的数据库类型!");  
            }  
            
            result = parseResultSetToMapList(rs);  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            close(rs);  
            close(conn);  
        }  
        return result;  
    }
    
    /**
     * 列出表的所有字段信息
     * 
     */
    public static List<Map<String, Object>> listColumns(String databasetype, String ip, String port, String dbname,  
            String username, String password, String tableName) { 
        List<Map<String,Object>> list = Lists.newArrayList(); 
        // 去除首尾空格  
        databasetype = trim(databasetype);  
        ip = trim(ip);  
        port = trim(port);  
        dbname = trim(dbname);  
        username = trim(username);  
        password = trim(password);  
        tableName = trim(tableName);  
        //  
        DATABASETYPE dbtype = parseDATABASETYPE(databasetype);  
        //  
        List<Map<String, Object>> result = null;  
        String url = concatDBURL(dbtype, ip, port, dbname);  
        Connection conn = getConnection(url, username, password);  
        // Statement stmt = null;  
        ResultSet rs = null;  
        //  
        try {  
            // 获取Meta信息对象  
            DatabaseMetaData meta = conn.getMetaData();  
            // 数据库  
            String catalog = null;  
            // 数据库的用户  
            String schemaPattern = null;// meta.getUserName();  
            // 表名  
            String tableNamePattern = tableName;//  
            // 转换为大写  
            if (null != tableNamePattern) {  
                tableNamePattern = tableNamePattern.toUpperCase();  
            }  
            //   
            String columnNamePattern = null;  
            // Oracle  
            if (DATABASETYPE.ORACLE.equals(dbtype)) {  
                // 查询  
                schemaPattern = username;  
                if (null != schemaPattern) {  
                    schemaPattern = schemaPattern.toUpperCase();  
                }  
            } else {  
                //  
            }  
            rs = meta.getColumns(catalog, schemaPattern, tableNamePattern, columnNamePattern);  
            // TODO 获取主键列,但还没使用  
            meta.getPrimaryKeys(catalog, schemaPattern, tableNamePattern);  
            //  
            result = parseResultSetToMapList(rs);  
            //System.out.println("result="+result);
            for (Map<String, Object> map : result) {
                String nameEn=map.get("COLUMN_NAME").toString();
                String nameCn=(String) map.get("REMARKS");
                if (nameCn == null || "".equals(nameCn)) {
                    map.put("nameCn", nameEn);
                }else {
                    map.put("nameCn", nameCn);
                }
                /*Integer type=(Integer) map.get("DATA_TYPE");*/
                // String type=map.get("TYPE_NAME").toString();
                Integer length=Integer.valueOf(map.get("COLUMN_SIZE").toString());
                map.put("nameEn", nameEn);
                map.put("type", formateType(map.get("TYPE_NAME").toString()));
                map.put("length", length);
                
                list.add(map);
                //System.out.println("columnlist="+list);
            }
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            // 关闭资源  
            close(rs);  
            close(conn);  
        }  
        //  
        return list;  
    }
    
    /**
     * 根据字符串,判断数据库类型
     * 
     * @param databasetype
     * @return
     */
    public static DATABASETYPE parseDATABASETYPE(String databasetype) {
        // 空类型
        if (StringUtil.isBlank(databasetype)) {
            return DATABASETYPE.EMPTY;
        }
        // 截断首尾空格,转换为大写
        databasetype = databasetype.trim().toUpperCase();
        // Oracle数据库
        if (databasetype.contains("ORACLE")) {
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            return DATABASETYPE.ORACLE;
        }
        // MYSQL 数据库
        if (databasetype.contains("MYSQL")) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            return DATABASETYPE.MYSQL;
        }
        // SQL SERVER 数据库
        if (databasetype.contains("SQLSERVER")) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            return DATABASETYPE.SQLSERVER;
        }
        // DB2 数据库
        if (databasetype.contains("DB2")) {
            try {
                Class.forName("com.ibm.db2.jcc.DB2Driver");
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
            return DATABASETYPE.DB2;
        }
        // INFORMIX 数据库
        if (databasetype.contains("INFORMIX")) {
            //
            return DATABASETYPE.INFORMIX;
        }
        // SYBASE 数据库
        if (databasetype.contains("SYBASE")) {
            //
            return DATABASETYPE.SYBASE;
        }
        // 默认,返回其他
        return DATABASETYPE.OTHER;
    }

    /**
     * 根据IP,端口,以及数据库名字,拼接Oracle连接字符串
     * 
     * @param ip
     * @param port
     * @param dbname
     * @return
     */
    public static String concatDBURL(DATABASETYPE dbtype, String ip, String port, String dbname) {
        //
        String url = "";

        if (DATABASETYPE.ORACLE.equals(dbtype)) {
            // ORACLE数据库
            url += "jdbc:oracle:thin:@";
            url += ip.trim();
            url += ":" + port.trim();
            url += ":" + dbname;
        } else if (DATABASETYPE.MYSQL.equals(dbtype)) {
            // MYSQL数据库
            url += "jdbc:mysql://";
            url += ip.trim();
            url += ":" + port.trim();
            url += "/" + dbname;
            url +="?characterEncoding=utf-8";
        } else if (DATABASETYPE.SQLSERVER.equals(dbtype)) {
            // SQLSERVER数据库
          //  url += "jdbc:jtds:sqlserver://";
            url += "jdbc:sqlserver://";
            url += ip.trim();
            url += ":" + port.trim();
            url += ";databaseName="+dbname;
        //   url += "/" + dbname;
            url += ";tds=8.0;lastupdatecount=true";
        } else if (DATABASETYPE.DB2.equals(dbtype)) {
            // DB2数据库
            url += "jdbc:db2://";
            url += ip.trim();
            url += ":" + port.trim();
            url += "/" + dbname;
        } else if (DATABASETYPE.INFORMIX.equals(dbtype)) {
            // INFORMIX
            url += "jdbc:informix-sqli://";
            url += ip.trim();
            url += ":" + port.trim();
            url += "/" + dbname;
        } else if (DATABASETYPE.SYBASE.equals(dbtype)) {
            // SYBASE
            url += "jdbc:sybase:Tds:";
            url += ip.trim();
            url += ":" + port.trim();
            url += "/" + dbname;
        } else {
            throw new RuntimeException("不认识的数据库类型!");
        }
        return url;
    }

    /**
     * 获取JDBC连接
     * 
     * @param url
     * @param username
     * @param password
     * @return
     */
    public static Connection getConnection(String url, String username, String password) {
        Connection conn = null;
        try {
            Properties info = new Properties();
            //
            info.put("user", username);
            info.put("password", password);
            // !!! Oracle 如果想要获取元数据 REMARKS 信息,需要加此参数
            info.put("remarksReporting", "true");
            // !!! MySQL 标志位, 获取TABLE元数据 REMARKS 信息
            info.put("useInformationSchema", "true");
            // 不知道SQLServer需不需要设置...
            //
            conn = DriverManager.getConnection(url, info);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * 测试数据库连接
     * 
     * @param databasetype
     * @param ip
     * @param port
     * @param dbname
     * @param username
     * @param password
     * @return
     */
    public static boolean TryLink(String databasetype, String ip, String port, String dbname,
            String username, String password) {
        DATABASETYPE dbtype = parseDATABASETYPE(databasetype);
        String url = concatDBURL(dbtype, ip, port, dbname);
        Connection conn = null;
        try {
            conn = getConnection(url, username, password);
            if (null == conn) {
                return false;
            }
            DatabaseMetaData meta = conn.getMetaData();
            if (null == meta) {
                return false;
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn);
        }
        return false;
    }

    /**
     * 关闭conn
     * 
     * @param conn
     */
    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
                conn = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 关闭stmt
     * 
     * @param stmt
     */
    public static void close(Statement stmt) {
        if (stmt != null) {
            try {
                stmt.close();
                stmt = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 关闭rs
     * 
     * @param rs
     */
    public static void close(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
                rs = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static String trim(String str){  
        if(null != str){  
            str = str.trim();  
        }  
        return str;  
    }  
    
    /**
     * 将一个未处理的ResultSet解析为Map列表.
     * 
     * @param rs
     * @return
     */
    public static List<Map<String, Object>> parseResultSetToMapList(ResultSet rs) {

        List<Map<String, Object>> result = Lists.newArrayList();
        if (null == rs) {
            return null;
        }
        try {
            while (rs.next()) {
                Map<String, Object> map = parseResultSetToMap(rs);
                if (null != map) {
                    result.add(map);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /** 
     * 解析ResultSet的单条记录,不进行 ResultSet 的next移动处理 
     *  
     * @param rs 
     * @return 
     */  
    private static Map<String, Object> parseResultSetToMap(ResultSet rs) {  
        if (null == rs) {
            return null;
        }
        Map<String, Object> map = Maps.newHashMap();
        try {
            ResultSetMetaData meta = rs.getMetaData();
            int colNum = meta.getColumnCount();
            for (int i = 1; i <= colNum; i++) {
                // 列名 
                String name = meta.getColumnLabel(i); // i+1  
                Object value = rs.getObject(i);  
                // 加入属性
                map.put(name, value);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
    
    private static Integer formateType(String javaType) {
        switch (javaType) {
        case "INT":
        case "BIGINT":
        case "LONG":
            return 10;
        case "VARCHAR":
        case "CHAR":
        case "VARCHAR2":
        case "NVARCHAR2":
        case "CLOB":
            return 1;
        case "LOGIC":
            return 6;
        case "BLOB":
            return 8;
        case "FLOAT":
            return 11;
        case "DOUBLE":
            return 9;
        case "DECIMAL":
            return 4;
       /* case "TIME":
            return 7;*/
        case "TIMESTAMP":
        case "DATETIME":
            return 5;
        case "DATE":
            return 3;
        case "TEXT":
            return 7;
        case "NUMBER":
            return 2;
        default:
            return 1;
        }
    }
    
    public static void main(String[] args) {
        testLinkOracle();
    }

    //测试 
    public static void testLinkOracle() {
        
        /*String ip = "183.245.210.26";
        String port = "3310";
        String dbname = "qxdata";
        String username = "root";
        String password = "root";
        String databasetype = "mysql";*/
        
        String ip = "183.245.210.26";
        String port = "1601";
        String dbname = "orcl";
        String username = "SYSMAN";
        String password = "123456";
        String databasetype = "oracle";
        
       //List<Map<String, Object>> tables = listTables(databasetype, ip, port, dbname, username, password);
        
        
       // String tableName = "sys_user";
       String tableName = "AKETTLETEST";
       List<Map<String, Object>> columns = listColumns(databasetype, ip, port, dbname, username, password, tableName);
        
       // tables = MapUtil.convertKeyList2LowerCase(columns);
        
        String jsonT = JSONArray.toJSONString(columns, true);  
        System.out.println(jsonT);  
        System.out.println("tables.size()=" + columns.size()); 
        for (Map<String, Object> map : columns) {
           //String ra= map.get("REMARKS").toString();
      
         /* String  ra = new String(map.get("REMARKS").toString().getBytes("ISO-8859-1"), "UTF-8");*/
          System.out.println("columns.remarks="+map.get("REMARKS"));
          System.out.println("columns.name="+map.get("COLUMN_NAME"));
        
           
        }
        
        List<String> idList =Lists.newArrayList();
        idList.add("i");
        idList.add("u");
        System.out.println("idlist======"+idList); //idlist======[i, u]
        
    }

}
