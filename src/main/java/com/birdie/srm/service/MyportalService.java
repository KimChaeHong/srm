package com.birdie.srm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.NT001MTDao;
import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dto.NT001MT;
import com.birdie.srm.dao.SR002MTDao;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Slf4j
public class MyportalService {

	@Autowired
	private SR001MTDao sr001mtDao;
	@Autowired
	private NT001MTDao nt001mtDao;

	@Autowired
	private SR002MTDao sr002mtDao;

	// 전체 게시물 갯수
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

	// 로그인한 사용자별 상태별 SR 갯수 가져오기
	public Map<String, Integer> getStatusCounts(String memberInfo) {
	    Map<String, Integer> counts = new HashMap<>();
	    counts.put("ALL", sr001mtDao.selectCountRowsByUser(memberInfo)); // 전체
	    counts.put("REQT", sr001mtDao.selectCountRowsByStatusAndUser("REQT", memberInfo));
	    counts.put("REGI", sr001mtDao.selectCountRowsByStatusAndUser("REGI", memberInfo));
	    counts.put("REJC", sr001mtDao.selectCountRowsByStatusAndUser("REJC", memberInfo));
	    counts.put("RECE", sr001mtDao.selectCountRowsByStatusAndUser("RECE", memberInfo));
	    counts.put("DEVING", sr001mtDao.selectCountRowsByStatusAndUser("DEVING", memberInfo));
	    counts.put("DEVDONE", sr001mtDao.selectCountRowsByStatusAndUser("DEVDONE", memberInfo));
	    return counts;
	}
	
	// 사용자별 총 행 수 가져오기
	public int getTotalRowsByUser(String memNo) {
		return sr001mtDao.selectCountRowsByUser(memNo);
	}

    // 사용자별 SR 목록 가져오기
	public List<SR001MT> getMySrListByUser(String memNo, PagerDto pager) {
	    return sr001mtDao.selectMysrListByUser(memNo, pager);
	}
	
	// 특정 상태의 사용자별 총 행 수 가져오기
	public int getTotalRowsByStatusAndUser(String srStat, String memberInfo) {
	    return "ALL".equals(srStat) ? 
	           sr001mtDao.selectCountRowsByUser(memberInfo) : 
	           sr001mtDao.selectCountRowsByStatusAndUser(srStat, memberInfo);
	}
	
    // 특정 상태의 사용자별 SR 목록 가져오기
	public List<SR001MT> getMySrListByStatusAndUser(PagerDto pager, String srStat, String memNo) {
	    return sr001mtDao.selectMysrListByStatusAndUser(pager, srStat, memNo);

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
	
	
	
	
	
	
	

	// 공지사항 조회
	public List<NT001MT> getNotices() {
		List<NT001MT> noticeList = nt001mtDao.selectNoticeAll();
		return noticeList;
	}

	// 공지사항 등록
	public void saveNotice(NT001MT notice) {
		nt001mtDao.insertNotice(notice);
	}
	
	// id로 공지사항 정보 가져옴
	public NT001MT getNotice(int noticeId) {
		NT001MT noticeDto = nt001mtDao.selectNotice(noticeId);
		log.info("서비스 호출");
		return noticeDto;
	}
	
	// 공지사항 수정
	public void updateNotice(NT001MT noticeDto) {
		nt001mtDao.updateNotice(noticeDto);
	}
	
	// 공지사항 삭제
	public void deleteNotice(int noticeId) {
		nt001mtDao.deleteNotice(noticeId);
	}

	
	

}
