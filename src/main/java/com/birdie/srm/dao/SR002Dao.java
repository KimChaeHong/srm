package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR002Dto;

@Mapper
public interface SR002Dao {
	public List<SR002Dto> selectAll();
	
}
