package com.birdie.srm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.birdie.srm.dto.SR001Dto;
import com.birdie.srm.dto.SearchDto;

@Mapper
public interface SR001Dao {

	public void insertSr(SR001Dto sr001Dto);

	public List<SR001Dto> getSearchedSr(Map<String, Object> searchCont);

	public int getRows(SearchDto search);

	public SR001Dto getDetail(String srId);

	public void srDelete(String srId);

	public void srAppReq(String srId);
}
