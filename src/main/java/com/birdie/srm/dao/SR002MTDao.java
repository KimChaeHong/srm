package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SR002NT;
import com.birdie.srm.dto.SearchDto;

@Mapper
public interface SR002MTDao {

	// SR 목록 전체 조회
	public List<SR002MT> getSrAll(PagerDto pager);

	// 페이징 처리된 검색조건에 맞는 List<SR002MT> 조회
	public List<SR002MT> getSearchedSr(Map<String, Object> searchCont);

	// 검색 결과 행 개수 조회
	public int countRows(SearchDto searchDto);

	// TB_SR_002MT에 데이터 insert
	public void insertAppSr(SR001MT sr001mt);

	// appSrId와 일치하는 TB_SR_002MT 데이터 조회
	public SR002MT selectSrPlan(String appSrId);

	// SR계획정보 저장
	public int updateSrPlan(SR002MT sr002mt);

	// appSrId와 일치하는 TB_SR_002MT 상세정보 데이터 조회
	public SR002MT selectDetailInfo(String appSrId);

	// SR계획정보 - 담당자 전체 조회
	public List<MB001MT> selectMgr();

	// SR계획정보 - 담당자 검색 조회
	public List<MB001MT> selectSearchMgr(MB001MT mb001mt);
	
	// srId가 일치하는 appSrId 가져오기
	public String selectAppSrId(String srId);

	
}