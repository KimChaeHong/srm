package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.IS001MT;

@Mapper
public interface IS001MTDao {
	// 모든 기관 가져오기
	public List<IS001MT> selectInstAll();

}
