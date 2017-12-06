/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.govmade.zhdata.common.utils;

import javax.servlet.http.HttpServletRequest;

import com.govmade.zhdata.module.sys.dao.LogDao;
import com.govmade.zhdata.module.sys.dao.MenuDao;
import com.govmade.zhdata.module.sys.pojo.Log;
import com.govmade.zhdata.module.sys.pojo.User;

/**
 * 字典工具类
 * @author ThinkGem
 * @version 2014-11-7
 */
public class LogUtils {
	
	public static final String CACHE_MENU_NAME_PATH_MAP = "menuNamePathMap";
	
	private static LogDao logDao = SpringContextHolder.getBean(LogDao.class);
	private static MenuDao menuDao = SpringContextHolder.getBean(MenuDao.class);
	
	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, String title){
		saveLog(request, null, null, title);
	}
	
	/**
	 * 保存日志
	 */
	public static void saveLog(HttpServletRequest request, Object handler, Exception ex, String title){
		User user = UserUtils.getCurrentUser();
		if (user != null && user.getId() != null){
			Log log = new Log();
			log.setTitle(title);
			log.setType(ex == null ? Log.TYPE_ACCESS : Log.TYPE_EXCEPTION);
			log.setRemoteAddr(StringUtil.getRemoteAddr(request));
			log.setUserAgent(request.getHeader("user-agent"));
			log.setRequestUri(request.getRequestURI());
			
            String uri = request.getRequestURI();
			
			int beginIndex =0;  
			int endIndex =0;  

			String mUri=uri.substring(1,uri.length()); 
			beginIndex = mUri.indexOf("/");  
			endIndex = mUri.lastIndexOf("/");  
			String href=mUri.substring(beginIndex,endIndex); 
			
			 
			title=menuDao.queryLogByUri(href);
			log.setTitle(title);
			
			log.setParams(request.getParameterMap());
			log.setMethod(request.getMethod());
			// 异步保存日志
			new SaveLogThread(log, handler, ex).start();
		}
	}

	/**
	 * 保存日志线程
	 */
	public static class SaveLogThread extends Thread{
		
		private Log log;
		private Object handler;
		private Exception ex;
		
		public SaveLogThread(Log log, Object handler, Exception ex){
			super(SaveLogThread.class.getSimpleName());
			this.log = log;
			this.handler = handler;
			this.ex = ex;
		}
		
		@Override
		public void run() {
			// 获取日志标题
			if (StringUtil.isBlank(log.getTitle())){
			    
				//TODO
				//log.setTitle("角色增加");
			}
			// 如果有异常，设置异常信息
			log.setException(Exceptions.getStackTraceAsString(ex));
			// 如果无标题并无异常日志，则不保存信息
			if (StringUtil.isBlank(log.getTitle()) && StringUtil.isBlank(log.getException())){
				return;
			}
			// 保存日志信息
			log.preInsert();
			logDao.insert(log);
		}
	}

	
	
}
