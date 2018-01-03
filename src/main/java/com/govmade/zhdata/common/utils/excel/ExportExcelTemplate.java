package com.govmade.zhdata.common.utils.excel;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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

import com.google.common.collect.Lists;
import com.govmade.zhdata.common.utils.DrsUtils;
import com.govmade.zhdata.common.utils.ListToTree;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.SysUtils;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.YjSystems;
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
    protected String[] unSelect = {"input","dateselect","textarea","element","linkageSelect"}; //不用做关联的inputtype
    
    public ExportExcelTemplate(String fileName, String title, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(fileName, title, rowName, dataList, response);
    }
    
    public ExportExcelTemplate(String fileName, String title, String templatFile, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(fileName, title, templatFile, rowName, dataList, response);
    }  
    
    public ExportExcelTemplate(String fileName, String title, String templatFile,
            String[] rowName, List<Map<String, Object>> infoList) throws IOException {
        super(fileName, title, templatFile, rowName, infoList);
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
          if(!Arrays.asList(unSelect).contains(CellValArr[0])){
              //有关联字段的数据
              String columType = CellValArr[0];
//              String columTypeValue = CellValArr[1];
              List<String> templateValue = getTemplateValue(CellValArr); //下拉选框数据
              int templateValueSize = 0;
              try {
                  templateValueSize = templateValue.size();
                } catch (Exception e) {
                    throw new RuntimeException(columType+"查询关联字段错误");
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
          }else if("linkageSelect".equals(CellValArr[0])){
              //有联动的
              List<Map<String, Object>> linkageTemplateValue = getLinkSelect(CellValArr[1]); //下拉选框数据
              while(true){
                  if(inputTypeRow.getCell(columnIndex+1).getStringCellValue().equals(CellVal)){
                      columnIndex++;
                  }else{
                      break;
                  }
              }  //这边用于跳过联动的子数据，以免多次生成模板
              
              Sheet attachedSheet = workbook.getSheetAt(2);
              workbook.setSheetName(2, "信息资源分类附页");
//              for(int i=0;i<500;i++){
//                  attachedSheet.createRow(i);
//              }
              attachedLinkSheetFunc(attachedSheet,linkageTemplateValue);
              
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
        workbook.setSheetName(1, "附页");
        for(int i=0;i<maxMapLen;i++){
            attachedSheet.createRow(i);
        }
        for(int n=0;n<valueList.size();n++){
            for(int m=0;m<valueList.get(n).size();m++){
                attachedSheet.getRow(m).createCell(n).setCellValue(valueList.get(n).get(m).toString());
            }
        }
    }
    
    //将联动信息添加到附表
    private Integer i =0; //行
    private Integer j =-1;// 列
//    private Integer _i = 1;
    @SuppressWarnings("unchecked")
    private void attachedLinkSheetFunc(Sheet attachedSheet,List<Map<String, Object>> valueList){
        j++;
//        int _i=1;
        for(Map<String, Object> infoSort:valueList){
//            System.out.println("name"+infoSort.getName());
            if(((List<Map<String, Object>>)infoSort.get("children")).size()>0){
                attachedLinkSheetFunc(attachedSheet,(List<Map<String, Object>>)infoSort.get("children"));
//                System.out.println("操作的列："+j);
//                System.out.println("从第几行开始："+i);
//                System.out.println("合并的行数"+(i-_i));
//                System.out.println("---------------");
//                _i = i;
            }else{
                i++;
                attachedSheet.createRow(i);
            }
            attachedSheet.getRow(i).createCell(j).setCellValue(infoSort.get("name").toString());
        }
        j--;
    }
    
    
    /**
     *  根据输入框类型以及类型的值查询下拉选框数据
     * @param inputType 输入框类型
     * @param columTypeValue dict的type
     * @return Map<id,n>
     */
        protected List<String> getTemplateValue(String[] inputTypeArr){
            List<String> templateValue =  Lists.newArrayList();
            String inputValue = "";
            String inputType = inputTypeArr[0];
            switch(inputType)
            {
            case "select":
                inputValue =  StringUtil.toUnderScoreCase(inputTypeArr[1]); //传过来的是大写的驼峰为了避免联动字段出错
                templateValue = getSelect(inputValue);
                break;
            case "dictselect":
            case "radio":
            case "check":
            case "checkbox":
                if(this.dictMap == null){
                    getAllDictToList();
                    System.out.println("dictMap:"+dictMap);
                }
                inputValue = StringUtil.toUnderScoreCase(inputTypeArr[1]);
                templateValue = dictMap.get(inputValue);
                System.out.println("inputValue:"+inputValue);
                System.out.println("templateValue:"+templateValue);
                break;
            case "companyselect":
                List<Company>  companyList = SysUtils.getCompanyList(); //单存的列表
                for(Company company:companyList){
                    templateValue.add(company.getName());
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
            List<String> templateValue = Lists.newArrayList();
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
                    List<YjSystems>  sysList = SysUtils.getSysList();
                    for(YjSystems systems:sysList){
                        templateValue.add(systems.getName());
                    }
                    break;
                default:
                    break;
                }
            }
            return templateValue;
        }
        
        /**
         * 联动类型的类型的关联数据（树形结构）
         * @param type dict的type类型
         * @return
         */
        private List<Map<String, Object>>  getLinkSelect(String type){
            List<Map<String, Object>>  templateValue = Lists.newArrayList();
            if (!StringUtil.isEmpty(type)) {
                switch (type) {
                case "infoSort":
                    List<InfoSort> infoSortList =  DrsUtils.findAllInfo();
                    List<Map<String, Object>> list = new ArrayList<>(); 
                    for(InfoSort infoSort:infoSortList){
                        Map<String, Object> infoSortMap = new HashMap<String, Object>();
                        infoSortMap.put("id", "id"+infoSort.getId());  
                        infoSortMap.put("name", infoSort.getName());  
                        infoSortMap.put("pid", "id"+infoSort.getParentId());  
                        list.add(infoSortMap);  
                    }
                    ListToTree listToTree = new ListToTree();
                    templateValue = listToTree.getTree(list, "id0", "id");
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
