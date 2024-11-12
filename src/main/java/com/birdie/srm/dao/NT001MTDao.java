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
	
}
