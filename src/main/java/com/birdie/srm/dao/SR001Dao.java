package com.birdie.srm.dao;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR001Dto;

@Mapper
public interface SR001Dao {

	public void insertSr(SR001Dto sr001Dto);


}
