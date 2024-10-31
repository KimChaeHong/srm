package com.birdie.srm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002MT;
import com.birdie.srm.dto.SearchDto;
import com.birdie.srm.service.SrProgressService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/prg")
public class PrgController {

	@Autowired
	private SrProgressService srProgressService;
	
	//OPERATION 조회하는 메서드
	/**
	 * CD_ID를 기준으로 업무 목록을 조회하여 JSON 형식으로 반환하는 메서드
	 * 
	 * 이 메서드는 주어진 업무 ID(selectedCdId)로부터 코드 그룹 ID를 생성한 후,
	 * 해당 코드 그룹 ID에 속하는 업무 목록을 조회하여 JSON 응답으로 반환합니다.
	 * 
	 * @param response HTTP 응답 객체로, JSON 데이터를 클라이언트에 전송하는 데 사용
	 * @param selectedCdId 선택된 코드 ID로, 코드 그룹 ID를 결정하는 데 사용
	 * @throws IOException 입력/출력 예외가 발생할 경우 처리
	 */
	@GetMapping("/getWkTypeList") 
	public void operList(HttpServletResponse response, String selectedCdId) throws IOException{
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
	
	//SR진척 목록 조회하는 메서드
	/**
	 * SR진척 목록을 검색 조건 및 페이징 정보를 바탕으로 조회하고, 관련 데이터를 모델에 추가하는 메서드
	 * 
	 * @param searchDto   사용자가 입력한 검색 조건을 담은 객체로, 관련 시스템, 업무 구분, 진행 상태, 접수 상태, 키워드 등을 포함
	 * @param pageNo      현재 페이지 번호로, 페이지 이동 시 해당 페이지의 목록을 조회하기 위해 사용
	 * @param rowsPerPage 한 페이지에 표시할 항목 수로, 페이징 처리를 위한 기본 값은 10입니다.
	 * @param model       뷰로 데이터를 전달하기 위한 Model 객체로, 검색된 SR 목록과 시스템 정보, 페이징 데이터를 포함하여 뷰로 전달
	 * @return            "prg/prgList" 뷰 페이지로 이동하여 SR 진행 목록을 출력
	 */
	@GetMapping("/list") 
	public String srPrgList(
			SearchDto searchDto, 
			@RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="10") int rowsPerPage,
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
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);
		
		/*int totalRows = srProgressService.getTotalRows();
		PagerDto pager = new PagerDto(10, 5, totalRows, pageNo);
		Map<String,Object> searchCont = new HashMap<String,Object>();
		searchCont.put("search", searchDto);
		searchCont.put("pager", pager);
		
		List<SR002Dto> srList = srProgressService.getSrAll(pager);
		model.addAttribute("srList", srList);
		model.addAttribute("searchCont", searchCont);*/
		
		return "prg/prgList";
	}
	
}
