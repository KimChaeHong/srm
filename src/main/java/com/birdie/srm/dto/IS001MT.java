package com.birdie.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class IS001MT {
	private String instId;
	private String instNm;
	
	private String deltYn;
	private Date firstInptDt;
	private String firstInptId;
	private Date lastInptDt;
	private String lastInptId;
}
