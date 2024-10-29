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
	private String progs;
	private String nInst;
	private String dDept;
	private String keyword;
	
	public void makeNull() {
		if("".equals(this.relSys)) {
			this.relSys = null;
		}
		if("".equals(this.progs)) {
			this.progs = null;
		}
		if("".equals(this.nInst)) {
			this.nInst = null;
		}
	}
}
