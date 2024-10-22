package com.birdie.srm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("membermanagement")
@Slf4j
public class MemberController {
	
	@GetMapping("/loginForm") 
	public String login(){
		log.info("로그인");
		return "membermanagement/loginform";
	}
	
	@GetMapping("/signupForm") 
	public String signup(){
		log.info("회원가입");
		return "membermanagement/signupform";
	}
	
	@GetMapping("/memberList")
	public String memberlist() {
		log.info("회원 목록");
		return "membermanagement/memberlist";
	}
	
	@GetMapping("/apprequestList")
	public String apprequestlist() {
		log.info("승인 요청 목록");
		return "membermanagement/apprequestlist";
	}
	
}
