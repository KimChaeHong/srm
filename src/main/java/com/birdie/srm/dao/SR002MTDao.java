package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;
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
	
	// 회원의 ROLE1에 따라서 이벤트 가져오기
	public List<SR002MT> selectGusrEvent(MB001MT mb001mt);
	public List<SR002MT> selectDeveEvent(MB001MT mb001mt);
	public List<SR002MT> selectAdmiEvent(MB001MT mb001mt);

	// 회원의 ROLE1에 따라서 진척율 가져오기
	public List<SR002MT> selectGusrProcess(MB001MT mb001mt);
	public List<SR002MT> selectDeveProcess(MB001MT mb001mt);
	public List<SR002MT> selectAdmiProcess(MB001MT mb001mt);

	// 사용자에 따른 승인 된 SR 행 갯수 가져오기
	public int selectAppCountRowsByUser(@Param("memNo") String memberInfo);

 	// 사용자에 따른 승인 된 나의 할 일 전체 목록 가져오기
	public List<SR002MT> selectAppsrListByUser(@Param("memNo") String memNo, @Param("pager") PagerDto pager);

	// 특정 상태의 사용자 별 승인 된 SR 총 행 수 가져오기
	public int selectAppCountRowsByStatusAndUser(@Param("srStat") String srStat, @Param("memNo") String memNo);

	// 특정 상태의 사용자 별 승인 된 SR 목록 가져오기
	public List<SR002MT> selectAppsrListByStatusAndUser(@Param("pager") PagerDto pager, @Param("srStat") String srStat, @Param("memNo") String memNo);
	
	//회원이 할당된 SR의 appSrId 목록 가져오기
	public List<SR002MT> selectAssignedSrId(MB001MT memInfo);
	
	// 개발자용 전체 SR 행 수 가져오기
    int selectCountDeveloperRows(@Param("memId") String memInfo);

    // 개발자용 SR 목록 가져오기
    List<SR002MT> selectDeveloperSrListByUser(@Param("memId") String memId, @Param("pager") PagerDto pager);

    // 개발자용 상태별 총 행 수 조회
    int selectCountDeveloperRowsByStatus(@Param("taskType") String taskType, @Param("memId") String memId);

    // 개발자용 특정 상태별 SR 목록 조회
    List<SR002MT> selectDeveloperSrListByStatus(@Param("pager") PagerDto pager, @Param("taskType") String taskType,  @Param("memId") String memId);
	
	
	

}