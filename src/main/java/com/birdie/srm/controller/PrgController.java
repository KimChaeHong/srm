package com.birdie.srm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SearchDto;
import com.birdie.srm.service.MemberService;
import com.birdie.srm.service.SrProgressService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/prg")
public class PrgController {

	@Autowired
	private SrProgressService srProgressService;
	@Autowired
	private MemberService memberService;
	
	// SR진척 검색창 - 업무구분 
	@GetMapping("/getWkTypeList") 
	public void getWkTypeList(HttpServletResponse response, String selectedCdId) throws IOException{
		String selectedCdGroupId = selectedCdId.substring(0,1) + "OPER";
		List<CDMT> listOper = srProgressService.getCDMTByGroupId(selectedCdGroupId);
		
		JSONArray jsonArray = new JSONArray(); //"[ {cdId:xxx, cdNm:yyy}, {...}, {...} ]"
		for(CDMT i : listOper) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("cdId", i.getCdId());
			jsonObject.put("cdNm", i.getCdNm());
			jsonArray.put(jsonObject);	
		}
		String json = jsonArray.toString();
		
		//응답 생성(헤더(contentType) + 본문 (데이터))
		response.setContentType("application/json; charset=utf-8");		//헤더(contentType)
		PrintWriter pw =  response.getWriter();		//본문(데이터)
		pw.println(json);
		pw.flush();
		pw.close(); 
	}
	
	// 전체 SR 목록 조회(+ 검색, 페이지 기능 추가)
	@GetMapping("/list") 
	public String srPrgList(
			SearchDto searchDto, 
			@RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="16") int rowsPerPage,
			Model model) {
		//관련시스템 목록 가져오기
		List<CDMT> listSys = srProgressService.getCDMTByGroupId("SYS");
		model.addAttribute("listSys", listSys);
		
		//디폴트 시스템 설정
		if(searchDto.getRelSys() == null) {
			searchDto.setRelSys("");
		} 
		if(!searchDto.getRelSys().equals("")) { 	
			//업무 목록 가져오기 
			String selectedCdGroupId = searchDto.getRelSys().substring(0,1) + "OPER";
			List<CDMT> listOper = srProgressService.getCDMTByGroupId(selectedCdGroupId);
			model.addAttribute("listOper", listOper);
		}
		
		//디폴트 업무구분 설정
		if(searchDto.getWkType() == null) searchDto.setWkType("");
		//디폴트 진행상태 설정
		if (searchDto.getTkType() == null) searchDto.setTkType("");
		//디폴트 접수상태 설정
		if (searchDto.getRcpStat() == null) searchDto.setRcpStat("");
		//디폴트 키워드(제목) 설정
		if (searchDto.getKeyword() == null) searchDto.setKeyword("");
		
		log.info(searchDto.toString());
		
		int rows = srProgressService.countRows(searchDto);			// jsp에서 받은 검색 정보를 가지고 그 검색 결과에 해당하는 행을 반환
		PagerDto pager = new PagerDto(rowsPerPage, 5, rows, pageNo);		// 반환된 행을 페이저 객체에 저장
		
		Map<String,Object> searchCont = new HashMap<String,Object>();	
		searchCont.put("searchDto", searchDto);
		searchCont.put("pager", pager);

		List<SR002MT> srList = srProgressService.getSearchedSr(searchCont);
		log.info(srList.toString());
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);
		
		return "prg/prgList";
	}
	
	// SR계획정보 조회
	@PostMapping("/srPlan")
	public void srPlan(
			String appSrId, 
			HttpServletResponse response, 
			HttpServletRequest request) throws Exception{
		SR002MT srPlan = srProgressService.getSrPlan(appSrId);
		//response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/prg/srPlan.jsp";
		request.setAttribute("srPlan", srPlan);
		
		// response 타입설정 및 요청에 request와 response 설정
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl); 
        dispatcher.include(request, response);
        log.info("appSrId : " + appSrId);
	}
	// SR계획정보 저장
	@PostMapping("/updateSrPlan")
	public void updateSrPlan(
	        SR002MT sr002mt, 
	        Authentication authentication, 
	        HttpServletResponse response) throws Exception {
	    log.info("컨트롤러 1 - SR계획정보 업데이트");

	    // 로그인 했을 경우 담당자 사번 설정
	    if (authentication != null) {
	        MB001MT memInfo = memberService.getUserInfo(authentication.getName());
	        sr002mt.setMgr(memInfo.getMemNo());
	    }
	    srProgressService.updateSrPlan(sr002mt);
	    log.info("컨트롤러 2 - SR계획정보 업데이트 완료");

	    response.setContentType("text/plain; charset=UTF-8");
	    response.getWriter().write("SR 계획 정보가 성공적으로 업데이트되었습니다!");
	}


	/*@PostMapping("/updateSrPlan")
	public String registerSrPlan(SR002MT sr002mt, Authentication authentication) {
		log.info("컨트롤러 1 - SR계획정보 업데이트");
		if (authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());
			sr002mt.setMgr(memInfo.getMemNo());	// 담당자 사번 설정
		}
		srProgressService.updateSrPlan(sr002mt);
		log.info("컨트롤러 2 - SR계획정보 업데이트");
		return "redirect:/prg/list";
	}*/
}
