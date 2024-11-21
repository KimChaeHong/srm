package com.birdie.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class SR001NT {
	private String memId; 			// 회원 id
	private String appSrId;			// 승인된 SR_ID
	private int plnMd;				// 계획공수
	
	private String deltYn;			// 삭제여부
	private Date firstInptDt;		// 최초등록일
	private String firstInptId;		// 최초등록자
	private Date lastInptDt;		// 마지막 수정일
	private String lastInptId;		// 마지막 수정자
	
	private String memNm;			// 회원 이름 
    private String role2;          // 역할2(팀장, 팀원)
    private int rnum;				// 순서
	
    private String memNo;
}
