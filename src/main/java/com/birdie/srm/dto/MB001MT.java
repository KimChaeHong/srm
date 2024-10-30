package com.birdie.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MB001MT {
	
	private String memId;          // 사용자 ID
    private String instId;         // 기관
    private String deptId;         // 부서
    private String memNo;          // 사번
    private String memNm;          // 사용자 이름
    private String memPw;          // 사용자 비밀번호
    private String memEmail;		// 사용자 이메일
    private String role1;          // 역할1
    private String role2;          // 역할2
    private String deltYn;         // 삭제 여부
    private String appYn;			// 승인 여부
    private String firstInptId;    // 최초등록자
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date  firstInptDt;    // 최초등록일시
    private String lastInptId;     // 수정입력자
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date  lastInptDt;     // 수정일시

}
