package com.govmade.zhdata.module.sys.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.govmade.zhdata.common.utils.MenuTreeUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.sys.pojo.Menu;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.MenuService;

@Controller
@RequestMapping(value = "index")
public class IndexController {

    @Autowired
    private MenuService menuService;

    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpServletRequest request,Model model) {

        List<Menu> menuList = menuService.selectByUserId(UserUtils.getCurrentUser().getId());
        
        User user = UserUtils.getCurrentUser();
        model.addAttribute("user", user);
        
        model.addAttribute("menuHtml", MenuTreeUtil.buildMenuHtml(request.getContextPath(), menuList));

        return "modules/sys/sysIndex";
    }
}
