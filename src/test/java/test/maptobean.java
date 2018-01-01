package test;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;

import com.govmade.zhdata.common.utils.MapUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.pojo.Information;

public class maptobean {
 
    
    
    @Test
    public void dou() {
        Map<String,Object> infoMap =new HashMap<String,Object>();
        infoMap.put("infoType1", 1);
        infoMap.put("infoType2", 48);
        infoMap.put("nameEn", "321000013239");
        infoMap.put("elementIds", "[{\"id\":9710}]");
        infoMap.put("manageStyle", 1);
        infoMap.put("nameCn", "地址信息");
//        infoMap.put("shareMode", 3);
//        infoMap.put("code", "11440400006988347T");
//        infoMap.put("openType", 2);
//        infoMap.put("info", "{\"xinxiziyuanzhaiyao\":\"11\",\"xinxiziyuanshengchengfangshi\":\"2\",\"zaixianziyuanlianjiedizhi\":\"11\",\"infoType3\":\"-100\",\"infoType4\":\"-100\",\"gengxinzhouqi\":\"2\",\"guanlianziyuandaima\":\"\",\"shemizhuxing\":\"0\"}");
//        infoMap.put("isOpen", 1);
//        infoMap.put("shareCondition", 11);
//        infoMap.put("rightRelation", 3);
//        infoMap.put("releaseDate", "2017-12-05");
//        infoMap.put("resourceFormat", 2);
//        infoMap.put("companyId", 13);
//        infoMap.put("systemId", 43);
//        infoMap.put("shareType", 2);
        Map<String,Object> _infoMap = new HashMap<String, Object>();
//        for (String key : infoMap.keySet()) {
//            String value = infoMap.get(key);
//            System.out.println("value:"+value);
//            if(StringUtils.isNumeric(value)&&value.length()<5){
//                _infoMap.put(key, Integer.valueOf(value));
//            }else{
//                _infoMap.put(key, value);
//            }
////            _infoMap.put(StringUtil.toCamelCase(key), infoMap.get(key));
////            String value = infoMap.get(key);  
////            System.out.println("Key = " + key + ", Value = " + value);  
//        } 
        System.out.println("_infoMap:"+_infoMap);
        try {
            Information information = MapUtil.map2bean(infoMap,Information.class);
            System.out.println("Information："+information);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}

    
   
        