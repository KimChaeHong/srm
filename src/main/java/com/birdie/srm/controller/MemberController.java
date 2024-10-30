package com.birdie.srm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String login(HttpServletRequest request, Model model) {
	    log.info("로그인");

	    // 세션에서 인증 예외 정보를 확인
	    Exception exception = (Exception) request.getSession().getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    if (exception != null && "Bad credentials".equals(exception.getMessage())) {
	        // Model에 오류 메시지 추가
	        model.addAttribute("loginError", "아이디 또는 비밀번호가 틀립니다.");
	        // 세션에서 예외 정보 제거
	        request.getSession().removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	    }

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
