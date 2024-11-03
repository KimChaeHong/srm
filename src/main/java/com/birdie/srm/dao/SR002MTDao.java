package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SearchDto;

@Mapper
public interface SR002MTDao {
	
	public List<SR002MT> getSrAll(PagerDto pager);			// SR 목록 전체 조회

	public List<SR002MT> getSearchedSr(Map<String, Object> searchCont);	// 검색

	public int countRows(SearchDto searchDto);		// 검색 결과 행 

	public void insertAppSr(SR001MT sr001mt); // TB_SR_002MT에 데이터 insert
	
}