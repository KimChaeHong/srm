package com.birdie.srm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.CDMTDao;
import com.birdie.srm.dao.IS001MTDao;
import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dao.SR002MTDao;
import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.IS001MT;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SrService {
	@Autowired
	private SR001MTDao sr001mtDao;
	@Autowired
	private SR002MTDao sr002mtDao;	
	@Autowired
	private CDMTDao cdmtDao;
	@Autowired
	private IS001MTDao is001mtDao;
	
	// SR 등록
	public void registerSr(SR001MT sr001Dto) {
		log.info("insertSr");
		sr001mtDao.insertSr(sr001Dto);
	}

	// 검색된 List<SR001MTDao>
	public List<SR001MTDao> SearchSr(Map<String, Object> searchCont) {
		List<SR001MTDao> srList = sr001mtDao.selectSearchedSr(searchCont);
		return srList;
	}
	
	// 검색된 데이터 개수
	public int countSearchedSr(SearchDto search) {
		int Rows = sr001mtDao.selectSearchedRows(search);
		return Rows;
	}
	
	// srId와 일치하는 데이터의 모든 값 가져오기
	public SR001MT searchDetail(String srId) {
		SR001MT srDetail = sr001mtDao.selectDetail(srId);
		return srDetail;
	}

	//srId와 일치하는 데이터 삭제
	public void deleteSr(String srId) {
		sr001mtDao.deleteSr(srId);
	}
	
	// srId와 일치하는 데이터 접수요청
	public void srAppReq(String srId) {
		sr001mtDao.updateSrREQT(srId);
	}

	// SR 승인/반려/재검토 처리(관리자)
	public void srProcess(SR001MT sr001mt) {
		// SR_STAT 변경
		log.info("SR_STAT처리");
		sr001mtDao.updateSrProcess(sr001mt);
	}

	// SR_STAT이 '접수'일때(승인되었을 때) TB_SR_002 테이블에 insert
	public void insertAppSr(SR001MT sr001mt) {
		log.info("TB_SR_002MT에 INSERT");
		sr002mtDao.insertSr(sr001mt);
	}
	
	// SR 수정
	public void updateSr(SR001MT sr001mt) {
		sr001mtDao.updateSr(sr001mt);
	}

	// 관련시스템 목록 가져오기
	public List<CDMT> searchRelSys(String groupId) {
		List<CDMT> sysList = cdmtDao.selectByGroupId(groupId);
		return sysList;
	}
	
	//기관 목록 가져오기
	public List<IS001MT> searchInst() {
		List<IS001MT> instList = is001mtDao.selectInstAll();
		return instList;
	}

}
