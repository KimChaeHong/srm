package com.birdie.srm.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.birdie.srm.dao.CDMTDao;
import com.birdie.srm.dao.SR001NTDao;
import com.birdie.srm.dao.SR002MTDao;
import com.birdie.srm.dao.SR002NTDao;
import com.birdie.srm.dao.SR003NTDao;
import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.SR001NT;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SR002NT;
import com.birdie.srm.dto.SR003NT;
import com.birdie.srm.dto.SearchDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SrProgressService {
	@Autowired
	private SR002MTDao sr002mtDao;
	@Autowired
	private CDMTDao cmdtDao;
	@Autowired
	private SR002NTDao sr002ntDao;
	@Autowired
	private SR001NTDao sr001ntDao;
	@Autowired
	private SR003NTDao sr003ntDao;
	
/*	// 승인된 SR 전체 목록 조회
	public List<SR002MT> getSrAll(PagerDto pager){
		List<SR002MT> srList = sr002mtDao.getSrAll(pager);	//List타입으로 승인된 SR전체 조회
		return srList;
	}*/
	
	// 검색 (검색정보, 페이지정보)
	public List<SR002MT> getSearchedSr(Map<String, Object> searchCont){	// 검색 기능 처리 메소드
		List<SR002MT> srList = sr002mtDao.getSearchedSr(searchCont);
		return srList;
	}
	
	// 검색 조건을 처리한 행 반환
	public int countRows(SearchDto searchDto) {
		int rows = sr002mtDao.countRows(searchDto);
		return rows;
	}
	
	/* 검색 기능 - 코드 테이블 그룹Id 반환 */
	public List<CDMT> getCDMTByGroupId(String groupId){
		List<CDMT> sysList = cmdtDao.selectByGroupId(groupId);
		return sysList;
	}
	
	/*SR계획정보 - appSrId와 일치하는 데이터 모든 값 가져오기*/
	public SR002MT getSrPlan(String appSrId) {
		SR002MT srPlan = sr002mtDao.selectSrPlan(appSrId);
		return srPlan;
	}

	/*SR계획정보 저장*/
	public void updateSrPlan(SR002MT sr002mt) {
		sr002mtDao.updateSrPlan(sr002mt);
	}

	// APP_SR 상세정보 가져오기
	public SR002MT getDetail(String appSrId) {
		SR002MT appSrDetail = sr002mtDao.selectDetailInfo(appSrId);
		return appSrDetail;
	}

	// 담당자 조회
	public List<MB001MT> getMgr() {
		List<MB001MT> mgrList = sr002mtDao.selectMgr();
		return mgrList;
	}
	
	// 담당자 검색 
	public List<MB001MT> getSearchMgr(MB001MT mb001mt) {
		List<MB001MT> searchMgrList = sr002mtDao.selectSearchMgr(mb001mt);
		return searchMgrList;
	}

	// appSrId와 일치하는 자원 가져오기
	public List<SR001NT> getHrList(String appSrId) {
		List<SR001NT> hrList = sr001ntDao.selectHrList(appSrId);
		return hrList;
	}
	
	// appSrId와 일치하는 진척율 가져오기
	public List<SR002NT> getPrgRatioList(String appSrId) {
		List<SR002NT> prgRatioList = sr002ntDao.selectPrgRatio(appSrId);
		return prgRatioList;
	}
	
	//진척율 6개 업데이트
	public int updatePrgRatio(List<SR002NT> sr002ntList) {
		int cntUpdate = 0;
		for(SR002NT sr002nt : sr002ntList) {
			cntUpdate += sr002ntDao.updatePrgRatio(sr002nt);			
		}
		return cntUpdate;
	}

	// 자원 리스트 저장
    public void saveHrList(String appSrId, List<SR001NT> hrList) {
        for (SR001NT hr : hrList) {
        	hr.setAppSrId(appSrId);

            if (sr001ntDao.exists(hr) > 0) {
                sr001ntDao.updateHr(hr);	// 존재하면 업데이트
            } else {
                sr001ntDao.insertHr(hr);	// 없으면 인서트
            }
        }
    }
    // 자원 삭제
	public void deleteHr(List<SR001NT> hrList) {
		for (SR001NT hr : hrList) {
			sr001ntDao.deleteHr(hr);
		}
	}

	// 날짜별 작업 시간 리스트 가져오기
	public List<List<SR003NT>> getWkhourList(MB001MT memInfo, List<Date> dayList) {
	    List<SR002MT> assignedSrList = sr002mtDao.selectAssignedSrId(memInfo);
	    List<List<SR003NT>> wkListList = new ArrayList<>();

	    for (SR002MT assignedSr : assignedSrList) {
	        Map<String, Object> dtoMap = new HashMap<>();
	        dtoMap.put("memId", memInfo.getMemId());
	        dtoMap.put("appSrId", assignedSr.getAppSrId());
	        dtoMap.put("dates", dayList);

	        // MyBatis로 데이터 조회
	        List<SR003NT> wkhourList = sr003ntDao.selectWkhour(dtoMap);

	        for (Date date : dayList) {
	            SR003NT dto = new SR003NT(memInfo.getMemId(), assignedSr.getAppSrId(), date);

	            // Integer로 반환받고 null 체크
	            Integer exists = sr003ntDao.existsWkhour(dto);
	            if (exists == null || exists == 0) { // null 또는 0일 경우 데이터 삽입
	                SR003NT newRecord = new SR003NT();
	                newRecord.setMemId(memInfo.getMemId());
	                newRecord.setAppSrId(assignedSr.getAppSrId());
	                newRecord.setWkDt(date);
	                sr003ntDao.insertWkhour(newRecord);
	            }
	        }
	        wkListList.add(wkhourList);
	    }
	    return wkListList;
	}

	public List<SR002MT> getAssignedSrIdList(MB001MT memInfo) {
		List<SR002MT> assignedSrList = sr002mtDao.selectAssignedSrId(memInfo);
		return assignedSrList;
	}

	public int updateWkhour(List<SR003NT> dataList) {
        int updateCount = 0;
        for (SR003NT sr003nt : dataList) {
            updateCount += sr003ntDao.updateWkhour(sr003nt); // 업데이트된 행 수 누적
        }
        return updateCount; // 전체 업데이트된 행 수 반환
    }

	
}
