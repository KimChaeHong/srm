package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR001NT;

@Mapper
public interface SR001NTDao {
	// appSrId에 해당하는 자원정보 모두 가져오기
	public List<SR001NT> selectHrList(String appSrId);
	
}
