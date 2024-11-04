package com.birdie.srm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.IS001MT;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;
import com.birdie.srm.service.MemberService;
import com.birdie.srm.service.SrService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("sr")
@Slf4j
public class SrController {
	@Autowired
	private SrService srService;
	@Autowired
	private MemberService memberService;

	//SR관리 목록
	@RequestMapping("/list") 
	public String srMngList(SearchDto search, @RequestParam(defaultValue="1") int pageNo, Authentication authentication,
			@RequestParam(defaultValue="10")int rowsPerPage, Model model){
		//로그인 된 회원의 MEM_ID를 통해 회원의 모든 정보 가져오기 (로그인 되어 있을 때에만 들어올 수 있도록 설정한 후에는 if 지울예정)
		if(authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());			
			model.addAttribute("memInfo", memInfo);
		}
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
		List<IS001MT> instList = srService.searchInst();
		model.addAttribute("sysList", sysList);
		model.addAttribute("instList", instList);
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);
		return "sr/srList";
	}
	
	//SR 등록
	@PostMapping("/registerSr")
	public String registerSr(SR001MT sr001, Authentication authentication) {	
		if(authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());			
			sr001.setFirstInptId(memInfo.getMemNo());
			sr001.setLastInptId(memInfo.getMemNo());
			sr001.setInstId(memInfo.getInstId());
		}		
		srService.registerSr(sr001);
		
		return "redirect:/sr/list";
	}
	
	//SR 상세보기
	@PostMapping("/srDetail")
	public void getSrDetail(String srId, HttpServletResponse response, HttpServletRequest request, Authentication authentication) throws Exception{
		//로그인 된 회원의 MEM_ID를 통해 회원의 모든 정보 가져오기 (로그인 되어 있을 때에만 들어올 수 있도록 설정한 후에는 if 지울예정)
		if(authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());			
			request.setAttribute("memInfo", memInfo);
		}
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
	
	// SR 삭제
	@PostMapping("/srDelete")
	public String deleteSr(SR001MT sr001Dto) {
		srService.deleteSr(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	// SR 접수요청
	@PostMapping("/srAppReq")
	public String appReqSr(SR001MT sr001Dto) {
		log.info("접수요청");
		srService.srAppReq(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	// SR 처리(관리자)
	@PostMapping("/srProcess")
	public String srProcess(SR001MT sr001Dto, Authentication authentication) {
		log.info("처리(관리자)");
		if(authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());
			sr001Dto.setLastInptId(memInfo.getMemNo());
		}
		srService.srProcess(sr001Dto);
		log.info(sr001Dto.getSrStat());
		log.info(sr001Dto.getSrId());
		if(sr001Dto.getSrStat().equals("RECE")) {
			srService.insertAppSr(sr001Dto);			
		}
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