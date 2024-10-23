package com.birdie.srm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("myportal")
@Slf4j
public class MyportalController {
	
	@GetMapping("/mytask")
	public String mytask() {
		
		log.info("나의  할 일");
		return "myportal/mytask";
	}
	

}
