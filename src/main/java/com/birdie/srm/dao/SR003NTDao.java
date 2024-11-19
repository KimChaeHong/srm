package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR003NT;

@Mapper
public interface SR003NTDao {

	List<SR003NT> selectWkhour(Map<String, Object> dtoMap);

	void insertWkhour(SR003NT newRecord);

	Integer existsWkhour(SR003NT sr003nt);

	int updateWkhour(SR003NT sr003nt);

}
