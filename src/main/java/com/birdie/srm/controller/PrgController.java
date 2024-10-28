package com.birdie.srm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.birdie.srm.dto.SR002Dto;
import com.birdie.srm.service.SrProgressService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("prg")
public class PrgController {

	@Autowired
	private SrProgressService srProgressService;
	
	@GetMapping("/list") 
	public String srListAll(Model model){
		log.info("SR 진척 목록111");
		List<SR002Dto> srList = srProgressService.getSrAll();
		model.addAttribute("srList", srList);
		log.info(srList.toString());
		log.info("SR 진척 목록222");
		return "prg/prgList";
	}

	

}
