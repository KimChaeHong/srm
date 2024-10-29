package com.birdie.srm.security;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.birdie.srm.dto.MemberDto;

public class MemberDetails extends User{
	
	private MemberDto member;
	
	public MemberDetails(
			MemberDto member,
			List<GrantedAuthority> authorities) {
		super(
				member.getMemId(), 
				member.getMemPw(), 
				 "Y".equals(member.getDeltYn()), // "Y"일 때 계정 활성화
				true, true, true, authorities
				);
		this.member = member;
		
	}

	public MemberDto getUserDto() {
		return member;
	}
}
