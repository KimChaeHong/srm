package com.birdie.srm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("sr")
@Slf4j
public class SrController {

	@GetMapping("/list") 
	public String login(){
		log.info("SR 목록");
		return "sr/srList";
	}


}