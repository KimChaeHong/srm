package com.birdie.srm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.birdie.srm.dto.SR001Dto;
import com.birdie.srm.service.SrService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("sr")
@Slf4j
public class SrController {
	@Autowired
	private SrService srService;

	@GetMapping("/list") 
	public String login(){
		log.info("SR 목록");
		return "sr/srList";
	}
	
	@PostMapping("/registerSr")
	public String registerSr(SR001Dto sr001Dto, Model model) {
		log.info("등록 컨트롤러");
		log.info(sr001Dto.getSrTitle());
		log.info(sr001Dto.getFirstInptId());
		log.info(sr001Dto.getSrStat());
		log.info(sr001Dto.getRelSys());
		log.info(sr001Dto.getSrCont());		
		srService.insertSr(sr001Dto);
		
		return "redirect/sr/list";
	}


}