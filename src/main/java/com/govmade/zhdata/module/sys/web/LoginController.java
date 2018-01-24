package com.govmade.zhdata.module.sys.web;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.utils.SessionListener;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.common.utils.VerifyCodeUtil;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.MenuService;

@Controller
@RequestMapping(value = "login")
public class LoginController {

    @Autowired
    private MenuService menuService;

    @RequestMapping(method = RequestMethod.GET)
    public String toLogin() {
        return "modules/sys/sysLogin";
    }

    @RequestMapping(method = RequestMethod.POST)
    public String login(User user, HttpServletRequest request) {
        try {

            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginName(), user.getPassword());
            token.setRememberMe(true);
            String vcode = request.getParameter("verifyCode");
            String verifyCode = subject.getSession().getAttribute(Global.SESSION_SECURITY_CODE).toString();

            if (vcode.equalsIgnoreCase(verifyCode)) {
                subject.login(token);
                subject.getSession().setTimeout(14400000);
                
            }
            
           String accountId=UserUtils.getCurrentUser().getId()+"";
            Date date=new Date();
            DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String time=format.format(date);
            request.getSession().setAttribute("accountId",accountId);
            request.getSession().setAttribute("time",time);
            if(accountId!=null&&accountId!=""){
                Integer accountid=Integer.parseInt(accountId);
                SessionListener.InfoToMap(accountid, time);
        }
        } catch (Exception e) {
            e.printStackTrace();
            return "modules/sys/sysLogin";
        }

        return "redirect:index";
    }

    /**
     * 生成登录验证码
     * 
     * @return
     */
    @RequestMapping(value = "verifyCode", method = RequestMethod.GET)
    public void verifyCode(HttpServletResponse response) {
        // 设置页面不缓存
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        // 为了手机客户端方便使用数字验证码
        String verifyCode = VerifyCodeUtil.generateTextCode(VerifyCodeUtil.TYPE_NUM_ONLY, 4, null);
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        session.setAttribute(Global.SESSION_SECURITY_CODE, verifyCode);
        try {
            // 设置输出的内容的类型为JPEG图像
            response.setContentType("image/jpeg");
            BufferedImage bufferedImage = VerifyCodeUtil.generateImageCode(verifyCode, 90, 30, 3, true,
                    Color.WHITE, Color.BLACK, null, null);
            // 写给浏览器
            ImageIO.write(bufferedImage, "JPEG", response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    
    /**
     * 用于测试
     * 
     * @param response
     * @return
     */
//    @RequestMapping(value = "verifyCodeNum", method = RequestMethod.GET)
//    public ResponseEntity<String>  verifyCodeNum(HttpServletResponse response) {
//        Subject currentUser = SecurityUtils.getSubject();
//        String verifyCode = currentUser.getSession().getAttribute(Global.SESSION_SECURITY_CODE).toString();
//        return ResponseEntity.ok(verifyCode);
//    }
    
    
    /**
     * 帐号注销 退出
     * 
     * @return
     */
    @RequestMapping("/system_logout")
    public static String logout(HttpServletRequest request, HttpSession session) {
        Subject currentUser = SecurityUtils.getSubject();
        currentUser.logout();
        session = request.getSession(true);
        session.removeAttribute(Global.SESSION_USER);
        /* session.removeAttribute(Const.SESSION_MENULIST); */
        /* return "redirect:loginIndex.html"; */
        return "modules/sys/sysLogin";
    }
}
