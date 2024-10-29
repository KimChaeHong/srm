package com.birdie.srm.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class AuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler { // 로그인 성공 시 사용자가 요청했던 페이지로 이동
	/*extends SimpleUrlAuthenticationSuccessHandler{ //로그인 성공 시 지정한 경로로 이동*/	
	@Override
	public void onAuthenticationSuccess(
			HttpServletRequest request, 
			HttpServletResponse response,
			Authentication authentication)  //로그인 성공 했을 때 권한 : id, 비밀번호 등 로그인 사용자에 대한 정보를 알 수 있는 객체이다.
					throws ServletException, IOException {
		log.info("로그인 성공");
		//extends SimpleUrlAuthenticationSuccessHandler 사용할 경우
		//setDefaultTargetUrl("/");로그인 성공했을 때 여기로 이동시킨다.
		super.onAuthenticationSuccess(request, response, authentication);
	}
}
