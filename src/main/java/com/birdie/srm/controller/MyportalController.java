package com.birdie.srm.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.service.MemberService;
import com.birdie.srm.service.MyportalService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("myportal")
@Slf4j
public class MyportalController {
	@Autowired
	private MyportalService myPortalService;
	@Autowired
	private MemberService memberService;

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
	
	// 상태별 SR 행 갯수 반환 (AJAX 요청)
    @GetMapping("/countStatus")
    public ResponseEntity<Map<String, Integer>> getStatusCounts() {
        Map<String, Integer> statusCounts = myPortalService.getStatusCounts();
        return ResponseEntity.ok(statusCounts);
    }
	
    //날짜 포메팅 메서드
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
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
            return map;
        }).collect(Collectors.toList());
    }

}
