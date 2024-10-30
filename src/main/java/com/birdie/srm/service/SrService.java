package com.birdie.srm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SrService {
	@Autowired
	private SR001MTDao sr001Dao;
	
	public void insertSr(SR001MT sr001Dto) {
		log.info("insertSr");
		sr001Dao.insertSr(sr001Dto);
	}

	public List<SR001MTDao> getSearchedSr(Map<String, Object> searchCont) {
		List<SR001MTDao> srList = sr001Dao.getSearchedSr(searchCont);
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
