package com.govmade.zhdata.module.drs.web;

import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.drs.pojo.Element;
import com.govmade.zhdata.module.drs.pojo.Information;
import com.govmade.zhdata.module.drs.pojo.Systems;
import com.govmade.zhdata.module.drs.service.ColumnsService;
import com.govmade.zhdata.module.drs.service.DbsService;
import com.govmade.zhdata.module.drs.service.ElementService;
import com.govmade.zhdata.module.drs.service.InformationService;
import com.govmade.zhdata.module.drs.service.SystemService;
import com.govmade.zhdata.module.drs.service.TablesService;
import com.govmade.zhdata.module.sys.pojo.Company;
import com.govmade.zhdata.module.sys.service.CompanyService;

@Controller
@RequestMapping(value = "assets/echarts")
public class EchartsController {

    @Autowired
    private CompanyService companySersvice;

    @Autowired
    private SystemService systemService;
    
    @Autowired
    private InformationService informationService;
    
    @Autowired
    private ElementService elementService;

    @Autowired
    private DbsService dbService;

    @Autowired
    private TablesService tableService;

    @Autowired
    private ColumnsService columnService;

    @RequestMapping(value = "toRelation", method = RequestMethod.GET)
    public String toRelation() {
        return "modules/assets/relationChart";
    }
    
    @RequestMapping(value = "toStatistic", method = RequestMethod.GET)
    public String toStatistic() {
        return "modules/assets/StatisticIndex";
    }

    @RequestMapping(value = "relation", method = RequestMethod.GET)
    public ResponseEntity<JSONObject> toPage() {

         int num=0;
         int num1=0;
         
        JSONObject resultJson = new JSONObject();
        JSONArray nodeArray = new JSONArray();
        JSONArray linkArray = new JSONArray();
        JSONObject nodeJson = new JSONObject();
        JSONObject linkJson = new JSONObject();

        // 存入部门信息
        Integer companyId = UserUtils.getCurrentUser().getCompanyId();
        Company company = companySersvice.queryById(companyId);
        nodeJson.put("id", company.getId());
        nodeJson.put("name", company.getName());
        nodeJson.put("category", 0);
        nodeJson.put("value", 60);
        nodeJson.put("num", num);
        nodeArray.add(nodeJson);

        // 存入系统信息
        Systems systems = new Systems();
        systems.setCompanyId(companyId);
        List<Systems> systemList = systemService.queryListByWhere(systems);
        if (systemList.size() > 0) {
            for (Systems s : systemList) {
                nodeJson.put("id", s.getId());
                nodeJson.put("name", s.getNameCn());
                nodeJson.put("category", 1);
                nodeJson.put("value", 55);
                nodeJson.put("num", ++num);
                nodeArray.add(nodeJson);
                linkJson.put("source", 0);
                linkJson.put("target", num);
                linkArray.add(linkJson);
                
                //存入信息资源
                Information infor=new Information();
                infor.setSystemId(s.getId());
                List<Information> infoList=informationService.queryListByWhere(infor);
                if (infoList.size()>0) {
                    num1=num;
                    for (Information i : infoList) {
                        nodeJson.put("id", i.getId());
                        nodeJson.put("name", i.getNameCn());
                        nodeJson.put("category", 2);
                        nodeJson.put("value", 45);
                        nodeJson.put("num", ++num);
                        nodeArray.add(nodeJson);
                        linkJson.put("source", num1);
                        linkJson.put("target", num);
                        linkArray.add(linkJson);
                        
                        //存入数据元
                       List<Element> eleList=elementService.queryList(i.getId());
                       if (eleList.size() > 0) {
                           int num2=num;
                           for (Element e : eleList) {
                              /* System.out.println("eNameCn="+e.getNameCn());*/
                               nodeJson.put("id", e.getId());
                               nodeJson.put("name", e.getNameCn());
                               nodeJson.put("category", 3);
                               nodeJson.put("value", 40);
                               nodeJson.put("num", ++num);
                               nodeArray.add(nodeJson);
                               linkJson.put("source", num2);
                               linkJson.put("target", num);
                               linkArray.add(linkJson);
                        }
                      }
                    }
                }
            }
        }

        resultJson.put("node", nodeArray);
        resultJson.put("link", linkArray);

        return ResponseEntity.ok(resultJson);
    }
}

