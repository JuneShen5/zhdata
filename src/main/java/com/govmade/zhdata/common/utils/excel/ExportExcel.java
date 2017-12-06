package com.govmade.zhdata.common.utils.excel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
  
/** 
 * 常规excel导出工具
 *  
 * @author cyz 
 * 
 */  
public class ExportExcel extends ExportExcelImpl{  

   
      
    //构造方法，传入要导出的数据  
//    public ExportExcel(String fileName,String title,String[] rowName,List<Object[]>  dataList,HttpServletResponse response){
//        this.fileName = fileName;
//        this.dataList = dataList;  
//        this.rowName = rowName;  
//        this.title = title;  
//        this.response = response;
//    }
    
  
    
    public ExportExcel(String fileName, String title, String[] rowName, List<Map<String, Object>> dataList, HttpServletResponse response) {
        super(fileName, title, rowName, dataList, response);
        // TODO Auto-generated constructor stub
    }
    
    
    @Override
    protected void exportHead(XSSFSheet sheet,int columnNum) {
        Row rowRowName = sheet.createRow(0);                // 在索引2的位置创建行(最顶端的行开始的第二行)  
        
        // 将列头设置到sheet的单元格中  
        for(int n=0;n<columnNum;n++){  
            Cell  cellRowName = rowRowName.createCell(n);               //创建列头对应个数的单元格  
            cellRowName.setCellType(Cell.CELL_TYPE_STRING);             //设置列头单元格的数据类型  
            RichTextString text = new HSSFRichTextString(rowName[n]);  
            cellRowName.setCellValue(text);                                 //设置列头单元格的值  
            cellRowName.setCellStyle(super.columnTopStyle);                       //设置列头单元格样式  
        }  
    }
    
    @Override
    void exportValue(XSSFSheet sheet,int columnNum) {
        //将查询出的数据设置到sheet对应的单元格中  
        for(int i=0;i<dataList.size();i++){  
              
            Map<String, Object> obj = super.dataList.get(i);//遍历每个对象  
            Row row = sheet.createRow(i+1);//创建所需的行数  
              
            for(int j=0; j<obj.size(); j++){  
                Cell  cell = null;   //设置单元格的数据类型  
                if(j == 0){  
                    cell = row.createCell(j,Cell.CELL_TYPE_NUMERIC);  
                    cell.setCellValue(i+1);   
                }else{  
                    cell = row.createCell(j,Cell.CELL_TYPE_STRING);  
                    if(!"".equals(obj.get("\""+j+"\"")) && obj.get("\""+j+"\"") != null){  
                        cell.setCellValue(obj.get("\""+j+"\"").toString());               //设置单元格的值  
                    }  
                }  
                cell.setCellStyle(style);                                   //设置单元格样式  
            }  
        }  
    }
}  
