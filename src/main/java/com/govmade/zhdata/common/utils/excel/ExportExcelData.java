package com.govmade.zhdata.common.utils.excel;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFSheet;

import com.google.common.collect.Maps;
import com.govmade.zhdata.common.utils.DrsUtils;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.SysUtils;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.InfoSort;
import com.govmade.zhdata.module.drs.pojo.Systems;
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
public class ExportExcelData extends ExportExcelImpl {
    
    protected Map<String, Map<String,String>> dictMap = new HashMap<String, Map<String,String>>();
    protected Map<String,String> companyMap = new HashMap<String, String>();
    protected Map<String,String> siteMap = new HashMap<String, String>();
    protected Map<String,String> roleMap = new HashMap<String, String>();
    protected Map<String,String> menuMap = new HashMap<String, String>();
    protected Map<String,String> sysMap = new HashMap<String, String>();
    protected Map<String,String> elementMap =  new HashMap<String, String>();
    protected Map<String,String> infoSortMap =  new HashMap<String, String>();
    
    private String regEx="[\\s~·`!！@#￥$%^……&*（()）\\-——\\-_=+【\\[\\]】｛{}｝\\|、\\\\；;：:‘'“”\"，,《<。.》>、/？?]";  
    
    protected String[] unSelect = {"input","dateselect","textarea","element"}; //不用做关联的inputtype,这边的element不做关联是因为在读取数据的时候直接把信息项的中文名读取出来了
    
    
    public ExportExcelData(String fileName, String title, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(fileName, title, rowName, dataList, response);
    }
    
    public ExportExcelData(HttpServletRequest request,String fileName, String title, String templatFile, String[] rowName,
            List<Map<String, Object>> dataList, HttpServletResponse response) throws Exception {
        super(request,fileName, title, templatFile, rowName, dataList, response);
    }  
    
    @Override
    protected void exportValue(XSSFSheet sheet) {
        int lastRowNum = sheet.getLastRowNum();
        Row nameEnRow = sheet.getRow(lastRowNum-1); //获取英文字段的行
        Row inputTypeRow = sheet.getRow(lastRowNum);
        int lastCellNum =  nameEnRow.getLastCellNum();   //模板中的总列数
        //将查询出的数据设置到sheet对应的单元格中
        Map<Integer, String> nameEnMap= Maps.newHashMap(); //存放字段英文名
        Map<Integer, String> inputTypeMap= Maps.newHashMap(); //存放inputType
        Map<Integer, String> inputTypeValueMap= Maps.newHashMap();//存放inputTypeValue
        
        for(int j=0;j<lastCellNum;j++){ //这边将英文字段以及字段类型整理好
            nameEnMap.put(j,nameEnRow.getCell(j).getStringCellValue());
            if(inputTypeRow.getCell(j).getStringCellValue().length()>0){
                String[] inputTypeArr = inputTypeRow.getCell(j).getStringCellValue().split("_");
                inputTypeMap.put(j, inputTypeArr[0]);
                if(inputTypeArr.length>1){
                    inputTypeValueMap.put(j, inputTypeArr[1]);
                }else{
                    inputTypeValueMap.put(j, "");
                }
            }else{
                inputTypeMap.put(j, "");
                inputTypeValueMap.put(j, "");
            }
        }
        for(int i=0;i<dataList.size();i++){
            Row newRow = sheet.createRow(lastRowNum+i+1);
            for(int j=0;j<lastCellNum;j++){
               String data =  (String) dataList.get(i).get(nameEnMap.get(j)); //根据英文那一列一次获取实体数据list中的值
               if(  data != null && inputTypeRow.getCell(j).getStringCellValue().length()>0 ){
                   //获取excel存放inputtype那一行的值
                   if(Arrays.asList(unSelect).contains(inputTypeMap.get(j))){
                       newRow.createCell(j).setCellValue(data);//没有关联表的数据
                   }else{
                       //有关联表的数据
                       String value = getTemplateValue(inputTypeMap.get(j),inputTypeValueMap.get(j),data);
                       newRow.createCell(j).setCellValue(value);
                   }
               }
               
            }
        }
//        changeLinkValue(sheet,lastRowNum);
    }
    
    /**
     * 统一更改有关联的数据
     * @param sheet
     * @param lastRowNum
     */
//    private void changeLinkValue(XSSFSheet sheet, int lastRowNum){
//        Row inputTypeRow = sheet.getRow(lastRowNum);
//        int lastCellNum =  sheet.getRow(lastRowNum-1).getLastCellNum();   //模板中的总列数
//        for(int j=0;j<lastCellNum;j++){
//          String[] inputTypeArr = inputTypeRow.getCell(j).getStringCellValue().split("_");
//          String columType = inputTypeArr[0];
//          if(!Arrays.asList(unSelect).contains(columType)){
//              for(int i=lastRowNum+1;i<dataList.size();i++){
//                  Row nowRow = sheet.getRow(i);
//                  XSSFCell nowCell = (XSSFCell) nowRow.getCell(j);
//                  String value = getTemplateValue(inputTypeArr,nowCell.getStringCellValue());
//                  nowCell.setCellValue(value);
//              }
//                
//          }
//        }
//    }
 
    /**
     *  根据关联的ID值获取实体数据
     * @param inputType 输入框类型
     * @param columTypeValue dict的type
     * @param data 管理数据的ID值
     * @return
     */
        protected String getTemplateValue(String inputType,String inputTypeValue,String Id){
            if(inputType == ""){
                return "";
            }
            String inputValue = "";
            String name = "";
            switch(inputType)
            {
            case "select":
                inputValue =  StringUtil.toUnderScoreCase(inputTypeValue); //传过来的是大写的驼峰为了避免联动字段出错
                name = getSelect(inputValue,Id);
                break;
            case "dictselect":
            case "radio":
                if(this.dictMap.size() == 0){
                    getAllDictToList();
                }
                inputValue = StringUtil.toUnderScoreCase(inputTypeValue);
                name = dictMap.get(inputValue).get(String.valueOf(Id));
                break;
            case "check":
            case "checkbox":
                if(this.dictMap.size() == 0){
                    getAllDictToList();
                }
                inputValue = StringUtil.toUnderScoreCase(inputTypeValue);
                Map<String,String> checkDic = dictMap.get(inputValue);
//                Matcher m = Pattern.compile(regEx).matcher(Id);
//                String[] idArray = m.replaceAll(",").split(",");
                String[] idArray = Id.split(",");
                String _name = "";
                for(int i=0;i<idArray.length;i++){
                    _name += checkDic.get(idArray[i])+",";
                  
                }
                name = _name.substring(0,_name.length() - 1);
                break;
            case "companyselect":
                if(this.companyMap.size() == 0){
                    List<Company> companyList= SysUtils.getCompanyList();
                    for(Company company : companyList){
                        companyMap.put(String.valueOf(company.getId()), company.getName());
                    }
                }
                name = companyMap.get(Id);
                break;
//            case "element":
//                if(this.elementMap.size() == 0){
//                    List<Element> elementList = SysUtils.getElementList();
//                    for(Element element : elementList){
//                        elementMap.put(String.valueOf(element.getId()),element.getNameCn());
//                    }
//                }
//                if(null!=Id && !"".equals(Id.trim())){
////                    String regEx="[\\s~·`!！@#￥$%^……&*（()）\\-——\\-_=+【\\[\\]】｛{}｝\\|、\\\\；;：:‘'“”\"，,《<。.》>、/？?]";  
////                    Pattern p = Pattern.compile(regEx);  
////                    Matcher m = p.matcher(name);  
//                    String[] idArray = Id.replaceAll(",").split(",");
//                    String _name = "";
//                    for(int i=0;i<idArray.length;i++){
//                        _Id += String.valueOf(elementMap.get(elementArray[i]))+",";
//                    }
//                    Id = _Id.substring(0,_Id.length() - 1);
//                }else{
//                    Id = "";
//                }
//                
//                break;
            case "linkageSelect":
                if(this.infoSortMap.size() == 0){
                    List<InfoSort> infoSortList =  DrsUtils.findAllInfo();
                    for(InfoSort infoSort : infoSortList){
                        infoSortMap.put(String.valueOf(infoSort.getId()), infoSort.getName());
                    }
                }
                name = infoSortMap.get(Id);
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
        private String getSelect(String type,String Id) {
            String name = "";
            if (!StringUtil.isEmpty(type)) {
                switch (type.trim().toLowerCase()) {
                case "company":
                    if(this.companyMap.size() == 0){
                        List<Company> companyList= SysUtils.getCompanyList();
                        for(Company company : companyList){
                            companyMap.put(String.valueOf(company.getId()), company.getName());
                        }
                    }
                    name = companyMap.get(Integer.valueOf(Id));
                    break;
                case "site":
                    if(this.siteMap.size() == 0){
                        List<Site> siteList= SysUtils.getSiteList();
                        for(Site site : siteList){
                            siteMap.put(String.valueOf(site.getId()), site.getName());
                        }
                    }
                    name = siteMap.get(Id);
                    break;
                case "role":
                    if(this.roleMap.size() == 0){
                        List<Role> roleList= SysUtils.getRoleList();
                        for(Role role : roleList){
                            roleMap.put(String.valueOf(role.getId()), role.getName());
                        }
                    }
                    name = roleMap.get(Id);
                    break;
                case "menu":
                    if(this.menuMap.size() == 0){
                        List<Menu> menuList= SysUtils.getMenuList();
                        for(Menu menu : menuList){
                            menuMap.put(String.valueOf(menu.getId()), menu.getName());
                        }
                    }
                    name = menuMap.get(Id);
                    break;
                case "sys":
                    if(this.sysMap.size() == 0){
                        List<YjSystems> sysList= SysUtils.getSysList();
                        for(YjSystems systems : sysList){
                            sysMap.put(String.valueOf(systems.getId()), systems.getName());
                        }
                    }
                    name = sysMap.get(Id);
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
        }
}  
