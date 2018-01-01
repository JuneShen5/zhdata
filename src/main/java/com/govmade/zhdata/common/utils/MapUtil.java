package com.govmade.zhdata.common.utils;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.apache.commons.lang3.StringUtils;
import org.springframework.cglib.beans.BeanMap;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

public class MapUtil {

    public static Map<String, Object> beanToMap(Object obj) {
        Map<String, Object> params = Maps.newHashMap();
        try {
            PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
            PropertyDescriptor[] descriptors = propertyUtilsBean.getPropertyDescriptors(obj);
            for (int i = 0; i < descriptors.length; i++) {
                String name = descriptors[i].getName();
                if (!StringUtils.equals(name, "class")) {
                    params.put(name, propertyUtilsBean.getNestedProperty(obj, name));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return params;
    }

    public static Map<String, Object> beansToMap(Object obj) {
        Map<String, Object> params = Maps.newHashMap();
        try {
            PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean();
            PropertyDescriptor[] descriptors = propertyUtilsBean.getPropertyDescriptors(obj);
            for (int i = 0; i < descriptors.length; i++) {
                String name = descriptors[i].getName();
                if (!StringUtils.equals(name, "class")) {
                    if (null != propertyUtilsBean.getNestedProperty(obj, name)) {
                        params.put(name, String.valueOf(propertyUtilsBean.getNestedProperty(obj, name)));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return params;
    }

    @SuppressWarnings("rawtypes")
    public static Map<String, Object> requestToMap(HttpServletRequest request) {
        Map<String, Object> params = Maps.newHashMap();
        try {
            Enumeration paramNames = request.getParameterNames();
            while (paramNames.hasMoreElements()) {
                String paramName = (String) paramNames.nextElement();

                String[] paramValues = request.getParameterValues(paramName);
                if (paramValues.length == 1) {
                    String paramValue = paramValues[0];
                    if (paramValue.length() != 0) {
                        params.put(paramName, paramValue);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return params;
    }

    @SuppressWarnings("rawtypes")
    public static Map<String, Object> infoToMap(Map<String, Object> map, String info) {
        JSONObject infoJson = JSONObject.fromObject(info);
        if (!infoJson.isNullObject()) {
            Iterator it = infoJson.keys();
            while (it.hasNext()) {
                String key = it.next().toString();
                map.put(key, infoJson.get(key));
            }
        }
        return map;
    }

    /**
     * 将List中的Key转换为小写
     * 
     * @param list 返回新对象
     * @return
     */
    public static List<Map<String, Object>> convertKeyList2LowerCase(List<Map<String, Object>> list) {
        if (null == list) {
            return null;
        }
        List<Map<String, Object>> resultList = Lists.newArrayList();
        Iterator<Map<String, Object>> iteratorL = list.iterator();
        while (iteratorL.hasNext()) {
            Map<String, Object> map = (Map<String, Object>) iteratorL.next();
            Map<String, Object> result = convertKey2LowerCase(map);
            if (null != result) {
                resultList.add(result);
            }
        }
        return resultList;
    }

    /**
     * 转换单个map,将key转换为小写.
     * 
     * @param map 返回新对象
     * @return
     */
    public static Map<String, Object> convertKey2LowerCase(Map<String, Object> map) {
        if (null == map) {
            return null;
        }
        Map<String, Object> result = new HashMap<String, Object>();
        Set<String> keys = map.keySet();
        Iterator<String> iteratorK = keys.iterator();
        while (iteratorK.hasNext()) {
            String key = (String) iteratorK.next();
            Object value = map.get(key);
            if (null == key) {
                continue;
            }
            String keyL = key.toLowerCase();
            result.put(keyL, value);
        }
        return result;
    }
    
   
  //Map转换为JavaBean  
    public static <T> T map2bean(Map<String,Object> map,Class<T> clz) throws Exception{  
        //创建JavaBean对象  
        T obj = clz.newInstance();  
        //获取指定类的BeanInfo对象  
        BeanInfo beanInfo = Introspector.getBeanInfo(clz, Object.class);  
        //获取所有的属性描述器  
        PropertyDescriptor[] pds = beanInfo.getPropertyDescriptors();  
        for(PropertyDescriptor pd:pds){  
            Object value = map.get(pd.getName());  
            Method setter = pd.getWriteMethod();  
            setter.invoke(obj, value);  
        }  
          
        return  obj;  
    }
    
    /** 
     * 将List<Map<String,Object>>转换为List<T> 
     * @param maps 
     * @param clazz 
     * @return 
     * @throws InstantiationException 
     * @throws IllegalAccessException 
     */  
    public static <T> List<T> mapsToObjects(List<Map<String, String>> maps,Class<T> clazz) throws InstantiationException, IllegalAccessException {  
        List<T> list = Lists.newArrayList();  
        if (maps != null && maps.size() > 0) {  
            Map<String, String> map = null;  
            T bean = null;  
            for (int i = 0,size = maps.size(); i < size; i++) {  
                map = maps.get(i);  
                bean = clazz.newInstance();  
                mapToBean(map, bean);  
                list.add(bean);  
            }  
        }  
        return list;  
    } 
    
    /** 
     * 将map装换为javabean对象 
     * @param map 
     * @param bean 
     * @return 
     */  
    public static <T> T mapToBean(Map<String, String> map,T bean) {  
        BeanMap beanMap = BeanMap.create(bean);  
        beanMap.putAll(map);  
        return bean;  
    } 
}
