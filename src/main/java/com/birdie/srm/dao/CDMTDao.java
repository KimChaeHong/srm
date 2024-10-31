package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.CDMTDto;
import com.birdie.srm.dto.SearchDto;

@Mapper
public interface CDMTDao {
	public List<CDMTDto> selectByGroupId(String groupId);
	
}
