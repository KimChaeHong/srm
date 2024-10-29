package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002Dto;

@Mapper
public interface SR002Dao {
	
	public List<SR002Dto> getSrAll(PagerDto pager);			// SR 목록 전체 조회

	public List<SR002Dto> getSearchedSr(Map<String, Object> searchPager);	// 검색

	public int countRows();		// 전체 행 개수
	
}
