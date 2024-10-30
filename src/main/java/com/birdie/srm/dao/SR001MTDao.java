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


}
