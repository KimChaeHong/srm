package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR002NT;

@Mapper
public interface SR002NTDao {
	
	// 진척율 Insert
	public void insertPrg(SR002NT sr002nt);
	
	// appSrId에 해당하는 진척율 모두 가져오기
	public List<SR002NT> selectPrgRatio(String appSrId);
	
	// 해당하는 진척율 6개 업데이트
	public int updatePrgRatio(SR002NT sr002nt);

}
