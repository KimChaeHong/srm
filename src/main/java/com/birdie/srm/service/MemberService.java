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
	
	@Resource
	private MemberDao memberDao;

	//회원가입
	public JoinResult join(MemberDto member) {


		memberDao.signUp(member);
		return JoinResult.SUCCESS;
	}

	

}
