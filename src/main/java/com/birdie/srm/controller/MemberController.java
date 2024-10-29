package com.birdie.srm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.birdie.srm.dto.MemberDto;
import com.birdie.srm.service.MemberService;
import com.birdie.srm.service.MemberService.JoinResult;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("member")
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/loginform") 
	public String login(){
		log.info("로그인");
		return "member/loginForm";
	}
	
	@GetMapping("/signupform") 
	public String signupForm(){
		log.info("회원가입 폼");
		return "member/signupForm";
	}
	
	@PostMapping("/signup")
	public String signup(MemberDto member) {
		log.info("회원가입");
		
		//계정 활성화
		member.setDeltYn("Y");
		
		//비밀번호 암호화
		PasswordEncoder passwordEncoder = 
				PasswordEncoderFactories.createDelegatingPasswordEncoder();
		member.setMemPw(passwordEncoder.encode(member.getMemPw()));
		
		log.info(member.toString());
		JoinResult joinResult = memberService.join(member);
		return "redirect:/member/loginform";
	}
	
	@GetMapping("/list")
	public String memberList() {
		log.info("회원 목록");
		return "member/memberList";
	}
	
	@GetMapping("/mgmt")
	public String apprequestlist() {
		log.info("가입 요청 목록");
		return "member/memberMgmt";
	}
	
}
