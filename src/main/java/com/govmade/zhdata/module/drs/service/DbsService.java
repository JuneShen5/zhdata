package com.govmade.zhdata.module.drs.service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.abel533.entity.Example;
import com.github.abel533.entity.Example.Criteria;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.common.utils.DBMSMetaUtil;
import com.govmade.zhdata.common.utils.JsonUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.module.drs.dao.DbsDao;
import com.govmade.zhdata.module.drs.mapper.ColumnsMapper;
import com.govmade.zhdata.module.drs.mapper.DbsMapper;
import com.govmade.zhdata.module.drs.mapper.TablesMapper;
import com.govmade.zhdata.module.drs.pojo.Columns;
import com.govmade.zhdata.module.drs.pojo.Dbs;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Tables;

@Service
public class DbsService extends BaseService<Dbs> {

    @Autowired
    private DbsMapper dbsMapper;
    
    @Autowired
    private TablesMapper tablesMapper;
    
    @Autowired
    private ColumnsMapper columnsMapper;

    @Autowired
    private DbsDao dbsDao;

    @Autowired
    private ElementService elementService;
    
    @Autowired
    private ColumnsService columnsService;
  

    public List<Map<String, Object>> importDB(Dbs dbs) throws Exception {

    	try {
    		List<Map<String,Object>> tableList = DBMSMetaUtil.listTables(dbs.getType(), dbs.getHost(), dbs.getPort(), 
    				dbs.getNameEn(), dbs.getUser(), dbs.getPassword());
    		List<Map<String,Object>> result = Lists.newArrayList();
    		for (Map<String, Object> table : tableList) {
    			Map<String, Object> map = Maps.newLinkedHashMap();
                String nameEn=(String)table.get("TABLE_NAME");
                String nameCn=(String) table.get("REMARKS");
                map.put("nameEn", nameEn);
                if (nameCn == null || "".equals(nameCn)) {
                    map.put("nameCn", nameEn);
                } else {
                    map.put("nameCn", nameCn);
                }
                result.add(map);
    		};
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public void saveAll(Dbs dbss, String tbEns, String tbCns) {
        // 保存库数据
         Dbs record1=new Dbs();
         record1.setSysId(dbss.getSysId());
         record1.setNameEn(dbss.getNameEn());
         Dbs dbone=dbsMapper.selectOne(record1);
         if (dbone==null) {
             dbss.preInsert();
             dbsMapper.insertSelective(dbss);
        }else {
            dbss.preUpdate();
            dbss.setId(dbone.getId());
            dbsMapper.updateByPrimaryKeySelective(dbss);
        }
         // 保存表数据
        String[] tEs=tbEns.split(",");
        String[] tCs = tbCns.split(",");
        
        Integer dbId=dbss.getId();
        for (int i = 0; i < tEs.length; i++) {
            Tables tb=new Tables();
            tb.setDbId(dbId);
            tb.setNameEn(tEs[i]);
            tb.setNameCn(tCs[i]);
            Tables record2=new Tables();
            record2.setDbId(dbId);
            record2.setNameEn(tb.getNameEn());
            Tables tbone =tablesMapper.selectOne(record2);
            if (tbone==null) {
                tb.preInsert();
                tablesMapper.insertSelective(tb);
            }else{
                tb.preUpdate();
                tb.setId(tbone.getId());
                tablesMapper.updateByPrimaryKeySelective(tb);
            }
           
            //保存数据表字段
            String tableName = tEs[i];
            List<Map<String, Object>> columnList;
            try {
                columnList = DBMSMetaUtil.listColumns(dbss.getType(), dbss.getHost(), dbss.getPort(), 
                                dbss.getNameEn(), dbss.getUser(), dbss.getPassword(), tableName);
                for (Map<String, Object> map : columnList) {
                    Columns columns=new Columns();
                    columns.setTbId(tb.getId());
                    columns.setNameEn((String) map.get("nameEn"));
                    String nameCn=(String) map.get("nameCn");
                    if(nameCn == null || "".equals(nameCn)){
                        columns.setNameCn((String) map.get("nameEn"));
                    }else{
                         columns.setNameCn((String) map.get("nameCn"));
                    }
                   
                    columns.setType((Integer) map.get("type")); //TYPE_NAME 类型名称
                    columns.setLength((Integer) map.get("length"));
                    Columns record3=new Columns();
                    record3.setTbId(tb.getId());
                    record3.setNameEn(columns.getNameEn());
                    Columns colone= columnsMapper.selectOne(record3);
                    if (colone==null) {
                        columns.preInsert();
                        columnsMapper.insertSelective(columns);
                    }else {
                        columns.preUpdate();
                        columns.setId(colone.getId());
                        columnsMapper.updateByPrimaryKeySelective(columns);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    

    public PageInfo<Dbs> findAll(Page<Dbs> page) {
        
        PageHelper.startPage(page.getPageNum(), page.getPageSize());
        Dbs dbs = JsonUtil.readValue(page.getObj(), Dbs.class);
        try {
            String nameCn= new String(dbs.getNameCn().getBytes("ISO-8859-1"), "UTF-8");
            dbs.setNameCn(nameCn);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<Dbs> list = this.dbsDao.findAll(dbs);
        return new PageInfo<Dbs>(list);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');
        List idList = Arrays.asList(array);
        Example example = new Example(Dbs.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);
        return this.dbsMapper.deleteByExample(example);
    }

	public void generate(Element element) {
		System.out.println("element: "+element.getId());
		if (element.getId() == null) {
    		if (this.elementService.saveSelective(element) > 0) {
    			Columns columns = new Columns();
        		columns.setId(element.getColId());
        		columns.setEleId(element.getId());
        		this.columnsService.updateSelective(columns);
    		}
    	} else {
    		this.elementService.updateSelective(element);
    	}
	}

	 /*批量添加用户（excel导入）*/
	public void saveAll(List<Map<String,String>> dataList) {
	    dbsDao.saveAll(dataList);
	}
   
    

}
