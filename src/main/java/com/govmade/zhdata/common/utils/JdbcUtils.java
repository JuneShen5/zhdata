package com.govmade.zhdata.common.utils;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class JdbcUtils {
//      static final String DRIVERCLASS;
//      static final String URL;
//      static final String USER;
//      static final String PASSWORD;
//      
//      static {
//              // 块编辑 alt+shift +a
//              // 变大写 ctrl+shift+x
//              // 变小写 ctrl+shift+y
//              // 向下复制一行   alt+ctrl+↓
//              // 向下添加一个空行 shift + enter
//              // 向上添加一个空行 ctrl+shift + enter
//              // 删除一行 选中行  ctrl+d
//              // 注释或者去掉注释 ctrl+/
//              // 向下移动一行 alt + ↓
//              
//              
//              // 获取ResourceBundle ctrl+2 l
//              ResourceBundle bundle = ResourceBundle.getBundle("jdbc");
//              
//              // 获取指定的内容
//              DRIVERCLASS = bundle.getString("driverClass");
//              URL = bundle.getString("url");
//              USER = bundle.getString("user");
//              PASSWORD = bundle.getString("password");
//      }
//      
//      static {
//              // 注册驱动 ctrl+shift+f格式化代码
//              try {
//                      Class.forName(DRIVERCLASS);
//              } catch (ClassNotFoundException e) {
//                      e.printStackTrace();
//              }
//      }
//      

//      // 获取连接
//      public static Connection getConnection() throws SQLException {
//              // 获取连接 ctrl+o 整理包
//              return  DriverManager.getConnection(URL, USER, PASSWORD);
//      }

        /**
         * 释放资源
         * 
         * @param conn
         *            连接
         * @param st
         *            语句执行者
         * @param rs
         *            结果集
         */
        public static void closeResource(Connection conn, Statement st, ResultSet rs) {
                closeResultSet(rs);
                closeStatement(st);
                closeConn(conn);
        }

        /**
         * 释放连接
         * 
         * @param conn
         *            连接
         */
        public static void closeConn(Connection conn) {
                if (conn != null) {
                        try {
                                conn.close();
                        } catch (SQLException e) {
                                e.printStackTrace();
                        }
                        conn = null;
                }

        }

        /**
         * 释放语句执行者
         * 
         * @param st
         *            语句执行者
         */
        public static void closeStatement(Statement st) {
                if (st != null) {
                        try {
                                st.close();
                        } catch (SQLException e) {
                                e.printStackTrace();
                        }
                        st = null;
                }

        }

        /**
         * 释放结果集
         * 
         * @param rs
         *            结果集
         */
        public static void closeResultSet(ResultSet rs) {
                if (rs != null) {
                        try {
                                rs.close();
                        } catch (SQLException e) {
                                e.printStackTrace();
                        }
                        rs = null;
                }

        }
        
        public static List<Map<String, Object>> resultSet2List(ResultSet rs) throws SQLException{
            List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
            ResultSetMetaData md = rs.getMetaData(); //获得结果集结构信息,元数据  
            int columnCount = md.getColumnCount();   //获得列数   s
         // 处理结果集(遍历结果集合)
            while( rs.next() ){
                Map<String,Object> rowData = new LinkedHashMap<String,Object>(); 
                for (int i = 1; i <= columnCount; i++) {
                    rowData.put(md.getColumnName(i), rs.getObject(i));  
                }  
                list.add(rowData);
            }
            return list;
        }
        
        public static Map<String, String> getType(ResultSet rs) throws SQLException{
            ResultSetMetaData md = rs.getMetaData(); //获得结果集结构信息,元数据  
            int columnCount = md.getColumnCount();   //获得列数   s
//          获取字段类型
          Map<String,String> type = new LinkedHashMap<String,String>();
          for (int i = 1; i <= columnCount; i++) {
              type.put(md.getColumnName(i),md.getColumnTypeName(i));
          }  
          return type;
        }
        
        public static Map<String, String> getRemark(Connection conn, String tableName) throws SQLException{
            DatabaseMetaData  dbmd = conn.getMetaData(); 
            ResultSet rs = dbmd.getColumns(null, "%",tableName, "%");
            Map<String,String> remark = new LinkedHashMap<String,String>();
            while (rs.next()) {
                remark.put(rs.getString("COLUMN_NAME"),rs.getString("REMARKS"));
//                System.out.println("COLUMN_NAME"+rs.getString("COLUMN_NAME"));
//                System.out.println("REMARKS"+rs.getString("REMARKS")); 
//                System.out.println("TYPE_NAME"+rs.getString("TYPE_NAME"));
//                System.out.println("COLUMN_SIZE"+rs.getString("COLUMN_SIZE"));
//                System.out.println("DECIMAL_DIGITS"+rs.getString("DECIMAL_DIGITS"));
               
            }
            return remark;
        }
        
        
        /**
         * JDBC的ResultSet转JSONArray
         * @param rs
         * @return
         * @throws SQLException
         * @throws JSONException
         */
        public static JSONArray resultSetToJsonArray(ResultSet rs) throws SQLException   
        {  
           // json数组  
           JSONArray array = new JSONArray();  
            
           // 获取列数  
           ResultSetMetaData metaData = rs.getMetaData();  
           int columnCount = metaData.getColumnCount();  
            
           // 遍历ResultSet中的每条数据  
            while (rs.next()) {  
                JSONObject jsonObj = new JSONObject();  
                 
                // 遍历每一列  
                for (int i = 1; i <= columnCount; i++) {
                    String columnName =metaData.getColumnLabel(i);  
                    String value = rs.getString(columnName);  
                    jsonObj.put(columnName, value);  
                }
                array.add(jsonObj);
//                array.put(jsonObj);   
            }  
            
           return array;  
        }  
        
        public static String listToString(List list, char separator) { 
            StringBuilder sb = new StringBuilder();   
            for (int i = 0; i < list.size(); i++) {    
                if (i == list.size() - 1) {
                    sb.append(list.get(i));       
                    } else {     
                        sb.append(list.get(i));    
                        sb.append(separator);      
                        }    }    
            return sb.toString();}
        
}
