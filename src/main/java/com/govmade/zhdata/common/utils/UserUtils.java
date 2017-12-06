package com.govmade.zhdata.common.utils;

import java.util.UUID;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.govmade.zhdata.common.config.Global;
import com.govmade.zhdata.module.sys.pojo.User;

public class UserUtils {
  

    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }

    public static Session getSession() {
        try {
            Subject subject = SecurityUtils.getSubject();
            Session session = subject.getSession(false);
            if (session == null) {
                session = subject.getSession();
            }
            if (session != null) {
                return session;
            }
        } catch (InvalidSessionException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void setSession(String key, Object value) {
        getSession().setAttribute(key, value);
    }

    public static User getCurrentUser() {
        Session session = getSession();
        User user = (User) session.getAttribute(Global.SESSION_USER);
        return user;
    }
    
   
}
