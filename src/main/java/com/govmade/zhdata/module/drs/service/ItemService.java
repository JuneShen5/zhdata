package com.govmade.zhdata.module.drs.service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.module.drs.dao.ItemDao;
import com.govmade.zhdata.module.drs.pojo.Item;

@Service
public class ItemService extends BaseService<Item> {
    
    @Autowired
    private ItemDao itemDao;

    public PageInfo<Item> queryAlList(Page<Item> page) {
        
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Item item = JsonUtil.readValue(page.getObj(), Item.class);
            try {
                String name = new String(item.getName().toString().getBytes("ISO-8859-1"), "UTF-8");
                String type = new String(item.getType().toString().getBytes("ISO-8859-1"), "UTF-8");
                item.setName(name);
                item.setType(type);
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
        }
        
        List<Item> items=this.itemDao.queryAlList(item);
        return new PageInfo<Item>(items);
    }

   
}
