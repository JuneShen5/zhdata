package com.govmade.zhdata.module.drs.pojo;

import javax.persistence.Table;
import javax.persistence.Transient;

import com.govmade.zhdata.common.persistence.BasePo;

@Table(name = "drs_computer_room")
public class ComputerRoom extends BasePo<ComputerRoom> {

    private static final long serialVersionUID = 1L;

    private Integer companyId;
    
    @Transient
    private String companyName;
    
    private String name;
    
    private String info;
    

    public ComputerRoom() {
        super();
    }


    public Integer getCompanyId() {
        return companyId;
    }


    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }


    public String getInfo() {
        return info;
    }


    public void setInfo(String info) {
        this.info = info;
    }


    public String getCompanyName() {
        return companyName;
    }


    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }


    public String getName() {
        return name;
    }


    public void setName(String name) {
        this.name = name;
    }

    

}
