package com.birdie.srm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.CDMT;

@Mapper
public interface CDMTDao {
	public List<CDMT> selectByGroupId(String groupId);

	//inst_id와 동일한 cd_group_id로 부서 정보 가져오기
	public List<CDMT> selectDepartmentByCdGroupId(String instId);


	
}
