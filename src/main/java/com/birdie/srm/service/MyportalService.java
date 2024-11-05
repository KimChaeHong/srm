package com.birdie.srm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;

@Service
public class MyportalService {
	
	@Autowired
	private SR001MTDao sr001mt;
	
	//전체 게시물 갯수
	public int getTotalRows() {
		int totalRows = sr001mt.selectCountRows();
		return totalRows;
	}

	// 처음 페이지 로드 시 전체 SR 목록 가져오기
	public List<SR001MT> getMySrList(PagerDto pager) {
		List<SR001MT> mySrList = sr001mt.selectMysrList(pager);
		return mySrList;
	}
	
	// 특정 상태별 게시물 갯수
	public int getTotalRowsByStatus(String srStat) {
	    return sr001mt.selectCountRowsByStatus(srStat); // 상태별 갯수 쿼리 호출
	}

	// 특정 상태의 SR 목록 가져오기
	public List<SR001MT> getMySrListByStatus(PagerDto pager, String srStat) {
	    return sr001mt.selectMysrListByStatus(pager, srStat); // 상태별 목록 쿼리 호출
	}



}
