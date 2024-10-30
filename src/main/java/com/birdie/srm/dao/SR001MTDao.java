package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR001MT;
import com.birdie.srm.dto.SearchDto;

@Mapper
public interface SR001MTDao {

	public void insertSr(SR001MT sr001Dto);

	public List<SR001MTDao> getSearchedSr(Map<String, Object> searchCont);

	public int getRows(SearchDto search);

	public SR001MT getDetail(String srId);

	public void srDelete(String srId);

	public void srAppReq(String srId);

	//나의 할 일 목록 가져오기
	public List<SR001MT> selectMyList();
}
