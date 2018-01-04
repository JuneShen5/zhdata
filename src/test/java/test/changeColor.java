package test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Test;

public class changeColor {
 
    
    
    @Test
    public void dou() {
        File  fi = new File("C:\\Users\\chenqi\\Desktop\\1514992260561.xlsx");
        InputStream in;
        try {
            in = new FileInputStream(fi);
            Workbook errorDataExcelWb =  new XSSFWorkbook(in);
            Sheet errorDataSheet = errorDataExcelWb.getSheetAt(0);
            
            
            CellStyle  style =  errorDataExcelWb.createCellStyle();
//            style.setFillBackgroundColor(IndexedColors.RED.getIndex());
            style.setFillForegroundColor(HSSFColor.RED.index);
            style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND); 
            errorDataSheet.getRow(6).getCell(2).setCellStyle(style);
            System.out.println(errorDataSheet.getRow(6).getCell(2).getStringCellValue());
            
            FileOutputStream fout = new FileOutputStream("C:\\Users\\chenqi\\Desktop\\22.xlsx");
            errorDataExcelWb.write(fout);
            fout.close();
        
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
       
}

    
   
        