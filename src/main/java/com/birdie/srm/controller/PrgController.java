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

import com.birdie.srm.dto.CDMTDto;
import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002Dto;
import com.birdie.srm.dto.SearchDto;
import com.birdie.srm.service.SrProgressService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/prg")
public class PrgController {

	@Autowired
	private SrProgressService srProgressService;
	
	// SR진척 검색창 - 업무구분 
	@GetMapping("/getWkTypeList") 
	public void getWkTypeList(HttpServletResponse response, String selectedCdId) throws IOException{
		String selectedCdGroupId = selectedCdId.substring(0,1) + "OPER";
		List<CDMTDto> listOper = srProgressService.getCDMTByGroupId(selectedCdGroupId);
		
		JSONArray jsonArray = new JSONArray(); //"[ {cdId:xxx, cdNm:yyy}, {...}, {...} ]"
		for(CDMTDto cdmtDto : listOper) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("cdId", cdmtDto.getCdId());
			jsonObject.put("cdNm", cdmtDto.getCdNm());
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
			@RequestParam(defaultValue="10") int rowsPerPage,
			Model model) {
		//관련시스템 목록 가져오기
		List<CDMTDto> listSys = srProgressService.getCDMTByGroupId("SYS");
		model.addAttribute("listSys", listSys);
		
		//디폴트 시스템 설정
		if(searchDto.getRelSys() == null) {
			searchDto.setRelSys("");
		} 
		if(!searchDto.getRelSys().equals("")) { 	
			//업무 목록 가져오기 
			String selectedCdGroupId = searchDto.getRelSys().substring(0,1) + "OPER";
			List<CDMTDto> listOper = srProgressService.getCDMTByGroupId(selectedCdGroupId);
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
		
		int rows = srProgressService.getRows(searchDto);			// jsp에서 받은 검색 정보를 가지고 그 검색 결과에 해당하는 행을 반환
		PagerDto pager = new PagerDto(rowsPerPage, 5, rows, pageNo);		// 반환된 행을 페이저 객체에 저장
		
		Map<String,Object> searchCont = new HashMap<String,Object>();	
		searchCont.put("search", searchDto);
		searchCont.put("pager", pager);

		List<SR002Dto> srList = srProgressService.getSearchedSr(searchCont);
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
