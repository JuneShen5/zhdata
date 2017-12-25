package com.govmade.zhdata.common.utils.excel;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;

import com.govmade.zhdata.common.utils.DrsUtils;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.SysUtils;
import com.govmade.zhdata.module.drs.pojo.Element;
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
    
    protected Map<String, Map<String,String>> dictMap = new HashMap<String, Map<String,String>>();
    protected Map<Integer,String> companyMap = new HashMap<Integer, String>();
    protected Map<Integer,String> siteMap = new HashMap<Integer, String>();
    protected Map<Integer,String> roleMap = new HashMap<Integer, String>();
    protected Map<Integer,String> menuMap = new HashMap<Integer, String>();
    protected Map<Integer,String> sysMap = new HashMap<Integer, String>();
    protected Map<Integer,String> elementMap =  new HashMap<Integer, String>();
    
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
//                       String columTypeValue = inputTypeArr[1];
//                       Map<String,String> templateValue = getTemplateValue(columType,columTypeValue); //对应下拉选框数据
//                       newRow.createCell(j).setCellValue(templateValue.get(data));//
                       String value = getTemplateValue(inputTypeArr,data);
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
        protected String getTemplateValue(String[] inputTypeArr,String data){
            String inputType = inputTypeArr[0];
            String inputValue = "";
            String name = "";
            Integer Id = Integer.valueOf(data);
            switch(inputType)
            {
            case "select":
                
                inputValue =  StringUtil.toUnderScoreCase(inputTypeArr[1]); //传过来的是大写的驼峰为了避免联动字段出错
                name = getSelect(inputValue,Id);
                break;
            case "dictselect":
            case "radio":
            case "check":
            case "checkbox":
                if(this.dictMap.size() == 0){
                    getAllDictToList();
                }
                inputValue = StringUtil.toUnderScoreCase(inputTypeArr[1]);
                name = dictMap.get(inputValue).get(String.valueOf(Id));
                break;
            case "companyselect":
                if(this.companyMap.size() == 0){
                    List<Company> companyList= SysUtils.getCompanyList();
                    for(Company company : companyList){
                        companyMap.put(company.getId(), company.getName());
                    }
                }
                name = companyMap.get(Id);
//                name = SysUtils.getCompanyName(Integer.valueOf(data));
                break;
//            case "element":
//                if(this.elementMap.size() == 0){
//                    List<Element> elementList = SysUtils.getElementList();
//                    for(Element element : elementList){
//                        elementMap.put(element.getId(),element.getNameCn());
//                    }
//                }
//                if(null!=Id && !"".equals(Id.trim())){
//                    String regEx="[\\s~·`!！@#￥$%^……&*（()）\\-——\\-_=+【\\[\\]】｛{}｝\\|、\\\\；;：:‘'“”\"，,《<。.》>、/？?]";  
//                    Pattern p = Pattern.compile(regEx);  
//                    Matcher m = p.matcher(name);  
//                    String[] elementArray = m.replaceAll(",").split(",");
//                    String _Id = "";
//                    for(int i=0;i<elementArray.length;i++){
//                        _Id += String.valueOf(elementMap.get(elementArray[i]))+",";
//                    }
//                    Id = _Id.substring(0,_Id.length() - 1);
//                }else{
//                    Id = "";
//                }
//                
//                break;
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
        private String getSelect(String type,Integer Id) {
            String name = "";
            if (!StringUtil.isEmpty(type)) {
                switch (type.trim().toLowerCase()) {
                case "company":
                    if(this.companyMap.size() == 0){
                        List<Company> companyList= SysUtils.getCompanyList();
                        for(Company company : companyList){
                            companyMap.put(company.getId(), company.getName());
                        }
                    }
                    name = companyMap.get(Integer.valueOf(Id));
                    break;
                case "site":
                    if(this.siteMap.size() == 0){
                        List<Site> siteList= SysUtils.getSiteList();
                        for(Site site : siteList){
                            siteMap.put(site.getId(), site.getName());
                        }
                    }
                    name = siteMap.get(Id);
                    break;
                case "role":
                    if(this.roleMap.size() == 0){
                        List<Role> roleList= SysUtils.getRoleList();
                        for(Role role : roleList){
                            roleMap.put(role.getId(), role.getName());
                        }
                    }
                    name = roleMap.get(Id);
                    break;
                case "menu":
                    if(this.menuMap.size() == 0){
                        List<Menu> menuList= SysUtils.getMenuList();
                        for(Menu menu : menuList){
                            menuMap.put(menu.getId(), menu.getName());
                        }
                    }
                    name = menuMap.get(Id);
                    break;
                case "sys":
                    if(this.sysMap.size() == 0){
                        List<Systems> sysList= SysUtils.getSysList();
                        for(Systems systems : sysList){
                            sysMap.put(systems.getId(), systems.getNameCn());
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
//            System.out.println("resultMap"+resultMap);
        }
}  
