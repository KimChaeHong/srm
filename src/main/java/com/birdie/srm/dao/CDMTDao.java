package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.CDMT;

@Mapper
public interface CDMTDao {
	public List<CDMT> selectByGroupId(String groupId);
	
}
