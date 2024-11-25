package com.birdie.srm.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.NT001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SR003NT;
import com.birdie.srm.security.MemberDetails;
import com.birdie.srm.service.MemberService;
import com.birdie.srm.service.MyportalService;
import com.birdie.srm.service.SrProgressService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("myportal")
@Slf4j
public class MyportalController {
	@Autowired
	private MyportalService myPortalService;

	@Autowired
	private MemberService memberService;

	@Autowired
	private SrProgressService srProgressService;

	// 나의 할 일 목록 보기
	@GetMapping("mytask")
	public String mySrList(Authentication authentication, // 로그인 사용자 정보 가져오기
			Model model, @RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) Integer rowsPerPage, HttpSession session) {

		// 로그인한 사용자 사번 및 역할 가져오기
		MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
		String memberInfo = memberDetails.getMember().getMemNo(); // 사번 가져오기
		String memberId = authentication.getName(); //아이디 가져오기
		String userRole1 = memberDetails.getMember().getRole1(); // 역할 가져오기
		log.debug("Member Info (사번): {}", memberInfo); // 로그 추가

		// 세션에서 rowsPerPage 값을 가져오거나 기본값 설정
		if (rowsPerPage == null) {
			rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
			if (rowsPerPage == null) {
				rowsPerPage = 10; // 기본값 설정
			}
		} else {
			session.setAttribute("rowsPerPage", rowsPerPage); // 변경된 값을 세션에 저장
		}

		// 역할에 따른 총 행 수와 SR 목록 가져오기
		int totalRows;
		PagerDto pager;

		if ("ROLE_ADMI".equals(userRole1)) { // 관리자의 경우
			totalRows = myPortalService.getTotalManagerRows(memberInfo); // 관리자용 쿼리로 총 행 수 가져오기
			pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
			List<SR001MT> mySrList = myPortalService.getManagerSrList(memberInfo, pager); // 관리자용 SR 목록 가져오기
			model.addAttribute("mySrList", mySrList);
		} else if("ROLE_DEVE".equals(userRole1)){
			totalRows = myPortalService.getTotalDeveloperRows(memberId); 
			pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
			List<SR002MT> mySrList = myPortalService.getDeveloperSrList(memberId, pager); 
			model.addAttribute("mySrList", mySrList);
		}
		else { // 일반 사용자
			totalRows = myPortalService.getTotalRowsByUser(memberInfo);
			pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
			List<SR001MT> mySrList = myPortalService.getMySrListByUser(memberInfo, pager);
			model.addAttribute("mySrList", mySrList);
		}

		// 공지사항 가져오기
		List<NT001MT> notices = myPortalService.getNotices();
		model.addAttribute("notices", notices);

		session.setAttribute("pager", pager);
		model.addAttribute("userRole", userRole1);

		return "myportal/mytask";
	}

	// 특정 상태의 SR 목록 가져오기 (AJAX 요청)
	@GetMapping("/mytaskFragment")
	public String getMySrListByStatus(
			Authentication authentication, 
			@RequestParam("srStat") String srStat,
			@RequestParam(defaultValue = "1") int pageNo, @RequestParam(required = false) Integer rowsPerPage,
			Model model, HttpSession session) {

		// 로그인한 사용자 정보 가져오기
		MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
		String memberInfo = memberDetails.getUsername(); // 아이디 가져오기
		String memberId = authentication.getName(); //아이디 가져오기
		String memberNo = memberDetails.getMember().getMemNo(); // 사번 가져오기
		String userRole1 = memberDetails.getMember().getRole1(); // 역할 가져오기

		log.debug("User Role: {}", userRole1);
		log.debug("Member Info (사번): {}", memberInfo);

		// 세션에서 rowsPerPage 값을 가져오거나 기본값 설정
		if (rowsPerPage == null) {
			rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
			if (rowsPerPage == null) {
				rowsPerPage = 10; // 기본값 설정
			}
		} else {
			session.setAttribute("rowsPerPage", rowsPerPage); // 변경된 값을 세션에 저장
		}

		int totalRows;
		PagerDto pager;

		// "ALL" 혹은 빈 srStat일 때 모든 상태 조회
		if ("ROLE_ADMI".equals(userRole1)) {
			if (srStat.isEmpty()) {
				totalRows = myPortalService.getTotalManagerRows(memberNo);
				pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
				List<SR001MT> mySrList = myPortalService.getManagerSrList(memberNo, pager);
				model.addAttribute("mySrList", mySrList);

			} else {
				totalRows = myPortalService.getTotalManagerRowsByStatus(srStat, memberNo);
				pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
				List<SR001MT> mySrList = myPortalService.getManagerSrListByStatus(srStat, memberNo, pager);
				model.addAttribute("mySrList", mySrList);
			}	
		} else if("ROLE_DEVE".equals(userRole1)){
			if (srStat.isEmpty()) {
				totalRows = myPortalService.getTotalDeveloperRows(memberId);
				pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
				List<SR002MT> mySrList = myPortalService.getDeveloperSrList(memberId, pager);
				model.addAttribute("mySrList", mySrList);

			} else {
				totalRows = myPortalService.getTotalDeveloperRowsByStatus(srStat, memberId);
				pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
				List<SR002MT> mySrList = myPortalService.getDeveloperSrListByStatus(srStat, memberId, pager);
				model.addAttribute("mySrList", mySrList);

			}
		}else {
			if (srStat.isEmpty()) {
				totalRows = myPortalService.getTotalRowsByUser(memberInfo);
				pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
				List<SR001MT> mySrList = myPortalService.getMySrListByUser(memberInfo, pager);
				model.addAttribute("mySrList", mySrList);

			} else {
				totalRows = myPortalService.getTotalRowsByStatusAndUser(srStat, memberInfo);
				pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
				List<SR001MT> mySrList = myPortalService.getMySrListByStatusAndUser(pager, srStat, memberInfo);
				model.addAttribute("mySrList", mySrList);

			}
		}

		log.debug("Total rows: {}", totalRows);

		session.setAttribute("pager", pager);
	
		return "myportal/mytaskFragment";
	}

	// 페이징 처리
	@GetMapping("/pagination")
	public String getPagination(
			Authentication authentication, 
			@RequestParam("srStat") String srStat, 
			@RequestParam(defaultValue = "1") int pageNo, 
			@RequestParam(required = false) Integer rowsPerPage,
			Model model, HttpSession session) {

		MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
		String memberInfo = memberDetails.getUsername(); // 사용자 아이디 가져오기
		String memberId = authentication.getName(); //아이디 가져오기
		String memberNo = memberDetails.getMember().getMemNo(); // 사번 가져오기
		String userRole1 = memberDetails.getMember().getRole1(); // 역할 가져오기

		if (rowsPerPage == null) {
			rowsPerPage = (Integer) session.getAttribute("rowsPerPage");
			if (rowsPerPage == null) {
				rowsPerPage = 10; // 기본값 설정
			}
		} else {
			session.setAttribute("rowsPerPage", rowsPerPage); // 변경된 값을 세션에 저장
		}

		int totalRows;
		PagerDto pager;

		// 관리자의 경우와 일반 사용자의 경우를 구분하여 처리
		if ("ROLE_ADMI".equals(userRole1)) { // 관리자의 경우
			if ("ALL".equals(srStat)) { // 전체 목록 조회
				totalRows = myPortalService.getTotalManagerRows(memberNo);
			} else { // 특정 상태 조회
				totalRows = myPortalService.getTotalManagerRowsByStatus(srStat, memberNo);
			}
			
		}else if("ROLE_DEVE".equals(userRole1)) {
			if ("ALL".equals(srStat)) { // 전체 목록 조회
				totalRows = myPortalService.getTotalDeveloperRows(memberId);
			} else { // 특정 상태 조회
				totalRows = myPortalService.getTotalDeveloperRowsByStatus(srStat, memberId);
			}
		
		}else { // 일반 사용자와 개발자의 경우
			if ("ALL".equals(srStat)) { // 전체 목록 조회
				totalRows = myPortalService.getTotalRowsByUser(memberInfo);
			} else { // 특정 상태 조회
				totalRows = myPortalService.getTotalRowsByStatusAndUser(srStat, memberInfo);
			}
		}

		pager = new PagerDto(rowsPerPage, 1, totalRows, pageNo);
		model.addAttribute("pager", pager);

		return "myportal/pagination";
	}

	@GetMapping("/countStatus")
	public ResponseEntity<Map<String, Integer>> getStatusCounts(Authentication authentication) {
		MemberDetails memberDetails = (MemberDetails) authentication.getPrincipal();
		String userRole1 = memberDetails.getMember().getRole1(); // 사용자 역할 가져오기
		String memNo;

		// 역할에 따라 memNo 값 설정
		if ("ROLE_ADMI".equals(userRole1)) {
			memNo = memberDetails.getMember().getMemNo(); // 관리자는 사번을 가져오기
		} else if("ROLE_DEVE".equals(userRole1)){
			memNo = authentication.getName();
		} 
		else {
			memNo = memberDetails.getUsername(); // 일반 사용자는 아이디를 가져오기
		}

		Map<String, Integer> statusCounts = myPortalService.getStatusCounts(memNo, userRole1);
		return ResponseEntity.ok(statusCounts);
	}

	// 날짜 포메팅 메서드
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	// FullCalendar 데이터 받아오기
	@ResponseBody
	@GetMapping("/getEventDate")
	public List<Map<String, Object>> getEventDate(Authentication authentication) {
		MB001MT mb001mt = memberService.getUserInfo(authentication.getName());
		// 데이터베이스에서 이벤트를 조회합니다.
		List<SR002MT> events = myPortalService.getEvents(mb001mt);

		// FullCalendar 이벤트 형식으로 변환
		return events.stream().map(event -> {
			Map<String, Object> map = new HashMap<>();
			map.put("title", event.getSrTitle()); // 이벤트 제목
			map.put("start", sdf.format(event.getTrgStDt())); // 시작 날짜 형식 변경
			map.put("end", sdf.format(event.getTrgEndDt())); // 종료 날짜 형식 변경
			return map;
		}).collect(Collectors.toList());
	}

	// ProcessBar 데이터 받아오기
	@ResponseBody
	@GetMapping("/getProcessBarData")
	public List<Map<String, Object>> getProcessBarData(Authentication authentication) {
		// 로그인된 사용자 정보 가져오기
		MB001MT mb001mt = memberService.getUserInfo(authentication.getName());
		// 서비스 호출하여 데이터 가져오기
		List<SR002MT> progressList = myPortalService.getProcessBarData(mb001mt);

		// 필요한 형식으로 변환하여 반환
		return progressList.stream().map(data -> {
			Map<String, Object> map = new HashMap<>();
			map.put("key", data.getSrTitle()); // 작업 이름
			map.put("value", data.getPrg()); // 진행률
			map.put("startDate", data.getTrgStDt() != null ? sdf.format(data.getTrgStDt()) : ""); // 시작일
			map.put("endDate", data.getTrgEndDt() != null ? sdf.format(data.getTrgEndDt()) : ""); // 마감일
			return map;
		}).collect(Collectors.toList());
	}

	// 공지사항 조회
	@GetMapping("/selectNotice")
	public String noticeSelect(Model model, Authentication authentication) {
		List<NT001MT> notices = myPortalService.getNotices();
		if (authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());
			if (memInfo != null) {
				model.addAttribute("memRole1", memInfo.getRole1());
			}
		}
		model.addAttribute("notices", notices);
		return "myportal/selectNotice";
	}

	// 공지사항 등록 폼 get
	@GetMapping("/addNotice")
	public String addNoticeForm() {
		log.info("등록 폼 불러오기");
		return "myportal/addNotice";
	}

	// 공지사항 등록 post
	@PostMapping("/addNotice")
	public String addNotice(NT001MT notice, Authentication authentication) {
		if (authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());
			if (memInfo != null) {
				notice.setMemId(memInfo.getMemId());
			}
		}
		myPortalService.saveNotice(notice);
		log.info("공지 등록----------------");
		return "redirect:/myportal/selectNotice";
	}

	// 공지사항 수정 폼
	@GetMapping("/noticeDetail/{noticeId}")
	public String updateNoticeForm(@PathVariable("noticeId") int noticeId, Model model) {
		NT001MT noticeDto = myPortalService.getNotice(noticeId);
		model.addAttribute("noticeDto", noticeDto);
		return "myportal/addNotice";
	}

	// 공지사항 수정
	@PostMapping("/updateNotice")
	public String updateNotice(NT001MT noticeDto, Authentication authentication) {
		if (authentication != null) {
			MB001MT memInfo = memberService.getUserInfo(authentication.getName());
			if (memInfo != null) {
				noticeDto.setLastInptId(memInfo.getMemId());
			}
		}
		myPortalService.updateNotice(noticeDto);
		return "redirect:/myportal/selectNotice";
	}

	// 공지사항 삭제
	@PostMapping("/deleteNotice/{noticeId}")
	public String deleteNotice(@PathVariable("noticeId") int noticeId) {
		myPortalService.deleteNotice(noticeId);
		log.info("공지사항 삭제 -------------");
		return "redirect:/myportal/selectNotice";
	}

	// 공지사항 상세 조회
	@GetMapping("detailNotice/{noticeId}")
	public String detailNotice(@PathVariable("noticeId") int noticeId, Model model) {
		NT001MT notice = myPortalService.getNotice(noticeId);
		model.addAttribute("notice", notice);

		return "myportal/detailNotice";
	}

	@PostMapping("/wkhour")
	public void wkhour(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws Exception {
		// 로그인된 사용자의 MEM_ID를 통해 회원의 모든 정보 가져오기
		MB001MT memInfo = memberService.getUserInfo(authentication.getName());

		// 오늘 날짜 기준으로 날짜 리스트 생성
		Calendar cal = Calendar.getInstance();
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

		List<Date> dayList = new ArrayList<>();
		for (int i = 0; i < 7; i++) {
			dayList.add(cal.getTime()); // Date 객체 추가
			cal.add(Calendar.DAY_OF_MONTH, 1); // 하루 증가
		}

		// 데이터 조회
		List<SR002MT> assignedSrList = srProgressService.getAssignedSrIdList(memInfo);
		List<List<SR003NT>> wkhourList = srProgressService.getWkhourList(memInfo, dayList);

		// JSP에 전달할 데이터 설정
		request.setAttribute("memId", memInfo.getMemId());
		request.setAttribute("assignedSrList", assignedSrList);
		request.setAttribute("dayList", dayList);
		request.setAttribute("wkhourList", wkhourList);

		// JSP로 포워드
		String jspUrl = "/WEB-INF/views/myportal/wkhour.jsp";
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl);
		dispatcher.include(request, response);
	}

	@PostMapping("/updateWkhour")
	@ResponseBody
	public int updateWkhour(@RequestBody List<SR003NT> dataList) {
		return srProgressService.updateWkhour(dataList);
	}

}