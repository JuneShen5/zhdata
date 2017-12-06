package com.govmade.zhdata.common.persistence;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;

import com.github.abel533.entity.Example;
import com.github.abel533.mapper.Mapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Maps;

public abstract class BaseService<T> {

    @Autowired
    private Mapper<T> mapper;

    public int queryConut(T record) {
        return this.mapper.selectCount(record);
    }
    
    
    /**
     * 根据id查询数据
     * 
     * @param id
     * @return
     * */
    public T queryById(Integer id) {
        return this.mapper.selectByPrimaryKey(id);
    }

    /**
     * 查询所有数据
     * 
     * @param
     * @return
     * */
    public List<T> queryAll(T record) {
        return this.mapper.select(record);
    }

    /**
     * 根据条件查询一条数据
     * 
     * @param record
     * @return
     * */
    public T queryOne(T record) {
        return this.mapper.selectOne(record);
    }

    /**
     * 根据条件查询数据列表
     * 
     * @param record
     * @return
     * */
    public List<T> queryListByWhere(T record) {
        return this.mapper.select(record);
    }

    /**
     * 分页查询数据列表
     * 
     * @param page
     * @param rows
     * @param record
     * @return
     * */
    public PageInfo<T> queryPageListByWhere(Integer page, Integer rows, T record) {
        // 设置分页参数
        PageHelper.startPage(page, rows);
        List<T> list = this.mapper.select(record);
        return new PageInfo<T>(list);
    }

    /**
     * 新增数据
     * 
     * @param t
     * @return
     * */
    public Integer save(T t) {
        return this.mapper.insert(t);
    }

    /**
     * 有选择的保存，选择不为null的字段作为插入字段
     * 
     * @param t
     * @return
     */
    public Integer saveSelective(T t) {
      return this.mapper.insertSelective(t);
    }

    /**
     * 更新数据
     * 
     * @param t
     * @return
     * */
    public Integer update(T t) {
        return this.mapper.updateByPrimaryKey(t);
    }

    /**
     * 有选择的更新，选择不为null的字段作为插入字段
     * 
     * @param t
     * @return
     */
    public Integer updateSelective(T t) {
        return this.mapper.updateByPrimaryKeySelective(t);
    }

    /**
     * 有选择的更新，设置条件
     * 
     * @param t
     * @return
     */
    public Integer updateByExampleSelective(T t, Object example) {
        return this.mapper.updateByExampleSelective(t, example);
    }

    /**
     * 根据id删除数据
     * 
     * @param id
     * @return
     */
    public Integer deleteById(Integer id) {
        return this.mapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除
     * 
     * @param clazz
     * @param property
     * @param values
     * @return
     */
    public Integer deleteByIds(Class<T> clazz, String property, List<Object> values) {
        Example example = new Example(clazz);
        example.createCriteria().andIn(property, values);
        return this.mapper.deleteByExample(example);
    }

    /**
     * 根据条件删除数据
     * 
     * @param record
     * @return
     */
    public Integer deleteByWhere(T record) {
        return this.mapper.delete(record);
    }
    
    @SuppressWarnings("rawtypes")
    public Page<T> getPageForSearch(Page<T> page) {
	JSONObject json=JSONObject.fromObject(page.getObj());
        Map<String, Object> params = Maps.newHashMap();
        Iterator it = json.keys();
        while (it.hasNext()) {
            String key = it.next().toString();
            /* params.put(key, json.get(key)); */
            
            try {
//                if (key.equals("isAudit")) {
//                     Integer value=json.getInt(key);
//                     params.put(key, value);
//                }else {
                    String value = new String(json.get(key).toString().getBytes("ISO-8859-1"), "UTF-8");
                    params.put(key, value);
//                }
                
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        page.startPage();
        page.setParams(params);
        return page;
	}
}
