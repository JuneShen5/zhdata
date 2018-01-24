package com.govmade.zhdata.common.utils.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Maps;
import com.govmade.zhdata.common.utils.DrsUtils;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.SysUtils;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.pojo.YjSystems;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.pojo.Dict;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.pojo.Role;
import com.govmade.zhdata.module.sys.pojo.Site;


/**
 * SpringMVC 读取Excle工具类
 * @author  cyz
 * @param <T>
 */
public class ImportExcelImpl{
    
    //log4j输出
    private Logger log = LoggerFactory.getLogger(ImportExcelImpl.class);
    // 时间的格式
    private String format="yyyy-MM";
    
    /**
     * 工作薄对象
     */
    private Workbook wb;
    
    /**
     * 工作表对象
     */
    protected Sheet sheet;

    /**
     * 错误数据的模板文件
     */
    private String errorDataExcel;       
    
    /**
     * 错误数据的模板文件
     */
    private Integer headerNum;
    /**
     * 文件名
     */
    private String fileName;
    
    /**
     * 控制每次从第几行数据开始读
     */
    protected int startRow = 3;
    
    /**
     * 控制每次从第几列数据开始读
     */
    protected int columnIndex = 1;
    
    protected HttpServletRequest request;
    
    /**
     * 控制读取多少条后返回
     */
    protected int commitRow = 500;
    
    private String regEx="[\\s~·`!！@#￥$%^……&*（()）\\-——\\-_=+【\\[\\]】｛{}｝\\|、\\\\；;：:‘'“”\"，,《<。.》>、/？?]";  
    
    String doubleReg = "^[0-9]+(.[0-9]+)?$"; 
    
    
    protected Map<String, Map<String,String>> dictMap = new HashMap<String, Map<String,String>>(); //存放数据字典
    protected Map<String,Integer> companyMap = new HashMap<String, Integer>();
    protected Map<String,Integer> siteMap =  new HashMap<String, Integer>();
    protected Map<String,Integer> roleMap =  new HashMap<String, Integer>();
    protected Map<String,Integer> menuMap =  new HashMap<String, Integer>();
    protected Map<String,Integer> sysMap =  new HashMap<String, Integer>();
    protected Map<String,Integer> elementMap =  new HashMap<String, Integer>();
    protected Map<String,Integer> infoSortMap =  new HashMap<String, Integer>();
    protected Map<String,Integer> infoMap =  new HashMap<String, Integer>();
    
    protected Map<Integer, String> nameEnMap= Maps.newHashMap(); //存放字段英文名
    protected Map<Integer, String> inputTypeMap= Maps.newHashMap(); //存放inputType
    protected Map<Integer, String> inputTypeValueMap= Maps.newHashMap();//存放inputTypeValue
    
    protected String[] unSelect = {"input","dateselect","textarea"}; //不用做关联的inputtype
//    protected String[] Select = {"checkbox","element","select"}; //一对一关联的或一对多关联的
    
    protected List<Map<String,Integer>> someErrorDataCoordinate= new ArrayList<Map<String,Integer>>();//错误数据的坐标
   
    protected List<Map<String,Integer>> AllErrorDataCoordinate= new ArrayList<Map<String,Integer>>();//错误数据的坐标
    
    public List<Map<String, Integer>> getAllErrorDataCoordinate() {
        return AllErrorDataCoordinate;
    }

    public void setAllErrorDataCoordinate() {
        if(someErrorDataCoordinate.size()>0){
            AllErrorDataCoordinate.addAll(someErrorDataCoordinate);
        }
    }


    public List<Map<String, Integer>> getSomeErrorDataCoordinate() {
        return someErrorDataCoordinate;
    }

    /**
     * 无参构造
     */
    public ImportExcelImpl() {
        super();
    }
    

    /**
     * 构造函数
     * 
     * @param file 导入文件对象
     * @param headerNum 标题行号，数据行号=标题行号+1
     * @param sheetIndex 工作表编号
     * @throws InvalidFormatException
     * @throws IOException
     */
    public ImportExcelImpl(HttpServletRequest request,MultipartFile multipartFile, int headerNum, int sheetIndex)
            throws InvalidFormatException, IOException {
        this(request,multipartFile.getOriginalFilename(), multipartFile.getInputStream(), headerNum, sheetIndex);
    }

    /**
     * 构造函数
     * 
     * @param path 导入文件对象
     * @param headerNum 标题行号，数据行号=标题行号+1
     * @param sheetIndex 工作表编号
     * @throws InvalidFormatException
     * @throws IOException
     */
    public ImportExcelImpl(HttpServletRequest request,String fileName, InputStream is, int headerNum, int sheetIndex)
            throws InvalidFormatException, IOException {
        if (StringUtils.isBlank(fileName)) {
            throw new RuntimeException("导入文档为空!");
        } else if (fileName.toLowerCase().endsWith("xls")) {
            this.wb = new HSSFWorkbook(is);
        } else if (fileName.toLowerCase().endsWith("xlsx")) {
            this.wb = new XSSFWorkbook(is);
        } else {
            throw new RuntimeException("文档格式不正确!");
        }
        if (this.wb.getNumberOfSheets() < sheetIndex) {
            throw new RuntimeException("文档中没有工作表!");
        }
        this.sheet = this.wb.getSheetAt(sheetIndex);
        this.headerNum = headerNum;
        this.fileName = fileName;
        this.request = request;
        log.debug("Initialize success.");
    }
    
   
    
	 /**
	  * 上传Excle文件、并读取其中数据、返回list数据集合
	  * @param titleAndAttribute
	  * @return List<Map<String, String>>
	  * @throws Exception
	  */
//    public List<Map<String, String>> uploadAndRead(Map<String, String> titleAndAttribute) throws Exception{
//        return readExcel(titleAndAttribute);
//    }
//    abstract  protected List<Map<String, String>> uploadAndRead(Map<String, String> titleAndAttribute) throws Exception;
        
    /**
     * 上传Excle文件、并读取其中数据、返回list数据集合
     * @param titleAndAttribute
     * @param startRow 开始读取的行数
     * @param commitRow 回滚的行
     * @return List<Map<String, String>>
     * @throws Exception*********
     */
    public void setParams(int startRow,int columnIndex, int commitRow, String errorDataExcel) throws Exception{
       this.columnIndex = columnIndex;
       this.commitRow = commitRow;
       this.errorDataExcel = errorDataExcel;
       Row nameEnRow = sheet.getRow(startRow-2);  //英文名称行
       Row inputTypeRow = sheet.getRow(startRow-1); //输入框及类型行
       int lastCellNum = nameEnRow.getLastCellNum(); //总共的列数
       for(int i=0;i<lastCellNum;i++){
            nameEnMap.put(i,nameEnRow.getCell(i).getStringCellValue());
            String[] inputType = inputTypeRow.getCell(i).getStringCellValue().split("_");
            inputTypeMap.put(i, inputType[0]);
            if(inputType.length>1){
                inputTypeValueMap.put(i, inputType[1]);
            }else{
                inputTypeValueMap.put(i, "");
            }
        }
    }

    /**
     * 判断接收的Map集合中的标题是否于Excle中标题对应
     * @param titleAndAttribute
     * @return List<Map<String, String>>
     * @throws Exception
     */
    public List<Map<String, String>> readExcel(Map<String, String> titleAndAttribute,int startRow) throws Exception{
        List<Map<String, String>> resolut = new ArrayList<Map<String, String>>();//存放最终结果
        int lastCellNum = nameEnMap.size(); //总共的列数
        someErrorDataCoordinate.clear();
        for (int rowIndex = startRow;  sheet.getRow(rowIndex)!=null; rowIndex++) {
            Row Datarow = sheet.getRow(rowIndex);
            Map<String, String> rowMap= Maps.newHashMap(); //每一行的数据
            for (int columnIndex = this.columnIndex ; columnIndex < lastCellNum; columnIndex++) {//等于1不取第一列数据,第一行是id
              
                String value =""; //excel每一格读取的值
                Cell cell = Datarow.getCell(columnIndex);
                if("".equals(inputTypeMap.get(columnIndex).trim()) ){
                    continue;  //类型行没有数据直接跳过
                }else if(Arrays.asList(unSelect).contains(inputTypeMap.get(columnIndex))){ //.trim().split("_")[0]
                    value = getCellValue(cell);   //没有关联的数据直接获取
                }else if("double".equals(inputTypeMap.get(columnIndex).trim()) ){ //浮点型数据
                    value = getCellValue(cell);
                    if(value.length()==0 || value=="" || value==null ){
                        value="0.00"; //数据为空的时候
                    }else if(!value.matches(doubleReg)){ //数据格式出错
                        Map<String,Integer> oneErrorDataCoordinate = new HashMap<String, Integer>();
                        oneErrorDataCoordinate.put("rowIndex", rowIndex);
                        oneErrorDataCoordinate.put("columnIndex", columnIndex);
                        someErrorDataCoordinate.add(oneErrorDataCoordinate);
                        rowMap.clear();
                        break;
                    }
                }else{
                    //有关联的数据，获取关联的ID
                    int _rowIndex; //用于记录错误的行和列
                    int _columnIndex ;
                    if (null!=getCellValue(cell)&&!"".equals(getCellValue(cell).trim())) {
                        String name = getCellValue(cell);
                       /* Map<label,value>*/
                        String ID = getTemplateValue(inputTypeMap.get(columnIndex),inputTypeValueMap.get(columnIndex),name); //下拉选框数据
                        if(ID==null || ID=="" || ID=="null"){
//                            _rowIndex = rowIndex+1; 
//                            _columnIndex = columnIndex+1;
//                            throw new RuntimeException("数据'"+getCellValue(cell)+"'未查询到关联数据,位置："+_rowIndex+"行"+_columnIndex+"列");
                            Map<String,Integer> oneErrorDataCoordinate = new HashMap<String, Integer>();
                            oneErrorDataCoordinate.put("rowIndex", rowIndex);
                            oneErrorDataCoordinate.put("columnIndex", columnIndex);
                            someErrorDataCoordinate.add(oneErrorDataCoordinate);
                            rowMap.clear();
                            break;
                        }else{
                            value = ID;
                        }
                    }else{
//                        _rowIndex = rowIndex+1; 
//                        _columnIndex = columnIndex+1;
//                        throw new RuntimeException("数据不能为空,位置："+_rowIndex+"行"+_columnIndex+"列");
                        value = "-100";
                    }
                }
                rowMap.put(nameEnMap.get(columnIndex), value);
            }
            if(rowMap.size()>0){
                resolut.add(rowMap);
            }
            if(resolut.size()%(this.commitRow) == 0 && resolut.size()>0){  
                return resolut; 
            }
        }
        return resolut;
    }
   
   /**
    * 获取单元格值
    * @param cell
    * @return
    */
    public String getCellValue(Cell cell) {
    	String val = "";
            if (cell != null) {
                if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC ) {
                    if (DateUtil.isCellDateFormatted(cell)) { 
                        Date date  =cell.getDateCellValue();
                        val =new SimpleDateFormat(this.format).format(date); 
                      }else {
//                          cell.setCellType(Cell.CELL_TYPE_STRING);
//                          val = cell.getStringCellValue();
                          DecimalFormat df = new DecimalFormat("0.####");
                          val = df.format(cell.getNumericCellValue()).toString();
                      }
                } else if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
                    val = cell.getStringCellValue();
                } else if (cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
                    val = cell.getCellFormula();
                } else if (cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
                    val = cell.getBooleanCellValue()+"";
                } else if (cell.getCellType() == Cell.CELL_TYPE_ERROR) {
                    val = cell.getErrorCellValue()+"";
                }
            }
//       System.out.println("CellType:"+cell.getCellType());
//       System.out.println("val:"+val);
//       System.out.println("----------");
        return val.trim();
    }
    /**
     *  根据关联的实体数据获取ID值（dict表中不一定全是数字）
     * @param inputType 输入框类型
     * @param columTypeValue dict的type
     * @param data 管理数据的ID值
     * @return
     */
        protected String getTemplateValue(String inputType,String columTypeValue,String name){
            String inputValue = "";
            String Id = "";
            Matcher m = null;
            String[] Array = null;
            String _Id = "";
            switch(inputType)
            {
            case "select":
                inputValue =  StringUtil.toUnderScoreCase(columTypeValue); //传过来的是大写的驼峰为了避免联动字段出错
                Id = getSelect(inputValue,name);
                break;
            case "dictselect":
            case "radio":
                if(this.dictMap.size() == 0){
                    getAllDictToList();
                }
                inputValue = StringUtil.toUnderScoreCase(columTypeValue);
                Id = dictMap.get(inputValue).get(name);
                
            case "check":
            case "checkbox":
                if(this.dictMap.size() == 0){
                    getAllDictToList();
                }
                inputValue = StringUtil.toUnderScoreCase(columTypeValue);
                Map<String,String> checkDic = dictMap.get(inputValue);
                m = Pattern.compile(regEx).matcher(name);  
                Array = m.replaceAll(",").split(",");
                for(int i=0;i<Array.length;i++){
                    String checkId = checkDic.get(Array[i]);
                    if(!(checkId == "" || checkId == null)){
                        _Id += checkId+",";
                    }
                }
                if(_Id.length()>0){
                    Id = _Id.substring(0,_Id.length() - 1);
                }
                break;
            case "companyselect":
                if(this.companyMap.size() == 0){
                    List<Company> companyList= SysUtils.getCompanyList();
                    for(Company company : companyList){
                        companyMap.put(company.getName(),company.getId());
                    }
                }
                Id = String.valueOf(companyMap.get(name));
                break;
            case "element":
                if(this.elementMap.size() == 0){
                    List<Element> elementList= SysUtils.getElementList();
                    for(Element element : elementList){
                        elementMap.put(element.getNameCn(),element.getId());
                    }
                }
                m = Pattern.compile(regEx).matcher(name);  
                Array = m.replaceAll(",").split(",");
                for(int i=0;i<Array.length;i++){
                    Integer elementId = elementMap.get(Array[i]);
                    if(!( elementId == null)){
                        _Id +="{\"id\":"+ elementId+"},";
                    }
                }
                if(_Id.length()>0){
                    Id = "["+_Id.substring(0,_Id.length() - 1)+"]";
                }else{
                    Id ="[{}]"; 
                }
                break;
            case "linkageSelect":
                if(this.infoSortMap.size() == 0){
                    List<InfoSort> infoSortList =  DrsUtils.findAllInfo();
                    for(InfoSort infoSort : infoSortList){
                        infoSortMap.put(infoSort.getName(),infoSort.getId());
                    }
                }
                Id = String.valueOf(infoSortMap.get(name));
                 break; 
            default:
                break;
            }
            return Id;
        }
        
        /**
         * select类型的关联数据
         * @param type dict的type类型
         * @return
         */
        private String getSelect(String type,String name) {
            String Id = "";
            if (!StringUtil.isEmpty(type)) {
                switch (type.trim().toLowerCase()) {
                case "company":
                    if(this.companyMap.size() == 0){
                        List<Company> companyList= SysUtils.getCompanyList();
                        for(Company company : companyList){
                            companyMap.put(company.getName(),company.getId());
                        }
                    }
                    Id = String.valueOf(companyMap.get(name));
                    break;
                case "site":
                    if(this.siteMap.size() == 0){
                        List<Site> siteList= SysUtils.getSiteList();
                        for(Site site : siteList){
                            siteMap.put(site.getName(),site.getId());
                        }
                    }
                    Id = String.valueOf(siteMap.get(name));
                    break;
                case "role":
                    if(this.roleMap.size() == 0){
                        List<Role> roleList= SysUtils.getRoleList();
                        for(Role role : roleList){
                            roleMap.put(role.getName(),role.getId());
                        }
                    }
                    Id = String.valueOf(roleMap.get(name));
                    break;
                case "menu":
                    if(this.menuMap.size() == 0){
                        List<Menu> menuList= SysUtils.getMenuList();
                        for(Menu menu : menuList){
                            menuMap.put(menu.getName(),menu.getId());
                        }
                    }
                    Id = String.valueOf(menuMap.get(name));
                    break;
                case "sys":
                    if(this.sysMap.size() == 0){
                        List<YjSystems> sysList= SysUtils.getSysList();
                        for(YjSystems systems : sysList){
                            sysMap.put(systems.getName(),systems.getId());
                        }
                    }
                    Id = String.valueOf(sysMap.get(name));
                    break;
                case "info":
                    if(this.infoMap.size() == 0){
                        List<Information> infoList = SysUtils.getInfoList();
                        for(Information info : infoList){
                            infoMap.put(info.getNameCn(),info.getId());
                        }
                    }
                    Id = String.valueOf(infoMap.get(name));
                    break;
                default:
                    break;
                }
            }
            return Id;
        }
    /**
     * 查询所有的dict数据并保存
     * 返回 Map<type, Map<label,value>>
     */
    protected void getAllDictToList(){
        Map<String, Map<String,String>> resultMap = new HashMap<String, Map<String,String>>(); 
        List<Dict> dictList = SysUtils.getDictList();
            for(Dict dict : dictList){
                if(resultMap.containsKey(dict.getType())){//map中异常批次已存在，将该数据存放到同一个key（key存放的是异常批次）的map中 
                    resultMap.get(dict.getType()).put(dict.getLabel(), dict.getValue()); 
                }else{//map中不存在，新建key，用来存放数据 
                    Map<String,String> valLabMap = new HashMap<String, String>();
                    valLabMap.put(dict.getLabel(), dict.getValue());
                    resultMap.put(dict.getType(), valLabMap); 
                } 

            } 

        this.dictMap = resultMap;
    }

    /**
     * 将错误数据保存起来用于下载
     * @throws IOException
     */
    public String creatErrorDataExcel() throws Exception {
        if(AllErrorDataCoordinate.size()>0){
            String templatePath = request.getSession().getServletContext().getRealPath("static/excel/excelTemplate");
            File  fi = new File(templatePath+"/"+errorDataExcel);
            InputStream in;
            try {
                in = new FileInputStream(fi);
            } catch (FileNotFoundException e) {
                throw new RuntimeException("模板文件不存在");
            }
            Workbook errorDataExcelWb =  new XSSFWorkbook(in);
            Sheet errorDataSheet = errorDataExcelWb.getSheetAt(0);
            int lastColum;
            if(errorDataSheet.getLastRowNum()>1){
              //模板中有东西的复制类型行(模板文件中缺类型这一行)
                int errorDataLastRowNum = errorDataSheet.getLastRowNum();
                System.out.println("errorDataLastRowNum:"+errorDataLastRowNum);
                Row errorDataNameEnRow = errorDataSheet.getRow(errorDataLastRowNum);
                lastColum = errorDataNameEnRow.getLastCellNum();
                Row errorDatainputRow = errorDataSheet.createRow(errorDataLastRowNum+1);
                Row importRow = sheet.getRow(errorDataLastRowNum+1);
                System.out.println("lastColum:"+lastColum);
                for(int i=0; i<lastColum; i++){
                	System.out.println("i:"+i);
                	System.out.println("value:"+importRow.getCell(i).getStringCellValue());
                    errorDatainputRow.createCell(i).setCellValue(importRow.getCell(i).getStringCellValue());
                }
                
            }else{
                //模板中没写东西的直接复制前三行
                lastColum = sheet.getRow(1).getLastCellNum();
                for(int i=0;i<3;i++){
                    errorDataSheet.createRow(i);
                    for(int j=0;j<lastColum;j++){
                        errorDataSheet.getRow(i).createCell(j).setCellValue(sheet.getRow(i).getCell(j).getStringCellValue());
                    }
                }
            }
            
            for(int j=0;j<2;j++){
                errorDataSheet.getRow(errorDataSheet.getLastRowNum()-j).setZeroHeight(true);//将行隐藏
            }
            
//            Sheet nameEnRow = errorDataExcel.getSheetAt(1).getRow(startRow-2);  //英文名称行
            //定义背景颜色
            XSSFCellStyle style = (XSSFCellStyle) errorDataExcelWb.createCellStyle();
            style.setFillForegroundColor(HSSFColor.RED.index);
            style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND); 
            
            for(int m=0;m<AllErrorDataCoordinate.size();m++){
                Row newRow = errorDataSheet.createRow(errorDataSheet.getLastRowNum()+1);//模板中创建的行
                Map<String ,Integer> Coordinate = AllErrorDataCoordinate.get(m); //获取行列的坐标
                Row errorRow = sheet.getRow(Coordinate.get("rowIndex"));   //获取导入文件中错误数据的哪一行
                //将导入文件中的错误数据保存到模板文件中
                for(int n=0;n<lastColum;n++){
                    try {
                        newRow.createCell(n).setCellValue(getCellValue(errorRow.getCell(n)));
//                        newRow.createCell(n).setCellValue(errorRow.getCell(n).getStringCellValue());
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
//                        e.printStackTrace();
                        continue; //在数据导出的时候有些cell没有创建过，这边以免错误就直接跳过这类cell
                    }
                }
                newRow.getCell(Coordinate.get("columnIndex")).setCellStyle(style);//将模板文件中的错误数据背景色标红
            }
            String outFileName = System.currentTimeMillis()+".xlsx";
            String errorDataExcelPath = request.getSession().getServletContext().getRealPath("static/excel/errorDataExcel");
            File errorDataExcelPathFile =new File(errorDataExcelPath); 
          //如果文件夹不存在则创建    
            if  (!errorDataExcelPathFile .exists()  && !errorDataExcelPathFile .isDirectory())      
            {       
                System.out.println("//不存在");  
                errorDataExcelPathFile .mkdir();    
            } else   
            {  
                System.out.println("//目录存在");  
            }  

            FileOutputStream fout = new FileOutputStream(errorDataExcelPath+"/"+outFileName);
            errorDataExcelWb.write(fout);
            fout.close();
            return request.getContextPath()+"/static/excel/errorDataExcel/"+outFileName;
        }else{
            return "";
        }
      
    }

}
