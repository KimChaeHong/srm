package com.birdie.srm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR002Dto;
import com.birdie.srm.dto.SearchDto;
import com.birdie.srm.service.SrProgressService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("prg")
public class PrgController {

	@Autowired
	private SrProgressService srProgressService;
	
	// SR 목록 전체 조회(+ 검색, 페이지 기능 추가)
	@GetMapping("/list") 
	public String srListAll(
			SearchDto search, 
			@RequestParam(defaultValue="1") int pageNo,
			HttpSession session, 
			Model model){
		
		int totalRows = srProgressService.getTotalRows();
		PagerDto pager = new PagerDto(10, 5, totalRows, pageNo);
		Map<String,Object> searchCont = new HashMap<String,Object>();
		search.makeNull();
		searchCont.put("search", search);
		searchCont.put("pager", pager);
		
		List<SR002Dto> srList = srProgressService.getSearchedSr(searchCont);
		model.addAttribute("srList", srList);
		return "prg/prgList";
	}
	/*// SR진척 - 승인된 SR 목록 전체 조회
	@RequestMapping("/list") 
	public String srListAll(
			@RequestParam(defaultValue="1") int pageNo,
			@RequestParam(name="search", defaultValue="default") SearchDto search,
			HttpSession session,
			Model model) {
		
		int totalRows = srProgressService.getTotalRows();
		PagerDto pager = new PagerDto(10, 5, totalRows, pageNo);
		Map<String, Object> searchPager = new HashMap<>();
		searchPager.put("pager", pager);
		searchPager.put("search", search);
		
		session.setAttribute("pager", pager);
		
		List<SR002Dto> srList = srProgressService.getSearchedSr(searchPager);
		model.addAttribute("srList", srList);
		return "prg/prgList";
	}*/


}
