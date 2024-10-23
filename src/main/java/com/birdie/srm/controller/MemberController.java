package com.birdie.srm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("member")
@Slf4j
public class MemberController {
	
	@GetMapping("/loginform") 
	public String login(){
		log.info("로그인");
		return "member/loginForm";
	}
	
	@GetMapping("/signupform") 
	public String signup(){
		log.info("회원가입");
		return "member/signupForm";
	}
	
	@GetMapping("/list")
	public String memberlist() {
		log.info("회원 목록");
		return "member/memberList";
	}
	
	@GetMapping("/mgmt")
	public String apprequestlist() {
		log.info("가입 요청 목록");
		return "member/memberMgmt";
	}
	
}
