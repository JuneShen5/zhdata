package com.govmade.zhdata.common.utils.excel;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;

import com.govmade.zhdata.module.drs.pojo.InfoSort;


/** 
 * 导出Excel公共方法 
 *  
 * @author cyz 
 * 
 */  
public class ExportExcelTemplate extends ExportExcelImpl {  
    
    
    private XSSFSheet attachedsheet = null;
    
    private static ExportExcelTemplate templateExport;
    
    private Boolean islinkselect= false; //用来判断联动是否已经处理 ，以免模板中多次输出
    
    public ExportExcelTemplate(String fileName, String title, String[] rowName,
        List<Map<String, Object>> dataList, HttpServletResponse response) {
        super(fileName, title, rowName, dataList, response);
        // TODO Auto-generated constructor stub
    }

    @Override
    void exportValue(XSSFSheet sheet,int columnNum) {
        XSSFCell  cell = null; 
        XSSFRow row = sheet.createRow(super.valueStartRow);//创建所需的行数  
        List<Map<String, Object>> valueList = new LinkedList<Map<String,Object>>();//用于存储附页信息
        int maxMapLen = 0;//用于记录list中最长的那个map的长度
        for(int m=0; m<columnNum; m++){
            String inputValue = "";
            String columType = super.rowName[m].split("_")[2];
            String columNaneCn = super.rowName[m].split("_")[0];
            
            if("dateselect".equals(columType)){ //时间
                cell = row.createCell(m,Cell.CELL_TYPE_STRING); 
                inputValue = "2017-10-1";
            }else if("input".equals(columType)||"textarea".equals(columType)){
                cell = row.createCell(m,Cell.CELL_TYPE_STRING); 
                inputValue = "";
            }
            //else if("linkselect".equals(columType)){ //联动
//                List<InfoSort> linkselect =  DrsUtils.findInfoArray();
//                这边的层级实在有点难搞，先一列显示，有时间再做吧，脑细胞吃不消了
//                TreeUtil tb = new TreeUtil();
//                String[][] linkArray = tb.buildListToTree(linkselect);
//                
//                for(int i=0;i<linkArray[0].length-1;i++){  //列标
//                    Map<String, Object> valueMap = new HashMap<String, Object>();
//                  
//                    valueMap.put("key_0",columNaneCn+"_"+i);
//                    valueMap.put("value_0",columNaneCn+"_"+i);
//                    valueMap.put("key_1","key");
//                    valueMap.put("value_1","value");
//                    int _j = 0;
//                    for(int j=0;j<linkArray.length-1;j++){ //行标
//                        _j = j+2;
//                        if(linkArray[j][i] != null){
//                            valueMap.put("key_"+_j,linkArray[j][i].split("_")[0]);
//                            valueMap.put("value_"+_j,linkArray[j][i].split("_")[1]); 
//                        }else{
//                            valueMap.put("key_"+_j,"");
//                            valueMap.put("value_"+_j,""); 
//                        }
//                     
//                    }
//                    if( _j>maxMapLen){
//                        maxMapLen =  _j;
//                    }
//                    valueList.add(valueMap);
//                }
//                System.out.println("valueList:"+valueList);
                
                //这边用于主表的标题
//            }
        else if("element".equals(columType)){
                inputValue = ""; 
           
            }else{
                String[] templateValue = super.getTemplateValue(columType,m);
                if(templateValue.length>0){
                    if("checkbox".equals(columType)||"check".equals(columType)){
                        inputValue="请参考附页（多选框）";
                    }else{
                        inputValue="请参考附页";
                    }
                    if("linkselect".equals(columType) && islinkselect ==true){
                        continue;
                    }else{
                        islinkselect = true;
                    }
//                    String columNaneCn = super.rowName[m].split("_")[0];
                    
                    Map<String, Object> valueMap = new HashMap<String, Object>();
                    valueMap.put("key_0",columNaneCn);
                    valueMap.put("value_0",columNaneCn);
                    valueMap.put("key_1","key");
                    valueMap.put("value_1","value");
                    
                    int num = 0;
                    for(int j=0;j<templateValue.length;j++){
                      num = j+2;
                      valueMap.put("key_"+num,templateValue[j].split("_")[1]);
                      valueMap.put("value_"+num,templateValue[j].split("_")[0]);
                  }
                    if(num>maxMapLen){
                        maxMapLen = num;
                    }
                    valueList.add(valueMap);
                }
            }
            if(valueList.size()>0){
                attachedSheet(valueList,maxMapLen);   //设置附页信息
            }
            cell = row.createCell(m,Cell.CELL_TYPE_STRING); 
            if(!"".equals(inputValue) && inputValue != null){
                cell.setCellValue(inputValue);               //设置模板例子数据
            }  
            cell.setCellStyle(style); 
        }
        //创建填写规则
        creatRule();
    }
    
    //添加附页信息
    private void attachedSheet(List<Map<String, Object>> valueList,int maxMapLen){
        if(attachedsheet == null){
            attachedsheet = workbook.createSheet("附页");                  // 创建工作表  
        }
        int listLen = valueList.size();
        for(int i=0;i<=maxMapLen;i++){
            Row rowRowName = attachedsheet.createRow(i);
         
            for(int j=0;j<listLen;j++){
                Map<String, Object> valueMap = valueList.get(j);
                Cell  cellKey = rowRowName.createCell(j*2);
                String keyValue="";
                try {
                    keyValue = valueMap.get("key_"+i).toString();
                } catch (Exception e) {
                    keyValue="";
                }
                cellKey.setCellValue(keyValue); //设置key值
                
                Cell  cellValue = rowRowName.createCell(j*2+1); 
                String valueValue = "";
                try {
                    valueValue = valueMap.get("value_"+i).toString();
                } catch (Exception e) {
                    valueValue="";
                }
                cellValue.setCellValue(valueValue); //设置value值
                
//                if(i==0){
//                    // 合并单元格
//                    CellRangeAddress cra =new CellRangeAddress(i, i, j*2, j*2+1); // 起始行, 终止行, 起始列, 终止列
//                    attachedsheet.addMergedRegion(cra);
//                }
            }
            
        }
        
    }
    
    //用于list转二维数组
    private   String[][] numfour=new String[30][30];
    public  String[][] listToArray(List<InfoSort> roots){
//        int  num = 0;
        
        for (InfoSort n : roots) {
//            System.out.println(n);
            int leval = n.getLevel(); //列
            int  num = getnumFromLevel(numfour,leval);
            int pRank = n.getChildren().size(); //行
            if(pRank>=0){
                numfour[num][leval] = n.getId()+"_"+n.getName();
                if(num-1>0){
                    numfour[num][leval+1] = n.getId()+"_"+n.getName();
                }
               
                num += pRank;
            }
            if(n.isLeaf()){
                ++num;
            }
            System.out.println("num："+num);
            System.out.println("level："+leval);
            System.out.println(n.getId()+"_"+n.getName());
//            int _num = getnumFromLevel(numfour,leval)+num;
//            System.out.println("_num："+_num);
            numfour[num][leval] = n.getId()+"_"+n.getName();
         
            if(!n.isLeaf()){
                listToArray(n.getChildren());
            }
          
        }
        
//        for(int a=0;a<30;a++){
            for(int b=0;b<30;b++){
//                System.out.println(numfour[b][1]);
            }
//        }
        
        
        return numfour;
    }
    
    public  Integer getnumFromLevel(String[][] strarray,int column){
        int rowlength = strarray.length;
        int num = 0;
        for(int i=rowlength-1;i>=0;i--){
//            System.out.println("column:"+strarray[i][column]);
            if( strarray[i][column] !=null){
//                System.out.println("column:"+strarray[i][column]);
//                System.out.println("i:"+i);
                num = i;
//                System.out.println("numnum:"+num);
                break;
            }
        }
         
        return num;
    } 
}  
