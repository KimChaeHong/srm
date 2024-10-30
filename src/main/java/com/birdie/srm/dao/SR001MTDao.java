package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;

@Mapper
public interface SR001MTDao {
	// SR insert
	public void insertSr(SR001MT sr001Dto);
	
	//페이징 처리된 검색조건에 맞는 List<SR001MT> 조회
	public List<SR001MTDao> getSearchedSr(Map<String, Object> searchCont);

	// 검색조건에 맞는 행의 개수 조회
	public int getRows(SearchDto search); 

	// srId와 일치하는 TB_SR_001MT의 데이터 조회
	public SR001MT getDetail(String srId);

	// srId와 일치하는 데이터의 DEL_YN 을 Y로 update
	public void srDelete(String srId);

	// srId와 일치하는 데이터의 SR_STAT 을 REQT 로 update
	public void srAppReq(String srId);

	// srId와 일치하는 데이터의 모든 내용을 수정한 내용으로 update
	public void srUpdate(SR001MT sr001MT);

	//나의 할 일 목록 가져오기
	public List<SR001MT> selectMyList();

}
