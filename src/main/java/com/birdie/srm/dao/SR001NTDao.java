package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.birdie.srm.dto.SR001NT;

@Mapper
public interface SR001NTDao {
	// appSrId에 해당하는 자원정보 모두 가져오기
	public List<SR001NT> selectHrList(String appSrId);

	// 자원 삽입
	public void insertHr(SR001NT hr);
	
	// appSrId에 해당하는 자원정보 저장
	public int updateHr(SR001NT hr);

	// 자원 존재 여부
	public int exists(SR001NT hr);

}
