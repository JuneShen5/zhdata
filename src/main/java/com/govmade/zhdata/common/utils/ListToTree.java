package com.govmade.zhdata.common.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;

public class ListToTree {
    private Integer maxRowNum=0; //最大的行数
    private Integer maxColumNum=0; //最大的行数
    public Integer getMaxRowNum() {
        return maxRowNum;
    }

    public Integer getMaxColumNum() {
        return maxColumNum;
    }

    public List<Map<String, Object>> getTree(List<Map<String, Object>> list, String pid, String idName) {
        maxRowNum++;
        List<Map<String, Object>> res = new ArrayList<Map<String,Object>>();  
        if (CollectionUtils.isNotEmpty(list))
            for (Map<String, Object> map : list) {
                if(pid == null && map.get("p"+idName) == null || map.get("p"+idName) != null && map.get("p"+idName).equals(pid)){  
                    String id = (String) map.get(idName);  
                    map.put("children", getTree(list, id, idName));  
                    res.add(map);  
                } 
                maxColumNum++;
            }  
        return res;  
    }  
}
