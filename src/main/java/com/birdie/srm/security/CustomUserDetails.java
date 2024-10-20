package com.birdie.srm.security;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.birdie.srm.dto.MemberDto;

public class CustomUserDetails extends User{
	private MemberDto member;
	
	public CustomUserDetails(
			MemberDto member,
			List<GrantedAuthority> authorities) {
		super(
				member.getMemId(), 
				member.getMemPw(), 
				member.isDeltYn(),
				true, true, true, authorities
				);
		this.member = member;
		
	}


}
