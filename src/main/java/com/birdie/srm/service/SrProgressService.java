package com.birdie.srm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR002Dao;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002Dto;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SrProgressService {
	@Autowired
	private SR002Dao sr002Dao;
	
	// 승인된 SR 전체 목록 조회
	public List<SR002Dto> getSrAll(PagerDto pager){
		List<SR002Dto> srList = sr002Dao.getSrAll(pager);	//List타입으로 승인된 SR전체 조회
		return srList;
	}
	/* 
	public List<SR002Dto> getSrAll(PagerDto pager){
		Map<String, Object> searchPager = new HashMap<>();
		searchPager.put("pager", pager);
		searchPager.put("search", search);
		
		List<SR002Dto> srList = sr002Dao.selectAll(pager);	//List타입으로 전체 조회
		return srList;
	}*/
	
	public List<SR002Dto> getSearchedSr(Map<String, Object> searchPager){	// 검색 기능 처리 메소드
		List<SR002Dto> srList = sr002Dao.getSearchedSr(searchPager);
		return srList;
	}
	
	public int getTotalRows() {		// 페이징 - 전체 행 개수
		int totalRows = sr002Dao.countRows();
		return totalRows;
	}
	
	
}
