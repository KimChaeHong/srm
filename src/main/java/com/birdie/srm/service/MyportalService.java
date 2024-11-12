package com.birdie.srm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dao.SR002MTDao;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyportalService {
	
	@Autowired
	private SR001MTDao sr001mtDao;
	@Autowired
	private SR002MTDao sr002mtDao;
	
	//전체 게시물 갯수
	public int getTotalRows() {
		int totalRows = sr001mtDao.selectCountRows();
		return totalRows;
	}

	// 처음 페이지 로드 시 전체 SR 목록 가져오기
	public List<SR001MT> getMySrList(PagerDto pager) {
		List<SR001MT> mySrList = sr001mtDao.selectMysrList(pager);
		return mySrList;
	}
	
	// 특정 상태별 게시물 갯수
	public int getTotalRowsByStatus(String srStat) {
	    return sr001mtDao.selectCountRowsByStatus(srStat); // 상태별 갯수 쿼리 호출
	}

	// 특정 상태의 SR 목록 가져오기
	public List<SR001MT> getMySrListByStatus(PagerDto pager, String srStat) {
	    return sr001mtDao.selectMysrListByStatus(pager, srStat); // 상태별 목록 쿼리 호출
	}

	// 전체 상태별 SR 갯수 가져오기
    public Map<String, Integer> getStatusCounts() {
        Map<String, Integer> counts = new HashMap<>();
        counts.put("ALL", sr001mtDao.selectCountRows()); // 전체
        counts.put("REQT", sr001mtDao.selectCountRowsByStatus("REQT"));
        counts.put("REGI", sr001mtDao.selectCountRowsByStatus("REGI"));
        counts.put("REJC", sr001mtDao.selectCountRowsByStatus("REJC"));
        counts.put("RECE", sr001mtDao.selectCountRowsByStatus("RECE"));
        counts.put("DEVING", sr001mtDao.selectCountRowsByStatus("DEVING"));
        counts.put("DEVDONE", sr001mtDao.selectCountRowsByStatus("DEVDONE"));
        return counts;
    }

	public List<SR002MT> getEvents(MB001MT mb001mt) {
		List<SR002MT> eventList = new ArrayList<>();
		switch(mb001mt.getRole1()) {
			case "ROLE_GUSR" :
				eventList = sr002mtDao.selectGusrEvent(mb001mt);
				break;
			case "ROLE_DEVE" :
				eventList = sr002mtDao.selectDeveEvent(mb001mt);
				break;
			case "ROLE_ADMI" :
				eventList = sr002mtDao.selectAdmiEvent(mb001mt);
				break;
			default:
				log.info("역할이 안맞음");
		}
		return eventList;
	}

	public List<SR002MT> getProcessBarData(MB001MT mb001mt) {
		List<SR002MT> processBarDataList = new ArrayList<>();
		switch(mb001mt.getRole1()) {
		case "ROLE_GUSR" :
			processBarDataList = sr002mtDao.selectGusrProcess(mb001mt);
			break;
		case "ROLE_DEVE" :
			processBarDataList = sr002mtDao.selectDeveProcess(mb001mt);
			break;
		case "ROLE_ADMI" :
			processBarDataList = sr002mtDao.selectAdmiProcess(mb001mt);
			break;
		default:
			log.info("유저정보 잘못 넘어옴");
		}
		return processBarDataList;
	}


}
