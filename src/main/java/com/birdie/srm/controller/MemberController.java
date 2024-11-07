package com.birdie.srm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.birdie.srm.dto.CDMT;
import com.birdie.srm.dto.IS001MT;
import com.birdie.srm.dto.MB001MT;
import com.birdie.srm.service.MemberService;
import com.birdie.srm.service.MemberService.JoinResult;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("member")
@Slf4j
public class MemberController {
	@Autowired
	private MemberService memberService;

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("login");
		log.info("로그아웃");
		return "redirect:/";
	}

	// 회원 가입 하는 곳
	@GetMapping("/signupform")
	public String signupForm() {
		log.info("회원가입 폼");
		return "member/signupForm";
	}

	// 회원 가입 정보 만들기
	@PostMapping("/signup")
	public String signup(MB001MT member) {
		log.info("회원가입");

		// 계정 활성화
		member.setDeltYn("N");

		// 비밀번호 암호화
		PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		member.setMemPw(passwordEncoder.encode(member.getMemPw()));

		log.info(member.toString());
		JoinResult joinResult = memberService.join(member);
		return "redirect:/member/loginform";
	}

	// 역할에 따른 기관 목록 조회
	@GetMapping("/institutions")
	public ResponseEntity<List<IS001MT>> getInstitutions() {
		log.info("역할에 따른 기관 목록 조회 - role ");
		List<IS001MT> institutions = memberService.getInstitutionsByRole("GUSR");
		return ResponseEntity.ok(institutions);
	}

	// 기관에 따른 부서 목록 조회
	@GetMapping("/departments")
	public ResponseEntity<List<CDMT>> getDepartmentsByInstId(@RequestParam String instId) {
		log.info("기관에 따른 부서 목록 조회 - instId: " + instId);
		List<CDMT> departments = memberService.getDepartmentsByInstId(instId);
		return ResponseEntity.ok(departments);
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
