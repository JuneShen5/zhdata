package test;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.map.HashedMap;
import org.junit.Test;

public class treeMap {
 
    
    
    @Test
    public void dou() {
        List<String> pcodes = new ArrayList<>();  
        pcodes.add(null);  
        List<Map<String, Object>> list = new ArrayList<>();  
        for (int i = 0, len = 10; i < len; i++){
            Map<String, Object> map = new HashedMap();  
            map.put("id", "id"+i);  
            map.put("name", "name" + i);  
            map.put("pid", pcodes.get(0));  
            pcodes.add("id"+i);  
//            pcodes.add(i); 
            Collections.shuffle(pcodes);  
            list.add(map);  
        }  
          System.out.println("list:"+list);
        try {
            System.out.println(getTree(list, null, "id"));
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } 
    }
    
    public static List<Map<String, Object>> getTree(List<Map<String, Object>> list, String pid, String idName) {  
        List<Map<String, Object>> res = new ArrayList<Map<String,Object>>();  
        if (CollectionUtils.isNotEmpty(list))  
            for (Map<String, Object> map : list) {  
                if(pid == null && map.get("p"+idName) == null || map.get("p"+idName) != null && map.get("p"+idName).equals(pid)){  
                    String id = (String) map.get(idName);  
                    map.put("children", getTree(list, id, idName));  
                    res.add(map);  
                }  
            }  
        return res;  
    }  
}

    
   
        