package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;

@Mapper
public interface MB001MTDao {
	
	// 회원 정보 가져오기
	public MB001MT selectByMemId(String memId);
	
	// 회원 가입 하기
	public int signUp(MB001MT member);

	// 기관명까지 Join 된 회원 정보 가져오기
	public MB001MT selectJoinedMemInfo(String memId);

	// 전체 사용자 목록 페이징 처리해서 가져오기
	public List<MB001MT> selectMemberList(PagerDto pager);

	// 전체 사용자 목록 행 갯수 가져오기
	public int selectCountMemRows();

	// 승인 받기 전 사용자 목록 페이징 처리해서 가져오기
	public List<MB001MT> selectMemberRequestList(PagerDto pager);

	// 회원 정보 수정하기
	public void updateMember(MB001MT member);
	
}
