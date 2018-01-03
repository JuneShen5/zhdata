package com.govmade.zhdata.common.utils.excel;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

  
/** 
 * 导出Excel公共方法 
 *  
 * @author cyz 
 * 
 */  
public abstract class ExportExcelImpl{  

    //导出文件的名字
    private String fileName;
    //显示的导出表的标题  
    private String title;  
    //导出表的列名  
    protected String[] rowName;
      
    protected List<Map<String, Object>>  dataList = new ArrayList<Map<String, Object>>();  
      
    private HttpServletResponse  response = null;
    
    protected XSSFWorkbook workbook = null;
    
    private OutputStream out = null;
    private String templatePath = ExportExcelImpl.class.getResource("excelTemplate/").getPath();
    
//    private String templatePath = System.getProperty("user.dir")+"\\src\\main\\webapp\\static\\file\\";
    
    protected CellStyle columnTopStyle = null;
    
    protected CellStyle style = null;
    
//    protected String[] unSelect = {"input","dateselect","textarea","element","linkageSelect"}; //不用做关联的inputtype
   
    protected List<Map<String, Object>> infoSortTree; //用于存储资源分类的树形结构数据
    
    protected Integer levalNum =4;
    
    //构造方法，传入要导出的数据  
    public ExportExcelImpl(String fileName,String title,String[] rowName,List<Map<String, Object>>  dataList,HttpServletResponse response){
        this.fileName = fileName;   //导出的文件名
        this.dataList = dataList;   //查询出来的实体数据
//        this.rowName = ChangeRowName(rowName);    //传过来的 中文名_因文名_类型_company 组成的数组
        this.rowName = rowName;
        this.title = title;       //sheet名
        this.response = response;
    }
    
    public ExportExcelImpl(String fileName,String title,String templatFile,String[] rowName,List<Map<String, Object>>  dataList,HttpServletResponse response) throws IOException{
        this(fileName, title, rowName,  dataList,response);
        System.out.println("templatePath:"+templatePath);
        System.out.println(templatePath+templatFile);
        File  fi = new File(templatePath+templatFile);
        InputStream in;
        try {
            in = new FileInputStream(fi);
        } catch (FileNotFoundException e) {
            throw new RuntimeException("模板文件不存在");
        }
        this.workbook = new XSSFWorkbook(in);
    }
    
    public ExportExcelImpl(String fileName,String title,String templatFile,String[] rowName,List<Map<String, Object>>  dataList) throws IOException{
        this.fileName = fileName;   //导出的文件名
        this.dataList = dataList;   //查询出来的实体数据
        this.rowName = ChangeRowName(rowName);    //传过来的 中文名_因文名_类型_company 组成的数组
//        this.rowName = rowName;
        this.title = title;       //sheet名
       
        File  fi = new File(templatePath+templatFile);
        InputStream in;
        try {
            in = new FileInputStream(fi);
        } catch (FileNotFoundException e) {
            throw new RuntimeException("模板文件不存在");
        }
        this.workbook = new XSSFWorkbook(in);
    }
    

    public String[] ChangeRowName(String[] rowName){
      ArrayList<String> rowNameList = new ArrayList<String>(Arrays.asList(rowName));
      ArrayList<String> _rowNameList = new ArrayList<>(rowNameList);
      ArrayList<String> linkList = new ArrayList<String>();
      int i=0;
      for(String rowNameElement:rowNameList){
          String[]  rowNameElementRow = rowNameElement.split("_");
          if("linkageSelect".equals(rowNameElementRow[2])){
              linkList.clear();
              String inputName =rowNameElementRow[1];
//              getLinkageData(rowNameElementRow[3]);
             for(int j=1;j<=levalNum;j++){
                 linkList.add(rowNameElementRow[0]+"_"+inputName+j+"_"+rowNameElementRow[2]+"_"+rowNameElementRow[3]);
             }
             _rowNameList.remove(i);
             _rowNameList.addAll(i, linkList);
             i++;
          }
      }
      return (String[]) _rowNameList.toArray(new String[_rowNameList.size()]);
    }
    


    public void export () throws Exception{
        Workbook createExcel = this.createExcel();
//        this.out(createExcel);  //测试导出到桌面
        this.writeInOutputStream(createExcel);
    }
    
    public void out(Workbook createExcel) throws Exception{
        FileOutputStream out = new FileOutputStream("C:\\Users\\chenqi\\Desktop\\export.xlsx");
        createExcel.write(out);
        out.close();
    }
    
              
    /* 
     * 导出数据 
     * */  
    public Workbook createExcel() throws Exception{
        XSSFSheet sheet = workbook.getSheetAt(0);
        workbook.setSheetName(0, this.fileName);
        //sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】  
        this.columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象  
        this.style = this.getStyle(workbook);//单元格样式对象  
        this.exportHead(sheet); //导出头部信息
        this.exportValue(sheet); //导出信息
        return workbook;  
    }
    
    /**
     * 模板输出下拉，实体数据输出数据
     * @param sheet
     */
   protected abstract void exportValue(XSSFSheet sheet);
   
   /**
    * 输出隐藏的那几行
    * @param sheet
    */
   private void exportHead(XSSFSheet sheet){
       
       int lastRowNum = sheet.getLastRowNum();
       
       if(lastRowNum <1){
           //模板中自己没做过设置的
           int valueStartRow=3;
           int columnNum = rowName.length;
           //没有excel模板的头部信息导出
           for(int m=0;m<valueStartRow;m++){
               Row rowRowName = sheet.createRow(m); //标题包含三行，第一行是中文，第二行是英文，第三行是类型（二三行隐藏）
         
               // 将列头设置到sheet的单元格中  
               for(int n=0;n<columnNum;n++){
                   Cell  cellRowName = rowRowName.createCell(n);               //创建列头对应个数的单元格  
                   cellRowName.setCellType(Cell.CELL_TYPE_STRING);             //设置列头单元格的数据类型  
                   if(m==valueStartRow-1){
                       String rowNameCell = rowName[n];
                       int index = rowNameCell.indexOf("_");
                       index = rowNameCell.indexOf("_", index+1); //英文有些最后一个_后面时空的，所有按照第二个_的位置来区分
                       RichTextString text = new XSSFRichTextString(rowNameCell.substring(index+1,rowNameCell.length()));
                       cellRowName.setCellValue(text); //设置列头单元格的值     
                   }else{
                       RichTextString text = new XSSFRichTextString(rowName[n].split("_")[m]);
                       cellRowName.setCellValue(text); //设置列头单元格的值     
                   }
                   cellRowName.setCellStyle(columnTopStyle);                       //设置列头单元格样式  
               }
                   if(m==1 || m==2){
                       rowRowName.setZeroHeight(true);//将行隐藏
                   }
           }
           
       }else{
           Row titelRow = sheet.getRow(lastRowNum); //获取英文字段的行
           int lastCellNum =  titelRow.getLastCellNum();   //模板中的总列数
           Map<String,String> rowNameMap = rowNameToMap(); //将rowname 的数组改成MAP形式以便快速和excel中的英文名称对应
           Row inputTypeRow = sheet.createRow(lastRowNum+1);
           for (int i = 0; i <lastCellNum; i++) {
               String nameEn = titelRow.getCell(i).getStringCellValue(); //获取每个英文字段
               String value =  rowNameMap.get(nameEn); 
               if(value != null){
                   inputTypeRow.createCell(i).setCellValue(value);//在下面第二行输入输入框类型的值
               }else{
                   inputTypeRow.createCell(i).setCellValue("");//在下面第二行输入输入框类型的值
               }
             
           }
           for(int j=0;j<2;j++){
               sheet.getRow(lastRowNum+j).setZeroHeight(true);//将行隐藏
           }
       }
   }
   
   /**
    * 将rowname 的数组改成MAP形式以便快速和excel中的英文名称对应
    * 因为要根据模板中nameEn的顺序来排序
    * @return Map<nameEn,input_inputvalue> 
    */
    private Map<String,String> rowNameToMap(){
        Map<String,String> rowNameMap = new HashMap<String,String>();
        
        for(int i=0;i<rowName.length;i++){
            String rowNameCell = rowName[i];
            int index = rowNameCell.indexOf("_");
            index = rowNameCell.indexOf("_", index+1); //英文有些最后一个_后面时空的，所有按照第二个_的位置来区分
            rowNameMap.put(rowNameCell.split("_")[1], rowNameCell.substring(index+1,rowNameCell.length()) );
        }
        return rowNameMap;
    }
    
    public void writeInOutputStream(Workbook workbook) throws Exception{
        
        //设置响应类型、与头信息
        response.setContentType("application/x-msdownload");
        response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(fileName+".xlsx", "UTF-8"));
        out = response.getOutputStream();
        workbook.write(out);
        
          //清除资源
        out.close();
    }
      
    /*  
     * 列头单元格样式 
     */      
    public CellStyle getColumnTopStyle(XSSFWorkbook workbook2) {  
          
          // 设置字体  
    	  Font font = workbook2.createFont();  
          //设置字体大小  
          font.setFontHeightInPoints((short)11);  
          //字体加粗  
          font.setBoldweight(Font.BOLDWEIGHT_BOLD);  
          //设置字体名字   
          font.setFontName("Courier New");  
          //设置样式;   
          CellStyle style = workbook2.createCellStyle();  
          //设置底边框;   
          style.setBorderBottom(CellStyle.BORDER_THIN);  
          //设置底边框颜色;    
          style.setBottomBorderColor(HSSFColor.BLACK.index);  
          //设置左边框;     
          style.setBorderLeft(CellStyle.BORDER_THIN);  
          //设置左边框颜色;   
          style.setLeftBorderColor(HSSFColor.BLACK.index);  
          //设置右边框;   
          style.setBorderRight(CellStyle.BORDER_THIN);  
          //设置右边框颜色;   
          style.setRightBorderColor(HSSFColor.BLACK.index);  
          //设置顶边框;   
          style.setBorderTop(CellStyle.BORDER_THIN);  
          //设置顶边框颜色;    
          style.setTopBorderColor(HSSFColor.BLACK.index);  
          //在样式用应用设置的字体;    
          style.setFont(font);  
          //设置自动换行;   
          style.setWrapText(false);  
          //设置水平对齐的样式为居中对齐;    
          style.setAlignment(CellStyle.ALIGN_CENTER);  
          //设置垂直对齐的样式为居中对齐;   
          style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);  
            
          return style;  
            
    }  
      
    /*   
     * 列数据信息单元格样式 
     */    
    public CellStyle getStyle(XSSFWorkbook workbook) {
          // 设置字体  
          Font font = workbook.createFont();  
          //设置字体大小  
          //font.setFontHeightInPoints((short)10);  
          //字体加粗  
          //font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
          //设置字体名字   
          font.setFontName("Courier New");  
          //设置样式;   
          CellStyle style = workbook.createCellStyle(); 
          //设置底边框;   
          style.setBorderBottom(CellStyle.BORDER_THIN);  
          //设置底边框颜色;    
          style.setBottomBorderColor(HSSFColor.BLACK.index);  
          //设置左边框;     
          style.setBorderLeft(CellStyle.BORDER_THIN);  
          //设置左边框颜色;   
          style.setLeftBorderColor(HSSFColor.BLACK.index);  
          //设置右边框;   
          style.setBorderRight(CellStyle.BORDER_THIN);  
          //设置右边框颜色;   
          style.setRightBorderColor(HSSFColor.BLACK.index);  
          //设置顶边框;   
          style.setBorderTop(CellStyle.BORDER_THIN);  
          //设置顶边框颜色;    
          style.setTopBorderColor(HSSFColor.BLACK.index);  
          //在样式用应用设置的字体;    
          style.setFont(font);  
          //设置自动换行;   
          style.setWrapText(false);  
          //设置水平对齐的样式为居中对齐;    
          style.setAlignment(CellStyle.ALIGN_CENTER);  
          //设置垂直对齐的样式为居中对齐;   
          style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);  
           
          return style;  
      
    } 
    
   
    
    
//    protected void getAllDictToList1(){
//        Connection conn = null;  
//        DruidDataSource dataSource = new DruidDataSource();
//        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
//        dataSource.setUrl("jdbc:mysql://127.0.0.1:3306/zhdata?useUnicode=true&characterEncoding=UTF-8");
//        dataSource.setUsername("root");
//        dataSource.setPassword("root");
//        
//        try {
//            conn = dataSource.getConnection();
//        } catch (SQLException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//        
//        
//        try {
//        
//        String etableNameSql = "select * from sys_dict";
//        
//        PreparedStatement stat = conn.prepareStatement(etableNameSql);
//        
//        ResultSet rs = stat.executeQuery();
//        int col = rs.getMetaData().getColumnCount();
//        ResultSetMetaData rsmd = rs.getMetaData();
//        Map<String, Map<String,String>> resultMap = new HashMap<String, Map<String,String>>(); 
//        while (rs.next()) {
//            for (int i = 1; i <= col; i++) {
////                String name = rsmd.getColumnName(i);
////                String value = rs.getString(i);
//                String type = rs.getString("type");
//                String value = rs.getString("value");
//                String label  = rs.getString("label");
//                if(resultMap.containsKey(type)){//map中异常批次已存在，将该数据存放到同一个key（key存放的是异常批次）的map中 
//                    resultMap.get(type).put(value,label); 
//                }else{//map中不存在，新建key，用来存放数据 
//                    Map<String,String> valLabMap = new HashMap<String, String>();
//                    valLabMap.put(value, label);
//                    resultMap.put(type, valLabMap); 
//                } 
//            }
//        }   
//        System.out.println("resultMap:"+resultMap);
//        dictMap = resultMap;
//    }catch (SQLException e) {
//        // TODO Auto-generated catch block
//        e.printStackTrace();
//    }
//    }
}  
