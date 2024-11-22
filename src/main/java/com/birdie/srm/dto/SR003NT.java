package com.birdie.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class SR003NT {
	private Date wkDt;
	private String memId;
	private String appSrId;
	private double wkHour;
	
	private Date trgStDt;
	private Date trgEndDt;
	
	private String deltYn;
	private Date firstInptDt;
	private String firstInptId;
	private Date lastInptDt;
	private String lastInptId;
	
	public SR003NT() {
	}
	
	public SR003NT(String memId, String appSrId, Date wkDt) {
        this.memId = memId;
        this.appSrId = appSrId;
        this.wkDt = wkDt;
    }
}
