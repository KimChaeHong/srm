package com.birdie.srm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR001Dao;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001Dto;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SrService {
	@Autowired
	private SR001Dao sr001Dao;
	
	public void insertSr(SR001Dto sr001Dto) {
		log.info("insertSr");
		sr001Dao.insertSr(sr001Dto);
	}

	public List<SR001Dto> getSearchedSr(Map<String, Object> searchCont) {
		List<SR001Dto> srList = sr001Dao.getSearchedSr(searchCont);
		return srList;
	}

	public int getRows(SearchDto search) {
		int Rows = sr001Dao.getRows(search);
		return Rows;
	}

	public SR001Dto getDetail(String srId) {
		SR001Dto srDetail = sr001Dao.getDetail(srId);
		return srDetail;
	}

	public void srDelete(String srId) {
		sr001Dao.srDelete(srId);
	}
	
	public void srAppReq(String srId) {
		sr001Dao.srAppReq(srId);
	}
}
