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

	//"나의 할 일" 목록 불러오기
	public List<SR001MT> getMySrList(PagerDto pager) {
		List<SR001MT> mySrList = sr001mt.selectMysrList(pager);
		return mySrList;
	}

	// 특정 상태에 따른 "나의 할 일" 목록 조회 (페이징 포함)
    public List<SR001MT> getMySrListByStatus(String srStat, PagerDto pager) {
        return sr001mt.selectMySrListByStatus(srStat, pager.getStartRowNo(), pager.getRowsPerPage());
    }
}
