package com.birdie.srm.security;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.birdie.srm.dto.MB001MT;

public class MemberDetails extends User{
	
	private MB001MT member;
	
	public MemberDetails(
			MB001MT member,
			List<GrantedAuthority> authorities) {
		super(
				member.getMemId(), 
				member.getMemPw(), 
				 "Y".equals(member.getDeltYn()), // "Y"일 때 계정 활성화
				true, true, true, authorities
				);
		this.member = member;
		
	}

	public MB001MT getUserDto() {
		return member;
	}
}
