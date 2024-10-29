package com.birdie.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SR002Dto {
	private String appSrId;		// 승인된 요청id
	private String srId;		// 요청 id 
	private String deptId;		// 부서 id
	private String wkType;		// 업무구분
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trgStDt;		// 목표 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trgEndDt;		// 목표 완료일
	
	private String rvwCont;
	private String srType;
	private String mgr;			// 담당자
	private String rcpStat;		// 접수상태(접수, 취소, 보류)
	
	private String deltYn;		// 삭제여부
	private Date firstInptDt;	// 최초입력일시
	private String firstInptId;	// 최초등록자
	private Date lastInptDt;	// 수정일시
	private String lastInptId;	// 수정입력자

	
	private String relSys;
	private String srTitle;
	private Date reqDt;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dueDt;
	
	private String srStat;
}
