package com.govmade.zhdata.common.utils;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.HashMap;
import java.util.Map;

public class SessionListener implements HttpSessionListener,HttpSessionBindingListener{
	

	private static Map<Integer, String> sMap = new HashMap<Integer, String>();
	 
	@Override
	public void sessionCreated(HttpSessionEvent event) {
			
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent event) {          
		 getSmap().remove(event.getSession().getId());
	}     

    public static Map<Integer, String> InfoToMap(Integer memberID, Object object) {     	          
        sMap.put(memberID, (String) object);
		return sMap;   
	}
	
    public static String getTime(Integer memberId) {
    	String sTime=sMap.get(memberId);
    	return sTime;
    }	    
    
    public static void removeSession(String sessionID) {  
        getSmap().remove(sessionID);  
    }  
    
    private static Map<Integer, String> getSmap() {
		return sMap;
	}
	
	public static boolean containsKey(String key) {  
        return getSmap().containsKey(key);  
    }  
  
	@Override
	public void valueBound(HttpSessionBindingEvent arg0) {		
	}
	
	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {		
	}  
	
}
