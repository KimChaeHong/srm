package com.birdie.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NT001MT {
	private int noticeId;			
	private String noticeTitle;		// 제목
	private String noticeContent;	// 내용
	private String memId;			// 회원id
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")	
	private Date firstInptDt;		// 최초입력일시
	@DateTimeFormat(pattern = "yyyy-MM-dd")	
	private Date lastInptDt;		// 수정일시
	private String deltYn;			// 삭제여부
	private String firstInptId;		// 최초등록자
	private String lastInptId;		// 수정입력자

}
