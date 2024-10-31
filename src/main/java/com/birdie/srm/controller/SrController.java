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

	//SR관리 목록 (Pending Approval SR List)
	@RequestMapping("/list") 
	public String sRMngList(SearchDto search, @RequestParam(defaultValue="1") int pageNo,
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
/*		List<String> sysList = srService.searchRelSys();
		model.addAttribute("sysList", sysList);*/
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);
		return "sr/srList";
	}
	
	//SR 등록
	@PostMapping("/registerSr")
	public String registerSr(SR001MT sr001Dto) {	
		srService.registerSr(sr001Dto);
		
		return "redirect:/sr/list";
	}
	
	//SR 상세보기
	@PostMapping("/srDetail")
	public void srDetail(String srId, HttpServletResponse response, HttpServletRequest request) throws Exception{
		// srId가 일치하는 데이터 가져오기
		SR001MT srDetail = srService.searchDetail(srId);
		//response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/sr/srDetail.jsp";
		//jsp를 요청에  값 설정
		request.setAttribute("srDetail", srDetail);

		// response 타입설정 및 요청에 request와 response 설정
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl); 
        dispatcher.include(request, response);
		
		log.info("srId : "+ srId);
		
	}
	
	// SR 삭제
	@PostMapping("/srDelete")
	public String srDelete(SR001MT sr001Dto) {
		srService.deleteSr(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	// SR 접수요청
	@PostMapping("/srAppReq")
	public String srAppReq(SR001MT sr001Dto) {
		log.info("접수요청");
		srService.srAppReq(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	// SR 처리(관리자)
	@PostMapping("/srProcess")
	public String srProcess(SR001MT sr001Dto) {
		log.info("처리(관리자)");
		srService.srProcess(sr001Dto);
		return "redirect:/sr/list";
	}
	
	// SR 수정(업데이트)
	@PostMapping("/srUpdate")
	public String srUpdate(SR001MT sr001mt) {
		log.info("수정(저장)");
		srService.updateSr(sr001mt);
		return "redirect:/sr/list";
	}
}