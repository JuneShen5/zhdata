package com.govmade.zhdata.common.utils.excel;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.collect.Maps;

/**
 * SpringMVC 实体数据导入
 * @author  cyz
 * @param <T>
 */
public class ImportExcelData extends ImportExcelImpl {
    
    
    public ImportExcelData(MultipartFile multipartFile, int headerNum, int sheetIndex) throws InvalidFormatException,
    IOException {
        super(multipartFile,headerNum,sheetIndex);
    }
    /**
     * 判断接收的Map集合中的标题是否于Excle中标题对应
     * @param titleAndAttribute
     * @return List<Map<String, String>>
     * @throws Exception
     */
    @Override
    protected List<Map<String, String>> readExcelTitle(Map<String, String> titleAndAttribute) throws Exception{
        
        // 获取标题及类型
        Map<Integer, String> titleEn = getAttribute(1,titleAndAttribute);
        Map<Integer, String> inputType = getAttribute(2,titleAndAttribute);
     System.out.println("titleEn");
        for(Map.Entry<Integer, String> k:titleEn.entrySet()){
           System.out.println(k.getKey()+":"+k.getValue());
       }
        System.out.println("inputType");
       for(Map.Entry<Integer, String> k:inputType.entrySet()){
           System.out.println(k.getKey()+":"+k.getValue());
       }
        
        
        
        return readExcelValue(titleEn, inputType);
        
    }
    
    
    //获取第二、三行参数
    private  Map<Integer, String> getAttribute(int k,Map<String, String> titleAndAttribute){
        Row titelRow = sheet.getRow(k);
        /*
         * 判断EXCEL是否有数据
         */
        if (k==sheet.getLastRowNum()) {
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
        return attribute;
    }
    
    /**
     * 获取Excle中的值
     * @param attribute
     * @return List<Map<String, String>>
     * @throws Exception
     */
    protected List<Map<String, String>> readExcelValue(Map<Integer, String> titleEn,Map<Integer, String> inputType ) throws Exception {
        List<Map<String, String>> info=new ArrayList<Map<String, String>>();
        //获取标题行列数
//        int titleCellNum = sheet.getRow(1).getLastCellNum();
        int titleCellNum = titleEn.size();
        // 获取值
        for (int rowIndex = startRow; rowIndex < sheet.getPhysicalNumberOfRows(); rowIndex++) { //getPhysicalNumberOfRows()  getLastRowNum
            Row row = sheet.getRow(rowIndex);
            //log.debug("第--" + rowIndex);
            /*
             * 获取每一行数据
             */
            Map<String, String> map= Maps.newHashMap();
            
            for (int columnIndex = 0; columnIndex < titleCellNum; columnIndex++) {//等于1不取第一列数据
                Cell cell = row.getCell(columnIndex);
                String value =null;
                //处理单元格中值得类型
                String inputTypeValue = inputType.get(Integer.valueOf(columnIndex));
                if("".equals(inputTypeValue.trim()) ){
                    continue;
                }
                if(inputTypeValue.trim().equals("select")||inputTypeValue.trim().equals("dictselect")||inputTypeValue.trim().equals("companyselect")||
                  inputTypeValue.trim().equals("radio")||inputTypeValue.trim().equals("linkselect")){
                    
                    int _rowIndex; //用于记录错误的行和列
                    int _columnIndex ;
                    if (null!=getCellValue(cell)&&!"".equals(getCellValue(cell).trim())) {
                        if(StringUtils.isNumeric(getCellValue(cell))){
                            value = getCellValue(cell);
                        }else{
                            _rowIndex = rowIndex+1; 
                            _columnIndex = columnIndex+1;
                            throw new Exception("数据'"+getCellValue(cell)+"'格式有误,位置："+_rowIndex+"行"+_columnIndex+"列");
                        }
                    }else{
                        _rowIndex = rowIndex+1; 
                        _columnIndex = columnIndex+1;
                        throw new Exception("数据不能为空,位置："+_rowIndex+"行"+_columnIndex+"列");
                    }
                }else if(inputTypeValue.trim().equals("element")){
                    String elementValue = getCellValue(cell);
                    if (null!=elementValue&&!"".equals(elementValue.trim())) {
                        String regEx="[\\s~·`!！@#￥$%^……&*（()）\\-——\\-_=+【\\[\\]】｛{}｝\\|、\\\\；;：:‘'“”\"，,《<。.》>、/？?]";  
                        Pattern p = Pattern.compile(regEx);  
                        Matcher m = p.matcher(elementValue);  
                        String[] elementArray = m.replaceAll(",").split(",");
                        String element = "";
                        for(int i=0;i<elementArray.length;i++){
                            element +="{'id':"+elementArray[i]+"},";
                        }
                        value ="["+element.substring(0,element.length() - 1)+"]";
                    }
                }else{
                    value = getCellValue(cell);
                }
                
                
                System.out.println("value:"+value);
                String key=titleEn.get(Integer.valueOf(columnIndex));
                map.put(key, value);
            }
            
            info.add(map);
            
            if(info.size()%(this.commitRow) == 0){  
                return info; 
            }
            
        }
        return info;
    }

}
