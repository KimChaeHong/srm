package com.birdie.srm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.security.MemberDetails;
import com.birdie.srm.service.MyportalService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("myportal")
@Slf4j
public class MyportalController {
	@Autowired
	private MyportalService myPortalService;

	// 나의 할 일 목록 보기
	@GetMapping("mytask")
	public String mySrList(
			Authentication authentication,  // 로그인 사용자 정보 가져오기
			Model model, 
			@RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) Integer rowsPerPage, 
			HttpSession session) {
		
		// 로그인한 사용자 아이디 가져오기
	    MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
	    String memberInfo = memberDetails.getUsername(); // Member 객체에서 사용자 ID 가져오기

		// 세션에서 rowsPerPage 값을 가져오거나 기본값 설정
		if (rowsPerPage == null) {
			rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
			if (rowsPerPage == null) {
				rowsPerPage = 16; // 기본값 설정
			}
		} else {
			session.setAttribute("rowsPerPage", rowsPerPage); // 변경된 값을 세션에 저장
		}

		// 사용자별 총 행 수 가져오기
	    int totalRows = myPortalService.getTotalRowsByUser(memberInfo);
	    PagerDto pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
	    session.setAttribute("pager", pager);

	    // 사용자별 SR 목록 가져오기
	    List<SR001MT> mySrList = myPortalService.getMySrListByUser(memberInfo, pager);
	    model.addAttribute("mySrList", mySrList);

		return "myportal/mytask";
	}
	
	// 특정 상태의 SR 목록 가져오기 (AJAX 요청)
	@GetMapping("/mytaskFragment")
	public String getMySrListByStatus(
	        Authentication authentication,
	        @RequestParam("srStat") String srStat,
	        @RequestParam(defaultValue = "1") int pageNo,
	        @RequestParam(required = false) Integer rowsPerPage,
	        Model model,
	        HttpSession session) {

	    // 로그인한 사용자 아이디 가져오기
	    MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
	    String memberInfo = memberDetails.getUsername();

	    // 세션에서 rowsPerPage 값을 가져오거나 기본값 설정
	    if (rowsPerPage == null) {
	        rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
	        if (rowsPerPage == null) {
	            rowsPerPage = 16; // 기본값 설정
	        }
	    } else {
	        session.setAttribute("rowsPerPage", rowsPerPage); // 변경된 값을 세션에 저장
	    }

	    int totalRows;
	    List<SR001MT> mySrList;
	    PagerDto pager;

	    if ("ALL".equals(srStat)) { // 전체 목록 조회
	        totalRows = myPortalService.getTotalRowsByUser(memberInfo);
	        pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
	        mySrList = myPortalService.getMySrListByUser(memberInfo, pager);
	    } else { // 특정 상태 조회
	        totalRows = myPortalService.getTotalRowsByStatusAndUser(srStat, memberInfo);
	        pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
	        mySrList = myPortalService.getMySrListByStatusAndUser(pager, srStat, memberInfo);
	    }

	    session.setAttribute("pager", pager);
	    model.addAttribute("mySrList", mySrList);

	    return "myportal/mytaskFragment";
	}

	
	@GetMapping("/pagination")
	public String getPagination(
	        Authentication authentication,
	        @RequestParam("srStat") String srStat,
	        @RequestParam(defaultValue = "1") int pageNo,
	        @RequestParam(required = false) Integer rowsPerPage,
	        Model model,
	        HttpSession session) {

	    MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
	    String memberInfo = memberDetails.getUsername();

	    if (rowsPerPage == null) {
	        rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
	        if (rowsPerPage == null) {
	            rowsPerPage = 16;
	        }
	    } else {
	        session.setAttribute("rowsPerPage", rowsPerPage);
	    }

	    // 전체 목록 또는 특정 상태의 목록을 가져오기 위한 조건 처리
	    int totalRows = "ALL".equals(srStat) ? 
	                    myPortalService.getTotalRowsByUser(memberInfo) : 
	                    myPortalService.getTotalRowsByStatusAndUser(srStat, memberInfo);
	                  
	    PagerDto pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);

	    model.addAttribute("pager", pager);

	    return "myportal/pagination";
	}
	
	// 상태별 SR 행 갯수 반환 (AJAX 요청)
	@GetMapping("/countStatus")
	public ResponseEntity<Map<String, Integer>> getStatusCounts(Authentication authentication) {
	    MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
	    String memberInfo = memberDetails.getUsername();
	    
	    Map<String, Integer> statusCounts = myPortalService.getStatusCounts(memberInfo);
	    return ResponseEntity.ok(statusCounts);
	}

}
