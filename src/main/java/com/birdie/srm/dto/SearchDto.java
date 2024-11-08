package com.birdie.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SearchDto {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;					// 시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;					// 종료일
	private String relSys;		// 관련 시스템
	private String srStat;		// SR 진행상태(등록, 요청, 반려, 접수, 재검토)
	private String instId;		// 기관
	private String dDept;		// 부서
	private String keyword;		// 키워드
	private String wkType;		// 업무구분
	private String tkType;		// 작업구분 진행상태(분석, 설계, 구현, 시험, 반영요청, 운영반영)
	private String rcpStat;		// 접수상태(접수, 취소, 보류)
	private String searchKey;	// 제목, SR번호 선택값
	private String name;		// 사람 이름
	private String content;		// SR내용
}


