package com.birdie.srm.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.birdie.srm.dao.MB001MTDao;
import com.birdie.srm.dto.MB001MT;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberService {
	public enum JoinResult {
		SUCCESS, FAIL_DUPLICATED_MID

	}
	
	
	public enum LoginResult {
		SUCCESS, FAIL_MID, FAIL_MPASSSWORD, FAIL_ENABLED, FAIL_APPROVE

	}


	@Resource
	private MB001MTDao memberDao;

	//회원가입
	public JoinResult join(MB001MT member) {


		memberDao.signUp(member);
		return JoinResult.SUCCESS;
	}

	
	// 로그인 결과값 반환 메서드
	public LoginResult login(MB001MT member) {
		MB001MT dbmember = memberDao.selectByMemId(member.getMemId());

		// 1. 아이디 존재 안함
		if (dbmember == null) {
			
			return LoginResult.FAIL_MID;
		}

		// 2.회원 가입 승인 안남
		if (dbmember.getAppYn() == "N") {
			
			return LoginResult.FAIL_APPROVE;
		}

		// 3. 비밀번호 틀림
		if (!dbmember.getMemPw().equals(member.getMemPw())) {

			return LoginResult.FAIL_MPASSSWORD;
		}

		return LoginResult.SUCCESS;
	}


	public MB001MT getUserInfo(String memId) {
		MB001MT meminfo = memberDao.selectJoinedMemInfo(memId);
		return meminfo;
	}
	
	
	

}
