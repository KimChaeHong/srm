package com.birdie.srm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.CDMTDao;
import com.birdie.srm.dao.SR002MTDao;
import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SrProgressService {
	@Autowired
	private SR002MTDao sr002mtDao;
	@Autowired
	private CDMTDao cmdtDao;
	
/*	// 승인된 SR 전체 목록 조회
	public List<SR002MT> getSrAll(PagerDto pager){
		List<SR002MT> srList = sr002mtDao.getSrAll(pager);	//List타입으로 승인된 SR전체 조회
		return srList;
	}*/
	
	// 검색 (검색정보, 페이지정보)
	public List<SR002MT> getSearchedSr(Map<String, Object> searchCont){	// 검색 기능 처리 메소드
		List<SR002MT> srList = sr002mtDao.getSearchedSr(searchCont);
		return srList;
	}
	
	// 검색 조건을 처리한 행 반환
	public int countRows(SearchDto searchDto) {
		int rows = sr002mtDao.countRows(searchDto);
		return rows;
	}
	
	/* 검색 기능 - 코드 테이블 그룹Id 반환 */
	public List<CDMT> getCDMTByGroupId(String groupId){
		List<CDMT> sysList = cmdtDao.selectByGroupId(groupId);
		return sysList;
	}
	
	/*SR계획정보 - appSrId와 일치하는 데이터 모든 값 가져오기*/
	public SR002MT getSrPlan(String appSrId) {
		SR002MT srPlan = sr002mtDao.selectSrPlan(appSrId);
		return srPlan;
	}

	/*SR계획정보 저장*/
	public void updateSrPlan(SR002MT sr002mt) {
		log.info("서비스 - SR계획정보 업데이트");
		sr002mtDao.updateSrPlan(sr002mt);
	}

	// APP_SR 상세정보 가져오기
	public SR002MT getDetail(String appSrId) {
		SR002MT appSrDetail = sr002mtDao.selectDetailInfo(appSrId);
		return appSrDetail;
	}

	// 담당자 조회
	public List<MB001MT> getMgr() {
		List<MB001MT> mgrList = sr002mtDao.selectMgr();
		return mgrList;
	}
	
	// 담당자 검색 
	public List<MB001MT> getSearchMgr(MB001MT mb001mt) {
		List<MB001MT> searchMgrList = sr002mtDao.selectSearchMgr(mb001mt);
		return searchMgrList;
	}

	
}
