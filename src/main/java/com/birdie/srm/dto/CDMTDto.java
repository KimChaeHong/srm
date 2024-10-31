package com.birdie.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CDMTDto {
	
	private String cdId;
	private String cdGroupId;
	private String cdNm;
	private String useYn;
	
	private String deltYn;
	private Date firstInptDt;
	private String firstInptId;
	private Date lastInptDt;
	private String lastInptId;
	
}
