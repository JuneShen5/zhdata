package com.govmade.zhdata.common.utils.kettle;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigInteger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.druid.pool.DruidDataSource;
import com.govmade.zhdata.common.persistence.DataBase;
import com.govmade.zhdata.module.drs.pojo.Tables;


public class BaseKettle {
    private static final int RADIX = 16;
    private static final String SEED = "0933910847463829827159347601486730416058";
    public  static final String PASSWORD_ENCRYPTED_PREFIX = "Encrypted ";
    public String lineSeparator = System.getProperty("line.separator", "\n"); //获取系统换行符 默认为"\n"
   
    protected List<Tables> tablesList;
  
    protected DataBase db;
    
    @Autowired
    private DruidDataSource dataSource;
    /**
     * 获取头部信息
     * @param ktrPath
     * @return
     * @throws IOException
     */
    protected String getHead(String ktrPath) throws IOException{
        ktrPath = BaseKettle.class.getResource("/template/dataCleanKttleHead.ktr").getFile();
        BufferedReader templateReader = null;
        try {
            templateReader = new BufferedReader(new FileReader(ktrPath));
            String line = null;
            StringBuffer templatestr = new StringBuffer();
            while ((line = templateReader.readLine()) != null) {
                templatestr.append(line);
                templatestr.append(lineSeparator);
            }
           
            String template = templatestr.toString();
            return template;

        }  finally {
            try {
                templateReader.close();// 3,关闭流
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    
     /**
      * 文件底部
      * @return
      */
    protected String getFoot() {
         String foot = 
                 "<step_error_handling>"+lineSeparator+
                 "<error>"+lineSeparator+
                   "<source_step>check</source_step>"+lineSeparator+
                   "<target_step>null 2</target_step>"+lineSeparator+
                   "<is_enabled>Y</is_enabled>"+lineSeparator+
                   "<nr_valuename/>"+lineSeparator+
                   "<descriptions_valuename/>"+lineSeparator+
                   "<fields_valuename/>"+lineSeparator+
                   "<codes_valuename/>"+lineSeparator+
                   "<max_errors/>"+lineSeparator+
                   "<max_pct_errors/>"+lineSeparator+
                   "<min_pct_rows/>"+lineSeparator+
                 "</error>"+lineSeparator+
             "</step_error_handling>"+lineSeparator+
              "<slave-step-copy-partition-distribution>"+lineSeparator+
           "</slave-step-copy-partition-distribution>"+lineSeparator+
              "<slave_transformation>N</slave_transformation>"+lineSeparator+

         " </transformation>"+lineSeparator;
         return foot;
     }

    protected void saveKtr(String ktr, String savePath) throws IOException {
        BufferedWriter templateWrite = null;
        // Writer out = null;
        try {

            File file = new File(savePath);
            if (!file.exists()) {
                (new File(file.getParent())).mkdirs();
            }
            FileWriter fileOut = new FileWriter(file);
            templateWrite = new BufferedWriter(fileOut);
            templateWrite.write(ktr);
            // out = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
        } finally {
            if (templateWrite != null) {
                try {
                    templateWrite.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

        }
    }
     
     /**
      * kettle中的加密机制
      * @param password
      * @return
      */
     public String encryptPassword(String  password)  
     {
//         String  password = "root";
         if (password==null) return "";  
         if (password.length()==0) return "";  
         BigInteger bi_passwd = new BigInteger(password.getBytes());  
           
         BigInteger bi_r0  = new BigInteger(SEED);  
         BigInteger bi_r1  = bi_r0.xor(bi_passwd);  
           
         String _password = PASSWORD_ENCRYPTED_PREFIX+bi_r1.toString(RADIX);

         return _password;   
     }
}
