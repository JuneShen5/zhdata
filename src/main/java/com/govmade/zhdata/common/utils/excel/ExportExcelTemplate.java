package com.govmade.zhdata.common.utils.excel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFDataValidationConstraint;
import org.apache.poi.xssf.usermodel.XSSFDataValidationHelper;
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
public class ExportExcelTemplate extends ExportExcelImpl {
    
    protected Map<String, List<String>> dictMap = null;
    
    public ExportExcelTemplate(String fileName, String title, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(fileName, title, rowName, dataList, response);
    }
    
    public ExportExcelTemplate(String fileName, String title, String templatFile, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(fileName, title, templatFile, rowName, dataList, response);
    }  
    
    public ExportExcelTemplate(String fileName, String title, String templatFile, String[] rowName,
            List<Map<String, Object>> dataList) throws Exception {
        super(fileName, title, templatFile, rowName, dataList);
    }
    
    @Override
    protected void exportValue(XSSFSheet sheet) {
      int lastRowNum = sheet.getLastRowNum();
      Row inputTypeRow = sheet.getRow(lastRowNum); //获取input_inputValue那一行
      Row selectBoxRow= sheet.createRow(lastRowNum+1);//用于存储下拉选框
      int lastCellNum =  inputTypeRow.getLastCellNum();   //模板中的总列数
      List<List<String>> attachedSheetList = new ArrayList<List<String>>();//存放所以需要放入附页中的信息
      int attachedMaxLen = 0; //用于存放附页中需要的行数
      for (int columnIndex = 0; columnIndex <lastCellNum; columnIndex++) {
          String  inputValue = "";
          String CellVal = inputTypeRow.getCell(columnIndex).getStringCellValue(); //获取inputType_inputTypeValue
          String[] CellValArr = CellVal.split("_");
          if(CellValArr.length>1){
              //有关联字段的数据
              String columType = CellValArr[0];
              String columTypeValue = CellValArr[1];
              List<String> templateValue = getTemplateValue(columType,columTypeValue); //下拉选框数据
              int templateValueSize = 0;
              try {
                  templateValueSize = templateValue.size();
                } catch (Exception e) {
                    throw new RuntimeException(columType+"_"+columTypeValue+"查询关联字段错误");
                }
              
              if(templateValueSize>0 && templateValueSize<10){
                  
                  String[] _templateValue = templateValue.toArray(new String[templateValue.size()]);//用于将下拉现况的list转为array
                  if("checkbox".equals(columType)||"check".equals(columType)){
                      inputValue="多选框";
                  }else{
                      inputValue = _templateValue[0]; //下拉选框第一个数据，用于参考用
                  }
                  //以下是存放下拉框
                  XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper(sheet);
                  XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper.createExplicitListConstraint(_templateValue); 
                  CellRangeAddressList  addressList = new CellRangeAddressList(lastRowNum+1, lastRowNum+1, columnIndex, columnIndex);  
                  XSSFDataValidation  validation = (XSSFDataValidation) dvHelper.createValidation(dvConstraint, addressList);
                  sheet.addValidationData(validation);
              }else if(templateValueSize>=10){//下拉框大于10个存于附页
                  if("checkbox".equals(columType)||"check".equals(columType)){
                      inputValue="多选框";
                  }else{
                      inputValue = "参考附页"; 
                  }
                  templateValue.add(0, sheet.getRow(lastRowNum-2).getCell(columnIndex).getStringCellValue());//将那一列的中文名放到第一个
                  if(templateValue.size()>attachedMaxLen){
                      attachedMaxLen = templateValue.size();
                  }
                  
                  attachedSheetList.add(templateValue);//存放所以需要放入附页中的信息
              }
          }else if("dateselect".equals(CellValArr[0])){
              inputValue = "2017-10-1";
          }
          selectBoxRow.createCell(columnIndex).setCellValue(inputValue);//下拉选框的提示内容
       }
      
      if(attachedSheetList.size()>0){
          attachedSheetFunc(attachedSheetList,attachedMaxLen);   //设置附页信息
      }
  }
    
  //添加附页信息
    private void attachedSheetFunc(List<List<String>> valueList,int maxMapLen){
        Sheet attachedSheet = workbook.getSheetAt(1);
        for(int i=0;i<maxMapLen;i++){
            attachedSheet.createRow(i);
        }
        for(int n=0;n<valueList.size();n++){
            for(int m=0;m<valueList.get(n).size();m++){
                attachedSheet.getRow(n).createCell(m).setCellValue(valueList.get(n).get(m));
            }
        }
    }
    
    /**
     *  根据输入框类型以及类型的值查询下拉选框数据
     * @param inputType 输入框类型
     * @param columTypeValue dict的type
     * @return Map<id,n>
     */
        protected List<String> getTemplateValue(String inputType,String columTypeValue){
            List<String> templateValue = null;
            String inputValue = "";
            switch(inputType)
            {
            case "select":
                inputValue =  StringUtil.toUnderScoreCase(columTypeValue); //传过来的是大写的驼峰为了避免联动字段出错
                templateValue = getSelect(inputValue);
                break;
            case "dictselect":
            case "radio":
            case "check":
            case "checkbox":
                if(this.dictMap == null){
                    getAllDictToList();
                }
                inputValue = StringUtil.toUnderScoreCase(columTypeValue);
                templateValue = dictMap.get(inputValue);
                break;
            case "companyselect":
                List<Company>  companyList = SysUtils.getCompanyList();
                for(Company company:companyList){
                    templateValue.add(company.getName());
                }
                break;
                
            case "linkselect":
                List<InfoSort> infoSorts =  DrsUtils.findInfoArray();
                for (InfoSort info : infoSorts) {
                    templateValue.add(info.getName());
                }
                 break; 
            default:
                break;
            }
            
            return templateValue;
        }
        
        /**
         * select类型的关联数据
         * @param type dict的type类型
         * @return
         */
        private List<String> getSelect(String type) {
            List<String> templateValue = null;
            if (!StringUtil.isEmpty(type)) {
                switch (type.trim().toLowerCase()) {
                case "company":
                    List<Company>  companyList = SysUtils.getCompanyList();
                    for(Company company:companyList){
                        templateValue.add(company.getName());
                    }
                    break;
                case "site":
                    List<Site> siteList = SysUtils.getSiteList();
                    for(Site site:siteList){
                        templateValue.add(site.getName());
                    }
                    break;
                case "role":
                    List<Role>  roleList = SysUtils.getRoleList();
                    for(Role role:roleList){
                        templateValue.add(role.getName());
                    }
                    break;
                case "menu":
                    List<Menu>  menuList = SysUtils.getMenuList();
                    for(Menu menu:menuList){
                        templateValue.add(menu.getName());
                    }
                    break;
                case "sys":
                    List<Systems>  sysList = SysUtils.getSysList();
                    for(Systems systems:sysList){
                        templateValue.add(systems.getNameCn());
                    }
                    break;
                default:
                    break;
                }
            }
            return templateValue;
        }
        
        /**
         * 查询所有的dict数据并保存
         * 返回 Map<type, Map<value,label>>
         */
        protected void getAllDictToList(){
            Map<String, List<String>> resultMap = new HashMap<String, List<String>>(); 
            List<Dict> dictList = SysUtils.getDictList();
            try{
                for(Dict dict : dictList){
                    if(resultMap.containsKey(dict.getType())){//map中异常批次已存在，将该数据存放到同一个key（key存放的是异常批次）的map中 
                        resultMap.get(dict.getType()).add(dict.getLabel()); 
                    }else{//map中不存在，新建key，用来存放数据 
                        List<String> valLabMap = new ArrayList<String>();
                        valLabMap.add(dict.getLabel());
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
