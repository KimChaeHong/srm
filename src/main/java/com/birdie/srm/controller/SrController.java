package com.birdie.srm.controller;

import java.io.OutputStream;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.birdie.srm.dao.SR001MTDao;
import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.IS001MT;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SR002NT;
import com.birdie.srm.dto.SR004NT;
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
		// 기본 날짜 입력 처리
		if (search.getStartDate() == null) {
		    search.setStartDate(new Calendar.Builder().setDate(Calendar.getInstance().get(Calendar.YEAR), 0, 1).build().getTime());
		}
		if (search.getEndDate() == null) {
		    search.setEndDate(new Date());
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
	public String registerSr(SR001MT sr001, Authentication authentication) throws Exception{	
		MB001MT memInfo = memberService.getUserInfo(authentication.getName());			
		sr001.setFirstInptId(memInfo.getMemNo());
		sr001.setLastInptId(memInfo.getMemNo());
		sr001.setInstId(memInfo.getInstId());

		srService.registerSr(sr001);
		//첨부파일 등록을 위한 값 세팅
		if(!sr001.getAttachment().isEmpty()) {
			String srId =srService.getSrId(memInfo.getMemNo());
			uploadAttatch(sr001.getAttachment(), srId);			
		}
		
		return "redirect:/sr/list";
	}
	
	//첨부파일 등록
	public void uploadAttatch(List<MultipartFile> attachment,String srId) throws Exception{
		int order = srService.getAttachOrder(srId);
			
		for(MultipartFile file : attachment) {
			order++;
			SR004NT sr004nt = new SR004NT();
			sr004nt.setSrId(srId);
			sr004nt.setAttachOName(file.getOriginalFilename());
			if(file.getContentType().equals("application/octet-stream")) {
				break;
			}
			sr004nt.setAttachType(file.getContentType());
			sr004nt.setAttachData(file.getBytes());
			sr004nt.setAttachOrder(order);
			
			srService.registerAttachment(sr004nt);
		}
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
		//첨부파일 리스트 가져오기
		List<SR004NT> attachList = srService.getAttachList(srId);
		//response에 담을 jsp 경로 설정
		String jspUrl = "/WEB-INF/views/sr/srDetail.jsp";
		//요청에  값 설정
		request.setAttribute("srDetail", srDetail);
		request.setAttribute("sysList", sysList);
		request.setAttribute("attachList", attachList);
		
		// response 타입설정 및 요청에 request와 response 설정
		response.setContentType("text/html; charset=UTF-8");
		RequestDispatcher dispatcher = request.getRequestDispatcher(jspUrl); 
        dispatcher.include(request, response);
		
		log.info("srId : "+ srId);
		
	}
	
	//첨부파일 다운로드
	@GetMapping("/attachDownload")
	public void attachDownload(@RequestParam String attachId, HttpServletResponse response) throws Exception{
		SR004NT attachment = srService.getAttach(attachId);
		log.info(attachment.getAttachId());
		log.info(attachment.getAttachOName());
		log.info(attachment.getAttachType());
		log.info(attachment.getAttachData()+"");
		//응답 헤더에 들어가는 Content-Type 내용 설정
		String contentType = attachment.getAttachType();
		response.setContentType(contentType);
		
		//파일로 저장하기 위한 설정
		String fileName = attachment.getAttachOName();
		String encodingFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingFileName + "\"");
		
		// 파일 데이터를 응답 스트림에 작성
	    OutputStream out = response.getOutputStream();
	    out.write(attachment.getAttachData());  // 실제 파일 데이터 전송
	    out.flush();
	    out.close();
	}
	
	
	// SR 삭제
	@PostMapping("/srDelete")
	public String deleteSr(SR001MT sr001Dto) {
		int cntDel = srService.deleteSr(sr001Dto.getSrId());
		return "redirect:/sr/list";
	}

	// SR 접수요청
	@ResponseBody
	@PostMapping("/srAppReq")
	public int appReqSr(SR001MT sr001Dto) {
		log.info("접수요청");
		int response = srService.srAppReq(sr001Dto.getSrId());
		return response;
	}

	// SR 처리(관리자)
	@ResponseBody
	@PostMapping("/srProcess")
	public int srProcess(SR001MT sr001Dto, Authentication authentication) {
		log.info("처리(관리자)");
		// 로그인한 회원의 정보 가져오기
		MB001MT memInfo = memberService.getUserInfo(authentication.getName());
		sr001Dto.setLastInptId(memInfo.getMemNo());
		
		int cntPrc = srService.srProcess(sr001Dto);
		
		//승인처리 일 때 승인된SR 테이블에 데이터생성 및 진척율 생성
		if(sr001Dto.getSrStat().equals("RECE")) {
			srService.insertAppSr(sr001Dto);
			SR002NT sr002nt = new SR002NT();
			String appSrId = srService.getAppSrId(sr001Dto.getSrId());
			log.info(appSrId);
			sr002nt.setAppSrId(appSrId);
			sr002nt.setFirstInptId(memInfo.getMemNo());
			insertPrg(sr002nt);
			
		}
		return cntPrc;
	}
	
	// SR002NT(진척율) 테이블에 6개 고정데이터 넣는 메서드
	public void insertPrg(SR002NT sr002nt) {
	    String[] taskTypeList = {"ANAL", "DESI", "IMPL", "TEST", "REFL", "OPER"};
	    for (String taskType : taskTypeList) {
	        sr002nt.setTaskType(taskType);
	        srService.insertPrg(sr002nt);
	    }
	}
	// SR 수정(업데이트)
	@ResponseBody
	@PostMapping("/srUpdate")
	public int srUpdate(SR001MT sr001mt, Authentication authentication) throws Exception{
		MB001MT memInfo = memberService.getUserInfo(authentication.getName());
		sr001mt.setLastInptId(memInfo.getMemNo());
		log.info("수정(저장)");
		int cntUpdate = srService.updateSr(sr001mt);
		//첨부파일 등록을 위한 값 세팅
		if(!sr001mt.getAttachment().isEmpty()) {
			String srId =sr001mt.getSrId();
			uploadAttatch(sr001mt.getAttachment(), srId);
		}
		return cntUpdate;
	}
	
	//첨부파일 삭제
	@ResponseBody
	@GetMapping("/deleteAttach")
	public int deleteAttach(String attachId) {
		int num = srService.deleteAttach(attachId);
		return num;
	}
}