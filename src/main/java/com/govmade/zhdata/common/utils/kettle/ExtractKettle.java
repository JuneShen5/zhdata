package com.govmade.zhdata.common.utils.kettle;

import java.lang.reflect.Field;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;

import com.govmade.zhdata.common.persistence.DataBase;
import com.govmade.zhdata.module.drs.pojo.Columns;
import com.govmade.zhdata.module.drs.pojo.Tables;


/**
 * 数据清洗
 * @author chenqi
 *
 */
@RequestMapping("dataClean")
//@Controller
public class ExtractKettle extends BaseKettle{
//    private static final int RADIX = 16;
//    private static final String SEED = "0933910847463829827159347601486730416058";
//    public  static final String PASSWORD_ENCRYPTED_PREFIX = "Encrypted ";
//    private String lineSeparator = System.getProperty("line.separator", "\n"); //获取系统换行符 默认为"\n"
//   
//    private List<Tables> tablesList;
//    
//    private DataBase db;
    
    
    public ExtractKettle(List<Tables> tablesList,DataBase db){
        super.tablesList = tablesList;
        super.db = db;
    }
    
    /**
     * 创建ktr文件
     * @param request
     * @return
     */
    public ResponseEntity<String> creatKtr(){
        try {

            String ktrPath = ExtractKettle.class.getResource("/template/kttleHead.ktr").getFile();

            String head = super.getHead(ktrPath); // 获取前面一份信息，内容较多暂时存文件里
            String foot = super.getFoot();
            
            String connectIn = getConnect("in", db); // 输入数据库的连接信息
            String connectOut = getConnect("out", db);// 输出数据库的连接信息
            // order信息
            String order = getOrder(); // 获取从order到数据库对应连接及字段对应的所有信息
            String ktr = head + connectIn + connectOut + order + foot;
            long date = System.currentTimeMillis();
            //
            String ktrName = "session_" + date;
//            // // 保存KTR文件
            String savePath = ExtractKettle.class.getResource("/template/").getFile() + ktrName + ".ktr";
            super.saveKtr(ktr, savePath);
//
//            // 将执行任务存入数据库
//            this.dataTaskService.saveDataTask(ktrName, request.getParameter("params"), connectData
//                    .get("name").toString());

            // KettleController.transTest(savePath);
            return ResponseEntity.status(HttpStatus.CREATED).body("任务创建成功！");
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        // 出错返回500
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("任务创建失败！");
    }
    
    //ktr文件所需内容方法开始
    private String getConnect(String in_out, DataBase db) {
        String option = "";
        String type = "";
        switch (db.getType()) {
        case 1:
            option = "<attribute><code>EXTRA_OPTION_MYSQL.characterEncoding</code><attribute>utf8</attribute></attribute>"+ lineSeparator
                    + "<attribute><code>EXTRA_OPTION_MYSQL.defaultFetchSize</code><attribute>500</attribute></attribute>"+ lineSeparator
                    + "<attribute><code>EXTRA_OPTION_MYSQL.useCursorFetch</code><attribute>true</attribute></attribute>"+ lineSeparator;
            type = "MYSQL";
            break;
        case 2:
            option =  "<attribute><code>EXTRA_OPTION_ORACLE.characterEncoding</code><attribute>utf8</attribute></attribute>"+ lineSeparator;
            type = "ORACLE";
            break;
        default:
            break;
        }
        String connectParam = 
                "<connection>"+ lineSeparator
                + "<name>"+ in_out+ "</name>"+ lineSeparator
                + "<server>"+ db.getHost()+"</server>"+ lineSeparator
                + "<type>"+ type+"</type>"+ lineSeparator
                + "<access>Native</access>"+ lineSeparator
                + "<database>"+ db.getDbName()+ "</database>"+ lineSeparator
                + "<port>"+ db.getPort()+ "</port>"+ lineSeparator
                + "<username>"+ db.getName()+ "</username>"+ lineSeparator
                + "<password>"+ encryptPassword(db.getPassword())+ "</password>"+ lineSeparator
                + "<servername/>"+ lineSeparator
                + "<data_tablespace/>"+ lineSeparator
                + "<index_tablespace/>"+ lineSeparator
                + "<attributes>"+ lineSeparator
                + option
                + "<attribute><code>FORCE_IDENTIFIERS_TO_LOWERCASE</code><attribute>N</attribute></attribute>"+ lineSeparator
                + "<attribute><code>FORCE_IDENTIFIERS_TO_UPPERCASE</code><attribute>N</attribute></attribute>"+ lineSeparator
                + "<attribute><code>IS_CLUSTERED</code><attribute>N</attribute></attribute>"+ lineSeparator
                + "<attribute><code>PORT_NUMBER</code><attribute>"+db.getPort()+"</attribute></attribute>"+ lineSeparator
                + "<attribute><code>PRESERVE_RESERVED_WORD_CASE</code><attribute>N</attribute></attribute>"+ lineSeparator
                + "<attribute><code>QUOTE_ALL_FIELDS</code><attribute>N</attribute></attribute>"+ lineSeparator
                + "<attribute><code>STREAM_RESULTS</code><attribute>Y</attribute></attribute>"+ lineSeparator
                + "<attribute><code>SUPPORTS_BOOLEAN_DATA_TYPE</code><attribute>Y</attribute></attribute>"+ lineSeparator
                + "<attribute><code>SUPPORTS_TIMESTAMP_DATA_TYPE</code><attribute>Y</attribute></attribute>"+ lineSeparator 
                + "<attribute><code>USE_POOLING</code><attribute>N</attribute></attribute>"+ lineSeparator 
                + "</attributes>" + "</connection>" + lineSeparator;
        return connectParam;
    }

    private String getOrder() throws IllegalArgumentException, IllegalAccessException {
        String oneOrder = "";
        int inNum = -1;
        int outNum = -1;
        String oneFormStep = ""; // 1对多 表字段对应
            String in = "";
            String out = "";
            for (int i = 0; i < tablesList.size(); i++) {
                outNum++;
                inNum++;

                oneOrder += "<hop> <from>IN_" + inNum + "</from><to>OUT_" + outNum
                        + "</to><enabled>Y</enabled> </hop>" + lineSeparator;

                in = this.getIn(inNum);
                out = this.getOut(outNum);
                oneFormStep += in + out;
            }

        String order = "<order>" + lineSeparator + oneOrder + "</order>" + lineSeparator;
        return order +  oneFormStep;
    }

//    表输入
    private String getIn(int num) throws IllegalArgumentException, IllegalAccessException {
        String sql = "";
        
        for(Columns columns:tablesList.get(num).getColList()){
            for (Field field : columns.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                if(field.get(columns).toString() != null){
                    sql += field.get(columns).toString() + ",";
//                    System.out.println(field.getName() + ":" + field.get(columns) );
                }
                
                }
        }
        String in = "<step>" + lineSeparator + "<name>IN_" + num + "</name>" + lineSeparator
                + "<type>TableInput</type>" + lineSeparator + "<description/>" + lineSeparator
                + "<distribute>Y</distribute>" + lineSeparator + "<custom_distribution/>" + lineSeparator
                + "<copies>1</copies>" + lineSeparator + "<partitioning>" + lineSeparator
                + "<method>none</method>" + lineSeparator + "<schema_name/>" + lineSeparator
                + "</partitioning>" + lineSeparator + "<connection>in</connection>" + lineSeparator
                + "<sql>SELECT " + sql + "FROM " + tablesList.get(num).getNameEn() + "</sql>" + lineSeparator
                + "<limit>0</limit>" + lineSeparator + "<lookup/>" + lineSeparator
                + "<execute_each_row>N</execute_each_row>" + lineSeparator
                + "<variables_active>N</variables_active>" + lineSeparator
                + "<lazy_conversion_active>N</lazy_conversion_active>" + lineSeparator + "<cluster_schema/>"
                + lineSeparator
                + "<remotesteps>   <input>   </input>   <output>   </output> </remotesteps>    <GUI>"
                + lineSeparator + "<xloc>122</xloc>" + lineSeparator + "<yloc>36</yloc>" + lineSeparator
                + "<draw>Y</draw>" + lineSeparator + "</GUI>" + lineSeparator + "</step>" + lineSeparator;
        return in;
    }

//    表输出
    private String getOut(int num) throws IllegalArgumentException, IllegalAccessException {
        String fields = "";
        for(Columns columns:tablesList.get(num).getColList()){
            for (Field field : columns.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                if(field.get(columns).toString() != null){
                    fields += "<field>" + lineSeparator + "<column_name>" + field.get(columns).toString() + "</column_name>"
                            + lineSeparator + "<stream_name>" + field.get(columns).toString() + "</stream_name>" + lineSeparator
                            + "</field>" + lineSeparator;
                    
                }
            }
        }
        String out = "<step>" + lineSeparator + "<name>OUT_" + num + "</name>" + lineSeparator
                + "<type>TableOutput</type>" + lineSeparator + "<description/>" + lineSeparator
                + "<distribute>Y</distribute>" + lineSeparator + "<custom_distribution/>" + lineSeparator
                + "<copies>1</copies>" + lineSeparator + "<partitioning>" + lineSeparator
                + " <method>none</method>" + lineSeparator + "<schema_name/>" + lineSeparator
                + "</partitioning>" + lineSeparator + "<connection>out</connection>" + lineSeparator
                + "<schema/>" + lineSeparator + "<table>" + tablesList.get(num).getNameEn() + "</table>" + lineSeparator
                + "<commit>1000</commit>" + lineSeparator + "<truncate>N</truncate>" + lineSeparator
                + "<ignore_errors>N</ignore_errors>" + lineSeparator + "<use_batch>Y</use_batch>"
                + lineSeparator + "<specify_fields>Y</specify_fields>" + lineSeparator
                + "<partitioning_enabled>N</partitioning_enabled>" + lineSeparator + "<partitioning_field/>"
                + lineSeparator + "<partitioning_daily>N</partitioning_daily>" + lineSeparator
                + "<partitioning_monthly>Y</partitioning_monthly>" + lineSeparator
                + "<tablename_in_field>N</tablename_in_field>" + lineSeparator + "<tablename_field/>"
                + lineSeparator + "<tablename_in_table>Y</tablename_in_table>" + lineSeparator
                + "<return_keys>N</return_keys>" + lineSeparator + "<return_field/>" + lineSeparator
                + "<fields>" + lineSeparator + fields + lineSeparator + "</fields>" + lineSeparator
                + "<cluster_schema/>" + lineSeparator
                + "<remotesteps>   <input>   </input>   <output>   </output> </remotesteps>    <GUI>"
                + lineSeparator + "<xloc>408</xloc>" + lineSeparator + "<yloc>425</yloc>" + lineSeparator
                + "<draw>Y</draw>" + lineSeparator + "</GUI>" + lineSeparator + "</step>" + lineSeparator;
        return out;
    }

  

  //ktr文件所需内容方法结束
}
