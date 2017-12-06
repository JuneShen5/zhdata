package com.govmade.zhdata.module.drs.service;



import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.ComputerRoomDao;
import com.govmade.zhdata.module.drs.mapper.ComputerRoomMapper;
import com.govmade.zhdata.module.drs.pojo.ComputerRoom;

@Service
public class ComputerRoomService extends BaseService<ComputerRoom> {
    
    @Autowired
    private ComputerRoomDao computerRoomDao;
    
    @Autowired
    private ComputerRoomMapper computerRoomMapper;

    @SuppressWarnings("rawtypes")
    public List<ComputerRoom> search(JSONObject json) {
        Map<String, Object> params = Maps.newHashMap();
        Iterator it = json.keys();
        while (it.hasNext()) {  
            String key = it.next().toString();
            /*params.put(key, json.get(key));*/
            String value;
            try {
                value = new String(json.get(key).toString().getBytes("ISO-8859-1"), "UTF-8");
                params.put(key, value);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
    List<ComputerRoom> cList = computerRoomDao.search(params);

    return cList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        ComputerRoom comRoom =new ComputerRoom();
        comRoom.setDelFlag(Global.DEL_FLAG_DELETE);
        Example example = new Example(ComputerRoom.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.computerRoomMapper.updateByExampleSelective(comRoom, example);
    }

    
   
}
