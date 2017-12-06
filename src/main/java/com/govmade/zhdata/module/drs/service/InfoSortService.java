package com.govmade.zhdata.module.drs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.module.drs.dao.InfoSortDao;
import com.govmade.zhdata.module.drs.dao.InformationDao;
import com.govmade.zhdata.module.drs.mapper.InfoSortMapper;
import com.govmade.zhdata.module.drs.pojo.InfoSort;

@Service
public class InfoSortService extends BaseService<InfoSort> {
	
	@Autowired
	private InfoSortDao infoSortDao;
	
	@Autowired
	private InfoSortMapper infoSortMapper;
	
	@Autowired
	private InformationDao informationDao;
	

   /* @SuppressWarnings({ "rawtypes", "unchecked" })
    public Integer deleteByIds(String ids) {
        String[] array = StringUtil.split(ids, ',');

        List idList = Arrays.asList(array);
        
         * InfoSort infosort=new InfoSort(); infosort.setDelFlag(Global.DEL_FLAG_DELETE);
         
        Example example = new Example(InfoSort.class);

        // 设置Where条件
        Criteria criteria = example.createCriteria();
        criteria.andIn("id", idList);

        Criteria criteria1 = example.createCriteria();
        criteria.andIn("parentId", idList);

        example.or(criteria1);

         return this.updateByExampleSelective(infosort, example); 
        return this.infoSortMapper.deleteByExample(example);
    }*/

	
    public void deleteByIds(List<String> idList) {
        this.infoSortDao.deleteByIds(idList);
    }

    
    
    public List<InfoSort> queryList(Integer id) {
            InfoSort record =new InfoSort();
            record.setDelFlag(Global.DEL_FLAG_NORMAL);
            record.setParentId(id);
            return this.infoSortMapper.select(record);

    }

    public List<InfoSort> findAll() {
        List<InfoSort> list=   this.infoSortDao.findAll();
/*        for(InfoSort infoSort :list){
            System.out.println(infoSort.getName()+infoSort.getId());
        }
*/        return list;

}
    
    
    public List<InfoSort> queryListByPid(Integer id, Integer type) {
        List<InfoSort> infoSorts=this.infoSortDao.queryListByPid(id,type);
        return infoSorts;
       
    }
    
    
    //基础、主题类中目录显示
    /*public List<InfoSort> queryListByPid(Integer id) {
        List<InfoSort> infoSorts=this.infoSortDao.findAll(new InfoSort());
        List<InfoSort> pareList=Lists.newArrayList();
        for (InfoSort iSort1 : infoSorts) {
            if(id.intValue() == iSort1.getParentId().intValue()){
                pareList.add(iSort1);
            }
            for (InfoSort iSort2 : infoSorts) {
                if (iSort2.getParentId().intValue()==iSort1.getId().intValue()) {
                    if (iSort2.getChildren() == null) {
                        List<InfoSort> mychildrens = Lists.newArrayList();
                        mychildrens.add(iSort2);
                        iSort1.setChildren(mychildrens);
                    } else {
                        iSort1.getChildren().add(iSort2);
                    }
                }  
            }
        }
        return pareList;
       
    }*/



    public List<InfoSort> queryInfoSortByParentId(Integer parentId) {
        InfoSort record=new InfoSort();
        record.setParentId(parentId);
         return this.infoSortMapper.select(record);
        
    }

   


 
	


}
