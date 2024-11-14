package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.NT001MT;

@Mapper
public interface NT001MTDao {
	// 공지사항 조회
	public List<NT001MT> selectNoticeAll();
	
	// 공지사항 등록
	public void insertNotice(NT001MT notice);
	
	// id로 공지사항 정보 가져옴
	public NT001MT selectNotice(int noticeId);

	// 공지사항 업데이트
	public int updateNotice(NT001MT noticeDto);

	// 공지사항 삭제
	public int deleteNotice(int noticeId);
	
}
