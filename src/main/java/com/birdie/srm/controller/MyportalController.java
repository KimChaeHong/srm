package com.birdie.srm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
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
			Model model, 
			@RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) Integer rowsPerPage, 
			HttpSession session) {

		// 세션에서 rowsPerPage 값을 가져오거나 기본값 설정
		if (rowsPerPage == null) {
			rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
			if (rowsPerPage == null) {
				rowsPerPage = 16; // 기본값 설정
			}
		} else {
			session.setAttribute("rowsPerPage", rowsPerPage); // 변경된 값을 세션에 저장
		}

		int totalRows = myPortalService.getTotalRows();
		PagerDto pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);

		List<SR001MT> mySrList = myPortalService.getMySrList(pager);
		model.addAttribute("mySrList", mySrList);

		return "myportal/mytask";
	}
	
	// 특정 상태의 SR 목록 가져오기 (AJAX 요청)
	@GetMapping("/mytaskFragment")
	public String getMySrListByStatus(
	        @RequestParam("srStat") String srStat,
	        @RequestParam(defaultValue = "1") int pageNo,
	        @RequestParam(required = false) Integer rowsPerPage,
	        Model model,
	        HttpSession session) {

	    // 세션에서 rowsPerPage 값을 가져오거나 기본값 설정
	    if (rowsPerPage == null) {
	        rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
	        if (rowsPerPage == null) {
	            rowsPerPage = 16; // 기본값 설정
	        }
	    } else {
	        session.setAttribute("rowsPerPage", rowsPerPage); // 변경된 값을 세션에 저장
	    }

	    List<SR001MT> mySrList;
	    int totalRows;
	    PagerDto pager;

	    if ("ALL".equals(srStat)) { // srStat이 "ALL"일 경우 전체 목록을 조회
	        totalRows = myPortalService.getTotalRows();
	        mySrList = myPortalService.getMySrList(new PagerDto(rowsPerPage, 5, totalRows, pageNo));
	    } else { // 특정 상태 조회
	        totalRows = myPortalService.getTotalRowsByStatus(srStat);
	        mySrList = myPortalService.getMySrListByStatus(new PagerDto(rowsPerPage, 5, totalRows, pageNo), srStat);
	    }
	    
	    pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
	    session.setAttribute("pager", pager);
	    model.addAttribute("mySrList", mySrList);

	    return "myportal/mytaskFragment";
	}
	
	@GetMapping("/pagination")
	public String getPagination(
	        @RequestParam("srStat") String srStat,
	        @RequestParam(defaultValue = "1") int pageNo,
	        @RequestParam(required = false) Integer rowsPerPage,
	        Model model,
	        HttpSession session) {

	    if (rowsPerPage == null) {
	        rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
	        if (rowsPerPage == null) {
	            rowsPerPage = 16;
	        }
	    } else {
	        session.setAttribute("rowsPerPage", rowsPerPage);
	    }

	    int totalRows = "ALL".equals(srStat) ? myPortalService.getTotalRows() : myPortalService.getTotalRowsByStatus(srStat);
	    PagerDto pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);

	    model.addAttribute("pager", pager);

	    return "myportal/pagination"; // pagination.jsp로 반환
	
	

}
