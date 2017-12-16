package com.govmade.zhdata.common.utils.excel;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;

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
public class ExportExcelData extends ExportExcelImpl {
    
    protected Map<String, Map<String,String>> dictMap = null;
    
    public ExportExcelData(String fileName, String title, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(fileName, title, rowName, dataList, response);
    }
    
    public ExportExcelData(String fileName, String title, String templatFile, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(fileName, title, templatFile, rowName, dataList, response);
    }  
    
    @Override
    protected void exportValue(XSSFSheet sheet) {
        int lastRowNum = sheet.getLastRowNum();
        
        Row titelRow = sheet.getRow(lastRowNum-1); //获取英文字段的行
        Row inputTypeRow = sheet.getRow(lastRowNum);
        int lastCellNum =  titelRow.getLastCellNum();   //模板中的总列数
        //将查询出的数据设置到sheet对应的单元格中
        for(int i=0;i<dataList.size();i++){
            Row newRow = sheet.createRow(lastRowNum+i+1);
            for(int j=0;j<lastCellNum;j++){
               String nameEn = titelRow.getCell(j).getStringCellValue(); //获取excel模板中英文那一列
               String data =  (String) dataList.get(i).get(nameEn); //根据英文那一列一次获取实体数据list中的值
               if(inputTypeRow.getCell(j).getStringCellValue().length()>0 && data != null  ){
                   //获取excel存放inputtype那一行的值
                   String[] inputTypeArr = inputTypeRow.getCell(j).getStringCellValue().split("_");
                   String columType = inputTypeArr[0];
                   if(Arrays.asList(unSelect).contains(columType)){
                       newRow.createCell(j).setCellValue(data);//没有关联表的数据
                   }else{
                       //有关联表的数据
                       String columTypeValue = inputTypeArr[1]; 
//                       Map<String,String> templateValue = getTemplateValue(columType,columTypeValue); //对应下拉选框数据
//                       newRow.createCell(j).setCellValue(templateValue.get(data));//
                       String value = getTemplateValue(columType,columTypeValue,data);
                       newRow.createCell(j).setCellValue(value);
                   }
               }
               
            }
        }
    }
    
    
    /**
     *  根据关联的ID值获取实体数据
     * @param inputType 输入框类型
     * @param columTypeValue dict的type
     * @param data 管理数据的ID值
     * @return
     */
        protected String getTemplateValue(String inputType,String columTypeValue,String data){
            String inputValue = "";
            String name = "";
            switch(inputType)
            {
            case "select":
                inputValue =  StringUtil.toUnderScoreCase(columTypeValue); //传过来的是大写的驼峰为了避免联动字段出错
                name = getSelect(inputValue,data);
                break;
            case "dictselect":
            case "radio":
            case "check":
            case "checkbox":
                if(this.dictMap == null){
                    getAllDictToList();
                }
                inputValue = StringUtil.toUnderScoreCase(columTypeValue);
                name = dictMap.get(inputValue).get(data);
                break;
            case "companyselect":
                name = SysUtils.getCompanyName(Integer.valueOf(data));
                break;
            case "linkselect":
//                List<InfoSort> infoSorts =  DrsUtils.findInfoArray();
//                for (InfoSort info : infoSorts) {
//                    templateValue.put(String.valueOf(info.getId()), info.getName());
//                }
                 break; 
            default:
                break;
            }
            
            return name;
        }
        
        /**
         * select类型的关联数据
         * @param type dict的type类型
         * @return
         */
        private String getSelect(String type,String data) {
            Integer Id = Integer.valueOf(data);
            String name = "";
            if (!StringUtil.isEmpty(type)) {
                switch (type.trim().toLowerCase()) {
                case "company":
                    name = SysUtils.getCompanyName(Id);
                    break;
                case "site":
                    name = SysUtils.getSiteName(Id);
                    break;
                case "role":
                    name = SysUtils.getRoleName(Id);
                    break;
                case "menu":
                    name = SysUtils.getMenuName(Id);
                    break;
                case "sys":
                    name = SysUtils.getSysName(Id);
                    break;
                default:
                    break;
                }
            }
            return name;
        }
        
        /**
         * 查询所有的dict数据并保存
         * 返回 Map<type, Map<value,label>>
         */
        protected void getAllDictToList(){
            Map<String, Map<String,String>> resultMap = new HashMap<String, Map<String,String>>(); 
            List<Dict> dictList = SysUtils.getDictList();
            try{
                for(Dict dict : dictList){
                    if(resultMap.containsKey(dict.getType())){//map中异常批次已存在，将该数据存放到同一个key（key存放的是异常批次）的map中 
                        resultMap.get(dict.getType()).put(dict.getValue(), dict.getLabel()); 
                    }else{//map中不存在，新建key，用来存放数据 
                        Map<String,String> valLabMap = new HashMap<String, String>();
                        valLabMap.put(dict.getValue(), dict.getLabel());
                        resultMap.put(dict.getType(), valLabMap); 
                    } 

                } 

                }catch(Exception e){
                e.printStackTrace();
                } 
            this.dictMap = resultMap;
//            System.out.println("resultMap"+resultMap);
        }
}  
