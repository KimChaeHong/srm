package com.birdie.srm.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR001Dao;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001Dto;

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

	public List<SR001Dto> getSrList(PagerDto pager) {
		List<SR001Dto> srList = sr001Dao.getSrList(pager);
		return srList;
	}

	public List<SR001Dto> getSearchedSr(Map<String, Object> searchCont) {
		List<SR001Dto> srList = sr001Dao.getSearchedSr(searchCont);
		return srList;
	}
	
}
