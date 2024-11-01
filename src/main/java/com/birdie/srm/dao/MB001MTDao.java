package com.birdie.srm.dao;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.MB001MT;

@Mapper
public interface MB001MTDao {
	
	//회원 정보 가져오기
	public MB001MT selectByMemId(String memId);
	
	//회원 가입 하기
	public int signUp(MB001MT member);

	//기관명까지 Join 된 회원 정보 가져오기
	public MB001MT selectJoinedMemInfo(String memId);

}
