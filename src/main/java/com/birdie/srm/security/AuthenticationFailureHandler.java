package com.birdie.srm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler{
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		log.info("로그인 실패");
		
		// 로그인 실패 메시지를 세션에 저장
        request.getSession().setAttribute("loginFailMessage", "회원 가입 승인이 완료되지 않았습니다.");
		setDefaultFailureUrl("/");

		super.onAuthenticationFailure(request, response, exception);
	}
}
