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
		/*search.makeNull();*/ // 빈 문자열로 받아진 검색내용들 null값으로 변경하는 메서드 (SearchDto에 만든 메서드)
		int Rows = srService.getRows(search); // 페이징처리를 위해 검색된 내용이 몇개인지 DB에서 확인
		log.info("Rows:" +Rows);
		PagerDto pager = new PagerDto(rowsPerPage, 5, Rows, pageNo); // Pager 설정
		Map<String,Object> searchCont = new HashMap<String,Object>(); // SearchDto와 PagerDto를 동시에 보내기 위해 Map 생성
		searchCont.put("search", search);
		searchCont.put("pager", pager);
		log.info("SR 목록");
		
		List<SR001MTDao> srList = srService.getSearchedSr(searchCont);
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);
		return "sr/srList";
	}
	
	//SR 등록
	@PostMapping("/registerSr")
	public String registerSr(SR001MT sr001Dto) {	
		srService.insertSr(sr001Dto);
		
		return "redirect:/sr/list";
	}
	
	//SR 상세보기
	@PostMapping("/srDetail")
	public void srDetail(String srId, HttpServletResponse response, HttpServletRequest request) throws Exception{
		// srId가 일치하는 데이터 가져오기
		SR001MT srDetail = srService.getDetail(srId);
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
		srService.srDelete(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	// SR 접수요청
	@PostMapping("/srAppReq")
	public String srAppReq(SR001MT sr001Dto) {
		log.info("접수요청");
		srService.srAppReq(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

}