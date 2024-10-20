package com.birdie.srm.dao;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.MemberDto;

@Mapper
public interface MemberDao {
	
	//회원 정보 가져오기
	public MemberDto selectByMemId(String memId);

}
