package com.govmade.zhdata.module.sys.security;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.common.utils.CipherUtil;
import com.govmade.zhdata.common.utils.StringUtil;
import com.govmade.zhdata.common.utils.UserUtils;
import com.govmade.zhdata.module.sys.pojo.User;
import com.govmade.zhdata.module.sys.service.UserService;

/**
 * 
 */
public class ShiroRealm extends AuthorizingRealm {

    /**
     * 账户类服务层注入
     */
    @Autowired
    private UserService userService;

    /**
     * 登录验证与Session记录
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) {
        // 令牌——基于用户名和密码的令牌
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;

        // 令牌中可以取出用户名
        String username = token.getUsername();
        String password = String.valueOf(token.getPassword());

        // 让shiro框架去验证账号密码
        if (!StringUtil.isEmpty(username)) {

            User record = new User();
            record.setLoginName(username);
            
            User user = userService.queryOne(record);
            
            if (null != user) {
                String pwdEncrypt = CipherUtil.createPwdEncrypt(password, user.getSalt()); 
                if (user.getPassword().equals(pwdEncrypt)) {
                    AuthenticationInfo info = new SimpleAuthenticationInfo(user.getLoginName(), password,
                            user.getName());
                    if (info != null) {
                        UserUtils.setSession(Global.SESSION_USER, user);
                    }
                    return info;
                } else {
                    throw new IncorrectCredentialsException(); /* 错误认证异常 */
                }
            } else {
                throw new UnknownAccountException(); /* 找不到帐号异常 */
            }
        } else {
            throw new AuthenticationException();
        }
    }

    /*
     * 授权查询回调函数, 进行鉴权但缓存中无用户的授权信息时调用,负责在应用程序中决定用户的访问控制的方法(non-Javadoc)
     * 
     * @see org.apache.shiro.realm.AuthorizingRealm#doGetAuthorizationInfo(org.apache.shiro.subject.
     * PrincipalCollection)
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection pc) {


       // 1、subject.hasRole(“admin”) 或 subject.isPermitted(“admin”)：自己去调用这个是否有什么角色或者是否有什么权限的时候；
       // 2、@RequiresRoles("admin") ：在方法上加注解的时候；
       // 3、[@shiro.hasPermission name = "admin"][/@shiro.hasPermission]：在页面上加shiro标签的时候，即进这个页面的时候扫描到有这个标签的时候。
        
       /* 
        System.out.println("授权-------------------");*/
        if (!SecurityUtils.getSubject().isAuthenticated()) {
            doClearCache(pc);
            SecurityUtils.getSubject().logout();
            return null;
        }
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        return info;
    }
}
