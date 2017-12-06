package com.govmade.zhdata.common.utils.excel;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Maps;

/**
 * SpringMVC 常规的excel文件导入
 * @author  cyz
 * @param <T>
 */
public class ImportExcel {
    
    //log4j输出
    private Logger log = LoggerFactory.getLogger(ImportExcel.class);
    // 时间的格式
    private String format="yyyy-MM-dd";
    
    /**
     * 工作薄对象
     */
    private Workbook wb;
    
    /**
     * 工作表对象
     */
    private Sheet sheet;

    /**
     * 标题行号
     */
    private int headerNum;

    /**
     * 无参构造
     */
    public ImportExcel() {
        super();
    }
    
  
    /**
     * 构造函数
     * 
     * @param path 导入文件，读取第一个工作表
     * @param headerNum 标题行号，数据行号=标题行号+1
     * @throws InvalidFormatException
     * @throws IOException
     */
    public ImportExcel(String fileName, int headerNum) throws InvalidFormatException, IOException {
        this(new File(fileName), headerNum);
    }

    /**
     * 构造函数
     * 
     * @param path 导入文件对象，读取第一个工作表
     * @param headerNum 标题行号，数据行号=标题行号+1
     * @throws InvalidFormatException
     * @throws IOException
     */
    public ImportExcel(File file, int headerNum) throws InvalidFormatException, IOException {
        this(file, headerNum, 0);
    }

    /**
     * 构造函数
     * 
     * @param path 导入文件
     * @param headerNum 标题行号，数据行号=标题行号+1
     * @param sheetIndex 工作表编号
     * @throws InvalidFormatException
     * @throws IOException
     */
    public ImportExcel(String fileName, int headerNum, int sheetIndex) throws InvalidFormatException,
            IOException {
        this(new File(fileName), headerNum, sheetIndex);
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
    public ImportExcel(File file, int headerNum, int sheetIndex) throws InvalidFormatException, IOException {
        this(file.getName(), new FileInputStream(file), headerNum, sheetIndex);
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
    public ImportExcel(MultipartFile multipartFile, int headerNum, int sheetIndex)
            throws InvalidFormatException, IOException {
        this(multipartFile.getOriginalFilename(), multipartFile.getInputStream(), headerNum, sheetIndex);
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
    public ImportExcel(String fileName, InputStream is, int headerNum, int sheetIndex)
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
        log.debug("Initialize success.");
    }
    
   
    
	 /**
	  * 上传Excle文件、并读取其中数据、返回list数据集合
	  * @param titleAndAttribute
	  * @return List<Map<String, String>>
	  * @throws Exception
	  */
    public List<Map<String, String>> uploadAndRead(Map<String, String> titleAndAttribute) throws Exception{
        return readExcelTitle(titleAndAttribute);
    }
    

    /**
     * 判断接收的Map集合中的标题是否于Excle中标题对应
     * @param titleAndAttribute
     * @return List<Map<String, String>>
     * @throws Exception
     */
    private List<Map<String, String>> readExcelTitle(Map<String, String> titleAndAttribute) throws Exception{
        
        // 获取标题
        Row titelRow = sheet.getRow(headerNum);
        /*
         * 判断EXCEL是否有数据
         */
        if (headerNum==sheet.getLastRowNum()) {
			return null;
		}
        Map<Integer, String> attribute = new HashMap<Integer, String>();
        if (titleAndAttribute != null) {
            for (int columnIndex = 0; columnIndex < titelRow.getLastCellNum(); columnIndex++) {
                Cell cell = titelRow.getCell(columnIndex);
                if (cell != null) {
                    String key = cell.getStringCellValue();
                    String value = titleAndAttribute.get(key);
                    if (value == null) {
                        value = key;
                    }
                    attribute.put(Integer.valueOf(columnIndex), value);
                }
            }
        } else {
            for (int columnIndex = 0; columnIndex < titelRow.getLastCellNum(); columnIndex++) {
                Cell cell = titelRow.getCell(columnIndex);
                if (cell != null) {
                    String key = cell.getStringCellValue();
                    attribute.put(Integer.valueOf(columnIndex), key);
                }
            }
        }

        return readExcelValue(attribute);
        
    }
    
    /**
     * 获取Excle中的值
     * @param attribute
     * @return List<Map<String, String>>
     * @throws Exception
     */
    private List<Map<String, String>> readExcelValue(Map<Integer, String> attribute) throws Exception{
        List<Map<String, String>> info=new ArrayList<Map<String, String>>();
        //获取标题行列数
        int titleCellNum = sheet.getRow(0).getLastCellNum();
        // 获取值
        for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
            Row row = sheet.getRow(rowIndex);
            //log.debug("第--" + rowIndex);
            /*
             * 获取每一行数据
             */
            Map<String, String> map= Maps.newHashMap();
            for (int columnIndex = 1; columnIndex < titleCellNum; columnIndex++) {//等于1不取第一列数据
            	
                Cell cell = row.getCell(columnIndex);
                
                //处理单元格中值得类型
                String value = getCellValue(cell);
                
                String key=attribute.get(Integer.valueOf(columnIndex));
                map.put(key, value);
            }
            info.add(map);
            
        }
        return info;
    }
    
    
 
   /**
    * 获取单元格值
    * @param cell
    * @return
    */
    public String getCellValue(Cell cell) {
    	String val = "";
        try {
            if (cell != null) {
                if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
                    
                      if (DateUtil.isCellDateFormatted(cell)) { 
                    	  Date date  =cell.getDateCellValue();
                          val =new SimpleDateFormat(this.format).format(date); 
                        }else {
                        	val = cell.getNumericCellValue()+"";
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
        } catch (Exception e) {
            return val;
        }
        return val;
    }

}
