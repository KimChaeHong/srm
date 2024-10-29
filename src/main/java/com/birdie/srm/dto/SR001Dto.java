package com.birdie.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SR001Dto {
	private String srId;
	private String srTitle;
	private Date reqDt;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dueDt;
	
	private String srCont;
	private String relSys;
	private String srStat;
	private Date firstInptDt;
	private String firstInptId;
	private Date lastInptDt;
	private String lastInptId;
	
	private int rnum;
}
