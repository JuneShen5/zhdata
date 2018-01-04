package com.govmade.zhdata.common.persistence;

public class Message {

    private Integer status; // 返回状态码

    private String message; // 返回信息

    public Message() {

    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    
}
