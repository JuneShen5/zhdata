package com.govmade.zhdata.common.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;


public interface BaseDao<T>  {

    /**
     * 获取单条数据
     * 
     * @param id
     * @return
     */
    public T get(int id);

    /**
     * 获取单条数据
     * 
     * @param entity
     * @return
     */
    public T get(T entity);

    /**
     * 查询所有数据列表
     * 
     * @return
     */
    public Long getCount(T entity);
    
    /**
     * 查询所有数据列表
     * 
     * @return
     */
    public List<T> findAll();

    /**
     * 查询所有数据列表
     * 
     * @param entity
     * @return
     */
    public List<T> findAll(T entity);
    
    /**
     * 查询所有数据列表
     * 
     * @param entity
     * @return
     */
    List<T> queryList(T record);
    
    /**
     * 根据分页查询数据列表
     * @param companyId 
     * 
     * @param site
     * @return
     */
    List<T> queryListByPage(@Param("page") Page<T> page);
    
    /**
     * 保存关联关系
     * 
     * @param entity
     * @return
     */
    public Integer saveRelation(T entity);

    /**
     * 删除关联关系
     * 
     * @param entity
     * @return
     */
    public Integer deleteRelation(T entity);
    
}
