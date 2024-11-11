package com.birdie.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SR002MT {
	private String appSrId;		// 승인된 요청id
	private String srId;		// 요청 id 
	private String deptId;		// 부서 id
	private String wkType;		// 업무구분
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trgStDt;		// 목표시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date trgEndDt;		// 목표완료일
	
	private String rvwCont;		// 검토내용
	private String srType;		// 요청 구분(개선, 신규, 오류, 기타)
	private String mgr;			// 담당자(사번)
	private String rcpStat;		// 접수상태(접수, 취소, 보류)
	
	private String deltYn;		// 삭제여부
	private Date firstInptDt;	// 최초입력일시
	private String firstInptId;	// 최초등록자
	private Date lastInptDt;	// 수정일시
	private String lastInptId;	// 수정입력자

	
	private String relSys;		// sr001 - 관련 시스템
	private String sysNm;		// cd - 관련 시스템 이름
	private String srTitle;		// sr001 - sr제목
	private String srCont;		// sr001 - sr내용
	private String instNm;		// is001 - 기관이름
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")	
	private Date reqDt;			// sr001 - 완료요청일
	@DateTimeFormat(pattern = "yyyy-MM-dd")		
	private Date dueDt;			// sr001 - 완료예정일
	
	private String srStat;		// sr001 - 진행상태
	private String taskType;	// TB_SR_001NT(진척율) - TASK_TYPE 컬럼
	private String memNm;		// 회원(담당자) 이름
	
	private String rnum;
}
