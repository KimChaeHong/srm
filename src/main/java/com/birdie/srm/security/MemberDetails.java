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
				// DeltYn이 "N"이고 AppYn이 "Y"일 때만 계정 활성화
				 "N".equals(member.getDeltYn()) && "Y".equals(member.getAppYn()),
				true, true, true, authorities
				);
		this.member = member;
		
	}

	public MB001MT getUserDto() {
		return member;
	}
}
