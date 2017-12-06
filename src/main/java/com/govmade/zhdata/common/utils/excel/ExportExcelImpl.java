package com.govmade.zhdata.common.utils.excel;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.CellRangeAddress;
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

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.utils.DrsUtils;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.SysUtils;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.Systems;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.Dict;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.pojo.Role;
import com.govmade.zhdata.module.sys.pojo.Site;
  
/** 
 * 导出Excel公共方法 
 *  
 * @author cyz 
 * 
 */  
abstract class ExportExcelImpl {  

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
    
    private String lineSeparator = System.getProperty("line.separator", "\n"); //获取系统换行符 默认为"\n"
      
    protected Integer valueStartRow = 3; //开始存数据的行
    
    protected CellStyle columnTopStyle = null;
    
    protected CellStyle style = null;
    //构造方法，传入要导出的数据  
    public ExportExcelImpl(String fileName,String title,String[] rowName,List<Map<String, Object>>  dataList,HttpServletResponse response){
        this.fileName = fileName;   //导出的文件名
        this.dataList = dataList;   //查询出来的实体数据
        this.rowName = ChangeRowName(rowName);    //传过来的 中文名_因文名_类型_company 组成的数组
        this.title = title;       //sheet名
        this.response = response;
    }
    
    
    public String[] ChangeRowName(String[] rowName){
      int _i=0;//用于记录第几个是linkselect类型的
      int levalNum = 0;//用于记录联动的层数
      String[] _rowName = null;//用于存放新的额数组
      for(int i=0;i<rowName.length ;i++){
          String columType = rowName[i].split("_")[2];
         if("linkselect".equals(columType)){
             _i = i;
             levalNum = 4;
             _rowName = new String[levalNum]; //这边先直接写死了
             //将值付给_rowName
             for(int j=1;j<=levalNum;j++){
//                 String inputType = "";
//                 if(j==1){
//                     inputType = rowName[_i].split("_")[2];
//                 }else{
//                     inputType = "input"; //下面的子级当做input以便在导出模板中不出错
//                 }
                 _rowName[j-1] = rowName[_i].split("_")[0]+j+"_"+rowName[_i].split("_")[1]+j+"_"+ rowName[_i].split("_")[2]+"_";
             }
         }
      }
      
      if(levalNum == 0){
          return rowName;
      }else{
          String[] _rowName_ = new String[_rowName.length+rowName.length-1];
          for(int a=0;a<_rowName_.length;a++){
              if(a<=3){
                  _rowName_[a] = _rowName[a];
              }else{
                  _rowName_[a] = rowName[a-3];
              }
          }
          return _rowName_;
//          if(_i >0){
//              String[] a = new String[_i];
//              String[] b = new String[rowName.length-_i-1];
//              for(int n=0;n<rowName.length;n++){
//                  if(n>_i){
//                    b[n] = rowName[n];
//                  }else{
//                    a[n] = rowName[n]; 
//                  }
//              }
//              _rowName_ =ArrayUtils.addAll(ArrayUtils.addAll(a,_rowName),b) ;
//          }else{
//             String[] a = new String[rowName.length-1];
//             for(int n=1;n<=rowName.length;n++){
//                 a[n-1] = rowName[n]; 
//             }
//             _rowName_ =ArrayUtils.addAll(_rowName,a) ;
//          }
//          
//          return _rowName_;
      }
        
    }
    
    
    
    
    
    //如果有联动表的则对rowName进行改动
//    public String[] ChangeRowName(String[] rowName){
//        int _i=0;//用于记录第几个是linkselect类型的
//        int levalNum = 0;//用于记录联动的层数
//        String[] _rowName = null;//用于存放新的额数组
//        for(int i=0;i<rowName.length ;i++){
//            String columType = rowName[i].split("_")[2];
//           if("linkselect".equals(columType)){
//               _i = i;
//               List<InfoSort> linkselect =  DrsUtils.findInfoArray();
//               TreeUtil tb = new TreeUtil();
//               String[][] linkArray = tb.buildListToTree(linkselect);
//               levalNum = linkArray[0].length;
//               _rowName = new String[levalNum];
//               //将值付给_rowName
//               for(int j=1;j<=levalNum;j++){
//                   String inputType = "";
//                   if(j==1){
//                       inputType = rowName[_i].split("_")[2];
//                   }else{
//                       inputType = "input"; //下面的子级当做input以便在导出模板中不出错
//                   }
//                   _rowName[j-1] = rowName[_i].split("_")[0]+j+"_"+rowName[_i].split("_")[1]+j+"_"+inputType+"_";
//               }
//           }
//        }
//        
//        if(levalNum == 0){
//            return rowName;
//        }else{
//            String[] _rowName_;
//            if(_i >0){
//                String[] a = new String[_i];
//                String[] b = new String[rowName.length-_i-1];
//                for(int n=0;n<rowName.length;n++){
//                    if(n>_i){
//                      b[n] = rowName[n];
//                    }else{
//                      a[n] = rowName[n]; 
//                    }
//                }
//                _rowName_ =ArrayUtils.addAll(ArrayUtils.addAll(a,_rowName),b) ;
//            }else{
//               String[] a = new String[rowName.length-1];
//               for(int n=1;n<=rowName.length;n++){
//                   a[n-1] = rowName[n]; 
//               }
//               _rowName_ =ArrayUtils.addAll(_rowName,a) ;
//            }
//            
//            return _rowName_;
//        }
//   }
    
    public void export () throws Exception{
        
        Workbook createExcel = this.createExcel();
        this.writeInOutputStream(createExcel);
    }
              
    /* 
     * 导出数据 
     * */  
    public Workbook createExcel() throws Exception{  
        try{  
            workbook = new XSSFWorkbook();                    // 创建工作簿对象  
            XSSFSheet sheet = workbook.createSheet(title);                  // 创建工作表  
              
            //sheet样式定义【getColumnTopStyle()/getStyle()均为自定义方法 - 在下面  - 可扩展】  
            this.columnTopStyle = this.getColumnTopStyle(workbook);//获取列头样式对象  
            this.style = this.getStyle(workbook);                  //单元格样式对象  
            
            // 定义所需列数  
            int columnNum = rowName.length;  
           
            this.exportHead(sheet,columnNum); //导出头部信息
            
            this.exportValue(sheet,columnNum);//导出模板或者数据
            
            //让列宽随着导出的列长自动适应  
            for (int colNum = 0; colNum < columnNum; colNum++) {
                int columnWidth = sheet.getColumnWidth(colNum) / 256;  
                for (int rowNum = 0; rowNum < sheet.getLastRowNum(); rowNum++) {  
                    Row currentRow;  
                    //当前行未被使用过  
                    if (sheet.getRow(rowNum) == null) {  
                        currentRow = sheet.createRow(rowNum);  
                    } else {  
                        currentRow = sheet.getRow(rowNum);  
                    }  
                    if (currentRow.getCell(colNum) != null) {  
                        Cell currentCell = currentRow.getCell(colNum);  
                        if (currentCell.getCellType() == Cell.CELL_TYPE_STRING) {
                            //int length = currentCell.getStringCellValue().getBytes().length;
                            String stringCellValue = null;
                            try {
                                stringCellValue = currentCell.getStringCellValue();
                            } catch (Exception e) {
                                continue;
                            }
                            int length = stringCellValue==null?50:stringCellValue.getBytes().length;  
                            
                            if (columnWidth < length) {  
                                columnWidth = length;  
                            }  
                        }  
                    }  
                }  
                if(colNum == 0){  
                    sheet.setColumnWidth(colNum, (columnWidth-2) * 256);  
                }else{  
                    sheet.setColumnWidth(colNum, (columnWidth+4) * 256);  
                }  
            }  
  
        }catch(Exception e){  
            e.printStackTrace();  
        }
        return workbook;  
          
    }
    
    
   protected void exportHead(XSSFSheet sheet,int columnNum) {
       
       for(int m=0;m<valueStartRow;m++){
           Row rowRowName = sheet.createRow(m); //标题包含三行，第一行是中文，第二行是英文，第三行是类型（二三行隐藏）
     
           // 将列头设置到sheet的单元格中  
           for(int n=0;n<columnNum;n++){
               Cell  cellRowName = rowRowName.createCell(n);               //创建列头对应个数的单元格  
               cellRowName.setCellType(Cell.CELL_TYPE_STRING);             //设置列头单元格的数据类型  
               RichTextString text = new XSSFRichTextString(rowName[n].split("_")[m]);
//             RichTextString text = new HSSFRichTextString(rowName[n]);  
               cellRowName.setCellValue(text);                                 //设置列头单元格的值  
               cellRowName.setCellStyle(columnTopStyle);                       //设置列头单元格样式  
           }
           if(m==1 || m==2){
               Row hiddenRow =  sheet.getRow(m); 
               hiddenRow.setZeroHeight(true);                             //将第二、三行隐藏
           }
       }
       
   }
    //导出数据的抽象方法 
    abstract  void exportValue(XSSFSheet sheet,int columnNum);
    
    private void elementList(CellStyle columnTopStyle, CellStyle style){
        XSSFSheet elementEheet = workbook.createSheet("信息项附页");                  // 创建工作表  
        Row rowRowName = elementEheet.createRow(0);
        String elementTitle [] = {"信息项ID","信息项名称","备注"};
        String elementEn [] = {"id","nameCn","label"};
        //设置标题
        for(int n=0;n<elementTitle.length;n++){
            Cell  cellRowName = rowRowName.createCell(n);               //创建列头对应个数的单元格  
            cellRowName.setCellType(Cell.CELL_TYPE_STRING);             //设置列头单元格的数据类型  
            cellRowName.setCellValue(elementTitle[n]);                                 //设置列头单元格的值  
            cellRowName.setCellStyle(columnTopStyle);                       //设置列头单元格样式  
        }
        List<Map<String, Object>> elementList = DrsUtils.getElementList();
        //将查询出的数据设置到sheet对应的单元格中  
        
        //设置值
        for(int i=0;i<elementList.size();i++){
            
            Row row = elementEheet.createRow(i+1);//创建所需的行数  
            
            for(int j=0; j<elementEn.length; j++){    //j代表列
                Cell  cell = null;   //设置单元格的数据类型  
                cell = row.createCell(j,Cell.CELL_TYPE_STRING);  
                String element = elementList.get(i).get(elementEn[j]).toString();
                cell.setCellValue(element);               //设置单元格的值  
                cell.setCellStyle(style);                //设置单元格样式  
            }  
        } 
        
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
    
//    增加填写说明
    public void creatRule(){
        XSSFSheet explainSheet = workbook.createSheet("填写说明");
        String explain = "信息项导入说明：根据需求从\"信息项附页\"中查询自己所需信息项，然后取其对应ID,若有多个则以\",\"区分（英文逗号）,如：1,2,3"+lineSeparator+
                         "多选框导入说明：如果示例中填写的是\"多选框\",则取其下拉选项中\"_\"后面数字,若有多个则以\",\"区分（英文逗号）,如：1,2,3"+lineSeparator+
                         "时间格式：2017-10-1"+lineSeparator+
                         "建设依据：填写信息系统建设依据，包括具体发布政策文件名字及相关建设方案、批复文件等"+lineSeparator+
                         "业务事项：系统所服务具体业务，比如办公自动化、行政审批等"+lineSeparator+
                         "系统用户规模：即系统注册及最终使用用户数据"+lineSeparator+
                         "数据规模：填写信息系统数据规模（单位为G，填写数字）"+lineSeparator+
                         "数据增长情况：按每月业务发生估算数据增长量单位M"+lineSeparator+
                         "建设经费来源：上级配套资金（具体经费来源渠道）；省财政资金（具体经费来源渠道）；市财政资金（具体经费来源渠道）；单位自筹资金（具体经费来源渠道）；其他资金（具体经费来源渠道）"+lineSeparator+
                         "投资金额：万元，填写数字";
        Row explainRow = explainSheet.createRow(1);
        Cell  cellRowName = explainRow.createCell(1);               //创建列头对应个数的单元格  
        cellRowName.setCellValue(explain);    
        explainSheet.addMergedRegion(new CellRangeAddress(1,20,1,20));
        
    }
    
    //根据自定义表格样式返回下拉选框内容(放入附页中)
    protected String[] getTemplateValue(String inputType,int m){
        String[] templateValue ={};
        List<String> valueList = Lists.newArrayList();
        String inputValue = "";
        switch(inputType)
        {
        case "select":
            inputValue =  StringUtil.toUnderScoreCase(rowName[m].split("_")[3]); //传过来的是大写的驼峰为了避免联动字段出错
            List<String> selectList = getList(inputValue);
            for(String select :selectList){
                valueList.add(select);
            }
            templateValue = (String[])valueList.toArray(new String[selectList.size()]);
            break;
        case "dictselect":
            inputValue = StringUtil.toUnderScoreCase(rowName[m].split("_")[3]);
            List<Dict>  dictList = SysUtils.getDictList(inputValue);
            for(Dict dict:dictList){
                valueList.add(dict.getLabel()+"_"+dict.getValue());
            }
            templateValue = (String[])valueList.toArray(new String[dictList.size()]);
            break;
        case "companyselect":
            List<Company>  companyList = SysUtils.getCompanyList();
            for(Company company:companyList){
                valueList.add(company.getName()+"_"+company.getId());
            }
            templateValue = (String[])valueList.toArray(new String[companyList.size()]);
            break;
        case "radio":
            inputValue = StringUtil.toUnderScoreCase(rowName[m].split("_")[3]);
            List<Dict>  radioList = SysUtils.getDictList(inputValue);
            for(Dict dict:radioList){
                valueList.add(dict.getLabel()+"_"+dict.getValue());
            }
            templateValue = (String[])valueList.toArray(new String[radioList.size()]);
            break;
        case "check":
            inputValue = StringUtil.toUnderScoreCase(rowName[m].split("_")[3]);
            List<Dict>  checkList = SysUtils.getDictList(inputValue);
            for(Dict dict:checkList){
                valueList.add(dict.getLabel()+"_"+dict.getValue());
            }
            templateValue = (String[])valueList.toArray(new String[checkList.size()]);
            break;
        case "checkbox":
            inputValue = StringUtil.toUnderScoreCase(rowName[m].split("_")[3]);
            List<Dict>  checkbox = SysUtils.getDictList(inputValue);
            for(Dict dict:checkbox){
                valueList.add(dict.getLabel()+"_"+dict.getValue());
            }
            templateValue = (String[])valueList.toArray(new String[checkbox.size()]);
            break;    
            
        case "linkselect":
            List<InfoSort> infoSorts =  DrsUtils.findInfoArray();
           /* List<InfoSort> infoSorts= this.infosortservice.findAll();*/
//            List<InfoSort>  infoSorts = SysUtils.getInfoSortList();
            for (InfoSort info : infoSorts) {
                valueList.add(info.getName()+"_"+info.getId());
            }
            templateValue = (String[])valueList.toArray(new String[infoSorts.size()]);
             break; 
        default:
            break;
        }
        
        return templateValue;
    }
    
    private List<String> getList(String type) {
        List<String> list = Lists.newArrayList();
        if (!StringUtil.isEmpty(type)) {
            switch (type.trim().toLowerCase()) {
            case "company":
                List<Company>  companyList = SysUtils.getCompanyList();
                for(Company company:companyList){
                    list.add(company.getName()+"_"+company.getId());
                }
                break;
            case "site":
                List<Site> siteList = SysUtils.getSiteList();
                for(Site site:siteList){
                    list.add(site.getName()+"_"+site.getId());
                }
                break;
            case "role":
                List<Role>  roleList = SysUtils.getRoleList();
                for(Role role:roleList){
                    list.add(role.getName()+"_"+role.getId());
                }
                break;
            case "menu":
                List<Menu>  menuList = SysUtils.getMenuList();
                for(Menu menu:menuList){
                    list.add(menu.getName()+"_"+menu.getId());
                }
                break;
            case "sys":
                List<Systems>  sysList = SysUtils.getSysList();
                for(Systems systems:sysList){
                    list.add(systems.getNameCn()+"_"+systems.getId());
                }
                break;
            default:
                break;
            }
        }
        return list;
    }
    

}  
