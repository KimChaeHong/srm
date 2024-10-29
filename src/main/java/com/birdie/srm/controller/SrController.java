package com.birdie.srm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dto.PagerDto;
import com.birdie.srm.dto.SR001Dto;
import com.birdie.srm.dto.SearchDto;
import com.birdie.srm.service.SrService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("sr")
@Slf4j
public class SrController {
	@Autowired
	private SrService srService;

/*	@GetMapping("/srlist") 
	public String srList(@RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="10")int rowsPerPage, Model model){
		int totalRows = 10;
		PagerDto pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
		List<SR001Dto> srList = srService.getSrList(pager);
		model.addAttribute("srList", srList);
		log.info("SR 목록");
		return "sr/srList";
	}*/
	
	@RequestMapping("/list") 
	public String srList(SearchDto search, @RequestParam(defaultValue="1") int pageNo,
			@RequestParam(defaultValue="10")int rowsPerPage, Model model){
		int totalRows = 10; /*DB에서 꺼내서 넣을거임*/
		PagerDto pager = new PagerDto(rowsPerPage, 5, totalRows, pageNo);
		Map<String,Object> searchCont = new HashMap<String,Object>();
		search.makeNull();
		searchCont.put("search", search);
		searchCont.put("pager", pager);
		log.info("SR 목록");
		
		List<SR001Dto> srList = srService.getSearchedSr(searchCont);
		model.addAttribute("srList", srList);
		return "sr/srList";
	}
	
	@PostMapping("/registerSr")
	public String registerSr(SR001Dto sr001Dto) {	
		srService.insertSr(sr001Dto);
		
		return "redirect:/sr/list";
	}
	
	@PostMapping("/srDetail")
	public String srDetail(String srId) {
		
		return "";
	}


}