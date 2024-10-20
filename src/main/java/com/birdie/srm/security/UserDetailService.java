package com.birdie.srm.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.birdie.srm.dao.MemberDao;
import com.birdie.srm.dto.MemberDto;

public class UserDetailService implements UserDetailsService{
	@Autowired
	private MemberDao memberDao;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberDto member = memberDao.selectByMemId(username);
		
		if(member==null) {
			throw new UsernameNotFoundException("bad username");
		}
		
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority(member.getRole1()));
		
		UserDetails userDetails = new CustomUserDetails(member, authorities);
		
		return userDetails;
	}
	
}
