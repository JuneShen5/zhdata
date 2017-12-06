/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.govmade.zhdata.module.sys.pojo;

import java.util.Date;
import java.util.Map;

import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;

import com.govmade.zhdata.common.persistence.BasePo;
import com.govmade.zhdata.common.utils.StringUtil;

/**
 * 日志Entity
 * @author ThinkGem
 * @version 2014-8-19
 */

@Table(name = "sys_log")
public class Log extends BasePo<Log> {

	private static final long serialVersionUID = 1L;
	private String type; 		// 日志类型（1：接入日志；2：错误日志）
	private String title;		// 日志标题
	private String remoteAddr; 	// 操作用户的IP地址
	private String requestUri; 	// 操作的URI
	private String method; 		// 操作的方式
	private String paramse; 		// 操作提交的数据
	private String userAgent;	// 操作用户代理信息
	private String exception; 	// 异常信息
	@Transient
	private String userName;
	
	private Date beginDate;		// 开始日期
	private Date endDate;		// 结束日期
	
	// 日志类型（1：接入日志；2：错误日志）
	public static final String TYPE_ACCESS = "1";
	public static final String TYPE_EXCEPTION = "2";
	
	public Log(){
		super();
	}
	
	public Log(Integer id){
            super(id);
    }
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRemoteAddr() {
		return remoteAddr;
	}

	public void setRemoteAddr(String remoteAddr) {
		this.remoteAddr = remoteAddr;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public String getRequestUri() {
		return requestUri;
	}

	public void setRequestUri(String requestUri) {
		this.requestUri = requestUri;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getParamse() {
		return paramse;
	}

	public void setParamse(String paramse) {
		this.paramse = paramse;
	}
	
	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	/**
	 * 设置请求参数
	 * @param paramMap
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void setParams(Map paramMap){
		if (paramMap == null){
			return;
		}
		StringBuilder params = new StringBuilder();
		for (Map.Entry<String, String[]> param : ((Map<String, String[]>)paramMap).entrySet()){
			params.append(("".equals(params.toString()) ? "" : "&") + param.getKey() + "=");
			String paramValue = (param.getValue() != null && param.getValue().length > 0 ? param.getValue()[0] : "");
			params.append(StringUtil.abbr(StringUtil.endsWithIgnoreCase(param.getKey(), "password") ? "" : paramValue, 100));
		}
		this.paramse = params.toString();
	}
	
	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this);
	}
}