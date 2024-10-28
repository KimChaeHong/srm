package com.birdie.srm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR002Dao;
import com.birdie.srm.dto.SR002Dto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SrProgressService {
	@Autowired
	private SR002Dao sr002Dao;
	
	// 승인된 SR 전체 목록 조회
	public List<SR002Dto> getSrAll(){
		List<SR002Dto> srList = sr002Dao.selectAll();	//List타입으로 전체 조회
		log.info("ㅁㅁㅁㅁㅁ서비스 호출--------");
		log.info(srList.toString());
		return srList;
	}
	
	
}
