package com.govmade.zhdata.common.utils.excel;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFDataValidationConstraint;
import org.apache.poi.xssf.usermodel.XSSFDataValidationHelper;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
/** 
 * 实体数据导出Excel公共方法 
 *  
 * @author cyz 
 * 
 */  
public class ExportExcelData extends ExportExcelImpl {  

    public ExportExcelData(String fileName, String title, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) {
        super(fileName, title, rowName, dataList, response);
        // TODO Auto-generated constructor stub
    }

    @Override
    void exportValue(XSSFSheet sheet,int columnNum) {
        
        //将查询出的数据设置到sheet对应的单元格中  
        for(int i=0;i<dataList.size();i++){
              
            Map<String, Object> obj = dataList.get(i);//遍历每个对象  
            Row row = sheet.createRow(i+3);//创建所需的行数  
              
            for(int j=0; j<columnNum; j++){    //j代表列
                Cell  cell = null;   //设置单元格的数据类型  
//                if(j == 0){
//                    cell = row.createCell(j,Cell.CELL_TYPE_NUMERIC);  
//                    cell.setCellValue(i+1);   
//                }else{
                    cell = row.createCell(j,Cell.CELL_TYPE_STRING);  
                    String nameEn = "";
                        try {
                            String columType = rowName[j].split("_")[2];
//                            String[] templateValue = getTemplateValue(columType,j);
//                            if(templateValue.length>0){
                            if(!(columType.equals("input")||columType.equals("dateselect")||"textarea".equals(columType)||columType.equals("element"))){
                                String[] templateValue = getTemplateValue(columType,j);
                                if(columType.equals("checkbox")||columType.equals("check")){ //多选框
                                    String regEx="[\\s~·`!！@#￥$%^……&*（()）\\-——\\-_=+【\\[\\]】｛{}｝\\|、\\\\；;：:‘'“”\"，,《<。.》>、/？?]";  
                                    Pattern p = Pattern.compile(regEx);  
                                    Matcher m = p.matcher(obj.get(rowName[j].split("_")[1]).toString().trim());  
                                    String[] checkArray = m.replaceAll(",").split(",");
                                    for(String check:checkArray){
                                        for(int n=0;n<templateValue.length;n++){
                                            if(check.equals(templateValue[n].split("_")[1].toString())){
                                                nameEn += templateValue[n].split("_")[0].toString()+",";
                                            }
                                        }
                                    }
                                    nameEn = nameEn.substring(0,nameEn.length() - 1);
                                }else{
                                    for(int m=0;m<templateValue.length;m++){
                                        if(obj.get(rowName[j].split("_")[1]).toString().trim().equals(templateValue[m].split("_")[1].toString())){
                                            nameEn = templateValue[m].split("_")[0].toString();
                                        }
                                    }
                                }
                            
                            }else{
                                nameEn = obj.get(rowName[j].split("_")[1]).toString();
                            }
                        } catch (Exception e) {
//                            // TODO Auto-generated catch block
////                            e.printStackTrace();
                            continue;    //此处continue是为了下标不报错
                        }
                    if(!"".equals(nameEn) && nameEn != null){
                        cell.setCellValue(nameEn);               //设置单元格的值  
                    }  
//                }  
//                cell.setCellStyle(style);                                   //设置单元格样式  
            }  
        }  
    }
    
  
    

}  
