package com.govmade.zhdata.module.sys.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.module.sys.dao.LogDao;
import com.govmade.zhdata.module.sys.mapper.LogMapper;
import com.govmade.zhdata.module.sys.pojo.Log;

@Service
public class LogService extends BaseService<Log> {
    @Autowired
    private LogDao logDao;

    @Autowired
    private LogMapper logMapper;

    public PageInfo<Log> findAll(Page<Log> page) {

        PageHelper.startPage(page.getPageNum(), page.getPageSize());

        Log log = JsonUtil.readValue(page.getObj(), Log.class);

        try {
            String str = new String(log.getTitle().getBytes("ISO-8859-1"), "UTF-8");
            log.setTitle(str);

        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Log> list = logDao.findAllList(log);

        return new PageInfo<Log>(list);
    }
}
