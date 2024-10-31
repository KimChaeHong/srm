package com.birdie.srm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.CDMTDao;
import com.birdie.srm.dao.SR002Dao;
import com.birdie.srm.dto.CDMTDto;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002Dto;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SrProgressService {
	@Autowired
	private SR002Dao sr002Dao;
	@Autowired
	private CDMTDao cmdtDao;
	
	// 승인된 SR 전체 목록 조회
	public List<SR002Dto> getSrAll(PagerDto pager){
		List<SR002Dto> srList = sr002Dao.getSrAll(pager);	//List타입으로 승인된 SR전체 조회
		return srList;
	}
	
	// 검색 (검색정보, 페이지정보)
	public List<SR002Dto> getSearchedSr(Map<String, Object> searchCont){	// 검색 기능 처리 메소드
		List<SR002Dto> srList = sr002Dao.getSearchedSr(searchCont);
		return srList;
	}
	
	// 검색 조건을 처리한 행 반환
	public int getRows(SearchDto searchDto) {
		int rows = sr002Dao.getRows(searchDto);
		return rows;
	}
	
	/* 검색 기능 - 코드 테이블 그룹Id 반환 */
	public List<CDMTDto> getCDMTByGroupId(String groupId){
		List<CDMTDto> listCDMTDto = cmdtDao.selectByGroupId(groupId);
		return listCDMTDto;
	}
	
}
