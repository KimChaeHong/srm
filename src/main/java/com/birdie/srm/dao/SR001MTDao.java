package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;
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
	public int deleteSr(String srId);

	// srId와 일치하는 데이터의 SR_STAT 을 REQT 로 update
	public int updateSrREQT(String srId);

	// srId와 일치하는 데이터의 모든 내용을 수정한 내용으로 update
	public int updateSr(SR001MT sr001mt);

	// srId와 일치하는 데이터 승인,반려,재검토 처리(관리자)
	public int updateSrProcess(SR001MT sr001mt);

	// 전체 SR 목록 행 갯수 가져오기
	public int selectCountRows();

	// 나의 할 일 전체 목록 가져오기
	public List<SR001MT> selectMysrList(PagerDto pager);
	
    // 특정 상태의 SR 목록 행 갯수 가져오기
	public int selectCountRowsByStatus(@Param("srStat") String srStat);

	// 특정 상태의 SR 목록 가져오기
	public List<SR001MT> selectMysrListByStatus(@Param("pager") PagerDto pager, @Param("srStat") String srStat);
	
	//방금 등록한 SR의 SR_ID를 가져오기
	public String selectSrId(String memNo);

	// 사용자에 따른 SR 행 갯수 가져오기
 	public int selectCountRowsByUser(@Param("memNo") String memberInfo);

 	// 사용자에 따른 나의 할 일 전체 목록 가져오기
	public  List<SR001MT> selectMysrListByUser(@Param("memNo") String memNo, @Param("pager") PagerDto pager);

	// 특정 상태의 사용자 별 총 행 수 가져오기
	public int selectCountRowsByStatusAndUser(@Param("srStat") String srStat, @Param("memNo") String memNo);

	// 특정 상태의 사용자별 SR 목록 가져오기
	public List<SR001MT> selectMysrListByStatusAndUser(@Param("pager") PagerDto pager, @Param("srStat") String srStat, @Param("memNo") String memNo);

	// 관리자의 나의 할 일 전체 목록 가져오기
	public List<SR001MT> selectAppsrListByUser(@Param("memNo") String memNo, @Param("pager") PagerDto pager);

    // 관리자용 전체 SR 행 수 가져오기
	public int selectCountManagerRows(@Param("memNo") String memberInfo);
    
	// 관리자용 SR 목록 가져오기
	public List<SR001MT> selectManagerSrList(@Param("memNo") String memNo, @Param("pager") PagerDto pager);
	
	// 관리자용 특정 상태별 총 행 수 조회
    public int selectCountManagerRowsByStatus(@Param("srStat") String srStat, @Param("memNo") String memNo);

    // 관리자용 특정 상태별 SR 목록 조회
    public List<SR001MT> selectManagerSrListByStatus(@Param("pager") PagerDto pager, @Param("srStat") String srStat, @Param("memNo") String memNo);

	
	
}
