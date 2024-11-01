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
	/**
	 * @파일명 MyportalController.java
	 * @Method Name  : mySrList
	 * @작성일   : 2024. 11. 1. 오전 9:17:14
	 * @Method 설명  : 세션에 저장된 rowsPerPage 값을 사용해 사용자가 요청한 페이지 번호에 따라 SR 리스트를 조회하고,
	 *                페이징 정보를 포함하여 뷰에 전달합니다. rowsPerPage 값이 지정되지 않은 경우 기본값을 세팅하며,
	 *                사용자가 변경할 때마다 세션에 저장합니다.
	 * @param model         뷰에 전달할 데이터를 저장하는 모델 객체
	 * @param pageNo        요청한 페이지 번호, 기본값은 1
	 * @param rowsPerPage   페이지당 표시할 행 수, 세션에 저장된 값 또는 기본값을 사용
	 * @param session       세션 객체로, rowsPerPage와 페이징 정보를 저장
	 * @return              myportal/mytask 뷰 이름
	 */
	@GetMapping("mytask")
	public String mySrList(Model model, @RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) Integer rowsPerPage, HttpSession session) {

		// 세션에서 rowsPerPage 값을 가져오거나 기본값 설정
		if (rowsPerPage == null) {
			rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
			if (rowsPerPage == null) {
				rowsPerPage = 10; // 기본값 설정
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
}
