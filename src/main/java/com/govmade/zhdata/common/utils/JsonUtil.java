package com.govmade.zhdata.common.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

/**
 * 关于JSON的工具类.
 * 
 * @author fts
 * 
 * @version 2017-08-09
 */
public final class JsonUtil {

    public static ObjectMapper objectMapper;

    /**
     * 使用泛型方法，把json字符串转换为相应的JavaBean对象。 (1)转换为普通JavaBean：readValue(json,Student.class)
     * (2)转换为List,如List<Student>,将第二个参数传递为Student [].class.然后使用Arrays.asList();方法把得到的数组转换为特定类型的List
     * 
     * @param jsonStr
     * @param valueType
     * @return
     */
    public static <T> T readValue(String jsonStr, Class<T> valueType) {
        if (objectMapper == null) {
            objectMapper = new ObjectMapper();
        }
        try {
            return objectMapper.readValue(jsonStr, valueType);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * json数组转List
     * 
     * @param jsonStr
     * @param valueTypeRef
     * @return
     */
    public static <T> T readValue(String jsonStr, TypeReference<T> valueTypeRef) {
        if (objectMapper == null) {
            objectMapper = new ObjectMapper();
        }
        try {
            return objectMapper.readValue(jsonStr, valueTypeRef);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 把JavaBean转换为json字符串
     * 
     * @param object
     * @return
     */
    public static String toJSon(Object object) {
        if (objectMapper == null) {
            objectMapper = new ObjectMapper();
        }
        try {
            return objectMapper.writeValueAsString(object);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<?> jsonArray2List(String json, Class<?> clazz) {

        List<?> list = Lists.newArrayList();
        if (!StringUtil.isEmpty(json)) {
            JSONArray jsonArray = JSONArray.fromObject(json);
            list = (List<?>) JSONArray.toCollection(jsonArray, clazz);
        }
        return list;
    }

    public static Map<String, Object> json2Map(String json) {
        Map<String, Object> map = Maps.newHashMap();
        if (objectMapper == null) {
            objectMapper = new ObjectMapper();
        }
        try {
            map = objectMapper.readValue(json, new TypeReference<HashMap<String, Object>>() {
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}