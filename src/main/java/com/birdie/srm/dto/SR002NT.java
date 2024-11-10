package com.birdie.srm.dto;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SR002NT {
	private String taskType; 		// 업무구분
	private String appSrId;		// 승인된 SR_ID
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date stDt;			// 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDt;			// 마감일
	private Integer prg;				// 진척율
	
	private String deltYn;		// 삭제여부
	private Date firstInptDt;		// 최초등록일
	private String firstInptId;	// 최초등록자
	private Date lastInptDt;		// 마지막 수정일
	private String lastInptId;	// 마지막 수정자
	
	private int rnum;				// 순서
	private String taskTName;		//업무구분 이름
}
