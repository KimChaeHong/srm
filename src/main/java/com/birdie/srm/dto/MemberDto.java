package com.birdie.srm.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDto {
	
	private String memId;          // 사용자 ID
    private String deptId;         // 부서 ID
    private String memNo;          // 사번
    private String memNm;          // 사용자 이름
    private String memPw;          // 사용자 비밀번호
    private String role1;          // 역할1
    private String role2;          // 역할2
    private boolean deltYn;         // 삭제 여부
    private String firstInptId;    // 최초등록자
    private Date  firstInptDt;    // 최초등록일시
    private String lastInptId;     // 수정입력자
    private Date  lastInptDt;     // 수정일시

}
