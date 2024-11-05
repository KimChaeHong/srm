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
	// SR 목록 전체 조회
	public List<SR002MT> getSrAll(PagerDto pager);			
	//페이징 처리된 검색조건에 맞는 List<SR002MT> 조회
	public List<SR002MT> getSearchedSr(Map<String, Object> searchCont);	
	// 검색 결과 행 개수 조회
	public int countRows(SearchDto searchDto);
	// TB_SR_002MT에 데이터 insert
	public void insertAppSr(SR001MT sr001mt);
	// appSrId와 일치하는 TB_SR_002MT 데이터 조회
	public SR002MT selectPlan(String appSrId);
	// appSrId와 일치하는 TB_SR_002MT 상세정보 데이터 조회
	public SR002MT selectDetailInfo(String appSrId);
}