package com.birdie.srm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001NT;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SR002NT;
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
	public void getWkTypeList(HttpServletResponse response, String selectedCdId) throws IOException {
		String selectedCdGroupId = selectedCdId.substring(0, 1) + "OPER";
		List<CDMT> listOper = srProgressService.getCDMTByGroupId(selectedCdGroupId);

		JSONArray jsonArray = new JSONArray(); // "[ {cdId:xxx, cdNm:yyy}, {...}, {...} ]"
		for (CDMT i : listOper) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("cdId", i.getCdId());
			jsonObject.put("cdNm", i.getCdNm());
			jsonArray.put(jsonObject);
		}
		String json = jsonArray.toString();

		// 응답 생성(헤더(contentType) + 본문 (데이터))
		response.setContentType("application/json; charset=utf-8"); // 헤더(contentType)
		PrintWriter pw = response.getWriter(); // 본문(데이터)
		pw.println(json);
		pw.flush();
		pw.close();
	}

	// 전체 SR 목록 조회(+ 검색, 페이지 기능 추가)
	@GetMapping("/list")
	public String srPrgList(SearchDto searchDto, @RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(defaultValue = "10") int rowsPerPage, Model model, Authentication authentication,
			@RequestParam(defaultValue = "false") boolean onlyMySr) {
		// 관련시스템 목록 가져오기
		List<CDMT> listSys = srProgressService.getCDMTByGroupId("SYS");
		model.addAttribute("listSys", listSys);
		// SR에 등록할 담당자 정보 가져오기
		List<MB001MT> mgrs = srProgressService.getMgr();
		model.addAttribute("mgrs", mgrs);

		// 로그인 사용자 정보 설정
	    if (authentication != null) {
	        MB001MT memInfo = memberService.getUserInfo(authentication.getName());
	        model.addAttribute("memInfo", memInfo);

	        // 내가 담당한 SR만 보기 - 로그인한 회원 id설정
	        if (onlyMySr) {
	            searchDto.setMemId(memInfo.getMemId());
	        }
	    }
		
		// 기본 날짜 입력 처리
		if (searchDto.getStartDate() == null) {
			searchDto.setStartDate(
					new Calendar.Builder().setDate(Calendar.getInstance().get(Calendar.YEAR), 0, 1).build().getTime());
		}
		if (searchDto.getEndDate() == null) {
			searchDto.setEndDate(new Date());
		}

		// 디폴트 시스템 설정
		if (searchDto.getRelSys() == null) {
			searchDto.setRelSys("");
		}
		if (!searchDto.getRelSys().equals("")) {
			// 업무 목록 가져오기
			String selectedCdGroupId = searchDto.getRelSys().substring(0, 1) + "OPER";
			List<CDMT> listOper = srProgressService.getCDMTByGroupId(selectedCdGroupId);
			model.addAttribute("listOper", listOper);
		}

		// 디폴트 업무구분 설정
		if (searchDto.getWkType() == null)
			searchDto.setWkType("");
		// 디폴트 진행상태 설정
		if (searchDto.getTkType() == null)
			searchDto.setTkType("");
		// 디폴트 접수상태 설정
		if (searchDto.getRcpStat() == null)
			searchDto.setRcpStat("");
		// 디폴트 키워드(제목) 설정
		if (searchDto.getKeyword() == null)
			searchDto.setKeyword("");

		log.info(searchDto.toString());

		int rows = srProgressService.countRows(searchDto); // jsp에서 받은 검색 정보를 가지고 그 검색 결과에 해당하는 행을 반환
		PagerDto pager = new PagerDto(rowsPerPage, 5, rows, pageNo); // 반환된 행을 페이저 객체에 저장
		log.info("rows--------------" + rows);
		Map<String, Object> searchCont = new HashMap<String, Object>();
		searchCont.put("searchDto", searchDto);
		searchCont.put("pager", pager);

		List<SR002MT> srList = srProgressService.getSearchedSr(searchCont);
		log.info(srList.toString());
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);
		model.addAttribute("onlyMySr", onlyMySr);
		return "prg/prgList";
	}

	// SR계획정보 조회
	@PostMapping("/srPlan")
	public void srPlan(String appSrId, HttpServletResponse response, HttpServletRequest request,
			Authentication authentication) throws Exception {
		SR002MT srPlan = srProgressService.getSrPlan(appSrId);
		// response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/prg/srPlan.jsp";
		request.setAttribute("srPlan", srPlan);

		List<MB001MT> mgrs = srProgressService.getMgr();
		request.setAttribute("mgrs", mgrs);

		if (authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());
			request.setAttribute("memInfo", memInfo);
		}
		// response 타입설정 및 요청에 request와 response 설정
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl);
		dispatcher.include(request, response);
		log.info("appSrId : " + appSrId);
	}

	// SR계획정보 저장
	@PostMapping("/updateSrPlan")
	public void updateSrPlan(SR002MT sr002mt, Authentication authentication, HttpServletResponse response)
			throws Exception {

		srProgressService.updateSrPlan(sr002mt);

		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().write("SR 계획 정보가 성공적으로 업데이트되었습니다!");
	}

	// SR 상세보기
	@PostMapping("/srDetail")
	public void getSrDetail(String appSrId, HttpServletResponse response, HttpServletRequest request) throws Exception {
		// srId가 일치하는 데이터 가져오기
		SR002MT appSrDetail = srProgressService.getDetail(appSrId);

		// response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/prg/srDetail.jsp";
		// 요청에 값 설정
		request.setAttribute("appSrDetail", appSrDetail);

		// response 타입설정 및 요청에 request와 response 설정
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl);
		dispatcher.include(request, response);
	}
	
	// 자원 jsp호출
	@PostMapping("/srHr")
	public void loadSrHr(String appSrId, HttpServletResponse response, HttpServletRequest request) throws Exception {
		// appSrId가 일치하는 자원 가져오기
		List<SR001NT> hrList = srProgressService.getHrList(appSrId);
		// response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/prg/srHr.jsp";
		request.setAttribute("appSrId", appSrId);
		request.setAttribute("hrList", hrList);

		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl);
		dispatcher.include(request, response);
	}
	// 자원 저장
	@PostMapping("/updateHr")
	public void updateHr(@RequestBody Map<String, Object> data, 
			HttpServletResponse response) throws Exception  {
		String appSrId = (String) data.get("appSrId");
		
		// memId와 plnMd를 포함한 Map
		List<Map<String, Object>> memInfoList = (List<Map<String, Object>>) data.get("memInfo");
		
		// SR001NT타입으로 각 정보들(appSrId, memId, plnMd) dto에 추가
		List<SR001NT> hr = new ArrayList<>();
		for (Map<String, Object> memInfo : memInfoList) {
	        SR001NT srHr = new SR001NT();
	        srHr.setAppSrId(appSrId);
	        srHr.setMemId((String) memInfo.get("memId"));
	        srHr.setPlnMd((Integer) memInfo.get("plnMd"));

	        hr.add(srHr);
		}
		srProgressService.saveHrList(appSrId, hr);
		log.info(appSrId);
		response.setContentType("text/plain; charset=UTF-8");
	    response.getWriter().write("자원 정보가 성공적으로 저장되었습니다!");
	}
/*	// 자원 삭제
	@PostMapping("/deleteHr")
	public void deleteHr(@RequestBody Map<String, Object> )*/
	
	// 진척율 jsp호출
	@PostMapping("/srRatio")
	public void loadSrRatio(String appSrId, HttpServletResponse response, HttpServletRequest request) throws Exception {
		// appSrId가 일치하는 진척율 가져오기
		List<SR002NT> prgRatioList = srProgressService.getPrgRatioList(appSrId);
		// response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/prg/srRatio.jsp";
		// 요청에 값 설정
		request.setAttribute("prgRatioList", prgRatioList);

		// response 타입설정 및 요청에 request와 response 설정
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl);
		dispatcher.include(request, response);
	}


	// SR계획정보 - 담당자 검색
	@GetMapping("/searchMgr")
	public void searchMgr(MB001MT mb001mt, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<MB001MT> mgrs = srProgressService.getSearchMgr(mb001mt);
		request.setAttribute("mgrs", mgrs);

		String jspUrl = "/WEB-INF/views/prg/searchMgr.jsp";
		response.setContentType("text/html; charset=UTF-8");

		// RequestDispatcher로 JSP 페이지의 특정 부분만 렌더링하여 응답으로 전달
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl);
		dispatcher.include(request, response);

		log.info(mgrs.toString());
	}
	// SR자원정보 - 자원 검색
	@GetMapping("/searchHr")
	public void searchHr(MB001MT mb001mt, HttpServletRequest request, HttpServletResponse response) throws Exception {

		List<MB001MT> mgrs = srProgressService.getSearchMgr(mb001mt);
		request.setAttribute("mgrs", mgrs);

		String jspUrl = "/WEB-INF/views/prg/searchHr.jsp";
		response.setContentType("text/html; charset=UTF-8");

		// RequestDispatcher로 JSP 페이지의 특정 부분만 렌더링하여 응답으로 전달
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl);
		dispatcher.include(request, response);

		log.info("컨트롤러에서 검색 실행됨");
		log.info(mgrs.toString());
	}

	// 진척율 6개 업데이트
	@ResponseBody
	@PostMapping("/updatePrgRatio")
	public int updatePrgRatio(@RequestBody List<SR002NT> prgRatioList) {
		int cntUpdate = srProgressService.updatePrgRatio(prgRatioList);
		return cntUpdate;
	}
	
	
}
