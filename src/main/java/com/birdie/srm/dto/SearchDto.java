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
	private String srStat;		// 진행상태
	private String instId;
	private String dDept;
	private String keyword;		// 키워드
	private String wkType;		// 업무구분
	private String rcpStat;		// 접수상태(접수, 취소, 보류)
	
/*	public void makeNull() {
		if("".equals(this.keyword)) {
			this.keyword = null;
		}
		if("".equals(this.relSys)) {
			this.relSys = null;
		}
		if("".equals(this.srStat)) {
			this.srStat = null;
		}
		if("".equals(this.instId)) {
			this.instId = null;
		}
		if("".equals(this.rcpStat)) {
			this.rcpStat = null;
		}
		if("".equals(this.wkType)) {
			this.wkType = null;
		}
	}*/
}
