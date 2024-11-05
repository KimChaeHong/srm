package com.birdie.srm.dto;

import lombok.Data;

@Data
public class SR004NT {
	private String attachId; 	//첨부파일 ID
	private String srId;		//SR_ID
	private String attachOName;	//첨부파일  원본 이름
	private String attachType;	//첨부파일 Type
	private byte[] attachData;	//첨부파일 내용
	private int attachOrder;	//첨부파일 순서
}
