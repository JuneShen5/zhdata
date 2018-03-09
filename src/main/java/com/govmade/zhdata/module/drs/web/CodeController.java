package com.govmade.zhdata.module.drs.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.github.pagehelper.PageInfo;
import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.persistence.BaseController;
import com.govmade.zhdata.common.persistence.BaseService;
import com.govmade.zhdata.common.persistence.Page;
import com.govmade.zhdata.module.drs.pojo.Code;
import com.govmade.zhdata.module.drs.service.CodeService;

@Controller
@RequestMapping(value = "catalog/code")
public class CodeController extends BaseController<Code> {

	@Autowired
	private CodeService codeService;
    @RequestMapping(method = RequestMethod.GET)
    public String toCode() {
        return "modules/catalog/codeIndex";
    }

    /**
     * 查询代码集
     * 
     * @param page
     * @return
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ResponseEntity<Page<Code>> list(Page<Code> page) {
        try {
            PageInfo<Code> pageInfo = this.codeService.findAll(page);
            List<Code> list = pageInfo.getList();
            Page<Code> resPage = new Page<Code>();
            resPage.setRows(list);
            resPage.setTotal(pageInfo.getTotal());
            return ResponseEntity.ok(resPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }
    
    /**
     * 删除代码集
     * 
     * @param ids
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(String ids) {
        try {
            codeService.deleteByIds(ids);
            return ResponseEntity.ok(Global.HANDLE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
    }

    

	@Override
	protected void getFileName() {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void getReadExcelStarLine() {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected BaseService<Code> getService() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	protected List<Map<String, Object>> queryDataForExp(Page<Code> page) {
		// TODO Auto-generated method stub
		return null;
	}
    
}
