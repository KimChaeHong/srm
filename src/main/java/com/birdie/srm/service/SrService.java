package com.birdie.srm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SrService {
	@Autowired
	private SR001MTDao sr001mtDao;
	
	public void registerSr(SR001MT sr001Dto) {
		log.info("insertSr");
		sr001mtDao.insertSr(sr001Dto);
	}

	public List<SR001MTDao> SearchSr(Map<String, Object> searchCont) {
		List<SR001MTDao> srList = sr001mtDao.selectSearchedSr(searchCont);
		return srList;
	}

	public int countSearchedSr(SearchDto search) {
		int Rows = sr001mtDao.selectSearchedRows(search);
		return Rows;
	}

	public SR001MT searchDetail(String srId) {
		SR001MT srDetail = sr001mtDao.selectDetail(srId);
		return srDetail;
	}

	public void deleteSr(String srId) {
		sr001mtDao.deleteSr(srId);
	}
	
	public void srAppReq(String srId) {
		sr001mtDao.updateSrREQT(srId);
	}

	public void srProcess(SR001MT sr001mt) {
		sr001mtDao.updateSrProcess(sr001mt);		
	}

	public void updateSr(SR001MT sr001mt) {
		sr001mtDao.updateSr(sr001mt);
	}

}
