package com.birdie.srm.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SearchDto {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String relSys;
	private String srStat;
	private String instId;
	private String dDept;
	private String keyword;
	
	public void makeNull() {
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
	}
}
