package com.birdie.srm.dto;

import lombok.Data;

@Data
public class SR004NT {
	private int attachId;
	private String srId;
	private String attachOName;
	private String attachType;
	private byte[] attachData;
	private int attachOrder;
}
