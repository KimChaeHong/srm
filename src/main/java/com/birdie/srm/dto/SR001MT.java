package com.birdie.srm.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SR001MT {
	private String srId;
	private String srTitle;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
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
	private String revCmt;
	
	private String registerName; // 등록자 이름
	private String institutionName; // 등록자 부서
	private String departmentName; // 등록자 부서
	
	private String instId;
	private String deptId; 
	
	private int rnum;
	private String memNm;
	private String instNm;
	
	private List<MultipartFile> attachment;
}
