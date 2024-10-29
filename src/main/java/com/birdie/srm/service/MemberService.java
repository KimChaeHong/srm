package com.birdie.srm.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.birdie.srm.dao.MemberDao;
import com.birdie.srm.dto.MemberDto;

@Service
public class MemberService {
	public enum JoinResult {
		SUCCESS, FAIL_DUPLICATED_USERID

	}
	
	
	public enum LoginResult {
		SUCCESS, FAIL_USERID, FAIL_USERPASSSWORD, FAIL_ENABLED

	}

	
	
	
	@Resource
	private MemberDao memberDao;

	//회원가입
	public JoinResult join(MemberDto member) {


		memberDao.signUp(member);
		return JoinResult.SUCCESS;
	}

	
	// 로그인 결과값 반환 메서드
	public LoginResult login(MemberDto member) {
		MemberDto dbmember = memberDao.selectByMemId(member.getMemId());

		// 1. 로그인
		if (dbmember == null) {
			return LoginResult.FAIL_USERID;
		}

		// 2.회원 가입 승인 안남
		if (dbmember.getAppYn() == "N") {
			return LoginResult.FAIL_ENABLED;
		}

		// 3. 비밀번호 틀림
		if (!dbmember.getMemPw().equals(member.getMemPw())) {
			return LoginResult.FAIL_USERPASSSWORD;
		}

		return LoginResult.SUCCESS;
	}
	
	
	

}
