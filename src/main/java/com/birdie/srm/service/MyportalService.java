package com.birdie.srm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.NT001MTDao;
import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dao.SR002MTDao;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.NT001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;

import lombok.extern.slf4j.Slf4j;

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

	// 특정 상태 별 게시물 갯수
	public int getTotalRowsByStatus(String srStat) {
		return sr001mtDao.selectCountRowsByStatus(srStat); // 상태별 갯수 쿼리 호출
	}

	// 특정 상태의 SR 목록 가져오기
	public List<SR001MT> getMySrListByStatus(PagerDto pager, String srStat) {
		return sr001mtDao.selectMysrListByStatus(pager, srStat); // 상태별 목록 쿼리 호출
	}

	// 로그인한 사용자 또는 관리자의 상태별 SR 갯수 가져오기
	public Map<String, Integer> getStatusCounts(String memNo, String userRole1) {
		Map<String, Integer> counts = new HashMap<>();

		if ("ROLE_ADMI".equals(userRole1)) {
			// 관리자의 경우, 관리자 전용 쿼리 사용
			counts.put("ALL", sr001mtDao.selectCountManagerRows(memNo));
			counts.put("REQT", sr001mtDao.selectCountManagerRowsByStatus("REQT", memNo));
			counts.put("REGI", sr001mtDao.selectCountManagerRowsByStatus("REGI", memNo));
			counts.put("REJC", sr001mtDao.selectCountManagerRowsByStatus("REJC", memNo));
			counts.put("RERE", sr001mtDao.selectCountManagerRowsByStatus("RERE", memNo));
			counts.put("RECE", sr001mtDao.selectCountManagerRowsByStatus("RECE", memNo));
			counts.put("DEVING", sr001mtDao.selectCountManagerRowsByDevingAndUser("DEVING", memNo));
			counts.put("DEVDONE", sr001mtDao.selectCountManagerRowsByDevdoneAndUser("DEVDONE", memNo));
		} else {
			// 일반 사용자와 개발자의 경우
			counts.put("ALL", sr001mtDao.selectCountRowsByUser(memNo));
			counts.put("REQT", sr001mtDao.selectCountRowsByStatusAndUser("REQT", memNo));
			counts.put("REGI", sr001mtDao.selectCountRowsByStatusAndUser("REGI", memNo));
			counts.put("REJC", sr001mtDao.selectCountRowsByStatusAndUser("REJC", memNo));
			counts.put("RERE", sr001mtDao.selectCountRowsByStatusAndUser("RERE", memNo));
			counts.put("RECE", sr001mtDao.selectCountRowsByStatusAndUser("RECE", memNo));
			counts.put("DEVING", sr001mtDao.selectCountRowsByDevingAndUser("DEVING", memNo));
			counts.put("DEVDONE", sr001mtDao.selectCountRowsByDevdoneAndUser("DEVDONE", memNo));
		}

		return counts;
	}

	// 사용자 별 총 행 수 가져오기
	public int getTotalRowsByUser(String memNo) {
		return sr001mtDao.selectCountRowsByUser(memNo);
	}

	// 사용자 별 SR 목록 가져오기
	public List<SR001MT> getMySrListByUser(String memNo, PagerDto pager) {
		return sr001mtDao.selectMysrListByUser(memNo, pager);
	}

	// 특정 상태의 사용자 별 총 행 수 가져오기
	public int getTotalRowsByStatusAndUser(String srStat, String memberInfo) {
		;
		if ("ALL".equals(srStat)) {
			return sr001mtDao.selectCountRowsByUser(memberInfo);
		} else if ("DEVING".equals(srStat)) {
			return sr001mtDao.selectCountRowsByDevingAndUser(srStat, memberInfo);
		} else if ("DEVDONE".equals(srStat)) {
			return sr001mtDao.selectCountRowsByDevdoneAndUser(srStat, memberInfo);
		} else {
			return sr001mtDao.selectCountRowsByStatusAndUser(srStat, memberInfo);
		}
	}

	// 특정 상태의 사용자별 SR 목록 가져오기
	public List<SR001MT> getMySrListByStatusAndUser(PagerDto pager, String srStat, String memNo) {
		if ("ALL".equals(srStat)) {
			return sr001mtDao.selectMysrListByUser(memNo, pager);
		} else if ("DEVING".equals(srStat)) {
			return sr001mtDao.selectMysrListByDevingAndUser(pager, srStat, memNo);
		} else if ("DEVDONE".equals(srStat)) {
			return sr001mtDao.selectMysrListByDevdoneAndUser(pager, srStat, memNo);
		} else {
			return sr001mtDao.selectMysrListByStatusAndUser(pager, srStat, memNo);
		}
	}

	// 관리자용 전체 SR 행 수 가져오기
	public int getTotalManagerRows(String memNo) {
		return sr001mtDao.selectCountManagerRows(memNo);
	}

	// 관리자용 SR 목록 가져오기
	public List<SR001MT> getManagerSrList(String memNo, PagerDto pager) {
		return sr001mtDao.selectManagerSrList(memNo, pager);
	}

	// 특정 상태별 관리자 총 행 수 조회
	public int getTotalManagerRowsByStatus(String srStat, String memberInfo) {
		if ("ALL".equals(srStat)) {
			return sr001mtDao.selectCountManagerRows(memberInfo);
		} else if ("DEVING".equals(srStat)) {
			return sr001mtDao.selectCountManagerRowsByDevingAndUser(srStat, memberInfo);
		} else if ("DEVDONE".equals(srStat)) {
			return sr001mtDao.selectCountManagerRowsByDevdoneAndUser(srStat, memberInfo);
		} else {
			return sr001mtDao.selectCountManagerRowsByStatus(srStat, memberInfo);
		}
	}

	// 특정 상태별 관리자 SR 목록 조회
	public List<SR001MT> getManagerSrListByStatus(String srStat, String memberInfo, PagerDto pager) {
		if ("ALL".equals(srStat)) {
			return sr001mtDao.selectManagerSrList(memberInfo, pager);
		} else if ("DEVING".equals(srStat)) {
			return sr001mtDao.selectMangerSrListByDevingAndUser(pager, srStat, memberInfo);
		} else if ("DEVDONE".equals(srStat)) {
			return sr001mtDao.selectMangerSrListByDevdoneAndUser(pager, srStat, memberInfo);
		} else
			return sr001mtDao.selectManagerSrListByStatus(pager, srStat, memberInfo);

	}

	// 개발자 전체 SR 행 수 가져오기
	public int getTotalDeveloperRows(String memberNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 개발자 SR 목록 가져오기
	public List<SR001MT> getDeveloperSrList(String memberNo, PagerDto pager) {
		// TODO Auto-generated method stub
		return null;
	}

	// 특정 상태별 개발자 총 행 수 조회
	public int getTotalDeveloperRowsByStatus(String srStat, String memberNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 특정 상태별 개발자 SR 목록 조회
	public List<SR001MT> getDeveloperSrListByStatus(String srStat, String memberNo, PagerDto pager) {
		// TODO Auto-generated method stub
		return null;
	}

	/* 달력 */
	public List<SR002MT> getEvents(MB001MT mb001mt) {
		List<SR002MT> eventList = new ArrayList<>();
		switch (mb001mt.getRole1()) {
		case "ROLE_GUSR":
			eventList = sr002mtDao.selectGusrEvent(mb001mt);
			break;
		case "ROLE_DEVE":
			eventList = sr002mtDao.selectDeveEvent(mb001mt);
			break;
		case "ROLE_ADMI":
			eventList = sr002mtDao.selectAdmiEvent(mb001mt);
			break;
		default:
			log.info("역할이 안맞음");
		}
		return eventList;
	}

	public List<SR002MT> getProcessBarData(MB001MT mb001mt) {
		List<SR002MT> processBarDataList = new ArrayList<>();
		switch (mb001mt.getRole1()) {
		case "ROLE_GUSR":
			processBarDataList = sr002mtDao.selectGusrProcess(mb001mt);
			break;
		case "ROLE_DEVE":
			processBarDataList = sr002mtDao.selectDeveProcess(mb001mt);
			break;
		case "ROLE_ADMI":
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
