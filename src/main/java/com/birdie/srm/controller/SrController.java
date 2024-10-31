package com.birdie.srm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;
import com.birdie.srm.service.SrService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("sr")
@Slf4j
public class SrController {
	@Autowired
	private SrService srService;

	// SR 목록을 조회하는 메서드
	/**
	 * 검색 조건과 페이징 정보를 바탕으로 SR 목록을 조회하여 뷰에 전달하는 메서드
	 * 
	 * @param search       검색 조건을 담은 객체로, SR 목록을 필터링하는 데 사용
	 * @param pageNo       현재 페이지 번호로, 기본값은 1이며 페이지 이동 시 해당 페이지의 SR 목록을 조회
	 * @param rowsPerPage  한 페이지에 표시할 항목 수로, 기본값은 10입니다.
	 * @param model        뷰에 데이터를 전달하기 위한 Model 객체로, SR 목록과 시스템 목록, 검색 조건 및 페이징 데이터를 포함하여 뷰로 전달
	 * @return             "sr/srList" 뷰 페이지로 이동하여 SR 목록을 출력
	 */
	@RequestMapping("/list") 
	public String srList(SearchDto search, @RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="10")int rowsPerPage, Model model){
		// 페이징처리를 위해 검색된 내용이 몇개인지 DB에서 확인
		int rows = srService.countSearchedSr(search);
		// Pager 설정
		PagerDto pager = new PagerDto(rowsPerPage, 5, rows, pageNo);
		// SearchDto와 PagerDto를 동시에 보내기 위해 Map 생성
		Map<String,Object> searchCont = new HashMap<String,Object>();
		log.info("Rows:" +rows);

		searchCont.put("search", search);
		searchCont.put("pager", pager);
		log.info("SR 목록");
		
		List<SR001MTDao> srList = srService.SearchSr(searchCont);
		List<CDMT> sysList = srService.searchRelSys("SYS");
		model.addAttribute("sysList", sysList);
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);
		return "sr/srList";
	}
	
	//SR을 등록하는 메서드 
	/**
	 * 전달된 SR 데이터를 기반으로 SR을 등록하고, SR 목록 페이지로 리디렉션하는 메서드
	 * 
	 * @param sr001Dto 등록할 SR 정보를 담은 객체로, SR의 주요 필드들이 포함
	 * @return         SR 목록 페이지로 리디렉션하여 등록된 SR을 확인
	 */
	@PostMapping("/registerSr")
	public String srRegister(SR001MT sr001Dto) {	
		srService.registerSr(sr001Dto);
		
		return "redirect:/sr/list";
	}
	
	//SR의 상세 정보를 조회하여 JSP 페이지에 전달하는 메서드
	/**
	 * 주어진 SR ID를 기준으로 SR 상세 정보를 조회하여 JSP 페이지에 전달하는 메서드
	 * 
	 * @param srId      상세 정보를 조회할 SR의 ID로, 해당 ID를 가진 SR 데이터를 조회하는 데 사용
	 * @param response  클라이언트에게 응답을 전송하기 위한 HttpServletResponse 객체로, JSP 페이지를 포함
	 * @param request   JSP 페이지에 데이터(Attribute)를 전달하기 위한 HttpServletRequest 객체로, SR 정보와 시스템 목록을 설정
	 * @throws Exception 데이터 조회 및 JSP 응답 처리 중 발생할 수 있는 예외를 처리
	 */
	@PostMapping("/srDetail")
	public void srDetail(String srId, HttpServletResponse response, HttpServletRequest request) throws Exception{
		// srId가 일치하는 데이터 가져오기
		SR001MT srDetail = srService.searchDetail(srId);
		//관련시스템 목록 가져오기
		List<CDMT> sysList = srService.searchRelSys("SYS");
		//response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/sr/srDetail.jsp";
		//요청에  값 설정
		request.setAttribute("srDetail", srDetail);
		request.setAttribute("sysList", sysList);
		
		// response 타입설정 및 요청에 request와 response 설정
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl); 
        dispatcher.include(request, response);
		
		log.info("srId : "+ srId);
		
	}
	
	//SR을 삭제하는 메서드
	@PostMapping("/srDelete")
	public String srDelete(SR001MT sr001Dto) {
		srService.deleteSr(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	//SR을 요청하는 메서드
	@PostMapping("/srAppReq")
	public String srAppReq(SR001MT sr001Dto) {
		log.info("접수요청");
		srService.srAppReq(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	//SR을 처리하는 메서드
	@PostMapping("/srProcess")
	public String srProcess(SR001MT sr001Dto) {
		log.info("처리(관리자)");
		srService.srProcess(sr001Dto);
		return "redirect:/sr/list";
	}
	
	//SR을 수정하는 메서드
	@PostMapping("/srUpdate")
	public String srUpdate(SR001MT sr001mt) {
		log.info("수정(저장)");
		srService.updateSr(sr001mt);
		return "redirect:/sr/list";
	}
}