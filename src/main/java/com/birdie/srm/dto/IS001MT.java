package com.birdie.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class IS001MT {
	private String instId;		//기관ID
	private String instNm;		//기관 이름
	
	private String deltYn;
	private Date firstInptDt;
	private String firstInptId;
	private Date lastInptDt;
	private String lastInptId;
}
