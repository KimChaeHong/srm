package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;

@Mapper
public interface SR001MTDao {
	// SR insert
	public void insertSr(SR001MT sr001Dto);
	
	//페이징 처리된 검색조건에 맞는 List<SR001MT> 조회
	public List<SR001MTDao> selectSearchedSr(Map<String, Object> searchCont);

	// 검색조건에 맞는 행의 개수 조회
	public int selectSearchedRows(SearchDto search); 

	// srId와 일치하는 TB_SR_001MT의 데이터 조회
	public SR001MT selectDetail(String srId);

	// srId와 일치하는 데이터의 DEL_YN 을 Y로 update
	public void deleteSr(String srId);

	// srId와 일치하는 데이터의 SR_STAT 을 REQT 로 update
	public void updateSrREQT(String srId);

	// srId와 일치하는 데이터의 모든 내용을 수정한 내용으로 update
	public void updateSr(SR001MT sr001mt);

	// srId와 일치하는 데이터 승인,반려,재검토 처리(관리자)
	public void updateSrProcess(SR001MT sr001mt);
  
    // 나의 할 일 목록 가져오기
	public List<SR001MT> selectMysrList(PagerDto pager);

	// SR 목록 행 갯수 가져오기
	public int selectCountRows();

	// 특정 상태에 따른 목록 조회
    public List<SR001MT> selectMySrListByStatus( String srStat,int startRowNo, int rowsPerPage);

}
