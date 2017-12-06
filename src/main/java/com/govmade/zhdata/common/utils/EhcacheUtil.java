package com.govmade.zhdata.common.utils;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

/**
 * @ClassName: EhcacheUtil
 * @Description: TODO
 * @author: 陈俞铮
 */
public class EhcacheUtil {

    private static final String path = "ehcache/ehcache.xml";

    private URL url;

    private CacheManager manager;

    private static EhcacheUtil ehCache;

    public static final String DICT_CACHE = "DictCache";

    private EhcacheUtil(String path) {
        url = getClass().getResource(path);
        manager = CacheManager.create(url);
        System.setProperty(net.sf.ehcache.CacheManager.ENABLE_SHUTDOWN_HOOK_PROPERTY, "true");
    }

    public static EhcacheUtil getInstance() {
        if (ehCache == null) {
            ehCache = new EhcacheUtil(path);
        }
        return ehCache;
    }

    public void put(String cacheName, String key, Object value) {
        Cache cache = manager.getCache(cacheName);
        Element element = new Element(key, value);
        cache.put(element);
    }

    public Object get(String cacheName, String key) {
        Cache cache = manager.getCache(cacheName);
        Element element = cache.get(key);
        return element == null ? null : element.getObjectValue();
    }

    @SuppressWarnings("unchecked")
    public List<Object> getValues(String cacheName) {
        Cache cache = manager.getCache(cacheName);

        List<Object> list = new ArrayList<Object>();
        List<String> keys = cache.getKeys();
        for (String key : keys) {
            Element element = cache.get(key);
            if (element != null && element.getObjectValue() != null) {
                list.add(element.getObjectValue());
            }
        }
        // 将缓存数据写入到磁盘，当项目重启时读取磁盘中的数据
        cache.flush();
        return list;
    }

    public void remove(String cacheName, String key) {
        Cache cache = manager.getCache(cacheName);
        cache.remove(key);
    }

    public void removeAll(String cacheName) {
        Cache cache = manager.getCache(cacheName);
        cache.removeAll();
    }

    public CacheManager getManager() {
        return manager;
    }

    public void setManager(CacheManager manager) {
        this.manager = manager;
    }

    @SuppressWarnings("unchecked")
    public static String getDictTypeName(String typeNameTag, String typeValue) {
        String typeName = null;
        List<Map<String, String>> typeMaps = (List<Map<String, String>>) EhcacheUtil.getInstance().get(
                EhcacheUtil.DICT_CACHE, typeNameTag);
        for (Map<String, String> map : typeMaps) {
            if (map.get("value").equals(typeValue)) {
                typeName = map.get("label");
            }
        }
        return typeName;
    }

}
