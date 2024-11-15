package com.birdie.srm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	
	// 로그인
	@RequestMapping("")
	public String login(HttpServletRequest request, Model model) {
		log.info("로그인 하는 곳");

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

}
