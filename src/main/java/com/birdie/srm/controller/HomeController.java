package com.birdie.srm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	
	@RequestMapping("")
	public String myportal() {
		log.info("my portal");
		return "myportal/mytask";
	}
	

}
