package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR002NT;
import com.birdie.srm.dto.SR004NT;

@Mapper
public interface SR002NTDao {
	
	// 진척율 Insert
	public void insertPrg(SR002NT sr002nt);

}
