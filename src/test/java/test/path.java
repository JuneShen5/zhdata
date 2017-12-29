package test;

import org.junit.Test;

import com.govmade.zhdata.common.utils.excel.ExportExcelImpl;


public class path {
    
    @Test
    public void dou() {
        try {
            String savePath = ExportExcelImpl.class.getResource("/excelTemplate/").getFile();
            System.out.println("savePath:"+savePath);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

    
   
        