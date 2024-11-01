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

	//
	public List<SR001MT> getMySrList(PagerDto pager) {
		List<SR001MT> mySrList = sr001mt.selectMysrList(pager);
		return mySrList;
	}

}
